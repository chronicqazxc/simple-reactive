//
//  SimpleReactive.swift
//  Pods
//
//  Created by Wayne, Hsiao X. -ND on 11/12/16.
//
//

import Foundation

protocol ObserveType {
    associatedtype Event
    func observe(observer: @escaping (Event) -> ())
}

/**
 Simple reactive
 
 */
public class SimpleColdSignal<T>: NSObject, ObserveType {

    typealias EventObserver = (T) -> ()
    typealias Token = Int64
    
    fileprivate var nextToken: Token = 0
    fileprivate let lock = NSRecursiveLock()
    /**
     Current value of observable
     
     */
    public private(set) var value: T
    fileprivate var observers: ContiguousArray<EventObserver> = []
    fileprivate var observerStorage: [Token: EventObserver] = [:] {
        didSet {
            observers = ContiguousArray(observerStorage.values)
        }
    }
    
    
    deinit {
        #if DEBUG
            print("\(type(of: self)) \(#function)")
        #endif
    }
    
    /**
     Initiate with initial value
     
     - parameter itmes: WDPRTableViewItems
     
     - returns: Void
     */
    public init(_ value: T) {
        lock.name = "com.SHDR.SHDRProfileUI.SimpleStream"
        self.value = value
        super.init()
    }
    
    /**
     Set next value
     
     - parameter event: value
     
     - returns: Void
     */
    public func next(_ event: T) {
        lock.lock()
        value = event
        for observer in observers {
            observer(value)
        }
        lock.unlock()
    }

    open func bindTo<B:SimpleColdSignal<T>>(bindable: B) {
        observe { bindable.next($0) }
    }
    
    public func observe(observer: @escaping (T) -> ()) {
        registerObserver(observer: observer)
        observer(value)
    }
    
    fileprivate func registerObserver(observer: @escaping EventObserver) {
        lock.lock()
        let token = nextToken
        nextToken = nextToken + 1
        lock.unlock()
        observerStorage[token] = observer
    }
}
