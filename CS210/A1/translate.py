#!/usr/bin/env python

'''
Class: CS 210
Assignment: 1
Author: Timothy 'Shaggy' Bielawa
Email: timbielawa@gmail.com
'''

input = "input"

''' Modes used for flow control:
1 = building dictionary
2 = reading in string to translate '''
mode = 1

fp = open('input', 'r')
contents = fp.readlines()

dict = { '-': '.' } # Create the dictionary, initialize it
    # with handling for the periods

spanish = contents[0].rstrip() 
''' Apply rstrip() to the string object
to strip the '\n' from '''

x = 1

# Iterators are weird in python.....
for y in range(1, len(contents)):
	if mode == 1:
		if contents[x-1] == "-----\n":
			mode = 2
			continue
		else:
			dict[spanish] = contents[x].rstrip()
			spanish = contents[x+1].rstrip()
			x = x + 2
	elif mode == 2: # 
		if contents[x] == "-----\n":
			break
		else:
			key = contents[x].rstrip()
			print dict[key]
			x = x + 1
fp.close()

