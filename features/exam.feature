Feature: exam
  As a user who use website
  I want to be able to take examination

  Background:
    Given we have categories like follow:
    | name | 
    | MySQL | 
    | Ruby On Rails|
    | MySQL Example|
    | Git |

  Scenario: None sign in user
    When I visit exam page
    Then I should see message say "You need to sign in or sign up before continuing."

  Scenario: Sigined in user
    Given I have already signed in
    When I visit exam page
    Then I should see header with text "All examinations" and button "Start"
    When I choose a category and click "Start"
    Then I should see an exam with "Start" link
