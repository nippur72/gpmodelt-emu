#include <stdio.h>
#include <stdlib.h>

void wait_one_second();

unsigned int speed=3350;  // 3350 is approx 1 seconds

int sec=55,min=-1;

int main(int argc, char *argv[]) {

  if(argc == 2) {
    speed = atoi(argv[1]);
  }

  printf("speed is %d\r\n",speed);

  while(1) {
    wait_one_second();
    if(++sec==60) {
      sec = 0;
      min++;
    }
    printf("%2d %2d\r\n",min,sec);
  }
}

void wait_one_second() {
  #asm

  ld hl, _speed
  ld e, (hl)
  inc hl
  ld d, (hl)

  ld h,d
  ld l,e

  outerloop:
  ld b, 64
  loophere:
    djnz loophere
  dec hl
  ld a,l
  or h
  jr nz, outerloop
  ret

  #endasm
}

