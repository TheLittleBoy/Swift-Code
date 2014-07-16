// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let name = "my name is wangxuanao"

var label = str + name

let width = 90

let widthlebel = label + String(width)

let summary = "I have \(width) ieces of fruit"

var shoppingList = ["catfish","water","tulips","blue paint"]

shoppingList[1] = "bottle of water"

let dictionary = ["malcolm":"captain","kaylee":"mechanic"]

let value = dictionary["malcolm"]

println(value);


////////////////p10

var firstforLoop = 0
for i in 0...3{
firstforLoop += i
}
firstforLoop

////////////////p11

func greet(name:NSString,day:String) -> String{
    return "Hello \(name),today is \(day)."
}

greet("wang xuan ao", "Tuesday")

//=======

func getGasPrices() -> (String,Double,Int32)
{
    return ("ao",23.21,3);
}

var a = getGasPrices()

a.0
a.1
a.2

//=====

func sumOf(numbers:Int...) ->Int{
    var sum = 0
    for number in numbers{
        sum += number
    }
    
    return sum
}

sumOf()

sumOf(42,579,12)


////////////////p12

//返回一个函数最为返回值
func makeIncrementer() -> (Int -> Int){
    func addOne(number :Int) -> Int{
        return 1+number;
    }
    return addOne
}

var increment = makeIncrementer();

increment(7)

//函数还可以作为参数传递进去，类似于block


////////////////p15

class NamedShape{
    var numberOfSides: Int = 0

    var name: String = ""
    
    func simpleDescription(){
       
    }
    
    init(name:String)
    {
        self.name = name
    }
    
    deinit{
        
    }
}

////////////////p16\p17

class Square:NamedShape{
    
    var sideLength: Double = 0.0
    
    //有点C++的意思
    init(){
        super.init(name: "a")
    }
    
    //重写
    override func simpleDescription(){
        println("adlfsjlks")
    }
    
    var perimeter:Double {
        get {
            return 4.0 * sideLength
        }
        set {
            sideLength = newValue/3.0
        }
    
    }
}

let test = Square()
test.perimeter
test.perimeter = 9.9
test.perimeter
test.simpleDescription()


////////////////p21

enum Rank: Int {
    case Ace = 1
    case Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten
    case Jack,Queen,King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.toRaw())
        }
    }
}
let ace = Rank.Eight
let aceRawvalue = ace.toRaw()
ace.simpleDescription()
let acc3 = Rank.fromRaw(3)
//acc3.simpleDescription()       //???


////////////////p23

struct Card{
    var rank: Rank
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of Rank"
    }
}

let threeOfSpades = Card(rank: .Three)

let threeOfSpadesDescription = threeOfSpades.simpleDescription()


////////////////p25

//协议-----class enum struct 都可以使用
protocol ExampleProtocol {
    
    var simpleDescription: String {get}
    
    mutating func adjust()
}

struct SimpleStructure: ExampleProtocol{
    
    var simpleDescription: String = "A simple Structure"
    mutating func adjust(){
        simpleDescription += " (adjusted)"
    }
    func anotherFunc() -> String
    {
        return simpleDescription
    }
}

var b = SimpleStructure()
b.adjust()

let bs = b.simpleDescription

////////////////p26

