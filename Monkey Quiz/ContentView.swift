//
//  ContentView.swift
//  Monkey Quiz
//
//  Created by Quinn Morgan on 17/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonRadius = 10.0  // button curve
    @State private var screenSize: CGRect = UIScreen.main.bounds // size of the screen
    
    @State private var showingQuiz = false  // show quiz if true
    @State private var showingProfile = false   // show profile sheet if true
    @State private var dark = false
    @State private var quizModeInit = "easy"    // initialise quiz mode
    @State private var quizArrayInit = [["Baboon", "baboon"],
                                        ["Capuchin", "capuchin"],
                                        ["Gorilla", "gorilla"],
                                        ["Howler Monkey", "howler"],
                                        ["Lemur", "lemur"],
                                        ["Orangutan", "orangutan"],
                                        ["Spider Monkey", "spider"],
                                        ["Squirrel Monkey", "squirrel"]]    // initialise array for quiz questions
    @State private var monkeyArrayInit = [["Baboon", "baboon"],
                                          ["Capuchin", "capuchin"],
                                          ["Gorilla", "gorilla"],
                                          ["Howler Monkey", "howler"],
                                          ["Lemur", "lemur"],
                                          ["Orangutan", "orangutan"],
                                          ["Spider Monkey", "spider"],
                                          ["Squirrel Monkey", "squirrel"]]  // initialise array for upcoming quiz questions
    @State private var questionArrayInit = ["Baboon", "Capuchin", "Gorilla", "Howler Monkey"]   // initialise array for current question
    
    
    var body: some View {
        if showingQuiz {    // open MonkeyView if true
            MonkeyView(quizMode: $quizModeInit, quizArray: $quizArrayInit,
                       monkeysArray: $monkeyArrayInit, questionArray: $questionArrayInit)   // call MonkeyView
        }
        else{   // run ContentView
            VStack {    // view that arranges its children vertically
                HStack {    //view that arranges its children horizontally
                    Spacer()    // fill empty space and push elements
                    Button(action: {    // button which opens ProfileView
                        self.showingProfile.toggle()    // show ProfileView// switch between true and false

                    }, label: {     // stores profile image
                        Image("usericon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(.all)
                    })
                            .scaledToFit()
                            .sheet(isPresented: $showingProfile) { // open MonkeyView if true
                                ProfileView()   // call ProfileView
                            }
                }
                Image("monkeyquizlogo") // image of logo
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(50)
                Text("Monkey Quiz") // Title of app
                    .font(.title)   // title format
                    .foregroundColor(.black)
                Spacer()
                

                Button(action: {    // button which opens Quiz in Easy mode
                    self.showingQuiz.toggle()
                    quizModeInit = "easy"   // set mode
                    quizArrayInit = buildList(mode: quizModeInit)   // set list of questions and answers
                    monkeyArrayInit = quizArrayInit     // set list of upcoming questions
                    questionArrayInit = randomMonkey(correctMonkey: quizArrayInit[0][0], falseMonkey: quizArrayInit)    // set first question
                }, label: {
                    Text("Easy")    // button text
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.all)
                        .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: 44)
                        .background(Color.yellow.cornerRadius(buttonRadius))
                        
                })

                
                Button(action: {    // button which opens Quiz in Medium mode
                    self.showingQuiz.toggle()
                    quizModeInit = "medium"
                    quizArrayInit = buildList(mode: quizModeInit)
                    monkeyArrayInit = quizArrayInit
                    questionArrayInit = randomMonkey(correctMonkey: quizArrayInit[0][0], falseMonkey: quizArrayInit)
                }, label: {
                    Text("Medium")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.all)
                        .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: 44)
                        .background(Color.yellow.cornerRadius(buttonRadius))
                })
                   
                
                Button(action: {    // button which opens Quiz in Hard mode
                    self.showingQuiz.toggle()
                    quizModeInit = "hard"
                    quizArrayInit = buildList(mode: quizModeInit)
                    monkeyArrayInit = quizArrayInit
                    questionArrayInit = randomMonkey(correctMonkey: quizArrayInit[0][0], falseMonkey: quizArrayInit)
                }, label: {
                    Text("Hard")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.all)
                        .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: 44)
                        .background(Color.yellow.cornerRadius(buttonRadius))
                })

                    

                Button(action: {    // button which opens Quiz in Marathon mode
                    self.showingQuiz.toggle()
                    quizModeInit = "marathon"
                    quizArrayInit = buildList(mode: quizModeInit)
                    monkeyArrayInit = quizArrayInit
                    questionArrayInit = randomMonkey(correctMonkey: quizArrayInit[0][0], falseMonkey: quizArrayInit)
                }, label: {
                    Text("Marathon")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.all)
                        .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: 44)
                        .background(Color.yellow.cornerRadius(buttonRadius))
                })
                    
            }
        }

    }
        
}
    
