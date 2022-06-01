int u0 = 42;
int m;

int power (int k, int n) {
    if (n > 0) {
        return k * power(k, n - 1);
    } else {
        return 1;
    }
}

int u(int i) {
    if (i > 0) {
        return ((2035 * u(i - 1)) % m);
    } else {
        return u0;
    }
}

int v(int i, int j) {
    return (j + 1) * u(i + j) / m;
}

int main() {
    m = power(2, 20) + 7;
}