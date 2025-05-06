import Foundation

var arr = [[Int]](repeating: [], count: 101)
var visited = [Bool](repeating: false, count: 101)
let n = Int(readLine()!)!
let s = readLine()!.split(separator: " ").map { Int(String($0))! }
var trig = true
let (start, dest) = (s[0], s[1])
let m = Int(readLine()!)!
var cnt = 1

for _ in 0..<m {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr[temp[0]].append(temp[1])
    arr[temp[1]].append(temp[0])
}

dfs(start, cnt: 0)

func dfs(_ n: Int, cnt: Int) {
    if visited[n] { return }
    visited[n] = true
    for value in arr[n] {
        if value == dest {
            print(cnt + 1)
            trig = false
            break
        }

        dfs(value, cnt: cnt + 1)
    }
}

if trig { print("-1") }


