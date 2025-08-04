# SysML v2 Model - Mixed Fleet Container Handling System

## Overview

This repository contains an exerpt of a SysML v2 model of a mixed fleet container handling system. The model demonstrates how heterogeneous autonomous vehicles (cranes, AGVs, forklifts, UAVs, trucks, and ships) can be coordinated to perform complex container handling workflows from ship-to-shore operations through final loading onto transport vehicles.

## What is This Model About?

The model represents a **container terminal operation** where different types of vehicles work together to handle containers through a complete logistics workflow:

1. **Unloading**: Cranes unload containers from ships to shore locations
2. **Movement**: AGVs transport containers from shore to storage areas
3. **Shuffling**: Forklifts reorganize containers within storage areas
4. **Loading**: Forklifts load containers onto trucks for final transport
5. **Search**: UAVs locate containers when needed
6. **Inspection**: UAVs perform an inspections of a suspicious or possibly damaged container

The model captures not just the structural aspects (vehicle types, containers, environment) but also the behavioral workflows, requirements, constraints, and verification procedures needed for postconditions verification.

## Model Architecture

The model is organized into four semantic spaces that promote separation of concerns and traceability:

### 📁 Structural Elements (`StructuralElements.sysml`)
- **Vehicle hierarchy**: Base `Vehicle` class specialized into `Crane`, `AGV`, `Forklift`, `UAV`, `Truck`, and `Ship`
- **Container and environment definitions**: Physical objects and operational contexts
- **Data types**: Coordinates, dimensions, and response enumerations

### 📋 Requirements Space (`RequirementsSpace.sysml`)
- **Hierarchical requirements**: Abstract requirement definitions specialized for specific operations
- **Constraint definitions**: Reusable constraints for safety, validation, and operational conditions
- **Role assignments**: Clear specification of subjects, stakeholders, actors, and items for each requirement

### ⚡ Actions Space (`ActionsSpace.sysml`)
- **Service definitions**: Atomic actions (`S_Unload`, `S_Move`, `S_Shuffle`, `S_Load`, `S_Search`, `S_Inspect`)
- **Base behaviors**: Common operational constraints inherited by specialized actions
- **Parameter interfaces**: Standardized inputs and outputs for service composition

### ✅ Verification Space (`Verifications.sysml`)
- **Test definitions**: Formal verification cases with explicit pass/fail criteria
- **Requirement traceability**: Direct links between verification cases and requirements
- **Runtime validation**: Integration of verification into operational workflows

### 🚢 Mixed Fleet Integration (`MixedFleet.sysml`)
- **Workflow orchestration**: `NormalOperation` action example that coordinates all services
- **Service composition**: Integration of atomic services into complex business processes
- **Verification-driven behavior**: Conditional execution based on verification results

## Key Modeling Patterns

The model demonstrates several reusable SysML v2 patterns: later 

- **Specialization Hierarchy Pattern**
- **Requirement Compositions Pattern**
- **Constraint Reuse Pattern**
- **Verification Integration Pattern** 
- **Service Participants Specification**
- **Service Choreography Pattern**

Check the paper for the details 

## Service-Oriented Architecture Mapping

The model serves as a foundation for service-oriented architecture implementation, the mapping is available in Table1


## Getting Started

### Prerequisites
- SysML v2 compatible modeling tool
- Understanding of systems engineering and service-oriented architecture concepts

### Model Structure
```
mixed-fleet-sysmlv2-full-model/
├── StructuralElements.sysml    # Vehicle types, containers, environment
├── RequirementsSpace.sysml     # Requirements and constraints
├── ActionsSpace.sysml          # Service definitions and behaviors
├── Verifications.sysml         # Verification cases and test definitions
└── MixedFleet.sysml           # Workflow orchestration and integration
```

### Key Concepts

- **Vehicles as Service Providers**: Each vehicle type provides specific services based on its capabilities
- **Requirements-Driven Design**: All actions trace back to formal requirements with explicit constraints
- **Verification-Driven Execution**: System behavior adapts based on runtime verification results
- **Environmental Context**: All operations consider environmental safety and operational conditions

## Use Cases

This model can be adapted for various domains:
- **Port and terminal operations**
- **Warehouse and logistics systems**
- **Construction site coordination**
- **Agricultural fleet management**
- **Emergency response coordination**

## Research Applications

The model demonstrates:
- SysML v2 language capabilities for complex system modeling
- Integration of requirements, behavior, and verification in a single model
- Service-oriented system design using systems engineering principles
- Patterns for scalable and traceable system models

## Contributing

When extending the model:
1. Follow the established semantic space organization
2. Apply the documented modeling patterns consistently
3. Ensure traceability between requirements, actions, and verification
4. Maintain the service-oriented architecture principles

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

paper link 

*This model demonstrates the application of SysML v2 for modeling complex, service-oriented systems with heterogeneous components, formal requirements, and integrated runtime verification.*