// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

///////////////////
//下标脚本

//下标脚本 可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要再调用实例的特定的赋值和访问方法。

struct TimesTable {
    let multiplier: Int
    subscript(index: Int)->Int{
        return multiplier*index
    }
}

let threeTimesTable = TimesTable(multiplier:3)

println("3*6 = \(threeTimesTable[6])")

//下标脚本允许任意数量的入参索引，并且每个入参类型也没有限制。下标脚本的返回值也可以是任何类型。下标脚本可以使用变量参数和可变参数，但使用写入读出（in-out）参数或给参数设置默认值都是不允许的。

//一个类或结构体可以根据自身需要提供多个下标脚本实现，在定义下标脚本时通过入参个类型进行区分，使用下标脚本时会自动匹配合适的下标脚本实现运行，这就是下标脚本的重载。

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows:2,columns:2)

matrix[0,1] = 1.5

matrix[1,1] = 3.2

matrix


///////////////////////////
//继承Inheritance

//一个类可以继承（inherit）另一个类的方法（methods），属性（property）和其它特性。当一个类继承其它类时，继承类叫子类（subclass），被继承类叫超类（或父类，superclass）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。

//在 Swift 中，类可以调用和访问超类的方法，属性和下标脚本（subscripts），并且可以重写（override）这些方法，属性和下标脚本来优化或修改它们的行为。

//可以为类中继承来的属性添加属性观察器（property observer），这样一来，当属性值改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原本被定义为存储型属性（stored property）还是计算型属性（computed property）。

class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    init() {
        numberOfWheels = 0
        maxPassengers = 1
    }
}

let someVehicle = Vehicle()

