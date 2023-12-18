//
//  GameOverView.swift
//  ArcadeGameTemplate
//

import SwiftUI

/**
 * # GameOverView
 *   This view is responsible for showing the game over state of the game.
 *  Currently it only present buttons to take the player back to the main screen or restart the game.
 *
 *  You can also present score of the player, present any kind of achievements or rewards the player
 *  might have accomplished during the game session, etc...
 **/


struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack {
            Image("main-background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center){
                    Text ("GAME OVER")
                        .font(.largeTitle)
                        .foregroundStyle(Color.accentColor)
                        .padding()
                    Text ("Oh oh oh you lost.")
                        .font(.title)
                        .padding()
                        .foregroundStyle(Color.accentColor)
                } .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(.white).frame(width: 600))
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .background(Circle().foregroundColor(.red).frame(width: 100, height: 100, alignment: .center))
                
                Spacer()
            }
       
        }
        .statusBar(hidden: true)
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(currentGameState: .constant(GameState.gameOver))
    }
}
