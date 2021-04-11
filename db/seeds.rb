3.times do |i|
  Article.create(title: "This is awsome title #{i}", content: "This is awsome#{i} content", slug: "awsome#{i}-slug")
end