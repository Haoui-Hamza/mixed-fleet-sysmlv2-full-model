package ActionsSpace{

    private import ScalarValues::*;

    private import StructuralElements::*; 
    private import RequirementsSpace::*;
    private import Verefication::*;
  
    action def operationalAction{
        in environement:Environment;
        assert constraint references environmentIsOperational {
            :>> operationalStatus = environement.operationalStatus;
        }
        assert constraint references safetyLevelAcceptable{
            :>> safetyLevel = environement.safetyLevel;
        }
    }
    // S.1 - Unload
    action def S_Unload specializes operationalAction{
        in vehicleId: String; 
        in itemId: String;
        in fromPlatformId: String;
        in toLocation: Coordinate;
        out status: ActionResponse;
    }

    // S.2 - Move
    action def S_Move {
        in vehicleId: String; 
        in itemId: String;
        in fromLocation: Coordinate;
        in toLocation: Coordinate;
        out status: ActionResponse;

        assert constraint references destinationIsDifferentFromSource{
            :>> source = fromLocation;
            :>> destination = toLocation;
        }
    }

    action def S_Shuffle {
        in vehicleId: String;
        in areaLocation: Coordinate;
        out status: ActionResponse;
    }
   
    action def S_Load {
        in vehicleId: String;
        in itemId: String;
        in fromLocation: Coordinate;
        in transportUnitId: String;
        out status: ActionResponse;
    }

    action def S_Search {
        in vehicleId: String;
        in itemId: String;
        in lastKnownLocation: Coordinate;
        out status: ActionResponse;
    }

    action def S_Inspect {
        in safetyAgentId: String;
        in itemId: String;
        out status: ActionResponse;
    }
}