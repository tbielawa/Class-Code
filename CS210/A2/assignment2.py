#!/usr/bin/env python
import re
import os

# 'clean' is a recursive method. It's much more fun that way
# Argument 'input' is required. Must be a string of length
#  1 or greater. Index is optional.
# Returns the input string without any crap on the head or tail
#  and most junk removed from the middle
def clean(input="", index=0):
    ok_at_ends = re.compile("[a-zA-Z0-9]")
    ok_in_middle = re.compile("[a-zA-Z0-9\-']")

    # Fix characters in the middle. They have their own rules
    if index > 0 and index < len(input):
        if not ok_in_middle.search(input[index]):
            input = input[:index-1] + input[index+1:]

    # Fix first character
    if not ok_at_ends.search(input[0]):
        input = input[1:]
    
    # Fix last character
    if not ok_at_ends.search(input[len(input)-1]):
        input = input[:len(input)-1]

    # If not at end, call clean() again and start cleaning junk
    # out of the middle of the word.
    if index == len(input):
        return input
    elif len(input) > 1:
        input = clean(input, index+1)

    return input

# Takes no items
# Returns: A touple where the first item is
#          a filepointer to the document that's been read in.
#          The second item is a list containing every line in 
#          the document. 
# Bonus functionality: has a crappy welcome message
def getInputData():
    print "This is the one program to rule them all. \n"\
        "This will astound you with its ability to take a file name you will \n"\
        "enter below and then create an output so worthless, you could only \n"\
        "call it a \"concordance.\"\n"

    print "There is no easy way to deal with literary operators like \"--\" \n" \
        "being incorrectly typed without a space on either side of them. \n"\
        "In other words, 'Through the Looking-Glass' as presented on Gutenberg \n"\
        "would have numerous parsing errors :-) \n"
    # Can you tell I spent some time on that?

    print "If all that hasn't scared you away, then you may continue.\n"

    print "The output from this program will also be written to a file \n"\
        "called 'concord.log'\n"

    print "Enter the name of, or path to a file. (~/input.txt, /tmp/input.txt, \n"\
        "and 'input.txt' are all equally acceptable input): "
    inputFile = raw_input("File: ")
    file = os.path.expanduser(inputFile)

    try:
        fp = open(file, "r")
    except IOError, c:
        print "Error cought. It said:"
        print "\t\"%s\"" % c
        print "\nBailing!"
        exit()

    inputDocument = fp.readlines()
    fp.seek(0)
    return (fp, inputDocument)

# Requires a file pointer as an argument 
#   File Pointer should be pointing an any generic
#   text document
# Returns: A dictionary where each key is a word and
#          each value is a list containing the lines 
#          the key occurs on.
def parseInputData(FP):
    inputData = {}
    i = 0
    for line in FP:
        for word in line.split():
            word = word.upper()
            word = clean(word)
            if word not in inputData.keys():
                inputData[word] = [i]
            else:
                inputData[word].append(i)
        i += 1
    FP.close()
    return inputData

# Requires an argument which is a dictionary in the format returned
#  by parseInputData(). Strings as keys, lists of line numbers as
#  the values.
# Requires an argument which is a list where each element 
#  containins the next line from the document read in
# Returns nothing. Just prints out a lot of stuff.
def printParsedInput(inputData, inputDocument):
    try:
        logging = True
        LOG = open("concord.log", 'w')
    except IOError, c:
        logging = False

    wordList = set(inputData.keys())
    
    for k in sorted(wordList):
        print "\n"
        if logging: LOG.write("\n")
        uniques = (set(inputData[k]) | set(inputData[k]))
        print "%s (%d)" % (k, len(uniques))
        if logging: LOG.write("%s (%d)\n" % (k, len(uniques)))
        for line in sorted(uniques):
            print "%03d %s" % (int(line), inputDocument[line]),
            if logging: LOG.write("%03d %s" % (int(line), inputDocument[line]))
    if logging: LOG.flush() # lol
    if logging: LOG.close()

    if logging:
        print "\nOutput was written to 'concord.log'"
    else:
        print "\nThere was a problem. Output could not be written to concord.log"
        print "It said: \n\t%s" % c


# Now that all that is out of the way, I guess I should actually do
#  something with all those methods I wrote.

(fp, inputDocument) = getInputData()
inputData = parseInputData(fp)
printParsedInput(inputData, inputDocument)
