from OpenGL.GLUT import *
from OpenGL.GLU import *
from OpenGL.GL import *

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
# File: Planet.py
'''

class Planet:
    def __init__(self, name, orbitRadius, planetRadius, r, g, b, speed=0.250, initOffset=0):
        self.name = name
        self.orbitRadius = orbitRadius
        self.planetRadius = planetRadius
        self.color = (r, g, b)
        self.speed = speed
        self.offset = initOffset
        self.moons = []

    def registerMoon(self, newMoon):
        self.moons.append(newMoon)

    def reportMoons(self):
        print "Moons registered to %s" % self.name
        for moon in self.moons:
            print moon.name

    def render(self):
        glPushMatrix()
        glRotate(self.offset, 0, 1, 0)
        glTranslate(self.orbitRadius, 0, 0)
        glMaterialfv(GL_FRONT, GL_AMBIENT, [self.color[0], self.color[1], self.color[2], 1.0])
        glutSolidSphere(self.planetRadius, 20, 20)

        for moon in self.moons:
            moon.renderMoon()

        glPopMatrix()
        self.offset = self.offset + self.speed
        if self.offset > 360:
            self.offset = self.offset - 360

class Moon(Planet):
    def renderMoon(self):
        glRotate(self.offset, 0, 1, 0)
        glTranslate(self.orbitRadius, 0, 0)

        glMaterialfv(GL_FRONT, GL_AMBIENT, [self.color[0], self.color[1], self.color[2], 1.0])
        glutSolidSphere(self.planetRadius, 40, 40)

        self.offset = self.offset + self.speed
        if self.offset > 360:
            self.offset = self.offset - 360
        if self.offset < -360:
            self.offset = self.offset + 360