struct MonkeyView: View {
    @State var showingMain = false  //show home if true
    @State private var showingScore = false // show score if true
    
    @State private var buttonRadius = 10.0
    @State private var screenSize: CGRect = UIScreen.main.bounds
    
    
    @Environment(\.dismiss) var dismiss
    
    @State private var slash = "/"
    @State private var counter = 0  // count questions
    @State private var position = 1
    @State private var score = 0    // store score
    @Binding var quizMode: String   // Store quiz mode
    @Binding var quizArray: [[String]] // Stores questions to be pulled
    @Binding var monkeysArray: [[String]] // Stores upcoming questions
    @Binding var questionArray: [String] // Stores current question
    
    var body: some View {
        if showingMain {
            ContentView()
        }
        else if showingScore {
            ScoreView(showingMainScore: $showingMain, scorePost: $score, totalPost: quizArray.count,
                      quizModePost: $quizMode)
        }
        else {
            VStack {
                ProgressView(value: Double(counter), total: Double(quizArray.count))    // show progress
                HStack {
                    Button(action: {
                        print("Back Test")
                        self.showingMain.toggle()
                    }, label: {
                        Image("backicon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(.all)
                    })
                            .scaledToFit()
                    Spacer()
                    
                    Text(quizMode.uppercased())
                        .font(.headline)
                        .frame(alignment: .center)
                        .padding()
                    
                    Spacer()
                    
                    Text("\(String(score)) \(slash) \(String(quizArray.count))")
                        .padding(.trailing)
                }
                
                
                Image(monkeysArray[0][1])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipped()
                Spacer()
                
                HStack {
                    Button(action: {
                        print("Monkey Test 1")
                        counter += 1
                        if (questionArray[0] == monkeysArray[0][0]) {   // 1 point if correct answer
                            score += 1  // increment
                        }
                        if (counter >= Int(quizArray.count)) {  // go to ScoreView if answered all questions
                            print("Go to Score view")
                            self.showingScore.toggle()
                        }
                        else{
                            monkeysArray.remove(at: 0)  // remove question just answered
                            questionArray = randomMonkey(correctMonkey: monkeysArray[0][0], falseMonkey: quizArray) // load next question
                        }
                    }, label: {
                        Text(questionArray[0])
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            
                            .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: screenSize.width/4)
                            .background(Color.yellow.cornerRadius(buttonRadius))
                            .padding()
                    })
                        
                            
                    
                    Button(action: {
                        print("Monkey Test 2")
                        counter += 1
                        if (questionArray[1] == monkeysArray[0][0]) {
                            score += 1
                        }
                        if (counter >= Int(quizArray.count)) {
                            print("Go to Score view")
                            self.showingScore.toggle()
                            
                        }
                        else{
                            monkeysArray.remove(at: 0)
                            questionArray = randomMonkey(correctMonkey: monkeysArray[0][0], falseMonkey: quizArray)
                        }
                    }, label: {
                        Text(questionArray[1])
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: screenSize.width/4)
                            .background(Color.yellow.cornerRadius(buttonRadius))
                            .padding(.all)
                    })
                        

                }
                
                HStack {
                    Button(action: {
                        print("Monkey Test 3")
                        counter += 1
                        if (questionArray[2] == monkeysArray[0][0]) {
                            score += 1
                        }
                        if (counter >= Int(quizArray.count)) {
                            print("Go to Score view")
                            self.showingScore.toggle()
                            
                        }
                        else{
                            monkeysArray.remove(at: 0)
                            questionArray = randomMonkey(correctMonkey: monkeysArray[0][0], falseMonkey: quizArray)
                        }
                    }, label: {
                        Text(questionArray[2])
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding()
                            .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: screenSize.width/4)
                            .background(Color.yellow.cornerRadius(buttonRadius))
                            .padding(.all)
                    })
                        

                    
                    Button(action: {
                        print("Monkey Test 4")
                        counter += 1
                        if (questionArray[3] == monkeysArray[0][0]) {
                            score += 1
                        }
                        if (counter >= Int(quizArray.count)) {
                            print("Go to Score view")
                            self.showingScore.toggle()
                            
                        }
                        else{
                            monkeysArray.remove(at: 0)
                            questionArray = randomMonkey(correctMonkey: monkeysArray[0][0], falseMonkey: quizArray)
                        }
                    }, label: {
                        Text(questionArray[3])
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding()
                            .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: screenSize.width/4)
                            .background(Color.yellow.cornerRadius(buttonRadius))
                            .padding(.all)
                    })
                        

                }
                Spacer()


            }
        }
    }
}

