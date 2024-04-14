# Movie Booking System

This is a CLI-based movie booking system where users can browse available movies and book show tickets.

## Prerequisites
Before running the application, ensure you have Ruby installed on your system.

- Ruby (version 3.2.2 recommended)
- Bundler gem (for installing dependencies)

## Installation

1. Clone this repository to your local machine.
    ```bash
     git clone git@github.com:dev-ishtiyaque-khan/movie-booking-ruby.git
    ```
2. Navigate to the project directory
3. Install dependencies using Bundler
    ```bash
    bundle install
    ```
4. Make `bin/executor` executable.
    ```bash
    chmod +x bin/executor
    ```

## Usage
1. Checkout to development branch
    ```bash
    git checkout development
    ```
2. Run the application (In **development branch**)
    ```bash
    bin/executor
    ```
3. Follow the prompts to browse movies, select a movie and book/cancel ticket.

### Future Enhancements

1. **User Authentication and Authorization**:
   - Enhance the system to support multiple users by implementing user authentication and authorization.
   - Users can sign up for an account, log in securely, and access personalized features such as booking history and book tickets.

2. **Admin Interface**:
   - Introduce an admin interface for managing movies, shows, and user accounts.
   - Admins can add new movies, shows and update existing show schedules.

3. **File Storage for Data Persistence**:
   - Implement a file storage mechanism using structured JSON or YAML files for improved data storage and retrieval.
   - Migrate from CSV files to structured formats for better organization, scalability, and ease of maintenance.
   - Ensure that booking, cancellation, and movie related operations persist data to files, providing a reliable storage solution.