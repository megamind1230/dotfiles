#include <algorithm>
#include <bits/stdc++.h>
using namespace std;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  // ---- SOLUTION START ----
  int t;
  cin >> t;
  while (t-- > 0) {
    int n;
    cin >> n;
    long long sum = 0;
    for (int i = 0; i < n; i++) {
      long long x;
      cin >> x;
      sum += x;
    }
    cout << sum << "\n";
  }
  // ---- SOLUTION END ----
  return 0;
}
