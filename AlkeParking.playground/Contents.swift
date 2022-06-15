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
    var vehicles = Set<Vehicle>()
}

var alkeParking = Parking()

let car = Vehicle(plate: "AA111AA", type: .Car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let moto = Vehicle(plate: "B222BBB", type: .Moto, checkInTime: Date(), discountCard: nil)
let miniBus = Vehicle(plate: "CC333CC", type: .MiniBus, checkInTime: Date(), discountCard: nil)
let bus = Vehicle(plate: "DD444DD", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let falseVehicle = Vehicle(plate: "AA111AA", type: .Bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

alkeParking.vehicles.insert(car)
alkeParking.vehicles.insert(moto)
alkeParking.vehicles.insert(miniBus)
alkeParking.vehicles.insert(bus)
alkeParking.vehicles.insert(falseVehicle) //Não foi adicionado por causa de placa já existente

alkeParking.vehicles.remove(bus)
print(alkeParking)
