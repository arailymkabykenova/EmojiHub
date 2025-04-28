import SwiftUI

struct ContentView: View {
    var body: some View {
        // NavigationView provides the top bar and allows pushing new views
        NavigationView {
            // VStack arranges views vertically
            VStack(spacing: 20) { // Add some spacing between elements
                Text("👋 Welcome to EmojiApp!")
                    .font(.largeTitle) // Make the font bigger
                    .fontWeight(.bold) // Make it bold

                Text("Explore a world of emojis.")
                    .font(.title2)
                    .foregroundColor(.gray) // Change text color

                Spacer() // Pushes content to the top

                // This links to our (soon to be created) EmojiListView
                NavigationLink(destination: EmojiListView()) {
                    Text("Browse Emojis")
                        .font(.headline)
                        .padding() // Add padding around the text
                        .frame(maxWidth: .infinity) // Make button wide
                        .background(Color.blue) // Blue background
                        .foregroundColor(.white) // White text
                        .cornerRadius(10) // Rounded corners
                }
                .padding(.horizontal) // Add padding on the sides of the button

                Spacer() // Pushes content up from the bottom
            }
            // Set the title that appears in the navigation bar
            .navigationTitle("Home")
            // Optional: Add padding around the whole VStack content
            .padding()
            // Optional: A subtle background color for "atmosphere"
            // .background(Color(UIColor.systemGray6).ignoresSafeArea())
        }
    }
}

// This preview code helps Xcode show your UI design live
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
