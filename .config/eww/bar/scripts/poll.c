#include <stdbool.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "Incorrect arguments");
    return -1;
  }

  char out[256];
  char last_out[256];

  FILE *fp;
  char cmd[128] = {0};

  char *c = "";
  for (int i = 1; i < argc; i++) {
    c = strcat(cmd, argv[i]);
    c = strcat(cmd, " ");
  }
  fprintf(stderr, "%s\n", cmd);

  for (;;) {
    fp = popen(cmd, "r");
    if (fp == NULL) {
      fprintf(stderr, "Could not execute command");
      return -1;
    }

    fgets(out, sizeof(out), fp);
    pclose(fp);

    if (strncmp(last_out, out, 256) != 0) {
      bool newline = false;
      for (int i = 0; out[i] != '\0'; i++) {
        fputc(out[i], stdout);
        if (out[i] == '\n') {
          newline = true;
        }
      }
      if (!newline) {
        fputc('\n', stdout);
      }
      fflush(NULL);
      strncpy(last_out, out, 256);
    }
  }
}
