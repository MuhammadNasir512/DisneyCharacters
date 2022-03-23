import Foundation
import PromiseKit

protocol APIHandlerType: AnyObject {
    func getData() -> Promise<Data>
    func getImage(urlString: String) -> Promise<Data>
    var urlString: String { get set }
    init(urlString: String)
}

final class APIHandler: APIHandlerType {
    
    var urlString: String
    init(urlString: String = "https://api.disneyapi.dev/characters") {
        self.urlString = urlString
    }
    
    func getData() -> Promise<Data> {
        return promise(urlString: urlString)
    }

    func getImage(urlString: String) -> Promise<Data> {
        return promise(urlString: urlString)
    }
    
    private func promise(urlString: String) -> Promise<Data> {
        return Promise { seal in
            guard let url = URL(string: urlString) else {
                let error = NSError(domain: "URLError", code: 99, userInfo: nil) as Error
                seal.reject(error)
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let error = error else {
                        let dataToSend = data ?? Data()
                        seal.fulfill(dataToSend)
                        return
                    }
                    seal.reject(error)
                }
            }
            task.resume()
        }
    }
}
