MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
BASE_DIR := $(shell cd $(dir $(MAKEFILE)); pwd)
SRC_DIR  := $(BASE_DIR)/src

BASICS_LECTURES := ValuesVariablesTypes Expressions Functions Recursion CBNvsCBV DefaultArgs StringOps
LECTURES := $(BASICS_LECTURES)

.PHONY: clean
clean:
	find $(SRC_DIR) -iname '*.class' -exec rm -v {} \;

.PHONY: compile-java-playground
compile-java-playground:
	javac $(SRC_DIR)/playground/JavaPlayground.java

.PHONY: run-java-playground
run-java-playground: compile-java-playground
	java -cp $(SRC_DIR) playground.JavaPlayground

.PHONY: compile-scala-playground
compile-scala-playground:
	scalac -d $(SRC_DIR) $(SRC_DIR)/playground/ScalaPlayground.scala

.PHONY: run-scala-playground
run-scala-playground: compile-scala-playground
	scala -cp $(SRC_DIR) playground.ScalaPlayground

check-lecture%:
	$(if $(word $*,$(BASICS_LECTURES)),,$(error invalid lecture!))

compile-basic%: check-lecture%
	scalac -d $(SRC_DIR) $(SRC_DIR)/lectures/part1basics/$(word $*,$(BASICS_LECTURES)).scala

run-basic%: compile-basic%
	scala -cp $(SRC_DIR) lectures.part1basics.$(word $*,$(BASICS_LECTURES))
