# frozen_string_literal: true

module SuperMarket
  class Base
    TYPES = {
      integer: Integer,
      float: Float,
      string: String,
      boolean: TrueClass,
      money: Money,
      bigdecimal: BigDecimal
    }.freeze

    class << self
      attr_reader :fields

      def inherited(base)
        base.instance_variable_set(:@fields, {})
      end

      def field(name, type, opts = {})
        TYPES.key?(type) || raise(ArgumentError, "Invalid type: #{type}")

        @fields[name] = { type: type, opts: opts }
      end

      # TODO: create a class to handle validations & changes
      #
      def normalize(attrs)
        attrs.map do |k, v|
          raise ArgumentError, "Invalid field #{k}" unless @fields.key?(k)

          # apply default value
          [k, v = @fields[k][:opts][:default]] if @fields[k][:opts].key?(:default) && v.nil?

          # change type
          case @fields[k][:type].to_sym
          when :integer
            [k, v.to_i]
          when :float
            [k, v.to_f]
          when :string
            [k, v.to_s]
          when :boolean
            [k, v.to_s == 'true']
          when :bigdecimal
            [k, BigDecimal(v.to_s)]
          else
            raise ArgumentError, "Invalid type: #{@fields[k][:type]}"
          end
        end.to_h
      end
    end

    # returns model attrs 'hashified'
    def to_h
      self.class.fields.map do |field|
        [field.first, send(field.first)]
      end.to_h
    end
  end
end
