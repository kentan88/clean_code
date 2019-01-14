alias CleanCode.Repo
alias CleanCode.Order
alias CleanCode.Customer
alias CleanCode.Event
alias CleanCode.User

Repo.delete_all(Customer)
Repo.delete_all(Order)
Repo.delete_all(Event)
Repo.delete_all(User)

organizer = Repo.insert!(%User{name: "Ken Tan", active: true})
organizer = Repo.insert!(%User{name: "Kiki Chen", active: true})

event = Repo.insert!(%Event{title: "JSConf Asia 2019", published: true})
event_2 = Repo.insert!(%Event{title: "Red Dot Ruby Conference 2019", published: true})

customer =
  Repo.insert!(%Customer{
    first_name: "John",
    last_name: "Doe",
    email: "johndoe@example.com",
    mobile_no: "94534534"
  })

Repo.insert!(%Order{event_id: event.id, customer_id: customer.id, status: "PAID"})
Repo.insert!(%Order{event_id: event_2.id, customer_id: customer.id, status: "PAID"})

customer =
  Repo.insert!(%Customer{
    first_name: "Foo",
    last_name: "BR",
    email: "foobar@example.com",
    mobile_no: "98765432"
  })

Repo.insert!(%Order{event_id: event.id, customer_id: customer.id, status: "FAILED"})
Repo.insert!(%Order{event_id: event_2.id, customer_id: customer.id, status: "PAID"})
