module ArDocStore
  module AttributeTypes
    class DateAttribute < BaseAttribute
      def type
        :date
      end

      def load
        :to_date
      end

      def dump
        :to_s
      end
    end
  end
end
