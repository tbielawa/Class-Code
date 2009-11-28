#ifndef PCBMAN_H
#define PCBMAN_H

extern int pblock(char *);
extern int punblock(char *);
extern int psuspend(char *);
extern int presume(char *);
extern int psetprio(char *);
extern int pready_to_running();
extern int prunning_exit();
extern int prunning_to_ready();

#endif
