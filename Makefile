#!/bin/bash
.PHONY: clean rebuild all

BIN_FOLDER:=bin
BINARIES:=$(BIN_FOLDER)/libclient.so $(BIN_FOLDER)/server_cpp

WITH_RDTSC:=-DUSERDTSC

CPP_OPTS:=-pthread -Wall -Wpedantic -Wno-vla -Wextra -std=c++11
CPP_O3:=-O3 -march=native -fomit-frame-pointer
CPP_DEBUG:=-O0 -fno-omit-frame-pointer -g3 -ggdb

CPP_OPTS:=$(CPP_OPTS) $(CPP_O3) -DEPOLL_CALL_STATS

# CPP_OPTS=-fsanitize=address -pthread -O0 -Wall -Wpedantic -Wno-vla -Wextra -std=c++11 -g3 -ggdb -fno-omit-frame-pointer

COMPILER=g++

all: $(BINARIES)

$(BIN_FOLDER)/server_cpp: server.cpp Makefile	
		$(COMPILER) $(CPP_OPTS) $< -o $@

$(BIN_FOLDER)/libclient.so: client.cpp Makefile
		$(COMPILER) $(CPP_OPTS) -DBUILDSHARED -shared -fPIC $< -o $@ 

clean:
		rm -f $(BINARIES)

rebuild: clean all
