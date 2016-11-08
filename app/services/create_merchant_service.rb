class CreateMerchantsService
  def call
    file = File.read('db/seeds/merchants.json')
    merchants = JSON.parse(file)
    merchants.each { |m| Merchant.create(m) }
  end
end
