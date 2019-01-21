#!/bin/bash

alias npm-audit='docker run -it --rm -v "$PWD"/:/usr/app/ mtheoryx/npm-audit:1.0.0'
alias npm-audit-fix='docker run -it --rm -v "$PWD"/:/usr/app/ mtheoryx/npm-audit:1.0.0 npm audit fix'