%This script calculates freshwater demand of each thermal power plant in
%the specific country. The first part of the code calculates the specific
%freshwater withdrawals, the second part calculates the specific freshwater
%consumption.

clear WaterPower
WaterPower=zeros(size(NumberPowerPlant,1),3);
for i=1:size(NumberPowerPlant,1)
   if SeaCooling(NumberPowerPlant==i)==0 %for freshwater-cooled power plants
      
%TypeOfFuel=1 for coal power plants; TypeOfFuel=2 for gas power plants;
%TypeOfFuel=3 for nuclear power plants; TypeOfFuel=4 for oil power plants
%FlhCoal2015, FlhGT2015, FlhNuclear2015, FlhOil2015 - Full Load Hours of
%the specific power plant in 2015, obtained from IEA (2015)
% 'Node' connects the power plant data with country data
            if TypeOfFuel(NumberPowerPlant==i)==1
            FLHcoeff=FlhCoal2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; %for the case if data is not available    
           elseif TypeOfFuel(NumberPowerPlant==i)==2
            FLHcoeff=FlhGT2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; %for the case if data is not available    
           elseif TypeOfFuel(NumberPowerPlant==i)==3
            FLHcoeff=FlhNuclear2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; %for the case if data is not available    
           elseif TypeOfFuel(NumberPowerPlant==i)==4
            FLHcoeff=FlhOil2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; %for the case if data is not available    
            end

%Extraction of water withdrawal factors for the specific thermal power plant, this code uses a table created by the authors, based on Macknick et al.(2012)
%WithdMedian, WithdMin, WithdMax - water use intensity (withdrawal), based on Macknick et al.(2012)
%Examples of Technology: combined cycle, steam, subcritial and supercritical (for coal power plants), etc.

           WatercoeffMedian=WithdMedian(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
           WatercoeffMin=WithdMin(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
           WatercoeffMax=WithdMax(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
 
 %Specific water withdrawal of each power plant: 
 
           WaterPower(i,1)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMedian*FLHcoeff;
           WaterPower(i,2)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMin*FLHcoeff;
           WaterPower(i,3)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMax*FLHcoeff;
           
  end
                    clear WatercoeffMedian;
                    clear WatercoeffMin;
                    clear WatercoeffMax;
                    clear FLHcoeff;
end

clear WaterPower
WaterPower=zeros(size(NumberPowerPlant,1),3);
for i=1:size(NumberPowerPlant,1)
   if SeaCooling(NumberPowerPlant==i)==0 
            if TypeOfFuel(NumberPowerPlant==i)==1
            FLHcoeff=FlhCoal2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0;    
           elseif TypeOfFuel(NumberPowerPlant==i)==2
            FLHcoeff=FlhGT2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; 
           elseif TypeOfFuel(NumberPowerPlant==i)==3
            FLHcoeff=FlhNuclear2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; 
           elseif TypeOfFuel(NumberPowerPlant==i)==4
            FLHcoeff=FlhOil2015(NodeNumberFLH==NodeTotal(NumberPowerPlant==i));
            FLHcoeff(isnan(FLHcoeff))=0; 
            end

%Extraction of water consumption factors for the specific thermal power
%plant, this code uses a table created by the authors, based on Macknick et al.(2012)
%ConsMedian, ConsMin, ConsMax - water use intensity (consumption)

           WatercoeffMedian=ConsMedian(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
           WatercoeffMin=ConsMin(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
           WatercoeffMax=ConsMax(TypeOfFuelWater==TypeOfFuel(NumberPowerPlant==i) & NumberCoolingWater==NumberCooling(NumberPowerPlant==i) & NumberTechnologyWater==NumberTechnology(NumberPowerPlant==i));
 
 %Specific water consumption of each power plant: 
  
           WaterPower(i,1)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMedian*FLHcoeff;
           WaterPower(i,2)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMin*FLHcoeff;
           WaterPower(i,3)=ActiveCapacityMW(NumberPowerPlant==i)*WatercoeffMax*FLHcoeff;
           
  end
                    clear WatercoeffMedian;
                    clear WatercoeffMin;
                    clear WatercoeffMax;
                    clear FLHcoeff;
end
