import SwiftUI
import Alamofire

struct QuizScreen: View {
    
    @State var quizzes: [Quiz] = []
    @State private var selectedQuiz: Quiz? = nil
    @State private var showCustomDialog: Bool = false
    @State private var navigateToQuestionScreen: Bool = false
    
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack(alignment: .center){
                            Text("Catch Me App!")
                                .font(.title)
                                .bold()
                                .padding(.top, 20)
                        }
                        
                        ForEach(quizzes, id: \._id) { item in
                            Button(action: {
                                selectedQuiz = item
                                showCustomDialog = true
                            }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(item.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .lineLimit(2)
                                    }
                                    
                                    Spacer()
                                
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.accentColor)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(color: .blue.opacity(0.4), radius: 5, x: 0, y: 2)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.accentColor.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                        }
                        
                        Spacer()
                        
                        if let quiz = selectedQuiz {
                            NavigationLink(
                                destination: QuestionScreen(quizId: quiz._id),
                                isActive: $navigateToQuestionScreen,
                                label: {
                                    EmptyView()
                                })
                        }
                    }
                    .padding(.horizontal)
                    .onAppear(){
                        let url = "\(APIConfig.baseURL)/quizzes"
                        
                        AF.request(url).responseDecodable(of: [Quiz].self) { response in
                            quizzes = response.value ?? []
                        }
                    }
                }
            }
             
            if showCustomDialog {
                CustomDialogView(
                    title: "Teste Başlamak İstediğinize Emin Misiniz?",
                    description: "Bu testi başlattıktan sonra soruları cevaplayabilirsiniz.",
                    primaryButtonText: "Evet",
                    secondaryButtonText: "Hayır",
                    onPrimaryButtonTapped: {
                        showCustomDialog = false
                        navigateToQuestionScreen = true
                    },
                    onSecondaryButtonTapped: {
                        showCustomDialog = false
                    }
                )
            }
        }
    }
}

struct CustomDialogView: View {
    var title: String
    var description: String
    var primaryButtonText: String
    var secondaryButtonText: String
    var onPrimaryButtonTapped: () -> Void
    var onSecondaryButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.headline)
                    .padding(.top, 20)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                HStack(spacing: 20) {
                    Button(action: onSecondaryButtonTapped) {
                        Text(secondaryButtonText)
                            .bold()
                            .frame(width: 100, height: 40)
                            .background(Color.red.opacity(1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                     
                    Button(action: onPrimaryButtonTapped) {
                        Text(primaryButtonText)
                            .bold()
                            .frame(width: 100, height: 40)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius:20)
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}
 
#Preview {
    QuizScreen()
      
}
