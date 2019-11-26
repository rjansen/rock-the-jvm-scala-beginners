MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))
BASE_DIR := $(shell cd $(dir $(MAKEFILE)); pwd)
SRC_DIR  := $(BASE_DIR)/src

BASICS_LECTURES := ValuesVariablesTypes Expressions Functions Recursion CBNvsCBV DefaultArgs StringOps
OOP_LECTURES := OOBasics MethodNotations
LECTURES := $(BASICS_LECTURES) $(OOP_LECTURES)

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

define-%:
	$(eval SECTION := $(word 1,$(subst -, ,$*)))
	$(eval SECTION_TITLE := $(shell echo $(SECTION) | tr a-z A-Z))
	$(eval SECTION_LECTURES := $($(SECTION_TITLE)_LECTURES))
	$(eval LECTURE_NUM := $(word 2,$(subst -, ,$*)))
	$(eval LECTURE := $(word $(LECTURE_NUM),$(SECTION_LECTURES)))
	$(if $(LECTURE),,$(error invalid lecture!))
	$(eval LECTURE_FILE := lectures/$(SECTION)/$(LECTURE).scala)
	$(eval LECTURE_CLASS := lectures.$(SECTION).$(LECTURE))
	@echo option=$(SECTION)/$(LECTURE_NUM)={lecture=$(LECTURE) source=$(LECTURE_FILE) class=$(LECTURE_CLASS)}

compile-%: define-% 
	scalac -d $(SRC_DIR) $(SRC_DIR)/$(LECTURE_FILE)

run-%: compile-%
	scala -cp $(SRC_DIR) $(LECTURE_CLASS)

