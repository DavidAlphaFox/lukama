##
# Lukama
#
# @file

.PHONY: test build fmt deps

build: deps
	dune build

deps:
	opam install . --deps-only --yes

test:
	dune test

fmt:
	dune build @fmt --auto-promote
# end