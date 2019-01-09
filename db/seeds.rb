# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
Type.create(name:'Bebida')
Type.create(name:'Lanche')
Type.create(name:'Pizza')
Type.create(name:'Sobremesa')


Ingredient.create(name: 'Mussarela')
Ingredient.create(name: 'Tomate')
Ingredient.create(name: 'Calabresa')
Ingredient.create(name: 'Cebola')
Ingredient.create(name: 'Bacon')
Ingredient.create(name: 'Hamburger')
Ingredient.create(name: 'Alface')

Product.create(name: "X-Tudo", price: 20, type_id: Type.find_by_name("Lanche").id, photo: "https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000jbKMtMAM/5936a3b3e4b06e1b76df11d2.jpg&w=620&h=400")
Product.last.ingredients << Ingredient.find_by_name('Bacon')
Product.last.ingredients << Ingredient.find_by_name('Hamburger')
Product.last.ingredients << Ingredient.find_by_name('Alface')
Product.last.ingredients << Ingredient.find_by_name('Tomate')
Product.last.ingredients << Ingredient.find_by_name('Calabresa')
Product.create(name: "X-Salada", price: 12, type_id: Type.find_by_name("Lanche").id, photo: "https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000o1s8UMAQ/5703ff88e4b00d8469855d38.jpg&w=620&h=400")
Product.last.ingredients << Ingredient.find_by_name('Hamburger')
Product.last.ingredients << Ingredient.find_by_name('Alface')
Product.last.ingredients << Ingredient.find_by_name('Tomate')
Product.create(name: "X-Bacon", price: 16, type_id: Type.find_by_name("Lanche").id, photo: "https://s3-sa-east-1.amazonaws.com/loja2/54a575bd76489ae73c98d720cbd91787.png")
Product.last.ingredients << Ingredient.find_by_name('Bacon')
Product.last.ingredients << Ingredient.find_by_name('Hamburger')
Product.create(name: "Mussarela", price: 24, type_id: Type.find_by_name("Pizza").id, photo: "http://www.picanhacia.com.br/wp-content/uploads/2017/02/xproduto_pizza_mussarela-1-510x437.jpg.pagespeed.ic.6I5HtSNod5.jpg")
Product.last.ingredients << Ingredient.find_by_name('Mussarela')
Product.last.ingredients << Ingredient.find_by_name('Tomate')
Product.create(name: "Calabresa", price: 24, type_id: Type.find_by_name("Pizza").id, photo: "https://img.itdg.com.br/tdg/images/recipes/000/073/643/303583/303583_original.jpg?mode=crop&scale=both&w=320&h=200")
Product.last.ingredients << Ingredient.find_by_name('Calabresa')
Product.last.ingredients << Ingredient.find_by_name('Cebola')
Product.create(name: "Coca-cola 2 Litros", price: 8, type_id: Type.find_by_name("Bebida").id, photo: "http://www.sushicampogrande.com.br/pedido/wp-content/uploads/2015/07/coke.jpg")
Product.create(name: "Pepsi 2 Litros", price: 7, type_id: Type.find_by_name("Bebida").id, photo: "https://static.carrefour.com.br/medias/sys_master/images/images/h22/h77/h00/h00/9494639607838.jpg")
Product.create(name: "Trufa", price: 3, type_id: Type.find_by_name("Sobremesa").id, photo: "https://receitatodahora.com.br/wp-content/uploads/2015/11/como-fazer-trufas-recheadas-para-vender.jpg")
Product.create(name: "Brigadeiro", price: 2, type_id: Type.find_by_name("Sobremesa").id, photo: "https://panelinha-sitenovo.s3-sa-east-1.amazonaws.com/receita/958014000000-Brigadeiro.jpg")

Client.create(name: "Cliente teste", address: "Rua do teste", email: "teste@teste.com", password: "123456", password_confirmation: "123456")
Admin.create(email: "admin@admin.com", password: "123456", password_confirmation: "123456")

client_id = Client.find_by_name( "Cliente teste").id
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)
Order.create(client_id: client_id, status: Order::STATUS_DELIVERY)

date = Date.today
Order.all.each do |o|
   date = date - 1.day
   o.update(date: date, created_at: date)
   1..3.times do |n|
     OrderProduct.create(order_id: o.id, product_id: rand(1..8), qty: rand(2..4))
   end
   o.ended 
end 