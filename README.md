<div align="center">
  <img src="https://github.com/Romulomga/CinePeak/assets/23625196/e3f9d0f0-1009-4054-8b79-423ee6d5fed9" alt="Screenshot 1" width="200" />
  <img src="https://github.com/Romulomga/CinePeak/assets/23625196/a9f32a3f-e5a0-408f-9645-48de17573852" alt="Screenshot 2" width="200" />
  <img src="https://github.com/Romulomga/CinePeak/assets/23625196/cafaba99-5764-40b4-8820-3a9fd88cc34d" alt="Screenshot 3" width="200" />
</div>

# CinePeak

CinePeak is an iOS application developed in Swift, focusing on providing up-to-date information about popular movies. Utilizing modern architecture and clean code practices, CinePeak offers a rich and fluid user experience.

## Features

- **Popular Movies Listing**: Discover a list of the most popular movies.
- **Movie Details**: Access detailed information about each movie, including synopsis, ratings, and more.

## Localization

- CinePeak is designed to reach both English and Portuguese-speaking audiences, offering localized content to enhance user experience. This approach helps in catering to users from different linguistic backgrounds.

## Architecture

- The project follows the MVVM (Model-View-ViewModel) architecture with the use of Coordinators for navigation.
- Dependency Injection: Implemented in the Coordinator to manage dependencies efficiently.

## Technologies Used

- **Swift**: A powerful and intuitive programming language for iOS development.
- **Kingfisher**: A versatile library for downloading and caching images from the web.
- **NetworkKit**: A custom Swift package developed by the author, handling network operations efficiently.

## Installation

Clone the repository and open the `CinePeak.xcodeproj` file in Xcode. Then, run the project on an iOS simulator or device.

```bash
git clone https://github.com/Romulomga/CinePeak.git
cd CinePeak
open CinePeak.xcodeproj
```

### Important Configuration

Before building the project, you must obtain an `API_TOKEN` from [The Movie Database (TMDb)](https://www.themoviedb.org). This token is essential for accessing the movie data. Once you have the token, add it to the provided `xcconfig` file in the project.

## Minimum Requirements

- **iOS Target**: iOS 16.0 or later.
- **Xcode Version**: Xcode 15.2 or later.

## Testing

To run the unit tests, select the `CinePeakTests` scheme in Xcode and run the tests (`Command + U`).
