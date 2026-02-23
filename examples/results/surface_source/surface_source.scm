
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/examples/results/surface_source/surface_source_example.tracepro")))
        
        (New_file) ;; Use of the function

            ; New block:
            (define emisor
            (geometry:primitive-block "emisor" 1 1 1 (position3d 0 0 0) "angles" 
            0 0 0 #f))

            ; New surface source
            (property:apply-irradiance-surface-source (tools:face-in-body 1 emisor) 3 1000 2 #f 0)
            (raytrace:set-surface-source-units-radiometric (tools:face-in-body 1 emisor))
            
            ; Wavelength definition:
            (raytrace:set-surface-source-discrete-wavelength "emisor/Surface 1")
            (raytrace:clear-wavelengths (raytrace:source-get-by-name "emisor/Surface 1"))
            (raytrace:set-wavelengths (list (list 0.555 1)) (raytrace:source-get-by-name "emisor/Surface 1"))

            ; New block:
            (define detector
            (geometry:primitive-block "detector" 1 1 1 (position3d 0 0 5) "angles" 
            0 0 0 #f))

        ; Get object id
        (define id (entity:get-id detector)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 0 (model:get-object-by-number id)) (list "Perfect absorber" "Default"))

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Plano deteccion")
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 0 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "incident")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #f)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/examples/results/surface_source/surface_source_example.tracepro")))
        
        (Save_file) ;; Use of the function