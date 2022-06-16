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
        Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
    
    
    //    init(plate:String, type:VehicleType, checkInTime: Date = Date(), discountCard:String?) {
    //        //TODO: TODO
    //    }
    
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
    var vehicles = Set<Vehicle>() {
        willSet {
            for i in newValue {
            checkInVehicle(i, onFinish: { canBeInserted in
                if canBeInserted {
                    vehicles.insert(i)
                }
            })
            }
        }
    }
        
    //
    //    init(vehicle:Vehicle) {
    //        checkInVehicle(vehicle)
    //    }
    
    mutating func checkInVehicle(_ vehicle:Vehicle, onFinish: (Bool) -> Void){
        guard vehicles.count < maxVehiclesParked else {
            return onFinish(false)
        }
        
        guard !vehicles.contains(vehicle) else {
            return onFinish(false)
        }
        
        onFinish(true)
    }
}

var alkeParking = Parking()

let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let vehicle2 = Vehicle(plate: "B222BBB", type: VehicleType.Moto, checkInTime: Date(), discountCard: nil)
let vehicle3 = Vehicle(plate: "CC333CC", type: VehicleType.MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle4 = Vehicle(plate: "DD444DD", type: VehicleType.Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle5 = Vehicle(plate: "AA111BB", type: VehicleType.Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
let vehicle6 = Vehicle(plate: "B222CCC", type: VehicleType.Moto, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")
let vehicle7 = Vehicle(plate: "CC333CC", type: VehicleType.MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle8 = Vehicle(plate: "DD444EE", type: VehicleType.Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let vehicle9 = Vehicle(plate: "AA111CC", type: VehicleType.Car, checkInTime: Date(), discountCard: nil)
let vehicle10 = Vehicle(plate: "B222DDD", type: VehicleType.Moto, checkInTime: Date(), discountCard: nil)
let vehicle11 = Vehicle(plate: "CC333EE", type: VehicleType.MiniBus, checkInTime: Date(), discountCard: nil)
let vehicle12 = Vehicle(plate: "DD444GG", type: VehicleType.Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")
let vehicle13 = Vehicle(plate: "AA111DD", type: VehicleType.Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let vehicle14 = Vehicle(plate: "B222EEE", type: VehicleType.Moto, checkInTime: Date(), discountCard: nil)
let vehicle15 = Vehicle(plate: "CC333FF", type: VehicleType.MiniBus, checkInTime: Date(), discountCard: nil)


//
//let car = Vehicle(plate: "AA111AA", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
//let moto = Vehicle(plate: "B222BBB", type: .Moto, checkInTime: Date(), discountCard: nil)
//let miniBus = Vehicle(plate: "CC333CC", type: .MiniBus, checkInTime: Date(), discountCard: nil)
//let bus = Vehicle(plate: "DD444DD", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
//let falseVehicle = Vehicle(plate: "AA111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
//
//alkeParking.vehicles.insert(car)
//alkeParking.vehicles.insert(moto)
//alkeParking.vehicles.insert(miniBus)
//alkeParking.vehicles.insert(bus)
//alkeParking.vehicles.insert(falseVehicle) //Não foi adicionado por causa de placa já existente
//
//alkeParking.vehicles.remove(bus)
//print(alkeParking)
