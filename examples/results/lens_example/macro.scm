
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/examples/results/lens_example/ejemplo_1.tracepro")))
        
        (New_file) ;; Use of the function
        
        ; New lens: 
        (define Lente_1
        (geometry:lens-element-2 "SCHOTT" "BK7" 8.0 "sphere" (list 35.0) "sphere" (list -43.11111111111111) "circle" 
        12.0 "none" (list ) (position3d 0 0 0) 0 
        0 0 (position3d 0 0 0) 0 0
        0 #f "Lente_1"))

        ; Get object id
        (define id (entity:get-id Lente_1)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "r1")

        ; Get object id
        (define id (entity:get-id Lente_1)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 1 (model:get-object-by-number id)) "r2")

        ; Get object id
        (define id (entity:get-id Lente_1)))
        
        ; Apply material:
        (property:apply-material (list (model:get-object-by-number id)) "SCHOTT" "F7" (vector3d 0 0 0))

            ; New block:
            (define Detector
            (geometry:primitive-block "Detector" 4.0 4.0 1.0 (position3d 0 0 16.886158047448372) "angles" 
            0 0 0 #f))

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Plano de deteccion")

        ; Get object id
        (define id (entity:get-id Detector)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 0 (model:get-object-by-number id)) (list "Perfect absorber" "Default"))

        ; New grid source:
        (define sourceID_0 (raytrace:add-grid-source "Fuente"))
        
        ; Modifications of the grid source:
        (raytrace:set-grid-boundary-annular 2.0 0 sourceID_0)
        (raytrace:set-grid-pattern-random 10000  10000 sourceID_0)
        (raytrace:set-grid-total-flux 10000 sourceID_0)
        (raytrace:set-grid-units-radiometric sourceID_0)
        (raytrace:set-grid-emission-type 0 sourceID_0)
        (raytrace:set-grid-origin (position3d 0 0 -50.0) sourceID_0)
        (raytrace:set-grid-orientation-direction-vectors (vector3d 0 0 1) (vector3d 0 1 0))
            
            ; Wavelength definition:
            (define wvList (list (list 0.555 1)))
            (raytrace:set-wavelengths wvList sourceID_0)
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
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
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/prueba_ejemplo_1.png")
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/examples/results/lens_example/ejemplo_1.tracepro")))
        
        (Save_file) ;; Use of the function

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 14.886158047448372 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_1.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 17.886158047448372 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_2.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 20.886158047448372 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_3.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 23.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_4.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 26.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_5.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 29.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_6.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 32.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_7.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 35.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_8.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 38.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_9.txt")

        ; Get object id
        (define id (entity:get-id Detector)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 0 41.886158047448376 #f #f )

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/examples/results/lens_example/irradiance_map_10.txt")
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/examples/results/lens_example/ejemplo_1.tracepro")))
        
        (Save_file) ;; Use of the function