# Poker Hand Evaluation Exercise #

This project is a proof-of-concept. This application takes a given poker hand and evaluates its rank.


### Installation

This project was implemented in Ruby and uses newer syntax introduced in Version 1.9, so please make sure you have a recent version of Ruby installed before running this project.

#### Dependencies

This project also uses [Bundler](http://bundler.io) to manage dependencies.
If you do not have bundler installed, you can do so from the shell with `gem install bundler`

Finally, install all of the project dependencies with: `bundle`

### Commandline Usage

The CLI for this project is "hand". Simply make the file executable (`chmod +x hand`)

```shell
Example:
./hand Ah As 10c 7d 6s #=> Ah As 10c 7d 6s - 1 Pair
./hand Kh Kc 3s 3h 2d #=> Kh Kc 3s 3h 2d - 2 Pair
./hand Kh Qh 6h 2h 9h #=> Kh Qh 6h 2h 9h - Flush
```

### Unit Tests
To run the suite of unit tests, simple invoke the Rake task runner:

```shell
rake # or rake test
```