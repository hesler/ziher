# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

e1 = Entry.create(name: 'jakies entry', document_number: 'ey1')
e2 = Entry.create(name: 'jakies drugie entry', document_number: 'ntr2')

c1 = Category.create(name: 'Darowizny', isExpense: true)
c2 = Category.create(name: 'Akcje zarobkowe', isExpense: true)
Category.create(name: 'Wyposazenie', isExpense: false)
Category.create(name: 'Materialy', isExpense: false)
Category.create(name: 'Transport', isExpense: false)
Category.create(name: 'Wynagrodzenia', isExpense: false)

Item.create(amount: 5, category_id: c1.id, entry_id: e1.id)
Item.create(amount: 7, category_id: c2.id, entry_id: e2.id)
Item.create(amount: 3, category_id: c1.id, entry_id: e2.id)
Item.create(amount: 11, category_id: c2.id, entry_id: e1.id)
