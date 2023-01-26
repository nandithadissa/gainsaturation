Title ""

Controls {
}

Definitions {
	Constant "ppregion" {
		Species = "BoronActiveConcentration"
		Value = -7e+18
	}
	Constant "nmulti" {
		Species = "PhosphorusActiveConcentration"
		Value = 7e+14
	}
	Constant "ncharge" {
		Species = "PhosphorusActiveConcentration"
		Value = 7e+17
	}
	Constant "nancharge" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+16
	}
	Constant "nabs" {
		Species = "PhosphorusActiveConcentration"
		Value = 7e+14
	}
	Constant "nbuffer" {
		Species = "PhosphorusActiveConcentration"
		Value = 7e+14
	}
	Constant "nnregion" {
		Species = "PhosphorusActiveConcentration"
		Value = 2e+19
	}
	Refinement "DeviceMeshRefinementDefinition" {
		MaxElementSize = ( 0.1 0.01 )
		MinElementSize = ( 0.01 0.001 )
	}
	Refinement "MultiMeshRefinementDefinition" {
		MaxElementSize = ( 0.1 0.001 )
		MinElementSize = ( 0.001 0.0001 )
	}
}

Placements {
	Constant "ppregion" {
		Reference = "ppregion"
		EvaluateWindow {
			Element = region ["pregion"]
		}
	}
	Constant "nnregion" {
		Reference = "nnregion"
		EvaluateWindow {
			Element = region ["nregion"]
		}
	}
	Constant "nmulti" {
		Reference = "nmulti"
		EvaluateWindow {
			Element = region ["multi"]
		}
	}
	Constant "ncharge" {
		Reference = "ncharge"
		EvaluateWindow {
			Element = region ["charge"]
		}
	}
	Constant "nancharge" {
		Reference = "nancharge"
		EvaluateWindow {
			Element = region ["ancharge"]
		}
	}
	Constant "nabs" {
		Reference = "nabs"
		EvaluateWindow {
			Element = region ["abs"]
		}
	}
	Constant "nbuffer" {
		Reference = "nbuffer"
		EvaluateWindow {
			Element = region ["buffer"]
		}
	}
	Refinement "full_area" {
		Reference = "MultiMeshRefinementDefinition"
		RefineWindow = Rectangle [(-0.01 0.49) (1.01 0.96)]
	}
}

