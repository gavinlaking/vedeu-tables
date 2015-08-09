module Vedeu

  module Tables

    # Provides mechanism to draw a table from the provided data.
    #
    class Table

      include Vedeu::Common

      # @!attribute [r] caption
      # @return [String]
      attr_reader :caption

      # @!attribute [r] data
      # @return [Hash<Symbol => String>]
      attr_reader :data

      # @!attribute [r] headings
      # @return [Hash<Symbol => String>]
      attr_reader :headings

      # @!attribute [r] title
      # @return [String]
      attr_reader :title

      # @see #initialize
      def self.build(attributes = {}, options = {})
        new(attributes, options)
      end

      # @param attributes [Hash]
      # @option attributes caption [String]
      # @option attributes data [Array<Hash<Symbol => String,Symbol>>]
      # @option attributes headings [Hash<Symbol => String,Symbol]
      # @option attributes title [String]
      # @param options [Hash]
      # @option options width [Fixnum]
      # @return [Vedeu::Tables::Table]
      def initialize(attributes = {}, options = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        @options = options
      end

      # @return [void]
      def render
        out = []

        out << horizontal
        out << render_title if present?(title)

        out << render_headings if present?(headings)

        # if headings && headings.any?
        #   headings_out = []

        #   headings.each do |heading|
        #     headings_out << ['|' + padded(heading) + '|']
        #   end

        #   out << headings_out.join
        # end

        # Array(data).each do |datum|
        #   data_out = ['| ']

        #   datum.each do |key, value|
        #     if value.to_s.size > (column_width - 4)
        #       value = value.chomp.slice(0..(column_width - 1))
        #     end

        #     data_out << value.to_s.ljust(column_width) + ' | '
        #   end

        #   out << data_out.join
        # end

        out << render_caption if present?(caption)
        out << horizontal
        out.join("\n")
      end

      # private




      # @return [Hash<Symbol => Array<Hash<Symbol => String,Symbol>>,
      #                         <Hash<Symbol => String,Symbol>,
      #                         NilClass>]
      def defaults
        {
          caption:  '',
          data:     [],
          headings: [],
          title:    '',
        }
      end


      # @return [Fixnum]
      def columns
        if headings && headings.any?
          headings.size

        elsif data && data.any?
          data[0].keys.size

        else
          1

        end
      end

      # Pads the title with a single whitespace either side.
      #
      # @example
      #   title = 'Truncated!'
      #   width = 20
      #   # => ' Truncated! '
      #
      #   width = 10
      #   # => ' Trunca '
      #
      # @return [String]
      # @see #truncated_title
      def padded(value)
        truncated(value).center(width - 2)
      end

      # Truncates the title to the width of the interface, minus characters
      # needed to ensure there is at least a single character of horizontal
      # border and a whitespace on either side of the title.
      #
      # @example
      #   title = 'Truncated!'
      #   width = 20
      #   # => 'Truncated!'
      #
      #   width = 10
      #   # => 'Trunca'
      #
      # @return [String]
      def truncated(value)
        value.chomp.slice(0..(width - 5))
      end

      def padded_column(value)

      end

      def truncated_column(value)
      end

      # Crudely provides a horizontal line.
      #
      # @return [String]
      def horizontal
        ['+', '-' * (width - 2), '+'].join
      end

      def render_caption
        ['|' + padded(caption) + '|']
      end

      def render_headings
        out = [horizontal]

        # headings_out = []

        # headings.size.times do |column|
        #   headings_out << '|'
        #   headings_out << ' ' * column_width
        # end

        # headings_out << '|'
        # out << headings_out.join

        out << horizontal
        out
      end

      def render_title
        ['|' + padded(title) + '|']
      end

      # @return [Fixnum]
      def column_width
        ((width - columns) / columns).round
      end

      def total_width
        column_width * columns
      end

      def border?
        options[:border]
      end

      # @return [Fixnum]
      def width
        options[:width]
      end

      # @return [Hash]
      def options
        default_options.merge!(@options)
      end

      # @return [Hash]
      def default_options
        {
          border: true,
          width:  Vedeu.width
        }
      end

    end # Table

  end # Tables

end # Vedeu
