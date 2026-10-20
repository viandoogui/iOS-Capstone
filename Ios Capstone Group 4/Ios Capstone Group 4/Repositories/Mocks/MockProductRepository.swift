//
//  MockProductRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

class MockProductRepository: RepositoryProtocol<Product> {

    func getAll() async throws -> [Product] {
        products
    }
    
    func insert(_ item: Product) async throws -> Product {
        products.append(item)
        return item
    }
    
    func update(_ item: Product) async throws {
        products.removeAll(where: { $0.id == item.id})
        products.append(item)
    }
    
    func delete(_ item: Product) async throws {
        products.removeAll(where: { $0.id == item.id})
    }
    func getById(_ id: Int) async throws -> Product? {
        products.first(where: { $0.id == id})
    }

    private var products: [Product] = [
        Product(
            id: 1,
            name: "Mountain Pro 500",
            productNumber: "BK-M500-RD",
            summary:
                "Lightweight aluminum mountain bike with front suspension and 21-speed gearing.",
            thumbnailPhoto: "mountain_pro_500_thumb",
            thumbnailPhotoFileName: "mountain_pro_500_small.gif",
            warranty: "2 years",
            color: "Red",
            listPrice: 749.99
        ),
        Product(
            id: 2,
            name: "Road Racer Elite",
            productNumber: "BK-R200-BL",
            summary:
                "Carbon fiber road bike built for speed, with a compact racing geometry.",
            thumbnailPhoto: "road_racer_elite_thumb",
            thumbnailPhotoFileName: "road_racer_elite_small.gif",
            warranty: "5 years",
            color: "Blue",
            listPrice: 1899.00
        ),
        Product(
            id: 3,
            name: "Trail Helmet X",
            productNumber: "HL-T100-BK",
            summary:
                "Ventilated all-mountain helmet with adjustable fit system and removable visor.",
            thumbnailPhoto: "trail_helmet_x_thumb",
            thumbnailPhotoFileName: "trail_helmet_x_small.gif",
            warranty: nil,
            color: "Black",
            listPrice: 89.50
        ),
        Product(
            id: 4,
            name: "City Cruiser 3-Speed",
            productNumber: "BK-C300-WH",
            summary:
                "Comfortable step-through commuter bike with fenders and a rear cargo rack.",
            thumbnailPhoto: "city_cruiser_thumb",
            thumbnailPhotoFileName: "city_cruiser_small.gif",
            warranty: "3 years",
            color: "White",
            listPrice: 459.00
        ),
        Product(
            id: 5,
            name: "Hydration Pack 12L",
            productNumber: "HP-012-GR",
            summary:
                "Lightweight 12-liter pack with a 2L reservoir and multiple storage pockets.",
            thumbnailPhoto: "hydration_pack_thumb",
            thumbnailPhotoFileName: "hydration_pack_small.gif",
            warranty: "1 year",
            color: "Green",
            listPrice: 64.95
        ),
        Product(
            id: 6,
            name: "LED Headlight 800",
            productNumber: "LT-800-SL",
            summary:
                "Rechargeable 800-lumen headlight with five modes and USB-C charging.",
            thumbnailPhoto: "led_headlight_thumb",
            thumbnailPhotoFileName: "led_headlight_small.gif",
            warranty: "6 months",
            color: "Silver",
            listPrice: 39.99
        ),
    ]

}
