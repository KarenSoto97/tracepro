
import win32com.client as win32
import os
import numpy as np

class TP_app:
    
    """
    Interface for generating TracePro macro files and executing them. The class
    manages the creation of Scheme commands for building and saving files,
    performing basic analysis, and executing the generated macro through the
    TracePro COM interface.

    Attributes:
        macro_path (str): Directory where the macro file will be created.
        macro_name (str): Name of the macro file (without extension).
        tp (win32com.client.Dispatch): Handle to the TracePro COM interface.
    """

    def __init__(self, macro_path: str, macro_name: str = 'macro'):
        macro_path = os.path.normpath(macro_path).replace("\\", "/")
        self.macro = f"{macro_path}/{macro_name}.scm"
        self.tp = win32.Dispatch("TracePro.TraceProXP")

    @classmethod
    def txt_map2array(cls, txt_path: str, num_files: int, file_name: str | list):

        """
        Load irradiance map data stored in one or more .txt files and convert it into NumPy array(s).

        By default, the irradiance map resolution is assumed to be 128×128, which is the system’s
        current fixed output resolution.

        TODO:
            - The current implementation uses smoothing because otherwise some values are not
            detected correctly. Improve robustness so smoothing is not required.
            - Allow customizable resolution instead of assuming the fixed 128×128 grid.
 
        Args:
            txt_path (str): Path to the directory containing the .txt file(s).
            num_file (int): Number of files to load. If 1, a 2D array is returned. If greater than 1, a 3D array is returned
            file_name (str): Name of the file (without extension) if num_files == 1, or a list of file names if num_files > 

        Returns:
            irradiance_maps (np.ndarray):
            - Shape (128, 128) if num_files == 1
            - Shape (128, 128, num_files) if num_files > 1
        """

        def first_line_num_data(lines: list):

            """
            Find the index of the first line containing numerical data.

            Args:
                lines (list): List of lines read from the text file.

            Returns:
                int | None: Index of the first data line, or None if not found.
            """

            for i, linea in enumerate(lines):
                if linea.strip() and linea.lstrip()[0].isdigit():
                    return  i
            return None
            
        if num_files == 1:

            irradiance_map = np.zeros([128, 128])

            with open(f"{txt_path}/{file_name}.txt", "r") as f:
                lineas = f.readlines()

            start_idx = first_line_num_data(lineas)
            data = np.loadtxt(lineas[start_idx:])

            irradiance_map[:,:] = data

            return irradiance_map
        
        elif num_files > 1:

            irradiance_maps = np.zeros([128, 128, num_files])

            for i, file in enumerate(file_name):
                with open(f"{txt_path}/{file}.txt", "r") as f:
                    lineas = f.readlines()

                start_idx = first_line_num_data(lineas)
                data = np.loadtxt(lineas[start_idx:])

                irradiance_maps[:, :, i] = data
            
            return irradiance_maps

    def clear_macro(self):

        """
        Removes all the scheme code from the macro file. 
        """

        with open(self.macro, 'w', encoding='utf-8') as file:
            pass


    def add_function(self, text: str):

        """
        Add the scheme code to the macro file. 

        Args:
            text (str): Scheme code fragment to append to the macro file.
        """

        with open(self.macro, 'a', encoding='utf-8') as file:
            file.write(text)

    
    def show_graphics_window(self):
        
        """
        Ensures that the TracePro user interface becomes visible. When a COM object
        is created while TracePro is not already running, the application starts in
        a non‑interactive mode with the UI hidden. This method enables user control,
        making the graphical interface visible.
        """

        self.tp.AllowUserControl()


    def new_file(self, file_name: str, tp_path: str):

        """
        Creates and saves a new TracePro file.

        Args:
            file_name (str): Name of the TracePro file (without extension).
            tp_path (str): Path to the folder where the new TracePro file will be saved.
        """

        tp_path = os.path.normpath(tp_path).replace("\\", "/")
        new_file_path = f"{tp_path}/{file_name}.tracepro"
 
        text = f"""
        ; New file: 
        (define New_file
        (lambda ( )
        (file:new)
        (file:save-as "{new_file_path}")))
        
        (New_file) ;; Use of the function"""

        self.add_function(text)


    def execute(self, graphic_window: bool = False, clear_macro: bool = True):
     
        """
        Executes TracePro using the generated macro file and the TracePro COM.

        Args:
            graphic_window (bool): If True, the TracePro graphical user interface is made visible before executing the macro. 
            clear_macro (bool): If True, the macro scheme code will be deleted.

        Returns:
            result (str): Result returned by TracePro after executing the Scheme macro
        
        Notes:
                The COM method ExecuteSchemeString returns:
                    index (int): 
                        0   → execution completed successfully
                        >0  → number of missing right parentheses
                        -1  → an error occurred
                    result (str): 
                        output of the last complete Scheme command or an error message.
        """

        with open(self.macro, 'r', encoding='utf-8') as macro:
            scheme_code = macro.read()

        if graphic_window:
            self.show_graphics_window()

        index, result = self.tp.ExecuteSchemeString(scheme_code)

        if index == 0:
            print('Successfully completed')
        elif index == -1:
            print(f'Error: {result}')
        else:
            print(f'{index} parentheses missing')

        if clear_macro:
            self.clear_macro()

        return result


    def save_file(self, file_name: str, tp_path: str):

        """
        Saves the TracePro file. 

        Args:
            file_name (str): Name of the TracePro file (without extension).
            tp_path (str): Path to the folder where the new TracePro file will be saved.
        """

        tp_path = tp_path.replace("\\", "/")
        save_path = f"{tp_path}/{file_name}.tracepro"

        text = f"""
        
        ; Save file: 
        (define Save_file
        (lambda ( )
        (file:save-as "{save_path}")))
        
        (Save_file) ;; Use of the function"""

        self.add_function(text)


    def save_irradiance_map(self, save_path: str, file_name: str, extension: str):

        """
        Saves the irradiance map

        Args:
            save_path (str): Path to the folder where the irradiance map will be saved.
            file_name (str): Name of the irradiance map file.
            extension (str): File extension for the saved map ("txt", "bmp", "jpg", "png", "dxf").
        """
        
        save_path = save_path.replace("\\", "/")
        irradiance_map_path = f"{save_path}/{file_name}.{extension}"

        text = f"""
        
        ; Save irradiance analysis
        (analysis:irradiance-save "{irradiance_map_path}")"""

        self.add_function(text)

    def __get_id(self, object_name: str):

        text = f"""

        ; Get object id
        (define id (entity:get-id {object_name}))"""

        return text
        

    def name_surfaces(self, name: str, object_name: str, surface_num: int):
    
        """
        Names a surface of an object.

        Args:
            name (str): Desired name for the surface.
            object_name (str): Name of the object.
            surface_num (int): Surface number within the object (from 0 to n).
        """

        get_id = self.__get_id(object_name=object_name)
    
        text = f"""
        
        ; Apply name to a surface:
        (property:apply-name (tools:face-in-body {surface_num} (model:get-object-by-number id)) "{name}")"""

        self.add_function(get_id + text)


    def name_object(self, name: str, object_name: str):

        """
        Names a surface of an object.

        Args:
            name (str): Desired name for the surface.
            object_name (str): Name of the object.
        """

        get_id = self.__get_id(object_name=object_name)
    
        text = f"""
        
        ; Apply name to an object:
        (property:apply-name (model:get-object-by-number id) "{name}")"""

        self.add_function(get_id + text)


    def select_detection_surface(self, object_name: str, surface_num: int):

        """
        Selects a detection surface of an object, before doing any type of analysis.

        Args:
            object_name (str): Name of the object.
            surface_num (int): Surface number within the object (from 0 to n).
        """

        get_id = self.__get_id(object_name=object_name)

        text = f"""
        
        ; Selection of the detection surface:
        (edit:select (tools:face-in-body {surface_num} (model:get-object-by-number id)))"""

        self.add_function(get_id + text)

    
    def ray_sorting(self, sorting_type: int, view: int, object_name: str = None, surface_num: int = None):

        """
        Once the rays have been traced, this function selects which rays will be shown.
        If "sorting_type = 1", a surface must be selected.
        By default ("sorting_type = 0"), all rays will be shown.
        
        TODO:
            - Views 2, 3, and 4 currently only display the irradiance map.
            Check whether unit definition and source specification are required.

        Args:
            sorting_type (int): Type of ray sorting.
                - 0 = all rays
                - 1 = selected surface
                - 2 = specular
                - 3 = single surface scatter
                - 4 = multiple surface scatter
                - 5 = single bulk scatter
                - 6 = multiple bulk scatter
                - 7 = single diffraction
                - 8 = multiple diffraction

            view (int): Type of view applied to the ray sorting.
                - 0 = model view
                - 1 = irradiance map
                - 2 = incident ray table
                - 3 = ray history table
                - 4 = polarization map

            object_name (str, optional): Name of the object containing the surface.
            surface_num (int, optional): Surface index within the object (0 to n).

        Raises:
            ValueError: If "sorting_type = 1` but no surface_num is provided"
        """

        if sorting_type == 1:
            if surface_num is None or object_name is None:
                raise ValueError("You must select a surface for sorting_type = 1.")
            self.select_detection_surface(object_name=object_name, surface_num=surface_num)

        text = f"""

        ; Ray sorting:
        (analysis:ray-sorting {sorting_type} 0 {view})"""

        self.add_function(text)

    def path_sorting(self, save: bool = False, saving_path: str = None, file_name: str = "Path_sorting_table"):
        
        """
            Enables the path‑sorting table in the configuration.  
            If "save = True", the table will be exported as a .txt file.

            Args:
                save (bool): If True, the path‑sorting table will be saved. Default is False.
                saving_path (str): Directory where the .txt file will be stored.
                file_name (str): Name of the exported .txt file (without extension).
        """

        text_1 = ""

        if save and saving_path and os.path.exists(saving_path):
            save_path = saving_path.replace("\\", "/")
            path = f"{save_path}/{file_name}.txt"
            text_1 = f'(analysis:path-sort-save "{path}")'
        elif save:
            raise ValueError('You must introduce a valid path.')

        text = f"""

        ; Path sorting:
        (analysis:path-sort)"""

        self.add_function(text + text_1)

    
    def path_sort_filter(self, filter_name: str, objects: list[tuple[str, int]], interaction: list[int]):

        """
        Creates a path sort filter and its corresponding rows for the path sorting table.

        Args:
            filter_name (str): Name of the filter to be created.
            objects (list[tuple[str, int]]): List of tuples (object_name, surface_number) defining the objects and their corresponding surfaces that interact with light.
            intercepts (list[int]): List of interaction types corresponding 1‑to‑1 with the elements in 'objects'.
                Interaction codes:
                0  = missing rays           | 1  = any interaction        | 2  = specular reflection
                3  = specular transmission  | 4  = random reflection      | 5  = random transmission
                6  = imperfect reflection   | 7  = imperfect transmission | 8  = diffuse reflection
                9  = imperfect diffuse refl | 10 = random diffuse trans   | 11 = imperfect diffuse trans
                12 = random volume scatter  | 13 = imperfect vol. scatter | 14 = GRIN transmission
                15 = reptile transmission   | 16 = undefined interaction

        Warnings:
            This function creates the filter but does not apply it.
            Applying filters is currently only supported through the GUI.

        """

        assert len(objects) == len (interaction)
        assert len(objects) > 0

        text = ""

        get_id = self.__get_id(object_name=objects[0][0])

        text_1 = f"""

        ; Path sort filter:
        (analysis:add-path-sort-filter "{filter_name}" (model:get-object-by-number id) (tools:face-in-body {objects[0][1]} (model:get-object-by-number id)) {interaction[0]})"""

        text = get_id + text_1

        if len(objects) > 1:

            for i, (object_name, face_num) in enumerate(objects[1:], start=1):

                get_id = self.__get_id(object_name=object_name)

                text_1 = f"""

        ; Path sort filter:
        (analysis:add-path-sort-filter-row "{filter_name}" (model:get-object-by-number id) (tools:face-in-body {face_num} (model:get-object-by-number id)) {interaction[i]})"""

                text += get_id + text_1

        self.add_function(text)
    

    def display_selected_path(self, path_num: int, irradiance_map : bool = False):
        
        """
            Displays the selected path from the path sorting table.

            TODO:
                - Check whether it's necessary to allow visualization of multiple paths 
                at once (e.g., passing a list of path numbers).
                - Currently works for a single use, but inside a loop the irradiance map 
                shown is always the total one.

            Args:
                path_num (int): Path number to display from the path sorting table.
                irradiance_map (bool): If True, also shows the irradiance map using the 
                    currently selected settings.
        """

        text_1 = ""

        text = f"""

        ;Activates the display of selected paths feature.
        (analysis:display-selected-paths #t)
        ;Select path form path sort table window and update model view
        (analysis:update-selected-paths (list {path_num}))"""

        if irradiance_map:

            text_1 = """
        ;Irradiance_map
        (analysis:irradiance)"""

        self.add_function(text + text_1)

        
    def apply_property(self, property: tuple[str, str], object_name: str, surface_num: int = -1 ):

        """
        Applies a property to an object if the surface number is negative; otherwise, the 
        property will be applied only to the selected surface.

        Args:
            property (str, str): Type of property (Catalog, property name). 
                Example: ("default", "perfect absorber")
            object_name (str): Name of the object.
            surface_num (int): Surface number within the object (from 0 to n). If negative, 
                the property is applied to the entire object.
        """

        get_id = self.__get_id(object_name=object_name)

        if surface_num >= 0:

            text = f"""
            
        ; Apply property:
        (property:apply-surface (tools:face-in-body {surface_num} (model:get-object-by-number id)) (list "{property[1].capitalize()}" "{property[0].capitalize()}"))"""
        else:

            text = f"""
            
        ; Apply property:
        (property:apply-surface (model:get-object-by-number id) (list "{property[1].capitalize()}" "{property[0].capitalize()}"))"""

        self.add_function(get_id + text)


    def apply_material(self, material: tuple[str, str], object_name: str):

        """
        Applies a material to an object.

        Args:
            material (str, str): Type of material (Catalog, material name). 
                Example: ("Default", "Perfect Absorber")
            object_name (str): Name of the object.

        """

        get_id = self.__get_id(object_name=object_name)

        text = f"""
        
        ; Apply material:
        (property:apply-material (list (model:get-object-by-number id)) "{material[0]}" "{material[1]}" (vector3d 0 0 0))"""

        self.add_function(get_id + text)


    def apply_color(self, object_name: str, color: tuple[int, int, int], transparency: bool = False, surface_num: int = -1 ):
   
        """
        Applies a color to an object if the surface number is negative; otherwise,
        the color will be applied only to the selected surface.

        Args:
            object_name (str): Name of the object.
            color (tuple[int, int, int]): Color of the object in RGB. Example (255, 0, 255).
            transparency (bool): If True, the object becomes transparent.
            surface_num (int): Surface number within the object (from 0 to n). If negative,
                the property is applied to the entire object.
        """

        get_id = self.__get_id(object_name=object_name)

        transparency_flag = "#t" if transparency else "#f"
    
        if surface_num >= 0:

            text = f"""
            
        ; Apply color:
        (property:apply-color (tools:face-in-body {surface_num} (model:get-object-by-number id)) {color[0]} {color[1]} {color[2]} {transparency_flag} 0.5 0.5 0.5)"""
        else:

            text = f"""
            
        ; Apply color:
        (property:apply-color (model:get-object-by-number id) {color[0]} {color[1]} {color[2]} {transparency_flag} 0.5 0.5 0.5)"""

        self.add_function(get_id + text)


    def import_piece(self, file_path: str):

        """
        Imports an external piece.

        Args:
            file_path (str): Path to the external piece to be imported.
        """

        file_path = os.path.normpath(file_path).replace("\\", "/")

        text = f"""
        
        ; Import:
        (file:open "{file_path}")"""

        self.add_function(text)


    def move_object(self, object_name: str, mode: str, distance: tuple[float, float, float]): 

        """
        Moves the selected object.

        Args:
            object_name (str): Name of the object.
            mode (str): Movement mode, either "relative" or "absolute".
            distance (float, float, float): Translation distance (x, y, z).
        """

        get_id = self.__get_id(object_name=object_name)

        if mode == "absolute":
            mode = "#f"
        elif mode == "relative":
            mode = "#t"
        else:
            raise ValueError("mode must be 'absolute' or 'relative'")
   
        text = f"""
            
        ; Move object:
        (edit:move (model:get-object-by-number id) {distance[0]} {distance[1]} {distance[2]} #f {mode} )""" 

        self.add_function(get_id + text)


    def rotate_object(self, object_name: str, angle: float, axis_type: int, degrees: bool, rotation_point: tuple[float, float, float], object_ref: bool, 
                       custom_axis: tuple[int, int, int] = (1, 0, 0)):

        """
        Rotate the selected object around a specified axis.

        The rotation is defined by:
        - the direction of the rotational axis (controlled by axis_type or custom_axis),
        - and a point through which that axis passes (rotation_point or the object reference origin).

        The rotational axis will pass through the specified rotation_point. If object_ref is True,
        the rotation_point is ignored and the axis will pass through the origin of the object
        reference system. Note that object_ref only affects the position of the axis, not its direction.

        Args:
            object_name (str): Name of the object.
            angle (float): Angle of rotation about the axis. The angle is interpreted as degrees or radians depending on the value of degrees.
            axis_type (int): Controls the direction of the rotational axis.
                0: rotation about global X axis.
                1: rotation about global Y axis.
                2: rotation about global Z axis.
                3: rotation about the object X axis.
                4: rotation about the object Y axis.
                5: rotation about the object Z axis.
                6: custom axis direction.
            degrees (bool): If True, the angle is specified in degrees. If False, the angle is specified in radians.
            rotation_point (float, float, float): Point through which the rotational axis passes. 
            This parameter is ignored if object_ref is True.
            object_ref (bool): If True, the rotational axis passes through the origin of the object reference system, resulting in a rotation about the object itself,
            independently of its position in the global coordinate system.
            custom_axis (int, int, int): Direction vector of the rotational axis when axis_type is set to 6 (custom). The vector does not need to be normalized.
            This parameter is ignored when axis_type is not 6.
        """

        get_id = self.__get_id(object_name=object_name)

        degrees_flag = "#t" if degrees else "#f" 

        object_ref_flag = "#t" if object_ref else "#f"

        copy_object = "#f"

        text = f"""
            
        ; Rotate object:
        (edit:rotate-objects (model:get-object-by-number id) {angle} {axis_type} {object_ref_flag} {copy_object} {degrees_flag} (vector3d {custom_axis[0]} {custom_axis[1]}
         {custom_axis[2]}) (position3d {rotation_point[0]} {rotation_point[1]} {rotation_point[2]}))""" 
        
        self.add_function(get_id + text)
        









