module ArDocStore
  module AttributeTypes

    class ArrayAttribute < BaseAttribute

      def build
        key = attribute.to_sym
        default_value = default
        model.class_eval do
          store_accessor json_column, key
          define_method key, -> {
            value = read_store_attribute(json_column, key)
            value or default_value
          }
          define_method "#{key}=".to_sym, -> (value) {
            value = nil if value == ['']
            write_store_attribute(json_column, key, value)
          }
          add_ransacker(key, 'text')
        end
      end

      def type
        :array
      end

    end

  end
end
