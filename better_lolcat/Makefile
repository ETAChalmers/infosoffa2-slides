all : ArgumentParser.o rainbow

CPP = g++
CPPOPTS = -g

ArgumentParser.o : ArgumentParser.cpp
	$(CPP) -c ArgumentParser.cpp -o ArgumentParser.o $(CPPOPTS)

rainbow : rainbow.cpp ArgumentParser.o
	$(CPP) -o rainbow rainbow.cpp ArgumentParser.o $(CPPOPTS)

clean :
	rm *.o
