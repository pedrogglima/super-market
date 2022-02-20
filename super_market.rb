# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'money'
require 'bigdecimal'

require_relative './super_market/product_queryable'
require_relative './super_market/price_rules'

require_relative './super_market/models/base'
require_relative './super_market/models/product'
require_relative './super_market/models/checkout'
require_relative './super_market/models/buy_one_get_one_free'
require_relative './super_market/models/discount_after'

module SuperMarket
  Money.locale_backend = nil
  Money.rounding_mode = BigDecimal::ROUND_HALF_UP

  BigDecimal.mode(BigDecimal::ROUND_HALF_UP)
end
