module Vedeu

  module Tables

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
      def self.build(attributes = {})
        new(attributes)
      end

      # @param attributes [Hash]
      # @option attributes caption [String]
      # @option attributes data [Array<Hash<Symbol => String,Symbol>>]
      # @option attributes headings [Hash<Symbol => String,Symbol]
      # @option attributes title [String]
      # @return [Vedeu::Tables::Table]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [void]
      def render
        out = []

        out << horizontal
        out << ['|' + padded(title) + '|'] if present?(title)



        out << ['|' + padded(caption) + '|'] if present?(caption)
        out << horizontal

        out.join("\n")
      end

      # private

      # @return [Fixnum]
      def column_width
        (((Vedeu.width - 2) - (columns - 1)) / columns).round
      end

      # @return [Hash<Symbol => Array<Hash<Symbol => String,Symbol>>,
      #                         <Hash<Symbol => String,Symbol>,
      #                         NilClass>]
      def defaults
        {
          caption:  '',
          data:     [],
          headings: {},
          title:    '',
        }
      end

      # @return [Fixnum]
      def columns
        if headings && headings.any?
          headings.keys.size

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
        truncated(value).center(Vedeu.width - 2)
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
        value.chomp.slice(0..(Vedeu.width - 5))
      end

      def render_title
        if title
          [horizontal, horizontal]


        else
          horizontal

        end
      end

      def horizontal
        ['+', '-' * (Vedeu.width - 2), '+'].join
      end

      def render_column(value)
        [value, vertical]
      end

      def vertical
      end

    end # Table

  end # Tables

end # Vedeu
