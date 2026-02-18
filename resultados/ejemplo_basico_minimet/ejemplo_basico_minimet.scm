
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/resultados/ejemplo_basico_minimet/ejemplo_basico_minimet.tracepro")))
        
        (New_file) ;; Use of the function

            ; New block:
            (define emisor
            (geometry:primitive-block "emisor" 1 1 0.5 (position3d 0 0 0) "angles" 
            45 0 0 #t))

            ; New surface source
            (property:apply-irradiance-surface-source (tools:face-in-body 1 emisor) 1 1000 2 #f 0)
            (raytrace:set-surface-source-units-radiometric (tools:face-in-body 1 emisor))
            
            ; Wavelength definition:
            (raytrace:set-surface-source-discrete-wavelength "emisor/Surface 1")
            (raytrace:clear-wavelengths (raytrace:source-get-by-name "emisor/Surface 1"))
            (raytrace:set-wavelengths (list (list 0.555 1)) (raytrace:source-get-by-name "emisor/Surface 1"))

            ; New block:
            (define espejo
            (geometry:primitive-block "espejo" 2 2 0.5 (position3d 0 -4 3.7499999999999996) "angles" 
            90 0 0 #t))

        ; Get object id
        (define id (entity:get-id espejo)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 0 (model:get-object-by-number id)) (list "Mirror" "Default"))

        ; Get object id
        (define id (entity:get-id espejo)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Superficie reflectante")

            ; New block:
            (define detector
            (geometry:primitive-block "detector" 1 1 0.5 (position3d 0 0 7.499999999999999) "angles" 
            -45 0 0 #t))

        ; Get object id
        (define id (entity:get-id detector)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 0 (model:get-object-by-number id)) (list "Perfect absorber" "Default"))

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Plano de deteccion")
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/resultados/ejemplo_basico_minimet/ejemplo_basico_minimet.tracepro")))
        
        (Save_file) ;; Use of the function

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.5 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_1.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.611111111111111 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_2.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.7222222222222223 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_3.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.8333333333333335 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_4.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.9444444444444446 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_5.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.055555555555555 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_6.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.166666666666667 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_7.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.277777777777778 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_8.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.388888888888889 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_9.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.5 3.7499999999999996 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_10.txt")
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/resultados/ejemplo_basico_minimet/ejemplo_basico_despl.tracepro")))
        
        (Save_file) ;; Use of the function

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4 3.7499999999999996 #f #f )

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_1.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_2.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_3.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_4.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_5.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_6.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_7.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_8.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_9.txt")

        ; Get object id
        (define id (entity:get-id espejo)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 0.5 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/ejemplo_basico_minimet/map_r_10.txt")
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/resultados/ejemplo_basico_minimet/ejemplo_basico_despa.tracepro")))
        
        (Save_file) ;; Use of the function