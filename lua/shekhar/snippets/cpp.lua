local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- DSA template snippets for C++
return {
  -- Main DSA template
  s("dsa", {
    t({
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "#define ll long long",
      "#define vi vector<int>",
      "#define vll vector<long long>",
      "#define pii pair<int, int>",
      "#define pll pair<long long, long long>",
      "#define pb push_back",
      "#define mp make_pair",
      "#define all(x) (x).begin(), (x).end()",
      "#define rall(x) (x).rbegin(), (x).rend()",
      "#define sz(x) (int)(x).size()",
      "#define F first",
      "#define S second",
      "",
      "void solve() {",
      "    ",
    }),
    i(1, "// Your code here"),
    t({
      "",
      "}",
      "",
      "int main() {",
      "    ios_base::sync_with_stdio(false);",
      "    cin.tie(NULL);",
      "    ",
      "    #ifdef LOCAL",
      "    freopen(\"input.txt\", \"r\", stdin);",
      "    freopen(\"output.txt\", \"w\", stdout);",
      "    #endif",
      "    ",
      "    int t = 1;",
      "    // cin >> t;",
      "    while(t--) {",
      "        solve();",
      "    }",
      "    return 0;",
      "}",
    }),
  }),

  -- Simple main template
  s("cppmain", {
    t({
      "#include <iostream>",
      "#include <vector>",
      "#include <algorithm>",
      "using namespace std;",
      "",
      "int main() {",
      "    ",
    }),
    i(1, "// Your code here"),
    t({
      "",
      "    return 0;",
      "}",
    }),
  }),

  -- Fast I/O template
  s("fastio", {
    t({
      "ios_base::sync_with_stdio(false);",
      "cin.tie(NULL);",
      "cout.tie(NULL);",
    }),
  }),

  -- Debug macro
  s("debug", {
    t({
      "#ifdef LOCAL",
      "#define debug(x) cerr << #x << \" = \" << (x) << endl",
      "#else",
      "#define debug(x)",
      "#endif",
    }),
  }),

  -- Vector input
  s("vinput", {
    t("vector<"),
    i(1, "int"),
    t("> "),
    i(2, "v"),
    t("("),
    i(3, "n"),
    t({ ");", "for(auto &x : " }),
    f(function(args)
      return args[1][1]
    end, { 2 }),
    t(") cin >> x;"),
  }),

  -- Print vector
  s("vprint", {
    t("for(auto x : "),
    i(1, "v"),
    t(') cout << x << " ";'),
    t({ "", "cout << endl;" }),
  }),

  -- Common DSA patterns
  s("binary_search", {
    t({
      "int left = 0, right = n - 1;",
      "while(left <= right) {",
      "    int mid = left + (right - left) / 2;",
      "    if(arr[mid] == target) return mid;",
      "    if(arr[mid] < target) left = mid + 1;",
      "    else right = mid - 1;",
      "}",
      "return -1;",
    }),
  }),

  s("sliding_window", {
    t({
      "int left = 0, right = 0;",
      "int result = 0;",
      "while(right < n) {",
      "    // Add arr[right] to window",
      "    ",
    }),
    i(1, "// Update window state"),
    t({
      "",
      "    ",
      "    // Shrink window if needed",
      "    while(/* condition */) {",
      "        // Remove arr[left] from window",
      "        left++;",
      "    }",
      "    ",
      "    // Update result",
      "    result = max(result, right - left + 1);",
      "    right++;",
      "}",
    }),
  }),

  s("two_pointers", {
    t({
      "int left = 0, right = n - 1;",
      "while(left < right) {",
      "    ",
    }),
    i(1, "// Process pair at left and right"),
    t({
      "",
      "    if(/* condition to move left */) {",
      "        left++;",
      "    } else if(/* condition to move right */) {",
      "        right--;",
      "    } else {",
      "        // Found solution",
      "        left++;",
      "        right--;",
      "    }",
      "}",
    }),
  }),

  -- Graph DFS
  s("dfs", {
    t({
      "void dfs(int node, vector<vector<int>>& graph, vector<bool>& visited) {",
      "    visited[node] = true;",
      "    ",
    }),
    i(1, "// Process node"),
    t({
      "",
      "    ",
      "    for(int neighbor : graph[node]) {",
      "        if(!visited[neighbor]) {",
      "            dfs(neighbor, graph, visited);",
      "        }",
      "    }",
      "}",
    }),
  }),

  -- Graph BFS
  s("bfs", {
    t({
      "void bfs(int start, vector<vector<int>>& graph) {",
      "    int n = graph.size();",
      "    vector<bool> visited(n, false);",
      "    queue<int> q;",
      "    ",
      "    q.push(start);",
      "    visited[start] = true;",
      "    ",
      "    while(!q.empty()) {",
      "        int node = q.front();",
      "        q.pop();",
      "        ",
      "        ",
    }),
    i(1, "// Process node"),
    t({
      "",
      "        ",
      "        for(int neighbor : graph[node]) {",
      "            if(!visited[neighbor]) {",
      "                visited[neighbor] = true;",
      "                q.push(neighbor);",
      "            }",
      "        }",
      "    }",
      "}",
    }),
  }),
}
