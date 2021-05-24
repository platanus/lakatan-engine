# Lakatan

Rails engine to play with [Lakatan](https:/lakatan.dev)

## Installation

Add to your Gemfile:

```ruby
gem "lakatan"
```

```bash
bundle install
```

Then, run the installer:

```bash
rails generate lakatan:install
```

## Api Usage

### User

#### Find User

```ruby
user = Lakatan::Api::User.find(115)
```

**Attributes:**

```ruby
user.id #=> 115
user.name #=> "Andrés Matte"
user.email #=> "andres@platan.us"
user.created_at #=> Thu, 17 Dec 2020 20:40:08 +0000
user.updated_at #=> Thu, 24 Dec 2020 20:23:00 +0000
user.team_ids #=> [103, 97, 96]
user.teams #=> [#<Lakatan::Api::Team:0x00007f93be276178>, #<Lakatan::Api::Team:0x00007f93be276171]
```

#### Find Users

```ruby
users = Lakatan::Api::User.all
```
#### Dynamic Attributes

The dynamic attributes defined on Lakatan for the organizarion users will be stored in the `Lakatan::User#dynamic_attributes` attribute. You can access these attributes as follows:

```ruby
user.get_dynamic_attr(:github_username) #=> "ldlsegovia"
```

### Team

#### Find Team

```ruby
team = Lakatan::Api::Team.find(115)
```

**Attributes:**

```ruby
team.id #=> 115
team.name #=> "Keepers of the seven keys"
team.purpose #=> "Definir cómo se entregan accesos y permisos a los distintos sistemas que necesitamos dentro de Platanus."
team.created_at #=> Thu, 17 Dec 2020 20:40:08 +0000
team.updated_at #=> Thu, 24 Dec 2020 20:23:00 +0000
team.user_ids #=> [139, 140]
team.task_ids #=> [33, 99]
team.users #=> [#<Lakatan::Api::User:0x00007f93be276178>, #<Lakatan::Api::User:0x00007f93be276171]
team.tasks #=> [#<Lakatan::Api::Task:0x00007f93be276178>, #<Lakatan::Api::Task:0x00007f93be276171]
```

#### Find Teams

```ruby
teams = Lakatan::Api::Team.all
```

### Task

#### Find Task

```ruby
task = Lakatan::Api::Task.find(115)
```

**Attributes:**

```ruby
task.id #=> 115
task.name #=> "Primera entrevista startup"
task.goal #=> "Ir a la primera entrevista startup PV"
task.raffle_type #=> "Equity"
task.created_at #=> Thu, 17 Dec 2020 20:40:08 +0000
task.updated_at #=> Thu, 24 Dec 2020 20:23:00 +0000
task.label_id #=> 0
task.user_minimum #=> 100
task.team_id #=> 10
task.team #=> #<Lakatan::Api::Team:0x00007f93be276178>
```

**Raffle:**

```ruby
raffle = task.raffle #=> #<Lakatan::Raffle:0x00007f93be276178>
raffle.users #=> [#<Lakatan::Api::User:0x00007f93be276178>, #<Lakatan::Api::User:0x00007f93be276171]
```

```ruby
raffle = task.raffle(user_ids: [1, 2]) #=> #<Lakatan::Raffle:0x00007f93be276178>
raffle.users #=> [#<Lakatan::Api::User:0x00007f93be276178>, #<Lakatan::Api::User:0x00007f93be276171]
```

#### Find tasks

```ruby
tasks = Lakatan::Api::Task.all
```

## Cache Usage

The engine monts an endpoint: `POST /lakatan/notifications`. You can perform a request to create, update or destroy a cached resource. The body must be:

- `model_name`: must be `Team`, `Task` or `User`.
- `model_id`: must be a valid team/task or user id.
- `notification_action`: must be `create`, `update` or `destroy`.

**Example**

```bash
curl -d '{"model_name":"Task", "model_id":"48", "notification_action":"create"}' -H "Content-Type: application/json" -X POST http://localhost:3000/lakatan/notifications
```

### Cache access

You can access the saved data in much the same way as you do with the API. 

**Example**

```ruby
task = Lakatan::Task.find(48)

# => #<Lakatan::Task:0x000000010e2573a8
#  id: 48,
#  name: "Primera entrevista startup",
#  goal: "Ir a la primera entrevista startup PV",
#  raffle_type: "Random",
#  label_id: 0,
#  team_id: 100,
#  user_minimum: 1,
#  created_at: Mon, 28 Dec 2020 18:33:30.379000000 UTC +00:00,
#  updated_at: Mon, 25 Jan 2021 20:22:16.013000000 UTC +00:00>
```

> Note: cache models can be updated manually running: `task.update_attributes_from_api!`

### Cors

It is a good idea to limit access to the notification endpoint. If you are using [rack-cors gem](https://github.com/cyu/rack-cors) you can add the following configuration to your `production.rb`.

```ruby
config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://lakatan.dev')
    resource '/lakatan/notifications', headers: :any, methods: [:post]
  end
end
```

### Sync

If you want to force the synchronization between Laktan and your application, run the following job:

```ruby
Lakatan::SyncModelsJob.perform_now
```

## Testing

To run the specs you need to execute, **in the root path of the gem**, the following command:

```bash
bin/guard
```

You need to put **all your tests** in the `/lakatan/spec/dummy/spec/` directory.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/lakatan/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Lakatan is maintained by [platanus](http://platan.us).

## License

Lakatan is © 2021 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
