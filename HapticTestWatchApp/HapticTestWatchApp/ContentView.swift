import SwiftUI
import WatchKit

struct ContentView: View {
    let session = SessionHandler()
    
    var body: some View {
        VStack {
            Text("Hello, world!!")
        }
        .onAppear {
            session.startSession()
        }
    }
}

#Preview {
    ContentView()
}

final class SessionHandler: NSObject, WKExtendedRuntimeSessionDelegate {
    var session: WKExtendedRuntimeSession?

    override init() {
        super.init()

        session?.delegate = self
    }
    
    func startSession() {
        session = WKExtendedRuntimeSession()

        let triggerDate = Date().addingTimeInterval(TimeInterval(30.0))

        session?.start(at: triggerDate)
    }

    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        extendedRuntimeSession.notifyUser(hapticType: .notification)
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        extendedRuntimeSession.invalidate()
    }
}
