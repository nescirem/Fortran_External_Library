# Basic Makefile for Fortran 90/95 dynamic library projects where 
# external modules are locate in $(MOD_DIR) directory, procedures
# are locate in $(SRC_DIR), and the built static library is $(LIBRARY)
# The .o and .mod are created in $(OBJ_DIR) directory
SHELL:=/bin/bash
SUFFIXES:=.f90

.SUFFIXES: # clear the suffixes
.SUFFIXES: $(SUFFIXES) .o
# Name of the static library without extension (assumed .a)
LIBRARY:=liblib
# Where source files are here
SRC_DIR:=src
# Where the modules are
MOD_DIR:=src/lib_in_lib
# Where to put .o .mod files
OBJ_DIR:=objects
# name of the library build-in
LIB:=lib_in_lib.a

# Compiler Flags
ifeq ($(FC),gfortran)
    LDFLAGS:= -fbacktrace -Wall -Wextra -Wno-maybe-uninitialized -Wno-unused-function -pedantic -std=f2008ts
else
    LDFLAGS:= -std15 -static-intel
endif
ifeq ($(FC),gfortran)
    FCFLAGS:=-I$(OBJ_DIR) -J$(OBJ_DIR)
else
    FCFLAGS:=-L$(OBJ_DIR)
endif

# RELEASE Only
OPTIMIZE:= -O2

# Getting the .o file name from source code
MOD_OBJECTS:=	$(patsubst $(MOD_DIR)/%,$(OBJ_DIR)/%,\
				 					$(patsubst %.f90,%.o,$(wildcard $(MOD_DIR)/*.f90))\
				  		)

# Getting the .o file name from source code
OBJECTS:=	$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,\
				 			$(patsubst %.f90,%.o,$(wildcard $(SRC_DIR)/*.f90))\
				  )

ALL_OBJECTS+=$(MOD_OBJECTS)
ALL_OBJECTS+=$(OBJECTS)

.PHONY: clean all info depend

VPATH:=$(OBJ_DIR) $(MOD_DIR) $(SRC_DIR)

# Default rule
# Display info, create $(OBJ_DIR),
# make dependancies and the static library

all: info depend $(LIBRARY)

# Display some info
info:
	@echo "make: Compiler options:"
	@echo "make: Compiler = $(FC)"
	@echo "make: OPTIMIZE = $(OPTIMIZE)"
	@echo "make: FCFLAGS = $(FCFLAGS)"
	@echo "make: LDFLAGS = $(LDFLAGS)"
	@echo "make: OBJECTS = $(OBJECTS)"

# Rule for the $(OBJ_DIR) directory
$(OBJ_DIR):
	@if [ ! -d $(OBJ_DIR) ]; then \
		echo 'make: Creating $(OBJ_DIR)/';\
		mkdir $(OBJ_DIR) ;	fi

# Getting the dependencies of the modules. This produces a file to include
depend: $(OBJ_DIR) $(MOD_OBJECTS)
	@echo 'make: Dependancies built'

# Rule for all file. Look at VPATH variable
$(OBJ_DIR)/%.o: %.f90
	@echo 'make: Compiling' $<
	@$(FC) $(LDFLAGS) $(OPTIMIZE) $(FCFLAGS) -o $@ -c $<

# Creating the library build-in
$(OBJ_DIR)/$(LIB): $(MOD_OBJECTS) $(OBJECTS)
	@echo 'make: Creating the library $@'
	@ar rv $@ $^
	@echo 'make: Library $@ successfuly created'

# Creating the static library
$(LIBRARY): $(ALL_OBJECTS)  $(OBJ_DIR)/$(LIB)
	@echo 'make: Stacticly linking objects'
	@ar rv $@.a $^
	@echo 'make: Static library '$@' successfuly created.'

clean:
	@echo 'make: rm -rf $(LIBRARY).a $(OBJ_DIR)'
	@-rm -rf $(LIBRARY).a $(OBJ_DIR)
