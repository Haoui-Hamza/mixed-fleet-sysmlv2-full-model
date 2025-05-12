package MixedFleet {
    private import ScalarValues::*;
    private import StructuralElements::*;
    private import RequirementsSpace::*;
    private import ActionsSpace::*;
    private import Verefication::*;
    private import VerificationCases::*;
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

    

        action unloadContainer : S_Unload{
            in :>> vehicleId= craneId ; //The :>> symbol is equivalent to the redefines keyword
            in :>> itemId = containerId ; 
            in :>> fromPlatformId = shipId ; 
            in :>> toLocation = environement.shoreLocation ; 
            out status;
        }
        action moveContainer: S_Move{
            in :>> vehicleId = agvId;
            in :>> itemId = containerId;
            in :>> fromLocation = environement.shoreLocation;
            in :>> toLocation = environement.storageArea;
            out status;
        }
        action shuffleContainers:S_Shuffle{
            in :>> vehicleId = forkliftId;
            in :>> areaLocation = environement.storageArea;
            out status;
        }
        action loadContainer:S_Load{
            in :>>vehicleId=forkliftId;
            in :>> itemId = containerId;
            in :>> fromLocation = environement.storageArea ;
            in :>> transportUnitId = truckId;
            out status;
        }

        first start ;
            then 
                perform unloadContainer;
           
            then
                perform moveContainer;
            then  
                perform VehicleMouvementTest{
                    :>> destination = moveContainer.toLocation;
                    :>> currentLocation = vehicle.currentLocation;
                    :>> status=status ;
                }
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