package MixedFleet {
    private import ScalarValues::*;
    private import StructuralElements::*;
    private import RequirementsSpace::*;
    private import ActionsSpace::*;
    private import Verefication::*;
    private import VerificationCases::*;
    private import SI::*;
    // --- Services already defined separately (S_Unload, S_Move, S_Shuffle, S_Load) ---
    // Now we define the higher-level "Normal Operation" action:
    

   
    
    action  NormalOperation{
        in craneId: String;
        in shipId: String;
        in agvId: String;
        in containerId: String;
        in vehicleId: String;
        in forkliftId: String;
        in truckId: String;
        in environement: Environment;
        in transportUnitId: String;
        in vehicle : Vehicle;
        out status: ActionResponse;

        // define Actors taking parts of the operation
        part Agv01 : Agv {
            attribute redefines id = "AGV-001";
            attribute :>> autonomyLevel = 2.0;
            attribute :>> liftingCapacity = 1000[kg];

            perform moveContainer ;
        }
       
        part Uav01 : Uav {
            attribute :>> id = "UAV-001";
            attribute :>> autonomyLevel = 2.0;
            attribute :>> scanRange = 1000.0[m];
        }

        
        part Crane01 : Crane {
            attribute :>> id = "CRANE-001";
            attribute :>> autonomyLevel = 1;
            attribute :>> liftingCapacity = 50000.0 [kg];
            attribute :>> reachLength = 30.0 [m];

            perform unload_container;
        }

        
        part Forklift01 : Forklift {
            attribute :>> id = "FORK-001";
            attribute :>> autonomyLevel = 1;
            attribute :>> liftingCapacity = 5000.0 [kg];
            attribute :>> forkHeight = 6.0 [m] ;

            perform shuffleContainers ;
            perform loadContainer ;
        }

        
        part Truck01 : Truck {
            attribute :>> id = "TRUCK-001";
            attribute :>> autonomyLevel = 2;
            attribute :>> maxLoad = 25000.0 [kg];
        }

        
        part Ship01 : Ship {
            attribute :>> id = "SHIP-001";
            attribute :>> autonomyLevel = 2;
            attribute :>> capacity = 10000;
        }

        // actions usages 
        action unloadContainer : S_Unload{
            in :>> vehicleId= craneId ; //The :>> symbol is equivalent to the redefines keyword
            in :>> itemId = containerId ; 
            in :>> fromPlatformId = shipId ; 
            in :>> toLocation = environement.shoreLocation ; 
            out status;
            satisfy R_Unload_Container by Crane01 ;
        }
        action moveContainer: S_Move{
            in :>> vehicleId = agvId;
            in :>> itemId = containerId;
            in :>> fromLocation = environement.shoreLocation;
            in :>> toLocation = environement.storageArea;
            out status;
            satisfy R_Move_Container by Agv01 ;
        }
        action shuffleContainers:S_Shuffle{
            in :>> vehicleId = forkliftId;
            in :>> areaLocation = environement.storageArea;
            out status;
            satisfy R_Shuffle_Containers by Forklift01 ;
        }
        action loadContainer:S_Load{
            in :>>vehicleId=forkliftId;
            in :>> itemId = containerId;
            in :>> fromLocation = environement.storageArea ;
            in :>> transportUnitId = truckId;
            out status;
             satisfy R_Load_Container by Forklift01 ;
        }

        // verification cases
        verification VehicleMouvementTest:VehicleMouvementTestDefinition{
            :>> testVehicle = Agv01 ;
            :>> destination = moveContainer.toLocation;
            :>> status=status ;
        }


        // Actions succession flow
        first start ;
            then 
                perform unloadContainer;
           
            then
                perform moveContainer;
            then  
                perform VehicleMouvementTest;
            if  VehicleMouvementTest == VerdictKind::pass
            {
                perform shuffleContainers;
            }else{
                // some behaviour for error recovery from vehicle not able to move
            }
            then 
                perform loadContainer;

        then done;

        metadata def ToolConfig {
            attribute toolName : String;
            attribute uri : String;
        }
     
    }
    
}