# SwiftUI Clean Architecture

A SwiftUI TodoList App implemented with clean architecture.

## Concept
```mermaid
graph LR
    UI[View]
    A[AppState]
    I[Interactor]
    R[Repository]

    A -->|Data Binding| UI -->|UI Operation| I
    I -->|Update State| A 
    I -->|CURD Resource| R
```
- #### `View` 
    View represents SwiftUI view structure.
- #### `AppState` 
    `Stateful`</br>
    AppState stores the data status of the APP.
- #### `Interactor` 
    `Stateless`</br>
     Interactor handles the business logic.
- #### `Repository`
    Repository provides the persistence data using different sources.



## Directory Structure
> The node is a file when it has file extension.</br> 
> Otherwise, the node represents a directory.
```cpp
|
|__ UI  // SwiftUI Views
|
|__ Internal
        |
        |__ DependencyInjector
        |           |
        |           |__ Container.swift         // dependency injector instance
        |           |__ EnvironmentKey.swift    // environment key definition
        |
        |__ Entity      // Data Models
        |
        |__ Domain      // Interfaces
        |       |
        |       |__ AppState.swift              // AppState interface definition
        |       |__ Interactor.swift            // Interactor interface definition
        |       |__ Repository.swift            // Repository interface definition
        |
        |__ AppState    // AppState implementation
        |       |
        |       |__ Mock                        // AppState mocked instance
        |       |__ General                     // AppState general instance
        |
        |__ Interactor  // Interactor implementation
        |       |
        |       |__ Mock                        // Interactor mocked instance
        |       |__ General                     // Interactor general instance
        |
        |__ Repository  // Repository implementation
        |       |
        |       |__ Mock                        // Repository mocked instance
        |       |__ General                     // Repository general instance
        |
        |__ Util        // Utilities
```

## Architecture

### General
All component function
```mermaid
graph TD
    subgraph " "
        AI[AppState Instance]
    end

    subgraph Dependency Injector
        I{Interactor}
        A{AppState}
    end

    subgraph " "
        AD{AppState\nDelegate}
        R{Repository}
        II[Interactor Instance]
    end

    subgraph " "
        DB[(Database)]
        C[(Cache)]
        N[(Network)]
        RI[Repository Instance]
        RI <==> DB & C & N
    end

    View ==>|UI Operation| I ==>|UI Operation| II 
    View <-.->|Data\nBinding| A -.-|Implementation| AI
    
    AD -..-|Implementation| AI

    II <==>|ALTER Data\nGET Data| R
    R <==>|ALTER Data\nGET Data| RI
    II ==>|Update State| AD
```

### Mock AppState
Implement AppState interface with mock instance
```mermaid
graph TD
    AI((Mock AppState Instance))

    subgraph Dependency Injector
        I{Interactor}
        A{AppState}
    end

    subgraph " "
        AD{AppState\nDelegate}
        R{Repository}
        II[Interactor Instance]
    end

    subgraph " "
        DB[(Database)]
        C[(Cache)]
        N[(Network)]
        RI[Repository Instance]
        RI <==> DB & C & N
    end

    View ==>|UI Operation| I ==>|UI Operation| II 
    View <-.->|Data\nBinding| A -.-|Implementation| AI
    
    AD -..-|Implementation| AI

    II <==>|ALTER Data\nGET Data| R
    R <==>|ALTER Data\nGET Data| RI
    II ==>|Update State| AD
```

### Mock Repository
Implement Repository interface with mock instance
```mermaid
graph TD
    subgraph " "
        AI[AppState Instance]
    end

    subgraph Dependency Injector
        I{Interactor}
        A{AppState}
    end

    subgraph " "
        AD{AppState\nDelegate}
        R{Repository}
        II[Interactor Instance]
    end


    RI((Mock Repository Instance))

    View ==>|UI Operation| I ==>|UI Operation| II 
    View <-.->|Data\nBinding| A -.-|Implementation| AI
    
    AD -..-|Implementation| AI

    II <==>|ALTER Data\nGET Data| R
    R <==>|ALTER Data\nGET Data| RI
    II ==>|Update State| AD
```


### Mock Interactor
Implement Interactor interface with mock instance
```mermaid
graph TD
    subgraph " "
        AI[AppState Instance]
    end

    subgraph Dependency Injector
        I{Interactor}
        A{AppState}
    end
    

    II((Mock Interactor Instance))

    View ==>|UI Operation| I ==>|UI Operation| II ==>|Update State| AI
    View <-.->|Data\nBinding| A -.-|Implementation| AI
```
