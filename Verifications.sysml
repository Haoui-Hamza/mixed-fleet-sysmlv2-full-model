package Verefication{
    private import ScalarValues::*;
    private import StructuralElements::*; 
    private import RequirementsSpace::*;     
    private import VerificationCases::*;

    part testVehicle:Vehicle{

    }

    verification def VehicleMouvementTestDefinition {
        subject vehicle : Vehicle;

        in destination:Coordinate;
        in currentLocation:Coordinate;
        in status:ActionResponse;

        objective VehicleArrivedToLocation {
            // The subject of the verify is automatically bound to "testVehicle".
            verify R_Move_Container ;
        }
        return verdict : VerdictKind =PassIf(destination==currentLocation and status==ActionResponse::Success );  
    }

    verification VehicleMouvementTest:VehicleMouvementTestDefinition{
        subject vehicle :> testVehicle;
    }
}