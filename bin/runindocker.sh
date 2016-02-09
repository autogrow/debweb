#!/bin/bash

bundle install --path="vendor/bundle"
/sbin/ip addr show
bundle exec bin/rails server -p 80 -b 0.0.0.0
