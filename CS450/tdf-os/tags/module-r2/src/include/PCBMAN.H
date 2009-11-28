#ifndef PCBMAN_H
#define PCBMAN_H

extern int pblock(char *, PCBDLL **);
extern int punblock(char *, PCBDLL **);
extern int psuspend(char *, PCBDLL **);
extern int presume(char *, PCBDLL **);
extern int psetprio(char *, PCBDLL **);

#endif
