typedef struct grades {
  char name[64];
  unsigned long id;
  float scores[11];
} grades;

grades g[60];
float *sp = &g[7].scores[3];
