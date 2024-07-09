# Weather App Backend

This backend service is implemented using Java Servlets and PostgreSQL to support a weather application. It stores and retrieves the preferred location, enabling the Flutter frontend to show the last searched city's weather upon app startup.

## Features

- Store preferred location in the database
- Retrieve preferred location for display on app load
- RESTful API endpoints for managing preferred locations

## Getting Started

### Prerequisites

- JDK (Java Development Kit): [Install JDK](https://www.oracle.com/java/technologies/javase-downloads.html)
- Apache Tomcat or another Java Servlet container: [Install Tomcat](https://tomcat.apache.org/download-90.cgi)
- PostgreSQL: [Install PostgreSQL](https://www.postgresql.org/download/)
- JDBC Driver for PostgreSQL: [Download Driver](https://jdbc.postgresql.org/download.html)

### Installation

1. Set up the PostgreSQL database:
    - Create a new PostgreSQL database.
    - Run the `ddl.sql` script to create the necessary tables:

    ```sql
    CREATE TABLE preferred_locations (
        id SERIAL PRIMARY KEY,
        preferred_location VARCHAR(255) NOT NULL
    );
    ```

2. Update database connection details in `PreferredLocationDAO.java`:

    ```java
    private final String url = "jdbc:postgresql://localhost:5432/yourdb"; // replace 'yourdb' with your database name
    private final String user = "youruser"; // replace 'youruser' with your username
    private final String password = "yourpassword"; // replace 'yourpassword' with your password
    ```

3. Download the PostgreSQL JDBC driver and place it in the `lib` directory of your servlet container (e.g., Tomcat).

4. Build and deploy the backend:
    - Compile the Java code:

    ```bash
    javac -cp "path-to-tomcat-lib/servlet-api.jar;path-to-postgresql-driver/postgresql.jar" -d ../webapp/WEB-INF/classes weatherapp/*.java
    ```

    - Package the web application (e.g., into a WAR file) and deploy it on your servlet container.

### Running the Backend

1. Start your PostgreSQL database.
2. Start your Tomcat or other servlet container.
3. Access the API endpoints at `http://localhost:8080/location`.

## API Endpoints

### `GET /location`

Retrieves the preferred location from the database.

#### Response

```json
{
    "data": "New York" // Example response
}
```

### `POST /location`

Updates the preferred location in the database.

#### Request Body

```
New York
```

## Project Structure

```
weatherapp/backend/
├── src/main/java/weatherapp/
│   ├── PreferredLocationDAO.java
│   ├── PreferredLocationModel.java
│   └── WeatherAPIController.java
├── src/main/resources/
│   └── ddl.sql
└── WEB-INF/
    ├── classes/
    └── lib/
```

### File Descriptions

- **PreferredLocationModel.java**: Java model class representing the preferred location.
- **PreferredLocationDAO.java**: Data Access Object (DAO) for performing CRUD operations on the `preferred_locations` table.
- **WeatherAPIController.java**: Servlet handling HTTP requests for getting and updating the preferred location.
- **ddl.sql**: SQL script to set up the `preferred_locations` table.

## Usage

1. **Retrieve Preferred Location**:
    - `GET /location`
    - Fetches the preferred location from the database and returns it in JSON format.

2. **Update Preferred Location**:
    - `POST /location`
    - Updates the preferred location in the database based on the request body content.

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue to suggest improvements or report bugs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Apache Tomcat](https://tomcat.apache.org/) - Servlet container
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Gson](https://github.com/google/gson) - JSON library