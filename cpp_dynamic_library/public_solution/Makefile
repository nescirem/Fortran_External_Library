# Basic Makefile for Fortran 90/95 projects where external modules are
# locate in $(MOD_DIR) directory, Fortran external dynamic library is $(LIB) 
# procedures in $(SRC_DIR), and the main program is $(PROGRAM)
# The .o and .mod are created in $(OBJ_DIR) directory
SHELL:=/bin/bash
SUFFIXES:=.cpp

.SUFFIXES: # clear the suffixes
.SUFFIXES: $(SUFFIXES) .o

BIN_DIR:=binary
# Basename of main program
PROGRAM:=main
# Where public source files are
SRC_DIR:=src
# Where to put .o .mod files
OBJ_DIR:=objects
LIB_DIR:=./
# name of the dynamic library
LIB:=libdll.so

# Compiler Flags
LDFLAGS:= -Wall -Wextra
ifeq ($(CXX),g++)
    # do nothing
# else ifeq ($(CXX),icc)
    # LDFLAGS:=
else
    $(info Unknown Compiler "$(CXX)", set default 'gfortran')
    CXX:=g++
endif

ifndef $(DDBUG)
    OPTIMIZE:= -O2
endif
ifeq ($(DDBUG),debug)
    ifeq ($(CXX),gfortran)
        OPTIMIZE:= -std=c++11 -O0 -g3 -g -Wpendantic -Wunnused -Wshadow -Wold-style-cast -Wpointer-arith -Wcast-qual -Wmissing-prototypes -Wno-missing-braces
    # else
        # OPTIMIZE:= -O0 -g -Wunknown-pragmas -Wunused-function -Wreturn-type
    endif
else
    DDBUG:=release
    OPTIMIZE:= -O2
endif
ifeq ($(CXX),g++)
    FCFLAGS:=-I$(SRC_DIR) -L$(LIB_DIR)
# else
    # FCFLAGS:=
endif

# Getting the .o file name from source code
OBJECTS:=	$(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,\
				 			$(patsubst %.cpp,%.o,$(wildcard $(SRC_DIR)/*.cpp))\
				  )

.PHONY: clean all info depend

VPATH:=$(OBJ_DIR) $(SRC_DIR)

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
depend: $(BIN_DIR) $(OBJ_DIR)
	@echo 'make: Dependancies built'

# Rule for all file. Look at VPATH variable
$(OBJ_DIR)/%.o: %.cpp
	@echo 'make: Compiling' $<
	@$(FC) $(OPTIMIZE) $(LDFLAGS) $(FCFLAGS) -o $@ -c $<

# Creating the executable file
$(PROGRAM): $(OBJECTS) $(LIB)
	@echo 'make: Stacticly linking objects'
	@$(FC) $(OPTIMIZE) $(LDFLAGS) $(FCFLAGS) -o $(BIN_DIR)/$@ $^ -ldl
	@echo 'make: Program '$@' successfuly created.'

clean:
	@echo 'make: rm -rf $(BIN_DIR) $(OBJ_DIR)'
	@-rm -rf $(BIN_DIR) $(OBJ_DIR)
