# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Notebook.destroy_all
Outline.destroy_all
OutlineNote.destroy_all
UserNotebook.destroy_all

ed = User.create(name: "Edward Ezekiel", image: "https://lh4.googleusercontent.com/-u5IJtEsPS_0/AAAAAAAAAAI/AAAAAAAAEIk/OqpYh9FuTsg/s96-c/photo.jpg", googleID: "111050977327358160154")
nb = ed.notebooks.create(title: "First Notebook")

outln = ed.outlines.create(video: "93p3LxR9xfM", notes: "this video is dope")

outnt = OutlineNote.create(outline: outln, notebook: nb)

usernt = UserNotebook.create(user: ed, notebook: nb)
