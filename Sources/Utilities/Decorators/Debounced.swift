//
//  Debounced.swift
//  SwiftyFoundation
//

import Foundation

/// A property wrapper that prevents frequent updates to a property.
@propertyWrapper
public final class Debounced<T> {
    /// Indicates whether a property update should be allowed.
    private var pass: Bool = true
    
    /// The current value of the wrapped property.
    private var value: T {
        didSet {
            pass = false
        }
    }
    
    /// The timer used to control the frequency of property updates.
    private var timer = Timer()
    
    /// The wrapped value of the property.
    public var wrappedValue: T {
        get { value }
        set {
            guard pass else {
                return
            }
            value = newValue
        }
    }
    
    /// Initializes a new `Debounced` property wrapper with the specified initial value and update interval.
    /// - Parameters:
    ///   - value: The initial value of the wrapped property.
    ///   - interval: The interval at which the property can be updated.
    public init(wrappedValue value: T, _ interval: DispatchQueue.SchedulerTimeType.Stride) {
        self.value = value
        self.timer = Timer.scheduledTimer(withTimeInterval: interval.seconds, repeats: true) { [weak self] _ in
            self?.pass = true
        }
    }
    
    /// Invalidates the timer used by the property wrapper when it is deallocated.
    deinit {
        timer.invalidate()
    }
}

private extension DispatchQueue.SchedulerTimeType.Stride {
    var seconds: TimeInterval {
        TimeInterval(magnitude/1_000_000_000)
    }
}
