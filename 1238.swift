import Foundation


let f = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n, m, x) = (f[0], f[1], f[2])

struct Heap<T: Comparable> {
    var heap: Array<T> = []

    func isEmpty() -> Bool {
        return heap.count <= 1 ? true : false
    }

    init() {}
    init(_ data: T) {
        heap.append(data) // 0번째 인덱스 채우기 용
        heap.append(data)
    }

    mutating func insert(_ data: T) {
        guard !heap.isEmpty else {
            heap.append(data)
            heap.append(data)
            return
        }

        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 { return false }

            return heap[insertIndex / 2] < heap[insertIndex] ? true : false
        }

        heap.append(data)
        var insertIndex = heap.count - 1
        while isMoveUp(insertIndex) {
            heap.swapAt(insertIndex / 2, insertIndex)
            insertIndex /= 2
        }
    }

    enum moveDownStatus { case none, left, right }

    mutating func pop() -> T? {
        if heap.count <= 1 { return nil }

        let returnData = heap[1]
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()

        func moveDown(_ poppedIndex: Int) -> moveDownStatus {
            let leftChildIndex = (poppedIndex * 2)
            let rightChildIndex = leftChildIndex + 1

            if leftChildIndex >= heap.count {
                return .none
            }

            if rightChildIndex >= heap.count {
                return heap[leftChildIndex] > heap[poppedIndex] ? .left : .none
            }

            if (heap[leftChildIndex] < heap[poppedIndex]) && (heap[rightChildIndex] < heap[poppedIndex]) {
                return .none
            }

            if (heap[leftChildIndex] > heap[poppedIndex]) && (heap[rightChildIndex] > heap[poppedIndex]) {
                return heap[leftChildIndex] > heap[rightChildIndex] ? .left : .right
            }

            return heap[leftChildIndex] > heap[poppedIndex] ? .left : .right
        }

        var poppedIndex = 1
        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnData
            case .left:
                let leftChildIndex = poppedIndex * 2
                heap.swapAt(poppedIndex, leftChildIndex)
                poppedIndex = leftChildIndex
            case .right:
                let rightChildIndex = (poppedIndex * 2) + 1
                heap.swapAt(poppedIndex, rightChildIndex)
                poppedIndex = rightChildIndex

            }
        }
    }

}

struct NodePriority: Comparable {
    static func < (lhs: NodePriority, rhs: NodePriority) -> Bool {
        lhs.priority > rhs.priority
    }
    var node: String = ""
    var priority: Int = 0
}

func dijkstra(graph: [String: [String: Int]], start: String) ->  [String: Int] {
    var distances: [String: Int] = [:]
    var priorityQueue = Heap(NodePriority.init(node: start, priority: 0))

    for key in graph.keys {
        let value = key == start ? 0 : 2147483647
        distances.updateValue(value, forKey: key)
    }

    while !priorityQueue.isEmpty() {
        guard let popped = priorityQueue.pop() else { break }

        if distances[popped.node]! < popped.priority {
            continue
        }

        for (node, priority) in graph[popped.node]! {
            let distance = priority + popped.priority
            if distance < distances[node]! {
                distances[node] = distance
                priorityQueue.insert(NodePriority.init(node: node, priority: distance))
            }
        }
    }
    return distances
}

var graph = [String: [String: Int]]()
var array = [Int](repeating: 0, count: 1001)

for _ in 0..<m {
    let s = readLine()!.split(separator: " ").map { String($0) }
    let (start, end, value) = (s[0], s[1], Int(s[2])!)
    graph[start, default: [:]][end] = value
}

for i in 1...n {
    array[i] = dijkstra(graph: graph, start: String(i))[String(x)]!
}

dijkstra(graph: graph, start: String(x)).forEach { key, value in
    array[Int(key)!] += value
}

print(array.max()!)

