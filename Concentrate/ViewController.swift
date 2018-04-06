import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    lazy var game = Concentrate(numberOfPairsOfCards: cardButtons.count/2)

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Filps: \(flipCount)"
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = cardButtons.index(of: sender) {
            //if all cards are match, then game should be finished
            if game.chooseCard(at: cardNumber) == true {
                flipCountLabel.text = "Game Complete!"
            }
            updateViewFromModel()
        } else {
            print("optional is nil")
        }
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                //if card is matched it would disappear, otherwise it should flip back to orange
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🍅","🐱","🚛","😈","💩","🐦","🌿","🇩🇰","⚠️","💾","▶️"]
    
    var emoji = [Int:String]()
    
    //use GKShuffledDistribution instead of arc4random_uniform to avoid generate duplicate int, move out side of function and add lazy since property initializers run before self is available
    lazy var randomIndex = GKShuffledDistribution(lowestValue: 0, highestValue: emojiChoices.count-1)
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil {
            emoji[card.identifier] = emojiChoices[randomIndex.nextInt()]
        }
        /*
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        */
        return emoji[card.identifier] ?? "?"
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
}

