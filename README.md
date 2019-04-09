# Inventables Car Rental Coding Challenge

In the year 20XX, Inventables is expanding, aiming to capture the hot vehicle rental market for vacationing X-Carve owners. We've procured a sizable vehicle fleet and built a website allowing customers to make rental reservations. Initial customer feedback has been mostly positive, except that over the recent Election Day holiday weekend we took more reservations than we had vehicles in our fleet and were unable to fulfill some of the reservations!

We want you to help us update the app to ensure that we won't take more reservations than we can fulfill so that we don't run into this problem again.

## Project layout

The project is organized following Rails conventions, with model classes in **app/models/**, controllers in **app/controllers/**, and views in **app/views/**. Tests are in **test/models/** and **test/controllers/**. The Rails routes file is **config/routes.rb** and the database schema is **db/schema.db**.

## Data models

### `VehicleCategory` (the `vehicle_categories` table)

A particular category of vehicle. A vehicle category has a `name`, such as `"SUV"`, `"Sedan"`, or `"Convertible"`, and a `daily_price`, in dollars, to rent a vehicle in that category.

As you will see below, we make reservations at the category level — that is, a customer will make a reservation for "a sedan" and we will fulfill it with any one of the sedans in our rental fleet.

### `VehicleModel` (the `vehicle_models` table)

A vehicle make and model. Each vehicle model belongs to a vehicle category. Vehicle models also have a `make` identifying the manufacturer, such as `"Ford"` or `"Honda"`, and a `name` identifying the model name, such as `"Focus"` or `"Pilot"`.

### `Vehicle` (the `vehicles` table)

A specific vehicle from our rental fleet. Each vehicle belongs to a vehicle model. A vehicle also has a `year`, such as `2019` and a `commissioned_on` date when it was added to the rental fleet. A vehicle can be removed from the rental fleet by setting a `decommissioned_on` date.

### `Reservation` (the `reservations` table)

A customer's vehicle reservation. A reservation belongs to a vehicle category, as mentioned above. A reservation also has a `start_date` and an `end_date`, and a `total_price` in dollars.

## Requirements
Ruby version `2.5.1`
Bundler gem, preferred version `2.0.1`

## Setting up
- Clone the git repo and navigate to code directory
- Install the gems: `bundle install`
- Run migrations: `rake db:migrate`
- Seed the database: `rails db:seed`
- Start the server: `rails server`

Navigate to [localhost:3000](http://localhost:3000) to see the app in action.

## Testing
Run `rake test` in the terminal to run the testing suite.
