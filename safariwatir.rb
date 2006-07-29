require 'watir/exceptions'
require 'safariwatir/scripter'
require 'safariwatir/core_ext'

module Watir
  include Watir::Exception

  module PageContainer
    def html
      @scripter.document_html
    end
    
    def text
      @scripter.document_text
    end
  end

  module Container
    attr_reader :scripter
    private :scripter

    module Clickable
      def click
        @scripter.highlight(self) do
          click_element
        end
      end    
    end

    class AlertWindow
      def initialize(scripter)
        @scripter = scripter
      end
      
      def click
          @scripter.click_alert_ok
      end
    end

    class Frame
      include Container
      include PageContainer
      
      attr_reader :name
      
      def initialize(scripter, name)
        @name = name
        @scripter = scripter.for_frame(self)
      end
    end

    class HtmlElement
      def_init :scripter, :how, :what
      attr_reader :how, :what

      def tag
        raise RuntimeError, "tag not provided for #{name}"
      end

      def speak
        @scripter.speak("#{name}'s don't know how to speak.")
      end

      def name
        self.class.name.split("::").last
      end

      def operate(&block)
        send("operate_by_" + how.to_s, &block)
      end

      protected
      
      def operate_by_id(&block)
        @scripter.operate_by_id(self, &block)        
      end
      def operate_by_index(&block)
        @scripter.operate_by_index(self, &block)        
      end
      def operate_by_name(&block)
        @scripter.operate_by_name(self, &block)        
      end
      def operate_by_text(&block)
        @scripter.operate_on_link(self, &block)        
      end
      def operate_by_url(&block)
        @scripter.operate_on_link(self, &block)        
      end
      def operate_by_value(&block)
        @scripter.operate_by_input_value(self, &block)
      end
    end

    class Form < HtmlElement
      def_init :scripter, :how, :what

      def submit
        @scripter.submit_form(self)
      end
      
      def tag; "FORM"; end
    end
    
    class InputElement < HtmlElement
      include Clickable
      
      def speak
        @scripter.speak_value_of(self)
      end

      def tag; "INPUT"; end

      # Hooks for subclasses
      def by_value; end
    end
    
    class ContentElement < HtmlElement
      include Clickable
      include Container

      def text
        @scripter.get_text_for(self)
      end

      def speak
        @scripter.speak_text_of(self)
      end      
    end
    
    class Button < InputElement
    end
    
    class Checkbox < InputElement
      def_init :scripter, :how, :what, :value
      def by_value
        @value
      end
      alias :set :click
    end

    class Div < ContentElement
      def tag; "DIV"; end
    end

    class Label < ContentElement
      def tag; "LABEL"; end
      
      protected
      
      def operate_by_text(&block)
        @scripter.operate_on_label(self, &block)
      end
    end

    class Link < InputElement
      def tag; "A"; end

      def click
        @scripter.highlight(self) do
          click_link
        end
      end
    end

    class Radio < Checkbox
    end

    class SelectList < InputElement
      def select(label)
        @scripter.highlight(self) do
          select_option(:text, label)
        end
      end

      def select_value(value)
        @scripter.highlight(self) do
          select_option(:value, value)
        end
      end
      
      def speak
        @scripter.speak_options_for(self)
      end
    end

    class Span < ContentElement
      def tag; "SPAN"; end
    end

    class Table
      def_init :scripter, :how, :what
      attr_reader :how, :what
      
      def each
        # TODO
      end
      
      def [](index)
        TableRow.new(@scripter, :index, index, self)
      end
      
      def row_count
        # TODO
      end
      
      def column_count
        # TODO
      end
    end
    
    class TableRow
      def initialize(scripter, how, what, table = nil)
        @scripter = scripter
        @how = how
        @what = what
        @table = table
      end

      attr_reader :table, :how, :what
            
      def each
        # TODO
      end
      
      def [](index)
        TableCell.new(@scripter, :index, index, self)
      end

      def column_count
        # TODO
      end
    end
    
    class TableCell < ContentElement
      def initialize(scripter, how, what, row = nil)
        @scripter = scripter.for_table(self)
        @how = how
        @what = what
        @row = row
      end
      
      attr_reader :how, :what, :row

      def operate_by_index(&block)
        @scripter.operate_by_table_cell_index(self, &block)
      end

      def operate(&block)
        @scripter.operate_by_table_cell(self, &block)
      end
    end

    class TextField < InputElement
      def set(value)
        @scripter.highlight(self) do
          clear_text_input
          value.length.times do |i|
            append_text_input(value[i, 1])
          end
        end
      end
      
      def getContents
        @scripter.get_value_for(self)
      end
      
      def verify_contains(expected)
        actual = getContents
        expected == actual
      end
    end

    class Password < TextField
    end


    # Elements
    
    def button(how, what)
      Button.new(scripter, how, what)
    end

    def cell(how, what)
      TableCell.new(scripter, how, what)
    end

    def checkbox(how, what, value = nil)
      Checkbox.new(scripter, how, what, value)
    end

    def div(how, what)
      Div.new(scripter, how, what)
    end

    def form(how, what)
      Form.new(scripter, how, what)
    end

    def frame(name)
      Frame.new(scripter, name)
    end
    
    def image(how, what)
      Button.new(scripter, how, what)
    end

    def label(how, what)
      Label.new(scripter, how, what)
    end
    
    def link(how, what)
      Link.new(scripter, how, what)
    end

    def password(how, what)
      Password.new(scripter, how, what)
    end

    def radio(how, what, value = nil)
      Radio.new(scripter, how, what, value)
    end

    def row(how, what)
      TableRow.new(scripter, how, what)
    end

    def select_list(how, what)
      SelectList.new(scripter, how, what)
    end
    
    def span(how, what)
      Span.new(scripter, how, what)
    end

    def table(how, what)
      Table.new(scripter, how, what)
    end
    
    def text_field(how, what)
      TextField.new(scripter, how, what)
    end
    
    def contains_text(what)
      case what
      when Regexp:
        text =~ what
      when String:
        text.index(what)
      else
        raise MissingWayOfFindingObjectException
      end
    end
  end

  class Safari
    include Container
    include PageContainer

    def self.start(url = nil)
      safari = new
      safari.goto(url) if url
      safari
    end
    
    def initialize
      @scripter = AppleScripter.new
      @scripter.ensure_window_ready
    end
    
    def close
      scripter.close
    end
    
    def quit
      scripter.quit
    end

    def alert
      AlertWindow.new(scripter)
    end
    
    def goto(url)
      scripter.navigate_to(url)
    end
  end # class Safari
end
