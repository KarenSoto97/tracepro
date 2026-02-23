
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "C:/Software/tracepro/examples/results/rotation/rotation_example.tracepro")))
        
        (New_file) ;; Use of the function

            ; New block:
            (define block
            (geometry:primitive-block "block" 1 1 0.5 (position3d 0 5 5) "angles" 
            90 0 0 #t))

        ; Get object id
        (define id (entity:get-id block)))
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body 0 (model:get-object-by-number id)) "Cuadrado")

        ; Get object id
        (define id (entity:get-id block)))
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) -45 4 #t #f #t (vector3d 1 0
         0) (position3d 0 0 0))
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "C:/Software/tracepro/examples/results/rotation/rotation_example.tracepro")))
        
        (Save_file) ;; Use of the function