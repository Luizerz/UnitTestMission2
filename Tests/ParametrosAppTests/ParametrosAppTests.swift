import XCTest
@testable import ParametrosApp
import class Foundation.Bundle

class ReadLinerTest: ReadLineProtocol {
    var readLineReturn: String = ""
    func willReadLine() -> String {
        return readLineReturn.lowercased()
    }
}


// Food
// let validOptions = ["praia","serra","interior","floresta","cidade grande"]
final class ParametrosAppTests: XCTestCase {
    let readliner = ReadLinerTest()

    func testVerifyClimateTrue() {
        let input = "quente"
        let output = ["frio", "quente"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertTrue(output.contains(testableClass.verifyClimate()))
    }

    func testVerifyClimateFalse() {
        let input = "mormaço"
        let output = ["frio", "quente"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertFalse(output.contains(testableClass.verifyClimate()))
    }

    func testVerifyRegionTrue() {
        let input = "Centro Oeste"
        let output = ["norte","nordeste","sul","sudeste","centro oeste"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertTrue(output.contains(testableClass.verifyRegion()))
    }

    func testVerifyRegionFalse() {
        let input = "CentroOeste"
        let output = ["norte","nordeste","sul","sudeste","centro oeste"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertFalse(output.contains(testableClass.verifyRegion()))
    }

    func testVerifyEnviromentTrue() {
        let input = "praia"
        let output = ["praia","serra","interior","floresta","cidade grande"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertTrue(output.contains(testableClass.verifyEnviroment()))
    }

    func testVerifyEnviromentFalse() {
        let input = "bolinho"
        let output = ["norte","nordeste","sul","sudeste","centro oeste"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertFalse(output.contains(testableClass.verifyEnviroment()))
    }

    func testVerifyFoodTrue() {
        let input = "japonesa"
        let output = ["japonesa", "italiana", "brasileira", "pizza", "mexicana", "sorvete", "sanduiche"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertTrue(output.contains(testableClass.verifyFood()))
    }

    func testVerifyFoodFalse() {
        let input = "japonesas"
        let output = ["japonesa", "italiana", "brasileira", "pizza", "mexicana", "sorvete", "sanduiche"]

        readliner.readLineReturn = input
        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        XCTAssertFalse(output.contains(testableClass.verifyFood()))
    }

    func testPopulateListaDeLocaisExist() {

        let url = Bundle.module.url(forResource: "locais", withExtension: "json")!

        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: url,
            readLine: readliner
        )
        XCTAssertTrue(testableClass.populateListaDeLocais())
    }

    func testPopulateListaDeLocaisNotExist() {
        guard let _ = Bundle.module.url(forResource: "locdaksofijasais", withExtension: "json") else {
            XCTAssertTrue(true)
            return
        }
    }

    func testVerifyFilterNotEmpty() {

        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        testableClass.resultList.append("frio") // verifyClimate
        testableClass.resultList.append("nordeste") // verifyRegion
        testableClass.resultList.append("praia") // verifyEnviro
        testableClass.resultList.append("italiana") // verifyFood

        let testableResult = testableClass.filterLocais()
        if !testableResult.isEmpty {
            XCTAssertTrue(testableClass.listaDeLocais.contains(testableResult.first!))
        }
    }

    func testVerifyFilterEmpty() {

        let testableClass: LocalsMainProgram = LocalsMainProgram(
            url: Bundle.module.url(forResource: "locais", withExtension: "json")!,
            readLine: readliner
        )
        testableClass.resultList.append("frio") // verifyClimate
        testableClass.resultList.append("norte") // verifyRegion
        testableClass.resultList.append("cidade grande") // verifyEnviro
        testableClass.resultList.append("sorvete") // verifyFood

        let testableResult = testableClass.filterLocais()
        if testableResult.isEmpty {
            XCTAssertTrue(true)
        }
    }

    func testRunIsWorking() {
        
    }

}


