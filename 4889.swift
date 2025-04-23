import Foundation

var cnt = 1

while true {
    var stack: [String] = []
    var stackCount = 0
    let inputString = readLine()!

    if (inputString.contains { $0 == "-" }) { break }
    let arr = inputString.map { String($0) }
    for i in 0..<arr.count {
        let bracket = arr[i]

        if stack.count == 0 {
            stack.append(bracket)
            continue
        }

        if bracket == "}" {
            if stack.last! == "{" {
                _ = stack.popLast()
            }
            else {
                stack.append(bracket)
            }
        }
        else {
            stack.append(bracket)
        }
    }

    for i in stride(from: 0, to: stack.count, by: 2) {
        if Array(stack[i...(i + 1)]).joined() == "{{" {
            stackCount += 1
        }
        else if Array(stack[i...(i + 1)]).joined() == "}}" {
            stackCount += 1
        }
        else {
            stackCount += 2
        }
    }

    print("\(cnt). \(stackCount)")
    cnt += 1
}

