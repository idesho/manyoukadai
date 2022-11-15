50.times do |i|
    Task.create!(title: "Blog#{i+1}", content: "テスト",deadline_on: "2025/02/18", priority: 1, status: 0)
end