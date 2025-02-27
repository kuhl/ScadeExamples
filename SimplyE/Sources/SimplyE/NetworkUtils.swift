import Foundation
#if os(Android)
    import FoundationNetworking
#endif

class NetworkUtils {

  static func loadData(from urlString: String) -> Data? {
    guard let url = URL(string: urlString) else { return nil }

    return try? Data(contentsOf: url)
  }

  static func loadDataAsync(from urlString: String, queue: DispatchQueue,
                                   onSuccess: @escaping (Data) -> Void) {
    loadDataAsyncWithResult(from: urlString) { result in
      switch result {
      case .success(let data):
        queue.async {
          onSuccess(data)
        }
      case .failure(let error):
        print(error)
      }
    }
  }

  static func loadDataAsync(from urlString: String, onSuccess: @escaping (Data) -> Void) {
    loadDataAsyncWithResult(from: urlString) { result in
      switch result {
      case .success(let data):
        onSuccess(data)
      case .failure(let error):
        print(error)
      }
    }
  }

  static func loadDataAsyncWithResult(from urlString: String,
                                      completion: @escaping (Result<Data, Error>) -> Void) {
    if let url = URL(string: urlString) {
      let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
        if let error = error {
          completion(.failure(error))
        }
        
        if let data = data {
          completion(.success(data))
        }
      }
      
      urlSession.resume()
    }
  }
}
