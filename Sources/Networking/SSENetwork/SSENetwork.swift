//
//  SSENetwork.swift
//  NiceTube
//

import Foundation
import LDSwiftEventSource

public struct SSEMessage {
    public let data: any Decodable
}

public protocol SSENetworkDelegate: AnyObject {
    func network(_ network: SSENetwork, didReceive message: SSEMessage)
    func network(_ network: SSENetwork, didReceive error: Error)
}

public protocol SSENetwork {
    func subscribe(delegate: SSENetworkDelegate, forType type: Decodable.Type)
    func unsubscribe(delegate: SSENetworkDelegate)
}

public final class SwiftEventSourceNetwork: SSENetwork {
    private let serverURL: URL
    private let decoder: JSONDecoder

    private weak var delegate: SSENetworkDelegate?
    private var dataType: Decodable.Type?

    private lazy var eventSource: EventSource = {
        var config = EventSource.Config(handler: self, url: serverURL)
        config.idleTimeout = Date.distantFuture.timeIntervalSince1970
        return EventSource(config: config)
    }()

    public init(serverURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.serverURL = serverURL
        self.decoder = decoder
    }

    public func subscribe(delegate: SSENetworkDelegate, forType type: Decodable.Type) {
        self.delegate = delegate
        dataType = type
        eventSource.start()
    }

    public func unsubscribe(delegate _: SSENetworkDelegate) {
        delegate = nil
        eventSource.stop()
    }
}

extension SwiftEventSourceNetwork: EventHandler {
    public func onOpened() {
        debugPrint("SSE Stream Opened.")
    }

    public func onClosed() {
        debugPrint("SSE Stream Closed.")
    }

    public func onMessage(eventType: String, messageEvent: LDSwiftEventSource.MessageEvent) {
        debugPrint("SSE Message Received", eventType, messageEvent)
        guard let type = dataType, let eventType = SSEEventType(rawValue: eventType) else {
            return
        }
        do {
            switch eventType {
            case .message:
                let data = Data(messageEvent.data.utf8)
                let decodable = try decoder.decode(type, from: data)
                let sseMessage = SSEMessage(data: decodable)
                delegate?.network(self, didReceive: sseMessage)
            case .error:
                throw NSError(domain: messageEvent.data, code: -1)
            }
        } catch {
            delegate?.network(self, didReceive: error)
        }
    }

    public func onComment(comment: String) {
        debugPrint("SSE Comment Received", comment)
    }

    public func onError(error: Error) {
        debugPrint("SSE Error Received", error)
        delegate?.network(self, didReceive: error)
    }
}

private enum SSEEventType: String {
    case message
    case error
}
