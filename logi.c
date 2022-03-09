#include <stdio.h>

int log_2(int n) {
	if (n / 2 > 0) {
		return (1 + log_2(n / 2));
	} else return 0;
}

int logi(int n) {
	if (log_2(n) > 0) {
		return (1 + logi(n / 2));
	} else return 0;
}

int main() {
	int n;
	scanf("%d", &n);
	int res = log_2(logi(n));
	printf("%d\n", res);
	return 0;
}