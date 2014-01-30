include ../../Makefile.inc
include ../Makefile.inc

SCRIPT_PATH=../..

# Uncomment the following line to get all the cpp files
SRCS=$(shell ls *.c)

objects=$(SRCS:.c=.o)

all: build

# pull in all the dependency info for *existing* .o files
# This must be included AFTER the first build target
-include $(SRCS:.c=.d)

build: $(objects)

# This builds all the .d files from the .cpp files
# This example was pulled from http://www.gnu.org/software/make/manual/make.html#Automatic-Prerequisites
%.d : %.cpp
	@set -e; rm -f $@; \
	$(CXX) $(DEFINES) $(INCLUDES) -MM $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

.PHONY: clean all
clean:
	-rm *.o *.d 2> /dev/null
