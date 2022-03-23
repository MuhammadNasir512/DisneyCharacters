import XCTest
@testable import DisneyCharacters

final class CharactersListTests: XCTestCase {
    
    func testJokesDecodedToModel() throws {
        let characters = makeCharactersLists()
        let expectedValue = 50
        let actualValue = characters.count
        XCTAssertEqual(actualValue, expectedValue)
        
        let firstCharacter = characters.first!
        XCTAssertEqual(firstCharacter.id, 6)
        XCTAssertEqual(firstCharacter.name, "'Olu Mel")
    }

    private func makeCharactersLists() -> [CharactersModel] {
        let data = mockedJsonData()!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let CharactersList = try! decoder.decode(RootObject.self, from: data)
        return CharactersList.data
    }
    
    private func mockedJsonData() -> Data? {
        guard let path = Bundle(for: CharactersListTests.self).path(forResource: "MockedJson", ofType: "json") else { return nil }
        do { let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch { }
        return nil
    }
}
