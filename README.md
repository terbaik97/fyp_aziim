# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# Campus Community Kit

This app is created to help the users find their POI and to navigate around the campus. Its is a community driven app where the users can contribute to the information of the campus.

## Getting Started Guide

### Prerequisites

- [postgresql >= 12.4](https://www.postgresql.org/download/)

### Installing

1. Clone the repo
2. First, create `master.key` file under config folder
3. Update the file with the master key provided by users that have the repo
4. Save the `master.key` file
5. Run `bundle install` in the terminal at your project working directory
6. Run `rails db:setup` to create the database, load the schema, and initialize it with the seed data.
7. Run `rails s` to verify if everything has been setup correctly
8. The server should run without errors if the installation is correct

## Running the tests

1. Open terminal
2. run `rspec`

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

-

## Contributing

-

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

-

## License

-

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## Notes

---

Reset database:

```
rake db:drop db:create db:migrate db:seed

```

Generate version table:

```
rails g paper_trail_version <model name>
```

eg:

```
rails g paper_trail_version user
```

When you first clone this repo, you need to generate master key & secret else can't login. To do so, run the following command:

```
rails credentials:edit
```
