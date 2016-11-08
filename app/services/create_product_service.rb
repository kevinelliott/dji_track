class CreateProductService
  def call
    file = File.read('db/seeds/products.json')
    products = JSON.parse(file)
    products.each { |p| Product.create(p) }
  end
end
