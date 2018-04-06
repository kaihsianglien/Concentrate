import Foundation
import GameplayKit

class Concentrate {
    
    var cards = [Card]()
    var indexOfoneAndOnlyFaceUpCard: Int?
    var remainingCardNumbers: Int
    var allCardsAreMatched = false
    
    func chooseCard(at index: Int) -> Bool {
        //assure card is still available
        if !cards[index].isMatched {
            //With the the current chosen one card[index] and previous indexOfoneAndOnlyFaceUpCard there will be two cards to compare)
            if let matchIndex = indexOfoneAndOnlyFaceUpCard, matchIndex != index {
                //matchIndex & index has same card emoji
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    remainingCardNumbers -= 2
                    //if all cards are matched the game should be over
                    if remainingCardNumbers == 0 {
                        allCardsAreMatched = true
                    }
                }
                cards[index].isFaceUp = true
                indexOfoneAndOnlyFaceUpCard = nil
            /*
            0 or 2 cards(which are not matched) are paced up,
            then flip all cards down and only current chosen up
            mark chosen one as indexOfoneAndOnlyFaceUpCard
            */
            } else {
               
                for filpDownIndex in cards.indices {
                    cards[filpDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfoneAndOnlyFaceUpCard = index
            }
        }
        return allCardsAreMatched
    }
    
    init (numberOfPairsOfCards: Int) {
        remainingCardNumbers = numberOfPairsOfCards * 2
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //shuffle the card to randon¥m distribution
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.cards) as! [Card]
    }
    
}
