# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
Type.create(name:'Bebida')
Type.create(name:'Lanche')
Type.create(name:'Pizza')
Type.create(name:'Sobremesa')

Product.create(name: "X-Tudo", price: 20, type_id: Type.find_by_name("Lanche").id)
Product.create(name: "X-Salada", price: 12, type_id: Type.find_by_name("Lanche").id)
Product.create(name: "X-Bacon", price: 16, type_id: Type.find_by_name("Lanche").id)
Product.create(name: "Mussarela", price: 24, type_id: Type.find_by_name("Pizza").id)
Product.create(name: "Calabresa", price: 24, type_id: Type.find_by_name("Pizza").id)
Product.create(name: "Coca-cola 2 Litros", price: 8, type_id: Type.find_by_name("Bebida").id)
Product.create(name: "Pepsi 2 Litros", price: 7, type_id: Type.find_by_name("Bebida").id)
Product.create(name: "Trufa", price: 3, type_id: Type.find_by_name("Sobremesa").id)
Product.create(name: "Brigadeiro", price: 2, type_id: Type.find_by_name("Sobremesa").id)