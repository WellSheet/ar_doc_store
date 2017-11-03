require 'encryptor'

module ArDocStore
  module AttributeTypes
    class EncryptedStringAttribute < BaseAttribute
      def type
        :encrypted_string
      end

      def self.encryption_key
        key = ENV['AR_DOC_STORE_ENCRYPTION_KEY']
        raise 'Encryption key nil. Please define using ENV variable AR_DOC_STORE_ENCRYPTION_KEY' if key.nil?
        key
      end

      def self.encryption_iv
        iv = ENV['AR_DOC_STORE_ENCRYPTION_IV']
        raise 'Encryption iv nil. Please define using ENV variable AR_DOC_STORE_ENCRYPTION_IV' if iv.nil?
        iv
      end

      def build
        key = attribute.to_sym
        model.class_eval do
          store_accessor json_column, key
          define_method key, -> {
            value = read_store_attribute(json_column, key)
            Encryptor.decrypt(value, key: EncryptedStringAttribute.encryption_key , iv: EncryptedStringAttribute.encryption_iv) if value
          }
          define_method "#{key}=".to_sym, -> (value) {
            value = Encryptor.encrypt(value.to_s,  key: EncryptedStringAttribute.encryption_key, iv: EncryptedStringAttribute.encryption_iv) if value
            write_store_attribute(json_column, key, value)
          }
          add_ransacker(key, 'text')
        end
      end
    end
  end
end
