
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/resultados/minimet cabeza lectora/cabeza_lectora_minimet.tracepro")))
        
        (New_file) ;; Use of the function

            ; New block:
            (define LED
            (geometry:primitive-block "LED" 1.0 0.5 1.0 (position3d 0.0 1.0 0.0) "angles" 
            -26.56505117707799 0 0 #t))

            ; New surface source
            (property:apply-surface-source-property (tools:face-in-body 2 LED) "lambertian sources" "30-degree Half Angle" 10000 0 1 #f)
            (raytrace:set-surface-source-units-radiometric (tools:face-in-body 2 LED))
            
            ; Wavelength definition:
            (raytrace:set-surface-source-discrete-wavelength "LED/Surface 2")
            (raytrace:clear-wavelengths (raytrace:source-get-by-name "LED/Surface 2"))
            (raytrace:set-wavelengths (list (list 0.88 1)) (raytrace:source-get-by-name "LED/Surface 2"))

            ; New block:
            (define Led_grating
            (geometry:primitive-block "Led_grating" 6.0 0.5 4.0 (position3d 0.0 0.0 0.0) "angles" 
            0 0 0 #t))

            ; New block:
            (define Top_grating
            (geometry:primitive-block "Top_grating" 8.0 0.5 2.0 (position3d 0.0 0.0 3.0) "angles" 
            0 0 0 #t))

            ; New block:
            (define Bottom_grating
            (geometry:primitive-block "Bottom_grating" 22.0 0.5 4.0 (position3d 0.0 -3.0 3.0) "angles" 
            0 0 0 #t))

            ; New block:
            (define Glass
            (geometry:primitive-block "Glass" 16.0 0.5 10.0 (position3d 0.0 -0.5 3.0) "angles" 
            0 0 0 #t))

            ; New block:
            (define Detector
            (geometry:primitive-block "Detector" 5.0 0.2 3.34 (position3d 0.0 1.0 5.67) "angles" 
            0 0 0 #t))

            ; New block:
            (define Detector_coat
            (geometry:primitive-block "Detector_coat" 5.2 0.4 3.54 (position3d 0.0 1.0 5.67) "angles" 
            0 0 0 #t))

        ; Get object id
        (define id (entity:get-id Led_grating)))
        
        ; Apply material:
        (property:apply-material (list (model:get-object-by-number id)) "SCHOTT" "BK7" (vector3d 0 0 0))

        ; Get object id
        (define id (entity:get-id Glass)))
        
        ; Apply material:
        (property:apply-material (list (model:get-object-by-number id)) "SCHOTT" "BK7" (vector3d 0 0 0))

        ; Get object id
        (define id (entity:get-id Top_grating)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 0 (model:get-object-by-number id)) (list "Perfect absorber" "Default"))

        ; Get object id
        (define id (entity:get-id Top_grating)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Tapa")

        ; Get object id
        (define id (entity:get-id Top_grating)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 2 (model:get-object-by-number id)) (list "Mirror" "Default"))

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 4 (model:get-object-by-number id)) (list "Mirror" "Default"))

        ; Get object id
        (define id (entity:get-id Detector)))
            
            ; Apply property:
            (property:apply-surface (tools:face-in-body 2 (model:get-object-by-number id)) (list "Perfect absorber" "Default"))

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 2 (model:get-object-by-number id)) "Plano de deteccion")

        ; Get object id
        (define id (entity:get-id LED)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 255 255 0 #f 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Led_grating)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 128 128 192 #t 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Glass)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 0 128 255 #t 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 128 128 128 #f 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Top_grating)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 128 128 128 #f 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Top_grating)))
            
            ; Apply color:
            (property:apply-color (tools:face-in-body 0 (model:get-object-by-number id)) 0 0 0 #f 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Detector)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 0 0 0 #f 0.5 0.5 0.5)

        ; Get object id
        (define id (entity:get-id Detector_coat)))
            
            ; Apply color:
            (property:apply-color (model:get-object-by-number id) 255 255 255 #t 0.5 0.5 0.5)
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -2.0 3.0 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_y_1.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.25 3.0 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_y_2.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -4.5 3.0 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_y_3.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -5.75 3.0 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_y_4.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -7.0 3.0 #f #f )
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_y_5.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Move object:
        (edit:move (model:get-object-by-number id) 0 -3.0 3.0 #f #f )

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_X_1.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_X_2.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_X_3.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_X_4.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_X_5.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) -5.0 0 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Y_1.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Y_2.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Y_3.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Y_4.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Y_5.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) -5.0 1 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Z_1.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Z_2.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Z_3.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Z_4.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) 1.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Raytrace
        (raytrace:set-analysis-mode-on)
        (raytrace:all-sources)

        ; Get object id
        (define id (entity:get-id Detector)))
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body 2 (model:get-object-by-number id)))
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "absorbed")
        (analysis:irradiance-color-map 0)
        (analysis:irradiance-buckets 50)
        (analysis:irradiance-smooth #t)
        (analysis:irradiance) ;; Display an irradiance map for the current model.
        
        ; Save irradiance analysis
        (analysis:irradiance-save "C:/Software/tracepro/resultados/minimet cabeza lectora/desp_Z_5.txt")

        ; Get object id
        (define id (entity:get-id Bottom_grating)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) -5.0 2 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))