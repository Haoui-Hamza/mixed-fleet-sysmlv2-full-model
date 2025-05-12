package RequirementsSpace{

    private import ScalarValues::*;
    private import StructuralElements::*;
    private import MixedFleet::*;
    private import VerificationCases::*;

    // --- Constraints ---

    constraint itemIdIsValid {
        attribute itemId: String;
        itemId != ""
    }
    constraint platformIdIsValid {
        attribute platformId: String;
        platformId != ""
    }


    constraint destinationIsDifferentFromSource{
        attribute source:Coordinate;
        attribute destination:Coordinate;
        source != destination
    }

    constraint environmentIsOperational {
        attribute operationalStatus : Number;
        operationalStatus == 1
    }
    constraint safetyLevelAcceptable {
        attribute safetyLevel : Number;
        safetyLevel >= 60
    }

    // --- Requirements for each service ---

    requirement def EnvironementRequirementDef {

        attribute operationalStatus : Number;
        attribute safetyLevel : Number;

        require environmentIsOperational {
            :>> operationalStatus = operationalStatus;
        }

        require safetyLevelAcceptable {
            :>> safetyLevel = safetyLevel;
        }
    }

    requirement EnvironementRequirement : EnvironementRequirementDef{
        subject environment:Environment;

        attribute :>> operationalStatus = environment.operationalStatus;
        attribute :>> safetyLevel = environment.safetyLevel.value;
    }
 
    // ------------------ START Requirements 1 ---------------------------

    requirement def RD_Unload specializes EnvironementRequirementDef{

        doc /* This requirement defines the unloading of a item from  other platform
        * to a designated location using a vehicle.
        */

        attribute itemId: String;
        attribute fromPlatformId: String;
        attribute toLocation: Coordinate;

        assume itemIdIsValid {
            :>> itemId = itemId;
        }
    }



    requirement <'S.1'> R_Unload_Container : RD_Unload {
        doc /* This requirement defines the unloading of a container from a ship
        * to a designated location on shore using a crane.
        */
        subject crane:Crane;
        stakeholder operator : Person;
        actor environment:Environment;
        actor ship : Ship;

        item container:Container;

        attribute :>> itemId = container.id;
        attribute :>> fromPlatformId = ship.id;
        attribute toLocation :>> environment.shoreLocation;
    }

    // ------------------ END Requirements 1 ---------------------------


    // ------------------ START Requirements 2 ---------------------------
    requirement def RD_Move specializes EnvironementRequirementDef{

        doc /* This requirement Move item from location to destination 
        */

        attribute itemId: String;
        attribute fromLocation: Coordinate;
        attribute toLocation: Coordinate;

        assume itemIdIsValid {
            :>> itemId = itemId;
        }
        
        require destinationIsDifferentFromSource{
            :>> source = fromLocation;
            :>> destination = toLocation;
        }
    }

    requirement <'S.2'> R_Move_Container:RD_Move {
        doc /* This requirement Move container from shore to stack by the Agv
        * Containers are moved from the shore onto temporary storage areas.
        */
        subject agv:Agv;

        stakeholder operator : Person;
        actor environment:Environment;
        item container:Container;
        
        attribute :>> itemId = container.id;
        attribute :>> fromLocation = environment.shoreLocation;
        attribute :>> toLocation =  environment.storageArea;

    }
    // ------------------ END Requirements 2 ---------------------------


    // ------------------ START Requirements 3 ---------------------------
    requirement def RD_Shuffle specializes EnvironementRequirementDef {
        doc /* This requirement describes how items are shuffled within the
        * a specific area.
        */

        attribute itemsIds[1..*]: String;
        attribute areaLocation : Coordinate;

        assume itemIdIsValid {
            :>> itemId = itemId;
        }

    }

    requirement <'S.3'> R_Shuffle_Containers:RD_Shuffle {
        doc /* This requirement describes how containers are shuffled within the
        * the storage areas.
        */
        subject forklift : Forklift;
        stakeholder operator : Person;
        actor environment:Environment;

        item containers[1..*]:Container; 

        attribute :>> itemsIds = containers.id;
        attribute :>> areaLocation = environment.storageArea;

    }
    // ------------------ END Requirements 3 ---------------------------


    // ------------------ START Requirements 4 ---------------------------
    requirement def  RD_Load  specializes EnvironementRequirementDef {
        doc /* This requirement specifies loading containers from a storage
        * location onto a transport unit.
        */
        attribute containerId : String;
        attribute fromLocation : Coordinate;
        attribute transportUnitId : String;

        assume itemIdIsValid {
            :>> itemId = containerId;
        }


    }

    requirement <'S.4'> R_Load_Container : RD_Load {
        doc /* This requirement specifies loading containers from a storage
        * location onto a truck or train.
        */

        subject forklift : Forklift;
        stakeholder operator : Person;
        actor environement: Environment;
        actor truck:Truck;

        item container: Container;

        attribute :>> containerId = container.id;
        attribute :>> fromLocation = environement.storageArea;
        attribute :>> transportUnitId = truck.id;

    }
    // ------------------ END Requirements 4 ---------------------------

    // ------------------ START Requirements 5 ---------------------------
    requirement def RD_Search  specializes EnvironementRequirementDef {
        doc /* This requirement defines the conditions for searching items
        */

        attribute itemId : String;
        attribute lastKnownLocation : Coordinate;

        assume itemIdIsValid {
            :>> itemId = itemId;
        }

    }

    requirement <'S.5'> R_Search_Container:RD_Search {
        doc /* This requirement defines the conditions for searching containers
        * using vision-equipped vehicles or human operators.
        */

        subject uav : Uav;

        stakeholder operator : Person;

        item container: Container;

        attribute :>> itemId = container.id;
        attribute :>> lastKnownLocation = container.currentLocation;

    }
    // ------------------ END Requirements 5 ---------------------------


    // ------------------ START Requirements 6 ---------------------------
    requirement def RD_Inspect  specializes EnvironementRequirementDef {
        doc /* Inspect problematic item 
        * In certain cases, a manual inspection of a container may be required before continuing thetransport.
        */

        attribute itemId : String;

        assume itemIdIsValid {
            :>> itemId = itemId;
        }

    }

    requirement <'S.6'> R_Inspect_Container : RD_Inspect {
        doc /* Inspect problematic container 
        * In certain cases, a manual inspection of a container may be required before continuing thetransport.
        */

        subject safetyAgent : Person;

        stakeholder operator : Person;

        item container:Container;

        attribute :>> itemId = container.id;
   
    }
    // ------------------ END Requirements 6 ---------------------------
}