import Foundation
/*  AlkeParking - Estacionamento de veículos
 
 - Carros, Motos, Micro-Ônibus e Ônibus
 CAPACIDADE MÁXIMA = 20 VEÍCULOS.
 
 */

enum VehicleType:Int {
    case Car
    case Moto
    case MiniBus
    case Bus
    
    var tarifa: Int{
        switch self {
        case .Car:
            return 20
        case .MiniBus:
            return 25
        case .Moto:
            return 15
        case .Bus:
            return 30
        }
    }
}

protocol Parkable {
    var plate:String { get }
    var type:VehicleType { get set }
    var checkInTime:Date { get }
    var discountCard:String? { get set }
    var parkedTime:Int { get }
}

struct Vehicle: Hashable, Parkable {
    
    let plate: String
    var type: VehicleType
    var checkInTime: Date = Date()
    var discountCard: String?
    var parkedTime: Int {
        return Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
    
    //Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    //Equatable
    static func == (lhs:Vehicle, rhs: Vehicle) -> Bool {
        lhs.plate == rhs.plate
    }
}

struct Parking {
    let maxVehiclesParked:Int = 20
    var vehicles:Set<Vehicle> = []
    
    
    mutating func checkInVehicle(_ vehicle:Vehicle, onFinish: (Bool) -> Void){
        guard vehicles.count < maxVehiclesParked else {
            return onFinish(false)
        }
        
        guard !vehicles.contains(vehicle) else {
            return onFinish(false)
        }
        let (insertSuccess, _) = vehicles.insert(vehicle)
        onFinish(insertSuccess)
    }
    
    
    mutating func checkOutVehicle(plate: String, onSucess: (Int) -> Void, onError: () -> Void) {
        if let vehicle = vehicles.first(where: { vehicle in vehicle.plate == plate }) {
                let discountCard:Bool = (vehicle.discountCard != nil) ? true : false
                let pricePaid = calculateFee(type: vehicle.type, parkedTime: vehicle.parkedTime, hasDiscountCard: discountCard)
                onSucess(pricePaid)
                vehicles.remove(vehicle)
            } else {
                onError()
        }
    }
    
    func calculateFee(type:VehicleType, parkedTime:Int, hasDiscountCard: Bool) -> Int {
        var price:Int = type.tarifa
        
        if parkedTime > 120 {
            let priceCalculate:Double = (Double(parkedTime) - 120.0)/15.0
            price += Int(ceil(priceCalculate))*5
        }
        
        if hasDiscountCard {
            price = price - Int(price*15/100)
        }
       
        return price
    }
    
    
}

let vehicle1 = Vehicle(plate: "AA111AA", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let vehicle2 = Vehicle(plate: "B222BBB", type: .Moto, checkInTime: Date(), discountCard: nil)
let vehicle3 = Vehicle(plate: "CC333CC", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle4 = Vehicle(plate: "DD444DD", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle5 = Vehicle(plate: "AA111BB", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
let vehicle6 = Vehicle(plate: "B222CCC", type: .Moto, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")
let vehicle7 = Vehicle(plate: "CC333CC", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle8 = Vehicle(plate: "DD444EE", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let vehicle9 = Vehicle(plate: "AA111CC", type: .Car, checkInTime: Date(), discountCard: nil)
let vehicle10 = Vehicle(plate: "B222DDD", type: .Moto, checkInTime: Date(), discountCard: nil)
let vehicle11 = Vehicle(plate: "CC333EE", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle12 = Vehicle(plate: "DD444GG", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")
let vehicle13 = Vehicle(plate: "AA111DD", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let vehicle14 = Vehicle(plate: "B222EEE", type: .Moto, checkInTime: Date(), discountCard: nil)
let vehicle15 = Vehicle(plate: "CC333FF", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle16 = Vehicle(plate: "AA111AA", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let vehicle17 = Vehicle(plate: "B222BBB", type: .Moto, checkInTime: Date(), discountCard: nil)
let vehicle18 = Vehicle(plate: "CC333CC", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle19 = Vehicle(plate: "DD444DD", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle20 = Vehicle(plate: "AA111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle24 = Vehicle(plate: "AX111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle23 = Vehicle(plate: "AY111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle22 = Vehicle(plate: "AZ111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle21 = Vehicle(plate: "TTTTTTA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
var alkeParking = Parking()

var vehicles = [vehicle1, vehicle2, vehicle3, vehicle4, vehicle5, vehicle6, vehicle7, vehicle8, vehicle9, vehicle10,vehicle11, vehicle12, vehicle13, vehicle14, vehicle15, vehicle16, vehicle17, vehicle18, vehicle19, vehicle20, vehicle24, vehicle23, vehicle22]

for vehicle in vehicles {
    alkeParking.checkInVehicle(vehicle) { isValid in
        if isValid {
            print("Welcome to AlkeParking!")
        }else {
            print("Sorry, the check-in failed")
        }
    }
}

alkeParking.checkOutVehicle(plate: "B222BBB", onSucess: { parkingPrice in
    print("O veículo foi removido e o valor a ser pago é \(parkingPrice)")
}) {
    print("Erro")
}

alkeParking.checkOutVehicle(plate: "CC333FF", onSucess: { parkingPrice in
    print("O veículo foi removido e o valor a ser pago é \(parkingPrice)")
}) {
    print("Erro")
}

alkeParking.checkOutVehicle(plate: "AX111AA", onSucess: { parkingPrice in
    print("O veículo foi removido e o valor a ser pago é \(parkingPrice)")
}) {
    print("Erro bem aqui")
}
