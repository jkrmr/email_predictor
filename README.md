Email Predictor
================

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
