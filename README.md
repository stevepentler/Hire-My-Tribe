# Hire My Tribe
Authors: Aaron Greenspan, Hector Huertas, Joseph "JP" Perry & Steve Pentler

[Live on Heroku](https://hiremytribe.herokuapp.com/)

## Overview

Hire My Tribe was born to fuse "Tribes" of freelance developers and connect them to contractors.

After interviewing for IT recruitment positions, we were astounded that up to 40% of developers paychecks are cashed in by recruitment firms. Afterwards, we developed a concept to connect freelance developers into "Tribes" to balance strengths, minimize culture conflicts, and allow independent developers to collectively work on larger projects.

The Hire My Tribe web application features a genetic algorithm that takes in parameters such as ideal number & type of developers, hourly rates, language preferences, and skill ratings, and outputs the optimal combination of available developers based on this criteria.

Technically, this Rails application allows distinct access privileges as either a developer, contractor, or admin. Depending on authorization, users are allowed to view, sort, edit, update, and delete developers, projects, specializations, and tags.

## Screenshot

![Screenshot](/app/assets/images/hire_my_tribe_screenshot.png)

## Skills acquired
Rails 4, ActiveRecord, Heroku Deployment, Shoulda Matchers Model Validations, Agile Development, Waffle, Git Workflow, Materialize, CSS, HTML, MVC Best Practices, Stripe Payment Processing, Paperclip & AWS S3

## Deployment
* Clone the repo
* Install dependencies with `$ bundle install`
* Setup the database with `$ rake db:setup`
* To run the website without Stripe support run `$ rails server`
* To run the website with Stripe test enabled:

  * Start sever with `$ PUBLISHABLE_KEY=pk_test_6pRNASCoBOKtIshFeQd4XMUh SECRET_KEY=sk_test_BQokikJOvBiI2HlWgH4olfQ2 rails server`
  * Use 4242 4242 4242 4242 as card number
