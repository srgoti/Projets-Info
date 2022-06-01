#include <stdio.h>
#include <stdbool.h>

bool is_prime(long int n) {
	int maxi = 0;
	for (int i = 2; i < n; i++) {
		if (n % i == 0) return false;
	}
	return true;
}

long int primes(long int n) {
	int m;
	for (long int k = 2; k < n; k++) {
		if (k * k <= n) {
		if (n % k == 0 && is_prime(k)) {
			if (is_prime(n / k)) {
				m = n / k;
				break;
			}
		}
		}
	}
	return m;
}

int main() {
	printf("%ld\n", primes(600851475143));
}