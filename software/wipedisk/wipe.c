#include <stdio.h>
#include <cpm.h>

FILE *f;

int n,e,tipo;

int main(int argc, char *arvg[]) {
    printf("Hello world from GP!\r\n");

    if(dir_move_first()) return;
    do {
       e = dir_get_entry_name();
       tipo = dir_get_entry_type();
       printf("%s -- %d",e,tipo);
       n = dir_move_next();
       printf("%d \r\n",n);
    } while (!n);

    printf("done");
}

/*
    f=fopen("SELECTOR.DOC","rb");
    if(f==NULL) printf("open failed\r\n");
    printf("%ld\r\n",ftell(f));
    fclose(f);
*/

/*
int dir_move_first()
int dir_move_next()
int dir_get_entry_type()
Result: 0=normal, 1=directory

char *dir_get_entry_name()
unsigned long dir_get_entry_size()
char *get_dir_name()
Directory stuff
  struct fcb *fc_dir;
  char fc_dirpos;
  char *fc_dirbuf;
*/