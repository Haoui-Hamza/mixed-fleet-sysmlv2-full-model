package StructuralElements {
    private import ScalarValues::*;
    private import ActionsSpace::*;
    private import RequirementsSpace::*;

     // Abstract base class for all Stackholders
    part def Person {
        ref item parent[2] : Person;
        ref item mother : Person[1..1] subsets parent;
        attribute numberOfChildren : Natural;
        ref item children[0..numberOfChildren] : Person;

        
    }

    // Items: class of identifiable objects that may be acted on over time, but do not necessarily perform actions themselves.
    item def Shipment {

    }

    item def Container {
        attribute id : String;
        attribute contentType : String;
        attribute weight : ISQ::MassValue;
        attribute dimensions : Dimensions;
        attribute currentLocation : Coordinate;
    }


    // Parts: modular units of structure, such as systems, system components, or external entities
    part def Environment {
        attribute name : String; // e.g., "HarborArea1"
        attribute coordinateType : String; // e.g., "Cartesian", "LocalCoordinate"
        attribute safetyLevel : Percentage; // 1 | 2 | 3 : how safe the environment is
        attribute isIndoor : Boolean; // true if it's inside a structure (e.g., warehouse)
        attribute trafficDensity : Percentage; // e.g., high traffic area might impact operations
        attribute visibilityLevel : Percentage; // to describe fog, lighting, etc.
        attribute operationalStatus : Number; // e.g., 1 when operational and 0 when restricted
        attribute shoreLocation : Coordinate;
        attribute storageArea : Coordinate;
    }

    part def Vehicle {
        attribute id : String; // Unique identifier for the vehicle
        attribute autonomyLevel: Real; // 0 = manual, 1 = assisted, 2 = fully autonomous
        attribute currentLocation:Coordinate;
    }
    part def Agv specializes Vehicle {
       attribute liftingCapacity :> ISQ::mass;
    }

    part def Uav specializes Vehicle {
        attribute scanRange : ISQ::LengthValue; // Maximum range of scanning capability
    }

    part def Crane specializes Vehicle {
        attribute liftingCapacity : ISQ::MassValue; 
        attribute reachLength : ISQ::LengthValue; // Horizontal reach of the crane's arm
        action unload_container:S_Unload;
    }
    part def Forklift specializes Vehicle {
        attribute liftingCapacity : ISQ::MassValue; // Max weight the forklift can lift
        attribute forkHeight : ISQ::LengthValue; // Height range of the fork for lifting
        action  shuffle_containers : S_Shuffle;
        action load_container : S_Load;
    }
    // Truck used for transporting containers within or outside the port
    part def Truck specializes Vehicle {
        attribute maxLoad : ISQ::MassValue; // Max cargo weight capacity
    }

    part def Ship specializes Vehicle {
        attribute dockedLocation : Coordinate;
        attribute capacity : Integer;
    }


    // Data types definitions
    attribute def Coordinate {
        attribute X : Real ;
        attribute Y : Real ;
        attribute Z : Real ;
    }

    attribute def Dimensions {
        attribute length : ISQ::LengthValue;
        attribute width : ISQ::LengthValue;
        attribute height : ISQ::LengthValue;
    }

    attribute def Percentage {
        attribute value: Integer; // 0 to 100
    }
    
    // enum
    enum def ActionResponse {
        Success;
        Failed;
        Timeout;
        Interrupted;
    }
}
