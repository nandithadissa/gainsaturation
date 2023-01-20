# initialize Sentaurus Device simulation
sdevice_init {
	Electrode{
		{ Name = "drain" Voltage = 0.0 }
		{ Name = "source" Voltage = 0.0 } 
	}

	File{
		Grid = "thinmultidiode_msh.tdr"
		Plot = "light_1.tdr"
		Current = "light_1.plt"
		Output = "light.log"
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

	 Optics(
				ComplexRefractiveIndex(WavelengthDep(Real Imag))
				OpticalGeneration (
					QuantumYield(Unity)
					ComputeFromMonochromaticSource()
				)

				Excitation (
					Theta= 0            # incidence angle
					Polarization= 0.5   # apolarized
					Wavelength=1.5      # um
					Intensity= 1 # [W/cm2]       #zero power
					Window ("L1") (
						Origin = (0,0,0)
						Line ( X1= 0 X2=1 )
					)
				)

				OpticalSolver (
					OptBeam(LayerStackExtraction(WindowName="L1"))
				)
			)

	}

	Physics(Region="multi"){
		  Mobility(
			  hHighFieldSaturation
		   )
		EffectiveIntrinsicDensity( OldSlotboom )

		Recombination(
						SRH
						Auger
						hAvalanche(vanOverstraetendeMan ElectricField)
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
		Digits=2
	}

}

# compute idvgs curve
sdevice_solve {
	Solve{
		
		NewCurrentPrefix = "initial_breakdown"
		Poisson
		Optics
		Coupled (Iterations=100) {Poisson Electron Hole}
		NewCurrentPrefix = ""
		Optics
		QuasiStationary (
			InitialStep=0.3  MaxStep=0.01 MinStep=0.00001
			Goal {Name="drain" Voltage=-40.0}
				plot { range=(0,0.7) intervals=1}
		)
			{ Coupled (iterations=25) {Poisson Electron Hole} }
		}
				#Save (FilePrefix = "dark")
}


# save final plot file
sdevice_finish
