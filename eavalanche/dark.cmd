# initialize Sentaurus Device simulation
sdevice_init {
	Electrode{
		{ Name = "drain" Voltage = 0.0 }
		{ Name = "source" Voltage = 0.0 } 
	}

	File{
		Grid = "thinmultidiode_msh.tdr"
		Plot = "dark.tdr"
		Current = "dark.plt"
		Output = "dark.log"
		Parameter = "models.latest.bg.par"
	}

	Physics{

		   EffectiveIntrinsicDensity( OldSlotboom )
		   
			Recombination(
			  	SRH 
				Auger 
				Radiative 
		   )
		   AreaFactor= 1
	}

	Physics(Region="multi"){
		  #Mobility(
		  #	 eHighFieldSaturation
		  # )
		   
		EffectiveIntrinsicDensity( OldSlotboom )

		Recombination(
						SRH
						Auger
						Radiative
						eAvalanche(vanOverstraetendeMan) # ElectricField)
		)	

	}


	Plot{
		SpaceCharge 
		ElectricField/Vector Potential
		eDensity hDensity
	  	eQuasiFermiEnergy hQuasiFermiEnergy
		eGradQuasiFermi/Vector hGradQuasiFermi/Vector
		Current/Vector eCurrent/Vector hCurrent/Vector
		SRHrecombination
		tSRHrecombination
		eAvalanche hAvalanche Avalanche	
		OpticalIntensity
		OpticalGeneration
	}
	Math {
		Iterations=100
		#BreakAtIonIntegral
		#-CheckUndefinedModels
		#Cylindrical(xAxis=0.0)
		Digits=5
	}

}

# compute idvgs curve
sdevice_solve {
	Solve{
		
		NewCurrentPrefix = "initial_breakdown"
		Poisson
		Coupled (Iterations=100) {Poisson Electron Hole}
		NewCurrentPrefix = ""
		QuasiStationary (
			InitialStep=0.3  MaxStep=0.01 MinStep=0.00001
			Goal {Name="drain" Voltage=-60.0}
				#plot { range=(0,0.125) intervals=2}
		)
			{ Coupled (iterations=25) {Poisson Electron Hole} }
		}
				#Save (FilePrefix = "dark")
}


# save final plot file
sdevice_finish
