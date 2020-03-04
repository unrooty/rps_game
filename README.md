# Requirements

* Ruby 2.6
* Node >= 8
* Yarn

# Getting Started

* Pull the source code.
* Go into the project directory.
* Run `bundle install` to install Ruby gems.
* Run `yarn install` to install JS dependencies.

# How to play game (using UI)

* Go into the project directory.
* Run `bundle exec rails s`
* Visit http://localhost:3000
* Make your choice and wait util computer choose.

# How to play game (using JSON request)

* Go into the project directory.
* Run `bundle exec rails s`
* Make request
```bash
curl -H "Content-Type: application/json" -d '{"bet": "rock"}' -X POST http://localhost:3000/play.json
```
**Example results**

```json
{
  "result":"human", # winner
  "computer_choice":"scissors",
  "human_choice":"rock"
}
```

```json
{ 
  "result":"tie",
  "computer_choice":"rock",
  "human_choice":"rock"
}
```

Please note: Available bets are rock, paper, scissors. If you provide incorrect bet, i.e.
```bash
curl -H "Content-Type: application/json" -d '{"bet": "rok"}' -X POST http://localhost:3000/play.json
```
you'll get HTTP status 400 with the following response:

```json
{ 
  "error_message":"Illegal bet `rok` was provided!"
}
```
