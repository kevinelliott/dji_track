class CreateManufacturersService
  def call
    file = File.read('db/seeds/manufacturers.json')
    manufacturers = JSON.parse(file)
    manufacturers.each { |m| Manufacturer.create(m) }
  end
end
