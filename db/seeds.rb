taro = User.create!(name:'taro', email: 'tttttatotarotaros@sample.com', password: 'password', password_confirmation: 'password')
current_hanako = User.create!(name: 'hanako', email: 'hhhhhhhhhanahanahanakosan@sample.com', password: '1234567', password_confirmation: '1234567', admin: "true")

50.times do |i|
  Task.create!(title: "hanako_task_title_#{ i + 1 }", content: "testデータ", deadline_on: Date.current + i, priority: "中", status: Task.statuses.values.to_a.sample, user_id: current_hanako.id)
  Task.create!(title: "task_title_#{ i + 1 }", content: "testデータ", deadline_on: Date.current + i, priority: "中", status: Task.statuses.values.to_a.sample, user_id: taro.id)
end