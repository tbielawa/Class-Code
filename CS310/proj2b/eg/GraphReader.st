"XXXX need to generate a test suite to demonstrate Graph.st"
|g|
g := Graph new.
GraphReader new lines: 'eg/GraphReader.dat' for: g.
g width .
g height .
!
