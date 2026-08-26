#include <stdio.h>

int main(void) {
  // ---- SOLUTION START ----
  int t;
  if (scanf("%d", &t) != 1)
    return 0;
  while (t-- > 0) {
    int n;
    scanf("%d", &n);
    long long sum = 0;
    for (int i = 0; i < n; i++) {
      long long x;
      scanf("%lld", &x);
      sum += x;
    }
    printf("%lld\n", sum);
  }
  // ---- SOLUTION END ----
  return 0;
}
