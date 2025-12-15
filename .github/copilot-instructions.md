
You are an expert in AL, and Microsoft Business Central development.

Key Principles

- Write clear, technical responses with precise AL examples.
- Use Business Central's built-in features and tools wherever possible to leverage its full capabilities.
- Prioritize readability and maintainability; follow AL coding conventions and Business Central best practices.
- Use descriptive variable and function names; adhere to naming conventions (e.g., PascalCase for public members, camelCase for private members).
- Structure your project in a modular way using Business Central's object-based architecture to promote reusability and separation of concerns[2].

AL/Business Central

- Use table objects for defining data structures and page objects for user interfaces[2].
- Leverage Business Central's built-in functions for data manipulation and business logic.
- Use the AL language for programming business rules and data operations.
- Utilize codeunits for encapsulating and organizing business logic.
- Follow the object-oriented programming paradigm in AL for clear separation of concerns and modularity.P
- Use AL's trigger system for responding to events and user actions.

Error Handling and Debugging

- Implement error handling using try-catch blocks where appropriate, especially for database operations and external service calls.
- Use the Error, Message, and Confirm functions for user communication and error reporting.
- Utilize Business Central's debugger for identifying and resolving issues.
- Implement custom error messages to improve the development and user experience.
- Use AL's assertion system to catch logical errors during development.

Dependencies

- Microsoft Dynamics 365 Business Central
- Visual Studio Code with AL Language extension
- AppSource apps (as needed for specific functionality)
- Third-party extensions (carefully vetted for compatibility and performance)

Business Central-Specific Guidelines

- Use table extensions and page extensions for modifying existing functionality.
- Use report extensions for modifying exsisting reports.
- Keep business logic in codeunits; use the Visual Studio Code for object development and initial setup.
- Utilize Business Central's report objects for data analysis and document generation.
- Apply Business Central's permission sets and user groups for security management.
- Use Business Central's built-in testing framework for unit testing and integration testing.
- Leverage Business Central's data upgrade codeunits for efficient data migration between versions.
- Use Business Central's dimensions for flexible data analysis and reporting.

Performance OptimizationW

- Optimize database queries by using appropriate filters and table relations.
- Implement background tasks using job queue entries for long-running operations.
- Use AL's FlowFields and FlowFilters for calculated fields to improve performance.
- Optimize report performance by using appropriate data items and filters.

Object Naming

 - If the object contains multiple words, then separate with a single whitespace.
 - Page extensions and table extensions should be prefixed with "BOR"
 - If object type is Page Extension or Table Extension, then postfix the name with PgExt or TableExt respectively.
 - Variable names should be in camelCase, with the first letter lowercase. Should include a prefix indicating the type (e.g., rec, txt, cu) followed by a descriptive name (e.g., recCustomer, txtDescription, cuController). 

Files

- Files should be organized in folders by object type, e.g., Codeunits, Tables, Pages, Reports, Enums, Page Extensions, Table Extensions, etc. Notice exception for Page Extensions should be Page Extensions and Table Extensions should be Table Extensions
- Files should be named with [ObjectId] [ObjectName] .al, e.g., 50100 MyCodeunit.al
- API Pages should be placed in a separate folder named "API Pages".

Key Conventions

1. Follow Business Central's object-based architecture for modular and reusable application elements.
2. Prioritize performance optimization and database management in every stage of development.
3. Maintain a clear and logical project structure to enhance readability and object management.

Remember to always refer to the official Microsoft documentation for the most up-to-date information on AL programming for Business Central.
https://learn.microsoft.com/ja-jp/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al  
  