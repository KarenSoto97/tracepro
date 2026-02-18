
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/resultados/pruebas_importar.tracepro")))
        
        (New_file) ;; Use of the function
        
        ; Import:
        (file:open "C:/Users/prisc/Desktop/FAGOR/Proyecto Lente/lente_karen.stp")
        
        ; Apply name to an object:
        (property:apply-name (model:get-object-by-number 1) "lente")
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number 1)) "r1")
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 2 (model:get-object-by-number 1)) "r2")
        
        ; Apply material:
        (property:apply-material (list (model:get-object-by-number 1)) "SCHOTT" "F7" (vector3d 0 0 0))
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/resultados/pruebas_importar.tracepro")))
        
        (Save_file) ;; Use of the function