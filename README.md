# Bank Kata

## User story

```
Given a client makes:

A deposit of 1000 on 10-01-2012

And a deposit of 2000 on 13-01-2012

And a withdrawal of 500 on 14-01-2012

When she prints her bank statement then she would see:

date || credit || debit || balance

14/01/2012 || || 500.00 || 2500.00

13/01/2012 || 2000.00 || || 3000.00

10/01/2012 || 1000.00 || || 1000.00
```

## Install the dependencies

    $ cd to/bank-kata/root
    $ bundle install

## Run the tests

    $ cd to/bank-kata/root
    $ rspec
