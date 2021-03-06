Email Predictor
================

Purpose
--------

Given a data set consisting of names and corresponding email addresses, we want
to predict the format of email addresses for staff at companies with known email
addresses. The formats of interest fall into four patterns:

00. `"#{first name}.#{last name}@#{email domain}"`
00. `"#{first name}.#{last initial}@#{email domain}"`
00. `"#{first initial}.#{last name}@#{email domain}"`
00. `"#{first initial}.#{last initial}@#{email domain}"`

Design
-------

The supplied data set is read and analyzed, each entry wrapped in an `Email`
object that manages parsing of the associated name and email address.

The collection of `Email`s is then passed to an `EmailFormat` builder method,
which decorates each `Email` with an `EmailFormat` matching the given email
format (or an `Unrecognized` format if no format matches). 

The `EmailFormat` provides logic to generate an email address adhering to the
specific format (strategy subclasses of `EmailFormat`) from a passed-in `Email`.

For a given company with known email addresses, the `Analyzer` selects the most
commonly occurring `EmailFormat` and uses that to generate a predicted email
address from the name passed as a command-line argument.


Usage
-----

```
$ predict -h
Usage:
predict  NAME  DOMAIN [--training_set JSON_FILEPATH]

Example:
predict 'Jane Doe' google.com [-t data/training.json]

Options:
    -t, --training_set               path to JSON training data (default: data/training.json)
    -v, --version                    display version
    -h, --help                       display this screen
```

Examples
--------
(run from `bin`)

```sh
predict 'Peter Wong' alphasights.com   &&
predict 'Craig Silverstein' google.com &&
predict 'Steve Wozniak' apple.com      &&
predict 'Barack Obama' whitehouse.gov  &&
predict 'Jake Romer' jkrmr.io -t ../data/with_unrecognized_format.json
```

With Output:

```sh
predict 'Peter Wong' alphasights.com
# => peter.wong@alphasights.com

predict 'Craig Silverstein' google.com
# => craig.s@google.com

predict 'Steve Wozniak' apple.com
# => s.w@apple.com

predict 'Barack Obama' whitehouse.gov
# => No training data available for that email domain.

predict 'Jake Romer' jkrmr.io -t ../data/with_unrecognized_format.json
# => Unrecognized format. Best guess: jake.romer@jkrmr.io
```

Test Suite
----------

```
EmailPredictor::Analyzer
  #predicted_email_for
    if training data for the given domain is analyzed
      returns a string version of the predicted email
    if no training data is provided for the given email domain
      returns a string saying no data were available for a prediction
  #classify_data
    maps each domain to its most frequently occurring format
    groups email data by email domain
    maps each email domain to an email format


Emails::Email
  #recipient
    returns the email recipient's split email address, sans domain
  #first_initial
    returns the email recipient's first initial
  ::collection_from
    returns an array of email objects
  #last_initial
    returns the email recipient's last initial
  #domain
    returns the email recipient's email domain

Emails::PartialEmail
  #domain
    returns the email recipient's email domain
  #first_initial
    returns the email recipient's first initial
  #recipient
    returns the email recipient's split email address, sans domain
  #last_initial
    returns the email recipient's last initial


Emails::EmailFormat
  #predicted_address_for
    raises an error if not overridden by a subclass
  #domain
    delegates to the decorated email

Emails::EmailFormat::FirstNameDotLastInitial
  #predicted_address_for
    generates an appropriate formatted predicted email
  #domain
    delegates to the decorated email

Emails::EmailFormat::FirstInitialDotLastName
  #predicted_address_for
    generates an appropriate formatted predicted email
  #domain
    delegates to the decorated email

Emails::EmailFormat::FirstInitialDotLastInitial
  #predicted_address_for
    generates an appropriate formatted predicted email
  #domain
    delegates to the decorated email

Emails::EmailFormat::FirstNameDotLastName
  #predicted_address_for
    generates an appropriate formatted predicted email
  #domain
    delegates to the decorated email

Emails::EmailFormat::Unrecognized
  #domain
    delegates to the decorated email
  #predicted_address_for
    generates a best guess (name.name) for an unrecognized format

Finished in 0.01235 seconds (files took 0.08315 seconds to load)
26 examples, 0 failures

Randomized with seed 41572

```
