#!/usr/bin/env python

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
def makegrid(length):
    grid = []
    for x in range(length + 1):
        grid.append([0 for x in range(length + 1)])
    return grid

# take a list of touples, and mark #in-edges on a x,x grid
def makemap(graph):
    grid = makegrid(highest(graph))
    for x, y in graph:
        grid[y][x] += 1
    return grid

# list of who points at 'node'
def atMe(node, grid):
    pointers = []
    for x in range(1, len(grid)):
        if grid[node][x] > 0:
            pointers.append(x)
    return pointers

# list of who 'node' points at
def meAt(node, grid):
    pointers = []
    for y in range(1, len(grid)):
        if grid[y][node] > 0:
            pointers.append(y)
    return pointers

# every point mentioned in the whole graph
def allPoints(points):
    allPointsList = []
    for a, b in points:
        if allPointsList.count(a) == 0:
            allPointsList.append(a)
        if allPointsList.count(b) == 0:
            allPointsList.append(b)
    return allPointsList

# every node that points to another node
def allBases(points):
    allBases = []
    for a, b in points:
        if allBases.count(a) == 0:
            allBases.append(a)
    return sorted(allBases)

# method to get every point possible to visit from a point
def getAttachments(node, grid, visited=set([])):
    # get parents
    parents = atMe(node, grid)
    # get children
    children = meAt(node, grid)
    # create unique list from the two of them
    relatives = set(parents) | set(children) | visited
    return relatives

default = [(1, 2), (1, 2), (2, 3), (2, 4), (4, 4), (5, 6), (6, 5)]
print "Enter a list of touples in valid python format"
print "Or type 'default' to accept the default."
print default
ingraph = input()

nodes = allPoints(ingraph) # list of nodes
plot = makemap(ingraph) # this is a grid

# There's no real strategic place to start working from
#  so I picked the first node that points at anything
firstlist = getAttachments(nodes[0], plot, set([nodes[0]]))
known = firstlist

for x in known:
    newrels = getAttachments(x, plot, known)
    known = known | newrels
    new = known - firstlist
postsearch = new

# basically, after each point known is tried we have a new
# list of 'known' points. if we're still finding new points
# then the known points minus the last known points will be 
# not a null set. 
while not postsearch == set([]):
    lastknown = known
    for x in postsearch:
        newrels = getAttachments(x, plot, known)
        known = known | newrels
    postsearch = known - lastknown

# we need to see if the result of subtracting all discovered points
# from the set of initially read in points results in a null set.
# If that is the case, then the graph is connected.
# If points remain after the difference, then the set is disjoint.
if len(set(nodes) - known) > 0:
    disjoint = set(nodes) - known
    print "The set entered is a disjoint set.\n"
    print "I can say the following for certain:"
    print "The nodes listed below: "
    for x in disjoint:
        print "\t%s" % x
    print "...are not connected to the nodes listed below:"
    for x in set(nodes) - disjoint:
        print "\t%s" % x
    print "The level of seperation may be greater, but this much is certain"
else: 
    print "The set entered is not a disjoint set"
