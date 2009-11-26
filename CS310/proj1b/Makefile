include lib.mk

# What group are you?
Group=82876623

# What project are you doing
Proj=proj1

# Directory of test inputs
Testdir= $(Here)/eg

# Filters to pipe together to process the test inputs.
# If multiple filters, they are piped together.
# Warning: make sure there is no blank space at end of line.
Filters=$(Here)/graph.awk

# Default test to run
X=1  

# Banner for top of each test
Hi=  printf "\n---| $X |-----------------------------------------\n\n"

# Default action (run test $X)
all :  
	echo $(Group)
	@$(MAKE) X=$X test

