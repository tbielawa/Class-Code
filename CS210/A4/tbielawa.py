#!/usr/bin/env python

'''
# Assignment: (4) Implement 2 
#  graph functions.
# CS210 - VanScoy, Reaser
# Fall 2008
# Author: Tim 'Shaggy' Bielawa
# E-Mail: timbielawa@gmal.com
# Comments: 
'''

# return the highest number in a list of touples
def highest(graph):
    highest = 0
    for x, y in graph:
        if x > highest:
            highest = x
        if y > highest:
            highest = y
    return highest

# make a generic x,x 2 dimensional array
def makeGrid(length):
    grid = []
    for x in range(length + 1):
        grid.append([0 for x in range(length + 1)])
    return grid

# take a list of touples, mark xRy and yRx once
def makeMatrix(graph):
    grid = makeGrid(highest(graph))
    for x, y in graph:
        grid[y][x] = 1
        grid[x][y] = 1
    return grid

# This method works for undirected graphs.
# To apply it to digraphs you would do it
# in reverse as well
def is_complete(g):
    matrix = makeMatrix(g)
    sum = 0
    verts = len(matrix) - 1
    # Next line is the most important part of this whole thing
    for x in range(1,len(matrix)):
        sum = sum + len([n for n in matrix[x][x+1:] if n > 0])
    # Simple graph is complete if number of edges is
    # equal to [n * (n-1)] / 2, by definition
    completeEdges = (verts * (verts -1)) / 2
    if sum == completeEdges:
        return True
    else:
        return False
    # To be more general, and work with digraphs, one could
    # rewrite this to sum over all G(i,j) in graph G, skipping
    # when i = j, then comparing to (n^2 - n). 

# Sum number of edges in each row of matrix produced from
# graph g. Each row will have an equal number of edges if
# graph g is regular.
# This function discounts duplicates due to symmetry, but does
# not discount self reflexivity. I.E.: xRx is counted, while 
# xRy and yRx is only counted once
def is_regular(g):
    matrix = makeMatrix(g)
    rowSum = []
    for x in range(1,len(matrix)):
        rowSum.append(len([n for n in matrix[x] if n > 0]))
    # A set contains unique objects. A length greater than 1
    # is indicative of row sums returning unequal lengths.
    if len(set(rowSum)) > 1:
        return False
    else:
        return True
