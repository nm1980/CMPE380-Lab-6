############################################################
# Makefile for line fitting C and C++ files
############################################################

# Standard compile flags for C and C++
CC        = gcc
CPP       = g++

# Control macros for timing/optimization flags
EN_TIME    = -DEN_TIME
MOVE_FOPEN = -DMOVE_FOPEN

# Compiler flags for the C and C++ programs
CFLAGS    = -O1 -g -Wall -std=c99 -pedantic $(EN_TIME) $(MOVE_FOPEN)
CPPFLAGS  = -O1 -g -Wall -std=c++98 -pedantic $(EN_TIME)

# Sources for the program
TARGET_C   = hw6c
TARGET_CPP = hw6cpp
SOURCE_C   = hw6c.c
SOURCE_CPP = hw6cpp.cpp

OUT        = out.txt
DATA       = data.txt

OBJS_C     = $(SOURCE_C:.c=.o)
OBJS_CPP   = $(SOURCE_CPP:.cpp=.o)

# Directives
.PHONY: all test mem clean help
.SILENT:

# Entry point to compile all
all: $(TARGET_C) $(TARGET_CPP)

# Linking step
$(TARGET_C): $(OBJS_C)
	@echo "Linking $(TARGET_C)"
	$(CC) $(CFLAGS) $^ -o $@

$(TARGET_CPP): $(OBJS_CPP)
	@echo "Linking $(TARGET_CPP)"
	$(CPP) $(CPPFLAGS) $^ -o $@

# Compiling step
%.o: %.c Timers.h
	@echo "Compiling C source files$<"
	$(CC) $(CFLAGS) -c $< -o $@
  
%.o: %.cpp Timers.h
	@echo "Compiling C++ source files$<"
	$(CPP) $(CPPFLAGS) -c $< -o $@
  
# Test step by running both the C++ and C files
test: $(TARGET_C) $(TARGET_CPP)
	@echo "------- Running C line program ------" > $(OUT) 2>&1
	./$(TARGET_C) $(DATA) >> $(OUT) 2>&1
	@echo "------- Running CPP line program ------" >> $(OUT) 2>&1
	./$(TARGET_CPP) $(DATA) >> $(OUT) 2>&1


# Entry point to clean up application and remove all exes, objs, etc.
clean:
	@echo "Cleaning all binaries, object, and test files"
	rm -f $(TARGET_C) $(OBJS_C) $(TARGET_CPP) $(OBJS_CPP) $(OUT)
 
# Entry point to list all Make targets
help:
	@echo " Makefile Targets for line fitting programs: "
	@echo " all: Builds the target file binary for both C and C++ files "
	@echo " test: Runs both C and C++ files using data.txt and returns output to out.txt "
	@echo " clean: cleans up all object, binaries, and output files "
	@echo " help: displays Makefile guide "