import SpriteKit

class GameScene: SKScene {

    var guardNode: SKSpriteNode!
    var moveTimer: Timer?
    var squares: [SKNode] = [] // To store nodes representing squares
    var currentSquareIndex = 0

    override func didMove(to view: SKView) {
        // Set up the guard
        guardNode = SKSpriteNode(imageNamed: "guard") // Replace with the name of the guard image
        guardNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(guardNode)

        // Load squares as nodes
        loadSquares()

        // Start automatic movement every second
        moveTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(moveGuard), userInfo: nil, repeats: true)
    }

    func loadSquares() {
        // Load squares from nodes
        if let square1 = self.childNode(withName: "black1") {
            squares.append(square1)
        }
        if let square2 = self.childNode(withName: "black2") {
            squares.append(square2)
        }
        if let square3 = self.childNode(withName: "black3") {
            squares.append(square3)
        }
        
        // Ensure the guard starts at the first square
        if !squares.isEmpty {
            guardNode.position = squares[0].position
        }
    }

    @objc func moveGuard() {
        guard !squares.isEmpty else { return }

        // Determine the next square in the sequence
        let nextIndex = (currentSquareIndex + 1) % squares.count
        let targetSquare = squares[nextIndex]

        // Set up the guard's movement towards the next square
        let moveAction = SKAction.move(to: targetSquare.position, duration: 1.0)
        guardNode.run(moveAction) {
            // Update the current index after movement is finished
            self.currentSquareIndex = nextIndex
        }
    }

    override func willMove(from view: SKView) {
        // Invalidate the timer when leaving the scene
        moveTimer?.invalidate()
    }
}
