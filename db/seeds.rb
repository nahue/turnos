# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    username: "admin",
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!

# Test user accounts
(1..10).each do |i|
  u = User.new(
      username: "user#{i}",
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end

# Setup Resources

rt1 = ResourceType.create(
  title: "Profesionales",
  multiple: true,
  field: "profesional_id"
)
rt2 = ResourceType.create(
  title: "Especialidades",
  multiple: false,
  field: "especialidad_id"
)

r1 = Resource.create(
  text: "Dr. Pepe Carioca",
  value: nil,
  color: "green",
  resource_type_id: rt1.id
)
r2 = Resource.create(
  text: "Kinesiologo Venique tetoco",
  value: nil,
  color: "yellow",
  resource_type_id: rt1.id
)
r3 = Resource.create(
  text: "Kinesiologia",
  value: nil,
  color: "red",
  resource_type_id: rt2.id
)

# Test resources
(1..20).each do |i|
  r = Resource.new(
      text: "Recurso #{i}",
      value: nil,
      color: "red",
      resource_type_id: rt2.id
  )

  r.save!

  puts "#{i} recursos de prueba creados..." if (i % 5 == 0)

end

# Test resource types
(1..20).each do |i|
  r = ResourceType.new(
    title: "ResourceType_#{i}",
    multiple: i.even?,
    field: "field_id_#{i}"
  )

  r.save!

  puts "#{i} tipos de recursos de prueba creados..." if (i % 5 == 0)

end

e1 = Event.new(
  title: "Evento #1",
  start: 1.day.ago.to_datetime,
  end: 1.day.ago.to_datetime,
  description: "Prueba de evento #1",
  isAllDay: true,
)
e1.resources << r1
e1.save

e2 = Event.new(
  title: "Evento #2",
  start: 2.day.ago.to_datetime,
  end: 2.day.ago.to_datetime,
  description: "Prueba de evento #2",
  isAllDay: true
)
e2.resources << [r1, r2]
e2.save