struct ScoreView: View {
    @Binding var showingMainScore: Bool // for back button
    
    @State private var buttonRadius = 10.0
    @State private var screenSize: CGRect = UIScreen.main.bounds
    @Environment(\.dismiss) var dismiss
    
    @State private var slash = "/"
    @State private var percent = "%"
    @Binding var scorePost: Int
    @State var totalPost: Int
    @Binding var quizModePost: String
    
    var body: some View {
        
        VStack {
            Text("Complete")
                .font(.title)
                .padding()
            Text(quizModePost.uppercased())
                .font(.headline)
                .frame(alignment: .center)
                .padding()

            Spacer()
            
            HStack {
                Text("\(String(scorePost)) \(slash) \(totalPost)")
                    .padding(.all)
                Text("\(String(format: "%.2f", 100 * calculatePercentage(value: scorePost, percentageVal: totalPost))) \(percent)") // calculate score as a percentage
                    .padding(.all)
            }
            
            HStack {
                Spacer()
                if 100 * calculatePercentage(value: scorePost, percentageVal: totalPost) >= 50 {    // gray if score < 50
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                } else {
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .grayscale(0.99)
                }
                if 100 * calculatePercentage(value: scorePost, percentageVal: totalPost) >= 70 {    // gray if score < 70
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                } else {
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .grayscale(0.99)
                }
                if 100 * calculatePercentage(value: scorePost, percentageVal: totalPost) >= 90 {    // gray if score < 90
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                } else {
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .grayscale(0.99)
                }
                Spacer()
            }
            Spacer()
            Button(action: {
                print("Continue Test")
                let defaults = UserDefaults.standard    // allows permantent storage
                
                if (quizModePost == "easy") {   // save score in easy score array
                    print("Save Easy Score")
                    let scoresObject = UserDefaults.standard.object(forKey: "easyScores")
                    var easyScores: [Double]
                    
                    if let tempScores = scoresObject as? [Double] { // get previous scores
                        easyScores = tempScores
                        easyScores.append(calculatePercentage(value: scorePost, percentageVal: totalPost))
                        print(easyScores)
                    }
                    else {
                        easyScores = [calculatePercentage(value: scorePost, percentageVal: totalPost)]
                    }
                    UserDefaults.standard.set(easyScores, forKey: "easyScores") // save data
                }
                
                else if (quizModePost == "medium") {    // save score in medium score array
                    print("Save Medium Score")
                    let scoresObject = UserDefaults.standard.object(forKey: "mediumScores")
                    var mediumScores: [Double]
                    
                    if let tempScores = scoresObject as? [Double] {
                        mediumScores = tempScores
                        mediumScores.append(calculatePercentage(value: scorePost, percentageVal: totalPost))
                        print(mediumScores)
                    }
                    else {
                        mediumScores = [calculatePercentage(value: scorePost, percentageVal: totalPost)]
                    }
                    UserDefaults.standard.set(mediumScores, forKey: "mediumScores")
                }
                
                else if (quizModePost == "hard") {  // save score in hard score array
                    print("Save Hard Score")
                    let scoresObject = UserDefaults.standard.object(forKey: "hardScores")
                    var hardScores: [Double]
                    
                    if let tempScores = scoresObject as? [Double] {
                        hardScores = tempScores
                        hardScores.append(calculatePercentage(value: scorePost, percentageVal: totalPost))
                        print(hardScores)
                    }
                    else {
                        hardScores = [calculatePercentage(value: scorePost, percentageVal: totalPost)]
                    }
                    UserDefaults.standard.set(hardScores, forKey: "hardScores")
                    
                }
                
                else if (quizModePost == "marathon") {  // save score in marathon score array
                    print("Save Marathon Score")
                    let scoresObject = UserDefaults.standard.object(forKey: "marathonScores")
                    var marathonScores: [Double]
                    
                    if let tempScores = scoresObject as? [Double] {
                        marathonScores = tempScores
                        marathonScores.append(calculatePercentage(value: scorePost, percentageVal: totalPost))
                        print(marathonScores)
                    }
                    else {
                        marathonScores = [calculatePercentage(value: scorePost, percentageVal: totalPost)]
                    }
                    UserDefaults.standard.set(marathonScores, forKey: "marathonScores")
                }
                
                    self.showingMainScore.toggle()
                
            }, label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.all)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            })
                .frame(minWidth: 100, maxWidth: screenSize.width/2, minHeight: screenSize.width/4)
                .background(Color.yellow.cornerRadius(buttonRadius))
                .padding()
        }
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    let defaults = UserDefaults.standard
    
    @State private var showingReset = false
    //@State private var i = 0
    @State private var randomMode = "Easy"
    @State private var randomPercent = "80%"
    @State private var randMode = ["Easy", "Medium", "Hard", "Marathon"]

    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    print("Back Test")
                    dismiss()
                }, label: {
                    Image("backicon")   //Image of back arrow
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(.all)
                })
                        .scaledToFit()
                Spacer()
                
                Text("Profile") // Title
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Spacer()    // two spacers to put text in the center
            }
            

            Text("Easy Mode Progress")
            
            ZStack {
                Rectangle() // graph background
                    .stroke(Color.gray, lineWidth: 3.0)
                    .frame(width: 300, height: 100, alignment: .center)
                
                let easyHistory = defaults.object(forKey: "easyScores") as? [Double] ?? [Double]()  // pull data from permanent data
                if easyHistory.count > 0 {  // dont draw graph if no entries
                    LineShape(yDouble: easyHistory) // draw progress graph
                        .stroke(Color.red, lineWidth: 2.0)
                        .frame(width: 300, height: 100, alignment: .center)
                }
                
            }
            Text("Medium Mode Progress")
            ZStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 3.0)
                    .frame(width: 300, height: 100, alignment: .center)

                let mediumHistory = defaults.object(forKey: "mediumScores") as? [Double] ?? [Double]()  // pull data from permanent data
                if mediumHistory.count > 0 {
                    LineShape(yDouble: mediumHistory)    // draw progress graph
                        .stroke(Color.red, lineWidth: 2.0)
                        .frame(width: 300, height: 100, alignment: .center)
                }
            }
            Text("Hard Mode Progress")
            ZStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 3.0)
                    .frame(width: 300, height: 100, alignment: .center)

                let hardHistory = defaults.object(forKey: "hardScores") as? [Double] ?? [Double]()  // pull data from permanent data
                if hardHistory.count > 0 {
                    LineShape(yDouble: hardHistory)  // draw progress graph
                        .stroke(Color.red, lineWidth: 2.0)
                        .frame(width: 300, height: 100, alignment: .center)
                }
            }
            Text("Marathon Mode Progress")
            ZStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 3.0)
                    .frame(width: 300, height: 100, alignment: .center)

                let marathonHistory = defaults.object(forKey: "marathonScores") as? [Double] ?? [Double]()  // pull data from permanent data
                if marathonHistory.count > 0 {
                    LineShape(yDouble: marathonHistory)  // draw progress graph
                        .stroke(Color.red, lineWidth: 2.0)
                        .frame(width: 300, height: 100, alignment: .center)
                }
            }


        }
    } 
}


