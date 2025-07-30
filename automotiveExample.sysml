package AutomotiveExample{
    // "The vehicle shall automatically apply the brakes within 300 milliseconds
    // when a forward collision is predicted."
    private import ScalarValues::*;

    requirement def MassLimitationRequirement {
        doc /* The actual mass shall be less than or equal
        * to the required mass. */
        attribute massActual : ISQ::MassValue;
        attribute massReqd : ISQ::MassValue;
        require constraint { massActual <= massReqd }
    }

    requirement vehicleSpecification {
        doc /* Overall vehicle requirements group */
        subject vehicle : Vehicle;
    }

    part Vehicle {
        attribute dryMass: ISQ::MassValue;
        attribute fuelMass: ISQ::MassValue;
        attribute fuelFullMass: ISQ::MassValue;
    }

    action  action1{
        in craneId: String;
        satisfy vehicleSpecification by Vehicle ;
    }   

    part def part1 {
        perform action1;
    } 
}