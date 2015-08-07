module Vedeu

  module Tables

    class Table

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

      def render_title
        if title
          [horizontal, horizontal]


        else
          horizontal

        end
      end

      def horizontal
      end

      def render_column(value)
        [value, vertical]
      end

      def vertical
      end

    end # Table

  end # Tables

end # Vedeu
