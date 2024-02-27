//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maxim P on 26/02/2024.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"] //массив значений
    
    @State private var computerChoice = Int.random(in: 0..<3) // от 3 рандомныз числа
    @State private var shouldWin = Bool.random() //рандомное булевое знаение
    
    @State private var score = 0// счет
    @State private var questionCount = 1 //количество вопросов
    @State private var showResults = false// показать результат
    
    var body: some View {
        VStack {
            Spacer()// отступ
            
            Text ("Computer has played...") // Текст
                .fontDesign(.serif)
                .bold()
                .font(.system(size: 25))
            
            Text (moves[computerChoice]) //массив с рандомным значением
                .font(.system(size: 100))
            
            if shouldWin { // если переменна тру то вопрос что нужно выбрать для победы,
                Text("Which one wins?")
                    .foregroundStyle(.green)
                    .font(.title)
            } else {
                Text("Which one loses?")// если фолс для поражения
                    .foregroundStyle(.red)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            HStack { // горизонтальная вьюшка
                ForEach(0..<3) {number in //выводим три кнопки в качестве которых все картинки
                    Button(moves[number]){ //на кнопку вешаем функцию play которая принимает выбранный индекс кнопки
                        play(choice: number)
                    }
                    .font(.system(size: 80))
                }
            }
            Spacer()
            
            Text("Sccore: \(score)") //счет
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game over", isPresented: $showResults) {//предупреждение которое появляется когда showResult тру
            Button("Play Again", action: reset)//в алерте кнопка новой игры которая запускает функцию reset
        } message: {
            Text("Your score was \(score)") //и счет за всю игру
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1,2,0] //победный массив
        let didWin: Bool //определяем выиграл ли текущий раунд игрок сравничая выбор с победным
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]// сравниваем переданное число с победным массивом
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin { //если верно то прибалвяем очки если нет вычитаем
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 5 { //играем 5 раз на 5м конец игры и сброс запускается алерт и функция reset
            showResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    
    func reset() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 1
        score = 0
        
    }
}

#Preview {
    ContentView()
}
