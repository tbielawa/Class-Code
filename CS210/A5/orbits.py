#!/usr/bin/env python

'''
# Assignment: (5) Implement basically anything 
#  using OpenGL. This project implements orbiting
#  bodies. Similar to a solar system.
# CS210 - VanScoy, Reaser
# Fall 2008
# Author: Tim 'Shaggy' Bielawa
# E-Mail: timbielawa@gmal.com
# Comments: I only wish I could have gotten textures
#  to work!!
# File: orbits.py
'''


from OpenGL.GLUT import *
from OpenGL.GLU import *
from OpenGL.GL import *
from sys import argv
from Planet import *

planetList = []

# Generate some heavenly bodies....
sun = Planet(name="The Sun", orbitRadius=0, planetRadius=.25, r=1, g=1, b=0, initOffset=0, speed=0.0)

earth = Planet(name="Earth", orbitRadius=1.5, planetRadius=.1, r=0, g=0, b=1, initOffset=0, speed=0.250)
earthMoon = Moon(name="The Earths Moon", orbitRadius=.28, planetRadius=0.05, r=.4, g=.455, b=.533, speed=.250*10)
earth.registerMoon(earthMoon)

saturn = Planet(name="Saturn", orbitRadius=3.3, planetRadius=.3, r=.3, g=.9, b=0.3, initOffset=180, speed=-.1)
saturn.registerMoon(Moon(name="Saturns Moon", orbitRadius=.35, planetRadius=0.05, r=.4, g=.0, b=.0, speed=.250*2))

neptune = Planet(name="Neptune", orbitRadius=6.4, planetRadius=.1, r=.2, g=.6, b=.33, initOffset=274, speed=-.3)

planetList.append(sun)
planetList.append(earth)
planetList.append(saturn)
planetList.append(neptune)

def coordmap():
    ll = 10 # Line Length
    
    glPushMatrix()

    glBegin(GL_LINES)
    glVertex3f(0, -ll, 0) # Y bottom
    glVertex3f(0, ll, 0) # Y top
    glVertex3f(-ll, 0, 0) # X left
    glVertex3f(ll, 0, 0) # X right
    glVertex3f(0, 0, -ll) # z far
    glVertex3f(0, 0, ll) # z near
    glEnd()

    glPopMatrix()

def display():
    global planetList
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    
    coordmap()

    for body in planetList:
        body.render()

    glutSwapBuffers()
    glutPostRedisplay()

def setup():
    glMatrixMode(GL_PROJECTION)
    gluPerspective(50.0, 1, 1, 40)
    gluLookAt(0, 0, 8,  0, 0, 0,  0, 1, 0)
    glMatrixMode(GL_MODELVIEW)
    glRotate(25, 1, 1, 1)
    glEnable(GL_DEPTH_TEST) # Enable so planets are correctly painted "behind" or "infront" of other planets

    # Lighting and coloring stuff
    # I won't even pretend to understand this
    glShadeModel(GL_SMOOTH)
    glEnable(GL_LIGHTING)
    glLightfv(GL_LIGHT0, GL_POSITION, [10.0, 10.0, 10.0, 1.0])
    glLightfv(GL_LIGHT0, GL_AMBIENT, [.50, .50, .50, .50])
    glEnable(GL_LIGHT0)

def main():
    global planetList
    glutInit(sys.argv)
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH)
    glutInitWindowSize(600,600)
    glutCreateWindow("Space!")

    setup()

    glutDisplayFunc(display)
    glutMainLoop()

if __name__ == "__main__": main()
