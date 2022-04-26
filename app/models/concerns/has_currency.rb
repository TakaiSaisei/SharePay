module HasCurrency
  extend ActiveSupport::Concern

  included do
    enum currency: {
      rub: 0,
      usd: 1,
      eur: 2
    }

    validates :currency, inclusion: { in: currencies.keys }
  end
end
