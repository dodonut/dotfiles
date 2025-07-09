#include <iostream>
#include <map>
using namespace std;

int main() {
  int i = 0;
  map<char, int> m;
  string c = "TEST";

  for (auto i : "TESTE DE STRING") {
    m[i] = 1;
  }

  cout << m['D'] << endl;
}
