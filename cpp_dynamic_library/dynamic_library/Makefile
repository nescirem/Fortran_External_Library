# Basic Makefile for Fortran 90/95 dynamic library projects where procedures are
# locate in $(SRC_DIR), and the built dynamic library is $(LIBRARY)
# The .o and .mod are created in $(OBJ_DIR) directory
SHELL:=/bin/bash
SUFFIXES:=.f90

.SUFFIXES: # clear the suffixes
.SUFFIXES: $(SUFFIXES) .o
# Name of the dynamic library without extension (assumed .so)
LIBRARY:=libdll
# Where source files are here
SRC_DIR:=src
# Where to put .o and .mod files
OBJ_DIR:=objects

# Compiler Flags
LDFLAGS:= -fbacktrace -Wall -Wextra -Wno-maybe-uninitialized -Wno-unused-function -pedantic -std=f2008ts
ifeq ($(FC),gfortran)
    # do nothing
else ifeq ($(FC),ifort)
    LDFLAGS:= -std15 -static-intel
else
    $(info Unknown Compiler "$(FC)", set default 'gfortran')
    FC=gfortran
endif
ifeq ($(FC),gfortran)
    FCFLAGS:=-I$(OBJ_DIR) -J$(OBJ_DIR)
else
    FCFLAGS:=-L$(OBJ_DIR)
endif

# RELEASE Only
OPTIMIZE:= -O2

# Getting the .o file name from source code
OBJECTS:=	$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,\
				 			$(patsubst %.f90,%.o,$(wildcard $(SRC_DIR)/*.f90))\
				  )

.PHONY: clean all info depend

VPATH:=$(OBJ_DIR) $(SRC_DIR)

# Default rule
# Display info, create $(OBJ_DIR),
# make dependancies and the static library

all: info $(OBJ_DIR) $(LIBRARY)

# Display some info
info:
	@echo "make: Compiler options:"
	@echo "make: Compiler = $(FC)"
	@echo "make: OPTIMIZE = $(OPTIMIZE)"
	@echo "make: FCFLAGS = $(FCFLAGS)"
	@echo "make: LDFLAGS = $(LDFLAGS)"
	@echo "make: OBJECTS = $(OBJECTS)"
	
# Getting the dependencies of the modules. This produces a file to include
depend: $(OBJ_DIR)
	@echo 'make: Dependancies built'
	
# Rule for all file. Look at VPATH variable
$(OBJ_DIR)/%.o: %.f90
	@echo 'make: Compiling' $<
	@$(FC) -fPIC $(OPTIMIZE) $(LDFLAGS) $(FCFLAGS) -o $@ -c $<


# Rule for the $(OBJ_DIR) directory
$(OBJ_DIR):
	@if [ ! -d $(OBJ_DIR) ]; then \
		echo 'make: Creating $(OBJ_DIR)/';\
		mkdir $(OBJ_DIR) ;	fi

# Creating the dynamic library
$(LIBRARY): $(OBJECTS)
	@echo 'make: Dynamically linking objects'
    
	@$(FC) $(OPTIMIZE) $(LDFLAGS) $(FCFLAGS) $^ -shared  -o $@.so
	@echo 'make: Dynamic library '$@' successfuly created.'

clean:
	@echo 'make: rm -rf $(LIBRARY).so $(OBJ_DIR)'
	@-rm -rf $(LIBRARY).so $(OBJ_DIR)
