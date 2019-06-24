# Basic Makefile for Fortran 90/95 projects where modules are
# locate in $(MOD_DIR) directory, procedures in $(SRC_DIR)
# and the main program is $(PROGRAM)
# The .o and .mod are created in $(OBJ_DIR) directory
SHELL:=/bin/bash
SUFFIXES:=.f90

.SUFFIXES: # clear the suffixes
.SUFFIXES: $(SUFFIXES) .o

BIN_DIR:=binary
# Basename of main program without extention (assumed .f90)
PROGRAM:=main
# Where the interface modules are
MOD_DIR:=src/interface
# Where public source files are
SRC_DIR:=src
# Where to put .o .mod files
OBJ_DIR:=objects
# name of the library
LIB:=libdll.so
# Compiler
FC:=gfortran
# Options for shared library
LDFLAGS:=
# Compiler options
# Leave -I,-J$(MOD_DIR) as .mod are put here
FCFLAGS:=-I$(OBJ_DIR) -J$(OBJ_DIR)

# Getting the .o file name from source code
MOD_OBJECTS:=	$(patsubst $(MOD_DIR)/%,$(OBJ_DIR)/%,\
				 					$(patsubst %.f90,%.o,$(shell ../../tools/make_depends_tree.sh $(MOD_DIR)))\
				  		)

# Getting the .o file name from source code
OBJECTS:=	$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,\
				 			$(patsubst %.f90,%.o,$(wildcard $(SRC_DIR)/*.f90))\
				  )

.PHONY: clean all info depend

VPATH:=$(OBJ_DIR) $(MOD_DIR) $(SRC_DIR)

# Default rule
# Display info, create $(OBJ_DIR),
# make dependancies and the main program

all: info depend $(PROGRAM)

# Display some info
info:
	@echo "make: Compiler options:"
	@echo "make: $(FCFLAGS)"
	@echo "objects: $(OBJECTS)"
	@echo "libs: $(LIB)"
		
# Rule for the $(BIN_DIR) directory
$(BIN_DIR):
	@if [ ! -d $(BIN_DIR) ]; then \
		echo 'make: Creating $(BIN_DIR)/';\
		mkdir $(BIN_DIR) ;	fi

# Rule for the $(OBJ_DIR) directory
$(OBJ_DIR):
	@if [ ! -d $(OBJ_DIR) ]; then \
		echo 'make: Creating $(OBJ_DIR)/';\
		mkdir $(OBJ_DIR) ;	fi

# Getting the dependencies of the modules. This produces a file to include
depend: $(BIN_DIR) $(OBJ_DIR) $(MOD_OBJECTS)
	@echo 'make: Dependancies built'

# Rule for all file. Look at VPATH variable
$(OBJ_DIR)/%.o: %.f90
	@echo 'make: Compiling' $<
	@$(FC) $(LDFLAGS) $(FCFLAGS) -o $@ -c $<

# Creating the executable file
$(PROGRAM): $(OBJECTS) $(LIB)
	@echo 'make: Stacticly linking objects'
	@$(FC) $(LDFLAGS) $(FCFLAGS) -o $(BIN_DIR)/$@ $^
	@echo 'make: Program '$@' successfuly created.'

clean:
	@echo 'make: rm -rf $(BIN_DIR) $(OBJ_DIR)'
	@-rm -rf $(BIN_DIR) $(OBJ_DIR)
