// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

//函数形参可以定义外部名字
func join(string s1: String,toString s2: String, withJoiner joiner: String)-> String{
    return s1+joiner+s2
}

join(string: "hello", toString: "world", withJoiner: ", ")

//用#简写

func containsCharacter(#string: String,#characterToFind:Character)->Bool{
    for character in string {
        if character == characterToFind{
            return true
        }
    }
    return false
}

let containsAVee = containsCharacter(string: "safewwe" ,characterToFind:"e")

//默认形参值
func join2(string s1:String,toString s2:String,withJoiner joiner:String = " ")->String{
    return s1+joiner+s2
}

join2(string:"hello",toString:"world",withJoiner:"-")

join2(string:"hello",toString:"world")

//简写
func join3(s1:String,s2:String,joiner:String = " ")->String{
    return s1+joiner+s2
}

join3("hello","world",joiner:"-")

join3("hello","world")

////////////
//可变形参，最多只有一个，而且要放在最后。
func arithmeticMean(numbers:Double...)->Double{
    var total:Double = 0
    for number in numbers{
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1,2,3,4,5,6)
arithmeticMean(3,22,8)

//常量形参和变量形参（默认是常量，不可修改）
func alignRight(var string:String ,count:Int,pad:Character) -> String{
    let amountToPad = count - countElements(string)
    for _ in 1...amountToPad {
        string = pad + string
    }
    return string
}

let paddedString = alignRight("hello",9,"-")

//In-Out形参
//相当于引用传递
func swapTwoInts(inout a:Int,inout b:Int){
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

swapTwoInts(&someInt,&anotherInt)     //需要有&符号

println("\(someInt)    \(anotherInt)")


//////////////////////////
//函数类型
func addTwoInts(a:Int,b:Int) ->Int{
    return a+b
}

//类型为 （Int，Int） -> Int

var mathFunction: (Int,Int) -> Int = addTwoInts


//////////////////////////////
//类和结构体

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

someVideoMode.resolution.width

//结构体都有一个自动生成的成员逐一初始化方法

let vga = Resolution(width:640, height:480)

//结构体和枚举、数组、字典 都是值类型

//类是引用类型
//两个变量指向同一个对象


//等价于 ===
//不等价于  !==


///////////////////////////////////
//指针
//swift中的引用于其他的常量变量的定义方式相同



////////////////////////////
//集合Collection
//swift中数组和字典类型均以结构体的形式实现。

var a = [1,2,3]

var b = a

var c = a

a[0]

b[0]

c[0]
//////////////
a[0] = 42

b[0]

c[0]
//////////////
a.append(4)
a[0] = 777

b[0]

c[0]
//////////////
b[0] = 55

c[0]

//确保数组的唯一性

//b.unshare()

b[0] = 33

c[0]

///////////

if b===c {
    
}else{
    
}

if b[1...2] === c[1...2]{
    println("子数组具有相同的元素！")
}else{
    println("不相同")
}

//copy强制显性 浅复制

var names = ["a","b","c","d","edf","sdf"]
var copiedNames = names


/////////////////////////////////
//属性

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get{
        let centerX = origin.x + size.width/2
        let centerY = origin.y + size.height/2
        return Point(x:centerX ,y:centerY)
    }
    set(newCenter){
        origin.x = newCenter.x - size.width/2
        origin.y = newCenter.y - size.height/2
    }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
println("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// 输出 "square.origin is now at (10.0, 10.0)”

//便捷setter声明   ----newValue
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get {
        let centerX = origin.x + (size.width / 2)
        let centerY = origin.y + (size.height / 2)
        return Point(x: centerX, y: centerY)
    }
    set {
        origin.x = newValue.x - size.width/2
        origin.y = newValue.y - size.height/2
    }
    }
}

//只读属性
//只有 getter 没有 setter 的计算属性就是只读计算属性。

//只读计算属性的声明可以去掉get关键字和花括号

struct Cuboid {
    var width = 0.0 , height = 0.0 , depth = 0.0
    var volume:Double {
    return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4,height: 5,depth: 2)

println("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//////////////////
//属性监视器

//属性监视器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性监视器，甚至新的值和现在的值相同的时候也不例外。
//不需要为无法重载的计算属性添加属性监视器，因为可以通过 setter 直接监控和响应值的变化。

//willSet和didSet

class StepCounter {
    var totalSteps: Int = 0 {
    willSet(newTotalSteps){
        println("About to set totalSteps to \(newTotalSteps)")
    }
    didSet{
        if totalSteps > oldValue {
            println("Added \(totalSteps - oldValue) steps")
        }
    }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 350

//如果在didSet监视器里为属性赋值，这个值会替换监视器之前设置的值。

/////////////////////////
//全局变量和局部变量

var test:Double = 0 {
willSet{
    println("在全局或局部范围都可以为存储型变量定义监视器")
}
didSet{
    println("yes")
}
}
////
var center:Point {
get{
    return Point(x: 3.0,y: 4.0)
}
set{
    println("在全局或局部范围都可以定义计算型变量")
    test = newValue.x
}
}

//////////////////////////////
//类型属性

//为类型本身定义属性，不管类型有多少个实例，这些属性都只有唯一一份。

//C 语言中的静态常量/变量

//对于值类型（指结构体和枚举）可以定义存储型和计算型类型属性，对于类（class）则只能定义计算型类型属性。
//跟实例的存储属性不同，必须给存储型类型属性指定默认值

struct SomeStructure {
    static var storedTypeProperty = "some value."
    static var computedTypeProperty:Int {
       return 3
    }//只读的哦~
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty:Int {
        return 5
    }
}

class SomeClass {
    class var computedTypeProperty:Int {
        return 6
    }
}

//通过类型名来访问
println(SomeClass.computedTypeProperty)

println(SomeStructure.storedTypeProperty)

println(SomeStructure.storedTypeProperty)


/////////////////////////////
//方法Methods

//类、结构体、枚举都可以定义实例方法

//类、结构体、枚举也可以定义类型方法

//类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。

class Counter {
    var count = 0
    func increment(){
        count++
    }
    func incrementBy(amount:Int){
        count += amount
    }
    func reset(){
        count = 0
    }
}

let counter = Counter()
// 初始计数值是0
counter.increment()
// 计数值现在是1
counter.incrementBy(5)
// 计数值现在是6
counter.reset()
// 计数值现在是0

//方法的局部参数名称和外部参数名称

//方法和函数的局部名称和外部名称的默认行为是不一样的。

//Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称局部参数名称和外部参数名称。

class Counter2 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter2 = Counter2()
counter2.incrementBy(5, numberOfTimes: 3)
// counter value is now 15

//就类似于少些了#的函数~~
var count:Int = 0
func incrementBy(amount: Int, #numberOfTimes: Int) {
    count += amount * numberOfTimes
}

//修改方法的外部参数名称
//有时为方法的第一个参数提供一个外部参数名称是非常有用的，尽管这不是默认的行为。你可以自己添加一个显式的外部名称或者用一个井号（#）作为第一个参数的前缀来把这个局部名称当作外部名称使用。
//相反，如果你不想为方法的第二个及后续的参数提供一个外部名称，可以通过使用下划线（_）作为该参数的显式外部名称，这样做将覆盖默认行为。


class Counter3 {
    var count: Int = 0
    func incrementBy(amount: Int,_ numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    func incrementBy2(first amount: Int,_ numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    func incrementBy3(#amount: Int,_ numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter3 = Counter3()
counter3.incrementBy(5,3)
counter3.incrementBy2(first: 5,3)
counter3.incrementBy3(amount: 3,5)

//////////////////////////
//self属性(The self Property)

//类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。

//////
//在实例方法中修改值类型
//mutating
//一般情况下，值类型的属性不能在它的实例方法中被修改。
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point2(x: 1.0, y: 1.0)
somePoint.moveByX(2.0, y: 3.0)
println("The point is now at (\(somePoint.x), \(somePoint.y))")
// 输出 "The point is now at (3.0, 4.0)"

//注意：不能在结构体类型常量上调用变异方法，因为常量的属性不能被改变，即使想改变的是常量的变量属性也不行

let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)
// this will report an error


//在变异方法中给self赋值

//变异方法能够赋给隐含属性self一个全新的实例。

struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case Off, Low ,High
    mutating func next(){
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low

ovenLight.next()
ovenLight.next()

//////////////////////////////
//类型方法

//声明类的类型方法，在方法的func关键字之前加上关键字class；声明结构体和枚举的类型方法，在方法的func关键字之前加上关键字static

class SomeClass2 {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass2.someTypeMethod()


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
println("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// 输出 "highest unlocked level is now 2"（最高等级现在是2）


player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    println("player is now on level 6")
} else {
    println("level 6 has not yet been unlocked")
}
// 输出 "level 6 has not yet been unlocked"（等级6还没被解锁）