func randomMonkey(correctMonkey: String, falseMonkey: [[String]]) -> [String] { // return 3 random answers aswell as correct answer in a shuffled array
    var monkeySelection = [String]()
    monkeySelection.append(correctMonkey)
    while monkeySelection.count != 4 {
        let randomMonkey = falseMonkey.randomElement()!
        if (monkeySelection.contains(randomMonkey[0]) == false) {
            monkeySelection.append(randomMonkey[0])
        }
    }
    
    monkeySelection.shuffle()
    return monkeySelection
}

func buildList(mode: String) -> [[String]] {    // return array of questions depending on mode
    var listToBuild = [[String]]()
    let easyList = [["Baboon", "baboon"],
                    ["Capuchin", "capuchin"],
                    ["Gorilla", "gorilla"],
                    ["Howler Monkey", "howler"],
                    ["Lemur", "lemur"],
                    ["Orangutan", "orangutan"],
                    ["Spider Monkey", "spider"],
                    ["Squirrel Monkey", "squirrel"]]    // easy questions
    
    let mediumList = [["Aye Aye", "ayeaye"],
                      ["Bald Uakari", "balduakari"],
                      ["Bush Baby", "bushbaby"],
                      ["Chimpanzee", "chimpanzee"],
                      ["Gibbon", "gibbon"],
                      ["Green Monkey", "green"],
                      ["Japanese Macaque", "japanesemacaque"],
                      ["Mandrill", "mandrill"],
                      ["Proboscis Monkey", "proboscis"],
                      ["Pygmy Marmoset", "pygmymarmoset"]]  // medium questions
    
    let hardList = [["Allen's Swamp Monkey", "allensswamp"],
                    ["Bonobo", "bonobo"],
                    ["Bornean Orangutan", "bornean"],
                    ["Debrazza's Monkey", "debrazzas"],
                    ["Emperor Tamarin", "emperor"],
                    ["Golden Lion Tamarin", "goldenlion"],
                    ["Golden Snub Nosed Monkey", "goldensnub"],
                    ["Saki", "saki"],
                    ["Sumatran Orangutan", "sumatran"]] //hard questions
    
    if (mode == "easy") {   // return easy questions
        for i in easyList {
            listToBuild.append([i[0],i[1]])
        }
    }
    else if (mode == "medium") {    // return medium questions
        for i in mediumList {
            listToBuild.append(i)
        }
    }
    else if (mode == "hard") {  // return hard questions
        for i in hardList {
            listToBuild.append(i)
        }
    }
    else if (mode == "marathon") {  // return all questions
        for i in easyList {
            listToBuild.append(i)
        }
        for i in mediumList {
            listToBuild.append(i)
        }
        for i in hardList {
            listToBuild.append(i)
        }
    }
    listToBuild.shuffle()   // shuffle array to randomise questions
    return listToBuild
}

public func calculatePercentage(value:Int,percentageVal:Int)->Double{
    let val = Double(value) / Double(percentageVal)

    return val
}

struct LineShape: Shape {
    var yDouble: [Double]

    func path(in rect: CGRect) -> Path {
        let xUp = (rect.width / (CGFloat(yDouble.count) - 1))   // length
        var path = Path()   // path to measure progress
        path.move(to: CGPoint(x: 0.0,
                              y: (1.0 - yDouble[0]) * Double(rect.height))) // mark first item on path
        for i in 1..<yDouble.count {    // for loop of past score
            let pt = CGPoint(x: (Double(i) * Double(xUp)),
                             y: (1.0 - yDouble[i]) * Double(rect.height))   // mark other items on path
            path.addLine(to: pt)
        }
        return path
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


