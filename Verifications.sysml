package Verefication{
    private import ScalarValues::*;
    private import StructuralElements::*; 
    private import RequirementsSpace::*;     
    private import VerificationCases::*;
    private import ActionsSpace::* ;
    

    verification def VehicleMouvementTestDefinition {
       
        subject testVehicle : Vehicle;

        in destination:Coordinate;
        in status:ActionResponse;

        objective VehicleArrivedToLocation {
            doc /* Tests whether a vehicle has successfully moved to its intended destination.
            * It defines an objective called VehicleArrivedToLocation that verifies the R_Move_Container requirement */

            // The subject of the verify is automatically bound to "testVehicle".
            verify R_Move_Container ;
        }
        action evaluateData {
            in destination = destination;
            in currentLocation = testVehicle.currentLocation ;
            in status = status ;
            out verdict : VerdictKind = PassIf(destination==currentLocation and status==ActionResponse::Success );
        };

        return verdict : VerdictKind = evaluateData.verdict;
    }


}