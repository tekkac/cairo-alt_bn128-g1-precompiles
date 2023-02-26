.PHONY: build test

build:
	protostar build --disable-hint-validation

test:
	protostar test tests/