//扩展
extension Int: ExampleProtocol{
    var simpleDescription: String {
    return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
    
    func anotherFunc() -> String
    {
        return simpleDescription
    }
}

5.simpleDescription
5.anotherFunc()

let protocolValue:ExampleProtocol = b
protocolValue.simpleDescription
//protocolValue.anotherFunc()   //error 仅能用protocol里边定义的


////////////////p27

//Generics    泛型 类似于C++的Template

func repeat<ItemType>(item: ItemType,times: Int) -> [ItemType]{
    var result = [ItemType]()
    for i in 0 ..< times {
        result += item
    }
    return result
}

var s = repeat("knock",4)

//
enum OptionalValue<T> {
    case None
    case Some(T)
    
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

////////////////p28

//泛型也可以确定范围  where

///////////////////////

let minUInt8Value = UInt8.min    //无符号

let maxUInt8Value = UInt8.max    //2^8-1  最大值记得-1

let maxInt8Value = Int8.max   //2^7-1    有符号

let maxIntValue = Int32.max

let minIntValue = Int32.min

let oneMillion:Double = 1_000_000.00_1    //方便易读

let one: UInt16 = 2_000

let two: UInt8 = 1

let oneAndtwo = one + UInt16(two)

//let three = one + two    //error!

let aadsf = Int(oneMillion)  //强制类型转换

//let minFloatValue = Float.min      //error  没有该方法

//let maxDoubleValue = Double.max     //error

//别名
typealias anOtherName = UInt16

let minOtherName = anOtherName.min

var i2 = 1

if i2 == 1 {
    i2++
}

//元组

let http404Error = (404,"not found")

let demo23 = (10,12,32,3,3)

//拆分元祖
let (statusCode, statusMessage) = http404Error

println("The status code is \(statusCode)")

println("the status message is \(statusMessage)")

let (onlyNeesOneValue, _) = http404Error

http404Error.1

let http200Status = (statusCode: 200, description:"Ok")

http200Status.statusCode



let possibleNumber = "123hello"
let convertedNumber = possibleNumber.toInt()    //nil

if convertedNumber {
    println("\(possibleNumber) has an integer value of \(convertedNumber!)")
}else{
    println("\(possibleNumber) could not be converted to an integer");
}


var serverResponseCode: Int? = 404

serverResponseCode = nil

var surveyAnswer: String?

let assumedString: String! = "An assumed string."

println(assumedString)


//断言

let age = -3

//assert(age >= 0)
//assert(age >= 0, "age cannot be less than zero")

///////////////////

//运算符
let (x,y) = (1,2)

var safsalkdf = -9 % 4

safsalkdf = -9 % -4

safsalkdf = 9 % -4

var ssafsalkdf = 8 % 2.5

//区间运算符

for index in 1...5 {
    println("\(index)*5 = \(index*5)")
}

var emptyString = ""

if emptyString.isEmpty {

}

emptyString += "your name" + "  sdf"


for character in emptyString {
    println(character)
}

let yenSign: Character = "￥"

let alskf = countElements(emptyString)   //最后的\0也算上了！

if emptyString.hasPrefix("your")
{
    println(emptyString.uppercaseString)  //大写
}
if emptyString.hasSuffix("sdf")
{
    println(emptyString.lowercaseString)   //小写
}


for codeUnit in emptyString.utf8 {
    println("\(codeUnit)")
}

////////////////////////
//数组
var shoppingList2: [String] = ["Eggs", "Milk"]

var shoppingList3 = [2,3]

shoppingList2.count

if shoppingList3.isEmpty {}

shoppingList2.append("Flour")

shoppingList2 += "Baking Powder"

shoppingList2 += ["Chocolate sprad","Cheese"]

var firstItem = shoppingList2[0]

shoppingList2[1] = "6 eggs"

shoppingList2[2...4] = ["Bananas","Apples"]

shoppingList2.insert("Mapple Syrup", atIndex:0)

let mapple = shoppingList2.removeAtIndex(0)

let apples = shoppingList2.removeLast()

for item in shoppingList2 {
    
    println(item)
    
}

for (index, value) in enumerate(shoppingList2) {
    println("Item \(index+1): \(value)")
}

////
var someInts = [Int]()   //空数组

someInts.append(3)

someInts = []   //赋值为空数组，但是仍然是Int[]类型

//////

var threeDoubles = [Double](count: 3,repeatedValue:0.0)   //[0.0, 0.0, 0.0]

var anotherThreeDoubles = Array(count: 3,repeatedValue:2.5) //[2.5, 2.5,2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles


///////////////////////////////
//字典

var airports: Dictionary<String,String> = ["TYO":"Tokyo","DUB":"Dublin"]

var airports2 = ["TYO":"Tokyo","DUB":"Dublin"]   //自动判断类型

var countairports = airports.count

airports["NEW"] = "London"   //新增加

airports["NEW"] = "London Heathrow"   //修改已有的值

if let oldValue = airports.updateValue("LONDON",forKey:"NEW")
{
    println("The old value for NEW was \(oldValue).")
}

if let airportName = airports["DBG"]{
    
}
else
{
    println("That airport is not in the dictionary")
}

/////
airports["TYO"] = nil   // 删除TYO

if let removedValue = airports.removeValueForKey("DBG")
{
    
}
else
{
    println("The airports dictionary does not contain a value for DUB.")
}

///////

for (airportCode, airportName) in airports{
    println("\(airportCode):\(airportName)")
}

for airportCode in airports.keys {
    println("code: \(airportCode)")
}

for airportName in airports.values {
    println("name: \(airportName)")
}

let airportCodes = Array(airports.keys)

///
var namesOFIntegers = Dictionary<Int,String>()  //初始化一个空字典

namesOFIntegers[16] = "sixteen"   //赋值

namesOFIntegers = [:]   //又成为了一个Int，String类型的空字典


//////////////////////////////
//控制流


for index in 1...5 {
    println("\(index) times 5 is \(index*5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {   //当不需要中间变量的时候可以用 _ 代替
    
    answer *= base
}

println ("\(base)to the power of \(power) is \(answer)")

//遍历数组
let namess = ["Anna","Alex","Brian","Jack"]

for name in namess
{
    println("Hello,\(name)!")
}

//遍历字典
let numberOfLegs = ["spider":8,"ant":6,"cat":3]
for (animalName,legCount) in numberOfLegs {
    println("\(animalName)s have \(legCount) legs")
}

//遍历字符串中的字符
for character in "Hello" {
    println(character)
}

//普通的写法
for var index = 0;index < 3;++index{
    println("index is \(index)")
}

/////////////////////////////////////
//While循环

let finalSquare = 25
var board = [Int](count:finalSquare+1,repeatedValue:0)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;

var square = 0
var diceRoll = 0
while square < finalSquare {
    //roll the dice
    if ++diceRoll == 7 {diceRoll = 1}
    //move by the rolled amount
    square += diceRoll
    if square < board.count{
        println(board[square])
        square += board[square]
    }
}

println("Game over!")

do {
     //someing
}while false

///////////////////////////
//switch

let someCharacter: Character = "e"

switch someCharacter {        //不在需要写break；每一个case块不允许为空
case "a","e","i","o","u":
    println("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    println("\(someCharacter) is a consonant")
default:   //必须有default
    println("\(someCharacter) is not a vowel or a consonant")
}

//case也可以是一个范围

var countt = 3_000_000
switch countt{
case 0:
    countt = 0
case 1...999:
    countt = 1
default:
    println("00000")
}

//case也可是元祖（Tuple）  , 使用下划线(_)来匹配所有可能的值。
let somePoint = (1,1)

switch somePoint {
case (0,0):
    println("(0,0)")
case (_,0):
    println("(*,0)")
case (-2...2,-3...3):
    println("(*,*)")
default:
    println("(1,1)")
}

//在case的时候还可以值绑定
switch somePoint {
case (let x,0):
    println("(0,0)")
case (0,let y):
    println("(0,0)")
case let (x,y):    //犹豫它可以匹配任意所有元祖，所以不在需要default块
    println("(\(x),\(y))")
}

//case块中的where语句  用来判断额外的条件

switch somePoint {
case let (x,y) where x == y:
    println("x==y")
case let (x,y) where x == -y:
    println("x==-y")
case let (x,y):
    println("(\(x),\(y))")
}


//控制转移语句
//continue
//break
//fallthrough
//return


//fallthrough 当你在switch的时候可以使用它来落入下一个case中，（落入的时候不会检查条件）

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"

switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += " a prime number , and also"
    fallthrough
default:
    
    description += " an integer."
}

println(description)


/////////////////////////////
//Labeled Statements  //你可以明确break和continue到底到什么地方，即给循环体一个标签

gameLoop : while square == finalSquare {
    if ++diceRoll == 7 { diceRoll = 1}
    
    switch square + diceRoll{
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        continue gameLoop
    default:
        square += diceRoll
        square += board[square]
    }
}

println("Game over!")


///////////////////////////////////
//函数
func syaHello(personName: String) ->String{
    let greeting = "Hello, "+personName+" !"
    return greeting
}

println(syaHello("Anna"))

func halfOpenRangeLength(start:Int,end:Int) -> Int{
    return end - start;
}

println(halfOpenRangeLength(1,10))

//无参数
func sayHelloWorld() -> String{
    return "hello, world"
}

println(sayHelloWorld())

//无返回值的
func sayGoodbye(persion:String)
{
    println("Goodbye,\(persion)")
}
sayGoodbye("wang")

//返回多参数
func count(string:String)->(vowels:Int,consonants:Int,others:Int)
{
    var vowels = 0,consonants = 0,others = 0
    for character in string{
        switch String(character).lowercaseString{
        case "a","e","i","o","u":
            ++vowels
        case "b","c", "d", "f", "g", "h", "j", "k", "l", "m","n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            ++consonants
        default:
            ++others
        }
    }
    return(vowels,consonants,others)
}

let total = count("some arbitrary string!")
println("\(total.vowels) vowels and \(total.consonants) consonants")

//可以为形参定义外部名称









