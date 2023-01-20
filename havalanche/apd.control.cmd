; ******* models a generic inP muli apd **********
;
; THis is a exact model of the excelitas with the charge layer created narrow.
; 12/15/22 - reduce the multu thiickess
; 12/30/22 - adding a thicker charge layera
; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; THIS IS A CONTROL DEVICE WITH NO NARROW P regions. THIS IS TO COMPARE WITH THE 010523 doe design
;--------------------------------------------------------


(set! process-up-direction "+z")
(sdegeo:set-auto-region-naming OFF)
(sdegeo:create-rectangle (position 0 0 0) (position 1.0 0.5 0) "InAlAs" "pregion")
(sdegeo:create-rectangle (position 0 0.5 0)  (position 1 0.8 0) "InAlAs" "multi")
(sdegeo:create-rectangle (position 0 0.8 0)  (position 1.0 0.9 0) "InAlAs" "charge")
(sdegeo:create-rectangle (position 0 0.9 0)  (position 1.0 0.95 0) "InAlAs" "ancharge")
(sdegeo:create-rectangle (position 0 0.95 0)  (position 1 1.45 0) "InGaAs" "abs")
(sdegeo:create-rectangle (position 0 1.45 0)  (position 1 1.95 0) "InAlAs" "buffer")
(sdegeo:create-rectangle (position 0 1.95 0)  (position 1 2.45 0) "InAlAs" "nregion")
(sdedr:define-constant-profile "ppregion" "BoronActiveConcentration" -7e+18)
(sdedr:define-constant-profile "nmulti" "PhosphorusActiveConcentration" 7e+14)
(sdedr:define-constant-profile "nfiller" "PhosphorusActiveConcentration" 7e+14)
(sdedr:define-constant-profile "ncharge" "PhosphorusActiveConcentration" 3.0e+18)
(sdedr:define-constant-profile "nancharge" "PhosphorusActiveConcentration" 5e+16)
(sdedr:define-constant-profile "nabs" "PhosphorusActiveConcentration" 7e+14)
(sdedr:define-constant-profile "nbuffer" "PhosphorusActiveConcentration" 7e+14)
(sdedr:define-constant-profile "nnregion" "PhosphorusActiveConcentration" 2e+19)
(sdedr:define-constant-profile-region "ppregion" "ppregion" "pregion")
(sdedr:define-constant-profile-region "nnregion" "nnregion" "nregion")
(sdedr:define-constant-profile-region "nmulti" "nmulti" "multi")
(sdedr:define-constant-profile-region "ncharge" "ncharge" "charge")
(sdedr:define-constant-profile-region "nancharge" "nancharge" "ancharge")
(sdedr:define-constant-profile-region "nabs" "nabs" "abs")
(sdedr:define-constant-profile-region "nbuffer" "nbuffer" "buffer")
(sdegeo:define-contact-set "source" 4  (color:rgb 1 0 0 ) "##")
(sdegeo:define-contact-set "drain" 4  (color:rgb 0 0 1 ) "##")
(sdegeo:set-current-contact-set "source")
(sdegeo:define-2d-contact (list (car (find-edge-id (position 0.5 2.45  0)))) "source")
(sdegeo:set-current-contact-set "drain")
(sdegeo:define-2d-contact (list (car (find-edge-id (position 0.5 0 0)))) "drain")
(sdedr:define-refeval-window "device_mesh_win" "Rectangle"  (position -0.01 -0.01 0) (position 1.01 2.46 0))
(sdedr:define-refinement-size "DeviceMeshRefinementDefinition" 0.1 0.01 1E-2 1E-3 )
(sdedr:define-refinement-placement "full_area" "DeviceMeshRefinementDefinition" (list "window" "device_mesh_win" ) )
; ** higher mesh in the multi--------------------------------------------
(sdedr:define-refeval-window "multi_mesh_win" "Rectangle"  (position -0.01 0.49 0) (position 1.01 0.96 0))
(sdedr:define-refinement-size "MultiMeshRefinementDefinition" 0.1 1E-3 1E-3 1E-4 )
(sdedr:define-refinement-placement "full_area" "MultiMeshRefinementDefinition" (list "window" "multi_mesh_win" ) )
;--------------------------------------------------------------------
(sde:set-meshing-command "snmesh -a -c boxmethod")
(sdedr:append-cmd-file "")
(sde:save-model "/home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-010523-control/thinmultidiode")
(sde:build-mesh "snmesh" "-a -c boxmethod" "/home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-010523-control/thinmultidiode")
(system:command "svisual /home/ndissanayake/synopsys/gainsaturation/toy/small-width-multi/narrow_charge_layer/inalas/doe-010523-control/thinmultidiode_msh.tdr &")