class Bicycle: Vehicle {
    init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
println("Bicycle: \(bicycle.description())")
// Bicycle: 2 wheels; up to 1 passengers

class Tandem: Bicycle {    //双人自行车可以坐两个人
    init() {
        super.init()
        maxPassengers = 2
    }
}


let tandem = Tandem()
println("Tandem: \(tandem.description())")
// Tandem: 2 wheels; up to 2 passengers


//////////////////////////////
//重写 Overriding

//super.someMethod()
//super.someProperty
//super[someIndex]

class Car: Vehicle {
    var speed:Double = 0.0
    init(){
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String{
        return super.description()+"; traveling at \(speed) mph"
    }
}

let car = Car()
car.speed = 120.0
println("Car: \(car.description())")
// Car: 4 wheels; up to 5 passengers; traveling at 120.0 mph

//你可以重写继承来的实例属性或类属性，提供自己定制的getter和setter，或添加属性观察器使重写的属性观察属性值什么时候发生改变。无论继承来的属性是存储型的还是计算型的属性

//你可以将一个继承来的只读属性重写为一个读写属性，只需要你在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。

class SpeedLimitedCar: Car {
    override var speed: Double  {
    get {
        return super.speed
    }
    set {
        super.speed = min(newValue, 40.0)
    }
    }
}

let limitedCar = SpeedLimitedCar()
limitedCar.speed = 60.0
println("SpeedLimitedCar: \(limitedCar.description())")
// SpeedLimitedCar: 4 wheels; up to 5 passengers; traveling at 40.0 mph

class AutomaticCar: Car{
    var gear = 1
    override var speed:Double{
    didSet{
        gear = Int(speed/10.0) + 1
    }
    }
    override func description() -> String{
        return super.description() + "in gear \(gear)"
    }
}

let automatic = AutomaticCar()
automatic.speed = 35.0
println("AutomaticCar: \(automatic.description())")
// AutomaticCar: 4 wheels; up to 5 passengers; traveling at 35.0 mph in gear 4

////防止重写

//你可以通过把方法，属性或下标脚本标记为final来防止它们被重写，只需要在声明关键字前加上@final特性即可。（例如：@final var, @final func, @final class func, 以及 @final subscript）

//你可以通过在关键字class前添加@final特性（@final class）来将整个类标记为 final 的，这样的类是不可被继承的，否则会报编译错误。

@final class AnoterCar: Car {
    var specialValue: Double = 0.0
    init(){
        super.init()
    }
}

////////////////////////////////////
//构造过程 Initialization

//与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。

//类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。

//你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。

struct Fahrenheit {
    var temperature: Double
    init() {               //一个不带参数的构造器
        temperature = 32.0
    }
}


var f = Fahrenheit()
println("The default temperature is \(f.temperature)° Fahrenheit")
// 输出 "The default temperature is 32.0° Fahrenheit”


//你可以在构造器中为存储型属性设置初始值；同样，你也可以在属性声明时为其设置默认值。

struct Fahrenheit2 {
    var temperature = 32.0
}

struct Celsius{
    var temperatureInCelsius:Double = 0.0
    init(fromFahrenheit fahrenheit:Double){
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin:Double){
        temperatureInCelsius = kelvin - 273.15
    }
}


let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 是 0.0”



//如果你在定义构造器时没有提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名，就相当于在每个构造参数之前加了一个哈希符号。

struct Color {
    let red = 0.0, green = 0.0, blue = 0.0
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

////可选属性类型

//可选类型optional type。可选类型的属性将自动初始化为空nil，表示这个属性是故意在初始化时设置为空的。

class SurveyQuestion{
    var text:String
    var response:String?
    init(text:String){
        self.text = text
    }
    func ask(){
        println(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 输出 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

//当SurveyQuestion实例化时，它将自动赋值为空nil，表明暂时还不存在此字符串。

class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text   //它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
    }
    func ask() {
        println(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// 输出 "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//默认构造器

//结构体的逐一成员构造器

//除上面提到的默认构造器，如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器，它们能自动获得一个逐一成员构造器。

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)    //结构体Size自动获得了一个逐一成员构造器 init(width:height:)


/////
//值类型的构造器代理

//构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承.类则不同，它可以继承自其它类

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    init(){}
    init(origin:Point,size:Size){
        self.origin = origin
        self.size = size
    }
    init(center:Point,size:Size){
        let x = center.x - (size.width/2)
        let y = center.y - (size.height/2)
        self.init(origin:Point(x:x,y:y),size:size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
// originRect 的原点是 (2.0, 2.0)，尺寸是 (5.0, 5.0)

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
// centerRect 的原点是 (2.5, 2.5)，尺寸是 (3.0, 3.0)

/////
//类的继承和构造过程

//构造器链

//为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：
//规则 1
//
//指定构造器必须调用其直接父类的的指定构造器。
//
//规则 2
//
//便利构造器必须调用同一类中定义的其它构造器。
//
//规则 3
//
//便利构造器必须最终以调用一个指定构造器结束。
//
//一个更方便记忆的方法是：
//
//指定构造器必须总是向上代理
//便利构造器必须总是横向代理


//////
//两段式构造过程

//Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个存储型属性值被确定后，第二阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。

//先上到顶部分配内存，在回到原点完成赋值。

//与方法、属性和下标不同，在重载构造器时你没有必要使用关键字override。

//子类不会默认继承父类的构造器。

//但是：如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。

//如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的，还是通过自定义实现的--它将自动继承所有父类的便利构造器。

///////
//便利构造器

//convenience

class Food {
    var name:String
    init(name:String){      //一个指定构造器
        self.name = name
    }
    convenience init(){      //个没有参数的便利构造器
        self.init(name:"[Unnamed]")
    }
}

let namedMeat = Food(name:"Bacon")

let mysteryMeat = Food()

class RecipeIngredient:Food{
    var quantity:Int
    init(name:String,quantity:Int){
        self.quantity = quantity
        super.init(name:name)
    }
    convenience init(name:String){
        self.init(name:name,quantity:1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem:RecipeIngredient{
    var purchased = false   //这个类将默认继承父类的所有构造函数、便捷够高函数
    var description:String{
    var output = "\(quantity)x \(name.lowercaseString)"
        output += purchased ? " yes" : " no"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    println(item.description)
}
// 1 x orange juice ✔
// 1 x bacon ✘
// 6 x eggs ✘

//通过闭包和函数来设置属性的默认值

//每当某个属性所属的新类型实例创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。

//小括号,这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。

//如果你使用闭包来初始化属性的值，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法。


struct Checkerboard {
    let boardColors:[Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10{
            for j in 1...10{
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row:Int,column:Int) -> Bool {
        return boardColors[(row*10)+column]
    }
}

let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))
// 输出 "true"
println(board.squareIsBlackAtRow(9, column: 9))
// 输出 "false"


















