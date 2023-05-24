import Foundation

// FUNCTIONS

//Quais serao os meus paramentros ->
//CLIMA - ESTRANGEIRO OU NACIONAL - REGIAO - TIPO DE AMBIENTE
//Tipos de clima: Equatorial, Tropical, Temperado, Subtropical, Mediterrâneo, Frio, Frio de Montanha, Polar, Desértico e Semiárido. QUENTE E FRIO FDS
//Tipos de viagem Nacional e Internacional
//Regiao: (nacional -> norte, nordeste, sul, sudeste, centro-oeste)(internacional -> europa, asia, america, oceania, africa, antartida.
//Tipo de Ambiente: Serra, montanha, praia, deserto, florestas, cidade grande.
//Tipo de Comida: Japonesa, italiana, brasileira, sanduiches/pizza, mexicana, sorvete
// STRUCT

struct Local: Decodable, Equatable {
    let clima: String
    let regiao: String
    let tipoAmbiente: String
    var comida: String
    let urlLocal: String
    let urlHotel: String
    let urlFood: String
    
    public func printURls() -> String {
        return """
        As opções foram selecionadas com muito carinho. Clique nas URL's abaixo: 
        URLLocal: \(urlLocal)
        URLHotel: \(urlHotel)
        URLFood: \(urlFood)
    """
    }
}

class LocalsMainProgram {
    let readLiner: ReadLineProtocol
    let arquivoURL: URL //Pegar o JSON do meu ambiente de desenvolvimento (locais.json)
    var listaDeLocais: [Local] = []
    var resultList: [String] = []
    var control: Bool = true

    var resultListMock: [[String]] = [["frio","nordeste","praia","italiana"],["abacate","nordeste", "praia", "sorvete"]]

    init(url: URL, readLine: ReadLineProtocol) {
        self.arquivoURL = url
        self.readLiner = readLine
        _ = populateListaDeLocais()
    }

    func populateListaDeLocais() -> Bool {
        do {
            let locaisData = try Data(contentsOf: arquivoURL)
            listaDeLocais = try JSONDecoder().decode([Local].self, from: locaisData)
            return true
        } catch {
            print(error)
            return false
        }
    }

    func verifyClimate() -> String {
        print("Qual o clima que você quer? Quente ou Frio?\nPor favor, digite o nome:")
        
        var climate = readLiner.willReadLine()
        let validOptions = ["quente","frio"]
        var errorCount: Int = 0
        if !validOptions.contains(climate) {
            while !validOptions.contains(climate) {
                errorCount += 1
                if errorCount > 2 {
                    print("Errou muito mofi")
                    control = false
                    break
                }
                print("Insira novamente: Quente ou Frio")
                climate = readLiner.willReadLine()
            }
        }
        if validOptions.contains(climate) {
            print("O clima escolhido foi: \(climate)")
        }
        return climate
    }

    func verifyRegion() -> String {
        print("Insira a região : Norte, Nordeste, Sul, Sudeste, Centro oeste")
        var region = readLiner.willReadLine()
        let validOptions = ["norte","nordeste","sul","sudeste","centro oeste"]
        var errorCount = 0
        if !validOptions.contains(region) {
            while !validOptions.contains(region) {
                errorCount += 1
                if errorCount > 2 {
                    print("Errou muito mofi")
                    control = false
                    break
                }
                print("Insira novamente: Norte, Nordeste, Sul, Sudeste, Centro oeste")
                region = readLiner.willReadLine()
            }
        }
        if validOptions.contains(region) {
            print("A região escolhida foi: \(region)")
        }
        return region
    }

    func verifyEnviroment() -> String {
        print("Insira o ambiente: Praia, Serra, Interior, Floresta, Cidade Grande")
        var typeAmb = readLiner.willReadLine()
        let validOptions = ["praia","serra","interior","floresta","cidade grande"]
        var errourCount = 0
        if !validOptions.contains(typeAmb) {
            while !validOptions.contains(typeAmb)  {
                errourCount += 1
                if errourCount > 2 {
                    print("Errou muito mofi")
                    control = false
                    break
                }
                print("Insira novamente: Praia, Serra, Interior, Floresta, Cidade Grande")
                typeAmb = readLiner.willReadLine()
            }
        }
        if validOptions.contains(typeAmb) {
            print("O ambiente escolhido foi: \(typeAmb)")
        }
        return typeAmb
    }

    func verifyFood() -> String {
        print("Insira a comida: Japonesa, Italiana, Brasileira, Pizza, Mexicana, Sorvete, Sanduiche")
        var food = readLiner.willReadLine()
        let validOptions = ["japonesa", "italiana", "brasileira", "pizza", "mexicana", "sorvete", "sanduiche"]
        var errorCount = 0
        if !validOptions.contains(food) {
            while !validOptions.contains(food)  {
                errorCount += 1
                if errorCount > 2 {
                    print("Errou muito mofi")
                    control = false
                    break
                }
                print("Insira novamente: Japonesa, Italiana, Brasileira, Pizza, Mexicana, Sorvete, Sanduiche")
                food = readLiner.willReadLine()
            }
        }
        if validOptions.contains(food) {
            print("A comida escolhida foi: \(food)")
        }
        return food
    }

    @discardableResult
    func filterLocais() -> [Local] {
        var result: [Local] = [] // nao importa
        result = listaDeLocais.filter({
            ($0.clima == resultList[0]) && ($0.regiao == resultList[1]) && ($0.tipoAmbiente == resultList[2]) && ($0.comida == resultList[3])
            })
        for resu in result {
            print(resu.printURls())
        }
        return result
    }

    func run() {
        resultList.append(verifyClimate())
        if control {
            resultList.append(verifyRegion())
        }
        if control {
            resultList.append(verifyEnviroment())
        }
        if control {
            resultList.append(verifyFood())
        }
        if control {
            filterLocais()
        }
    }

}

var readLiner = ReadLineMain()
if let url =  Bundle.module.url(forResource: "locais", withExtension: "json") {

    let mainProgram = LocalsMainProgram(
        url: url,
        readLine: readLiner
    )
    mainProgram.run()
}
print("passou do programa principal")


class ReadLineMain: ReadLineProtocol {
    func willReadLine() -> String {
        return readLine()!.lowercased()
    }
}
// MARK: URL
//let arquivoURL = Bundle.module.url(forResource: "locais", withExtension: "json")!
