// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

////////////////////
//泛型

func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

//栈
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 现在栈已经有4个string了


let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings


///////////////////////
//类型约束

//所有的 Swift 基本类型（如String，Int， Double和 Bool）默认都是可哈希。

func findStringIndex(array: [String], valueToFind: String) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    println("The index of llama is \(foundIndex)")
}
// 输出 "The index of llama is 2"


//Swift 标准库中定义了一个Equatable协议，该协议要求任何遵循的类型实现等式符（==）和不等符（!=）对任何两个该类型进行比较。所有的 Swift 标准类型自动支持Equatable协议。

func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2

/////关联类型(Associated Types)

//一个关联类型作为协议的一部分，给定了类型的一个占位名（或别名）。关联类型被指定为typealias关键字。

protocol Container {
    typealias ItemType   //不确定类型type
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack:Container{
    var items = [Int]()
    mutating func push(item:Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
    //typealias ItemType = Int   //类型会被自动推断，所以这句话可以省略。
    mutating func append(item:Int){
        self.push(item)
    }
    var count:Int {
    return items.count
    }
    subscript(i:Int) -> Int{
        return items[i]
    }
}

struct Stack2<T>: Container {
    // original Stack2<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
    return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

//是的，array已经实现了Container协议

extension Array: Container {}  //这里就是声明一下
//定义了这个扩展后，你可以将任何Array当作Container来使用。


////////Where 语句

func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
        
        // 检查两个Container的元素个数是否相同
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查两个Container相应位置的元素彼此是否相等
        for i in 0 ..< someContainer.count-1 {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 如果所有元素检查都相同则返回true
        return true
        
}
/////解析：
//
//C1必须遵循Container协议 (写作 C1: Container)。
//C2必须遵循Container协议 (写作 C2: Container)。
//C1的ItemType同样是C2的ItemType（写作 C1.ItemType == C2.ItemType）。
//C1的ItemType必须遵循Equatable协议 (写作 C1.ItemType: Equatable)。


var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings) {
    println("All items match.")
} else {
    println("Not all items match.")
}
// 输出 "All items match."


/////////////////////////
//高级运算符

//除了基本操作符中所讲的运算符，Swift还有许多复杂的高级运算符，包括了C语言和Objective-C中的位运算符和移位运算。

//位运算符

//按位取反运算符---按位取反运算符~对一个操作数的每一位都取反。

let initialBits: UInt8 = 0b00001111           //15
let invertedBits = ~initialBits  // 等于 0b11110000    //240

//按位与运算符

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // 等于 00111100

//按位或运算

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // 等于 11111110

//按位异或运算符---不同为1，相同为0

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // 等于 00010001

//按位左移、右移运算符

//对无符整型的移位的效果如下：
//已经存在的比特位向左或向右移动指定的位数。被移出整型存储边界的的位数直接抛弃，移动留下的空白位用零0来填充。这种方法称为逻辑移位。

let shiftBits: UInt8 = 4   // 即二进制的00000100
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

let pink: UInt32 = 0xCC6699  //十六进制中每两个字符是8比特位
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC, 即 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66, 即 102
let blueComponent = pink & 0x0000FF           // blueComponent 是 0x99, 即 153

//有符整型的移位操作

//有符整型通过第1个比特位(称为符号位)来表达这个整数是正数还是负数。0代表正数，1代表负数。
//负数呢，跟正数不同。负数存储的是2的n次方减去它的绝对值，n为数值位的位数。一个8比特的数有7个数值位，所以是2的7次方，即128。

//对有符整型按位右移时，不使用0填充空白位，而是根据符号位(正数为0，负数为1)填充空白位。

///////
//溢出运算符

var potentialOverflow = Int16.max
// potentialOverflow 等于 32767, 这是 Int16 能承载的最大整数
//potentialOverflow += 1
// 噢, 出错了

//当然，你有意在溢出时对有效位进行截断，你可采用溢出运算，而非错误处理。Swfit为整型计算提供了5个&符号开头的溢出运算符。
//溢出加法 &+
//溢出减法 &-
//溢出乘法 &*
//溢出除法 &/
//溢出求余 &%


//值的上溢出
var willOverflow = UInt8.max
// willOverflow 等于UInt8的最大整数 255
willOverflow = willOverflow &+ 1
// 此时 willOverflow 等于 0

//值的下溢出
var willUnderflow = UInt8.min
// willUnderflow 等于UInt8的最小值0
willUnderflow = willUnderflow &- 1
// 此时 willUnderflow 等于 255


var signedUnderflow = Int8.min
// signedUnderflow 等于最小的有符整数 -128
signedUnderflow = signedUnderflow &- 1
// 此时 signedUnderflow 等于 127

//除零溢出---运算符&/和&%进行除0操作时就会得到0值。
let x = 1
let y = x &/ 0
// y 等于 0


////////
//运算符函数----运算符重载

struct Vector2D {
    var x = 0.0, y = 0.0
}
@infix func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector 是一个新的Vector2D, 值为 (5.0, 5.0)

//实现一个前置或后置运算符时，在定义该运算符的时候于关键字func之前标注 @prefix 或 @postfix 属性。

@prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 为 (-3.0, -4.0)
let alsoPositive = -negative
// alsoPositive 为 (3.0, 4.0)


////////
//组合赋值运算符

//组合赋值是其他运算符和赋值运算符一起执行的运算.

//实现一个组合赋值符号需要使用@assignment属性，还需要把运算符的左参数设置成inout，因为这个参数会在运算符函数内直接修改它的值。

@assignment func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 现在为 (4.0, 6.0)

//前置的 组合运算符
@prefix @assignment func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
// toIncrement 现在是 (4.0, 5.0)
// afterIncrement 现在也是 (4.0, 5.0)

//默认的赋值符(=)是不可重载的。只有组合赋值符可以重载。三目条件运算符 a？b：c 也是不可重载。

///////
//比较运算符

@infix func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

@infix func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    println("这两个向量是相等的.")
}
// prints "这两个向量是相等的."

//////////
//自定义运算符

//个性的运算符只能使用这些字符 / = - + * % < > ! & | ^ . ~

operator prefix +++ {}   //先声明

@prefix @assignment func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在是 (2.0, 8.0)
// afterDoubling 现在也是 (2.0, 8.0)

/////////
//自定义中置运算符的优先级和结合性

//结合性(associativity)的值可取的值有left，right和none。
//结合性(associativity)的值默认为none，优先级(precedence)默认为100。

operator infix +- { associativity left precedence 140 }

func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 此时的值为 (4.0, -2.0)


let ar:[Int] = [1,2,3,3]  //语法变了，呵呵




