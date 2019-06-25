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
# path to the library
LIB_DIR:=library
# name of the library
LIB:=liblib.a

# Compiler Flags
ifeq ($(FC),gfortran)
    LDFLAGS:= -fbacktrace -Wall -Wextra -Wno-maybe-uninitialized -Wno-unused-function -pedantic -std=f2008ts
else
    LDFLAGS:= -std15 -static-intel
endif

ifndef $(DDBUG)
    OPTIMIZE:= -O2
endif
ifeq ($(DDBUG),debug)
    ifeq ($(FC),gfortran)
        OPTIMIZE:= -O0 -g3 -Warray-bounds -Wcharacter-truncation -Wline-truncation -Wimplicit-interface -Wimplicit-procedure -Wunderflow -fcheck=all -ffree-line-length-132 -fimplicit-none -fbacktrace -fdump-core -finit-real=nan -std=f2008ts -fall-intrinsics
    else
        OPTIMIZE:= -O0 -debug all -check all -warn all -extend-source 132 -traceback -gen-interfaces -fpe-all=0 -fp-stack-check -fstack-protector-all -ftrapuv -no-ftz -std15
    endif
else
    DDBUG:=release
endif
ifeq ($(FC),gfortran)
    FCFLAGS:=-I$(OBJ_DIR) -J$(OBJ_DIR)
else
    FCFLAGS:=-L$(OBJ_DIR)
endif

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
	@echo "make: Compiler = $(FC)"
	@echo "make: DDBUG = $(DDBUG)"
	@echo "make: OPTIMIZE = $(OPTIMIZE)"
	@echo "make: FCFLAGS = $(FCFLAGS)"
	@echo "make: LDFLAGS = $(LDFLAGS)"
		
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
	@$(FC) $(LDFLAGS) $(OPTIMIZE) $(FCFLAGS) -o $@ -c $<

# Creating the executable file
$(PROGRAM): $(OBJECTS) $(LIB_DIR)/$(LIB)
	@echo 'make: Stacticly linking objects'
	@$(FC) $(LDFLAGS) $(OPTIMIZE) $(FCFLAGS) -o $(BIN_DIR)/$@ $^
	@echo 'make: Program '$@' successfuly created.'

clean:
	@echo 'make: rm -rf $(BIN_DIR) $(OBJ_DIR)'
	@-rm -rf $(BIN_DIR) $(OBJ_DIR)
