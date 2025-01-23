#define _CRT_SECURE_NO_WARNINGS
#define _NO_CRT_STDIO_INLINE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

HANDLE h,h2;
COORD c;
int digits,exersices,is_again,delay;
clock_t start, end;
extern void cleen_line(HANDLE h,COORD c);
extern void one_exersice(int digits,HANDLE h, HANDLE h2,int seconds);
extern void print_results();
extern void zero();
void run() {
label:
	zero();
	printf("enter seconds to show exercise: ");
	scanf("%d",&delay);
	getchar();
	cleen_line(h, c);
	delay *= 1000;
	printf("enter amount of digits: ");
	scanf("%d", &digits);
	getchar();
	cleen_line(h, c);
	printf("enter amount of exersices: ");
	scanf("%d", &exersices);
	getchar();
	cleen_line(h,c);
	start = clock();
	while (exersices--) {
		one_exersice(digits,h, h2,delay);
	}
	end = clock();
	end -= start;
	end /= CLOCKS_PER_SEC;
	print_results();
	printf("%d:%d", end / 60, end % 60);
	Sleep(5000);
	cleen_line(h, c);
	printf("again enter 0 other exit: ");
	scanf("%d", &is_again);
	getchar();
	cleen_line(h,c);
	if (!is_again) {
		goto label;
	}
		
}
int main() {
	srand(time(NULL));
	c.X = c.Y = 0;
	h = GetStdHandle(-11);
	h2 = GetStdHandle(-10);
	run();
	return 0;
}