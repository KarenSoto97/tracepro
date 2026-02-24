
class Source:
    
    """
    Builds Scheme macro fragments to define and configure TracePro sources.
    The generated text can be appended to a .scm macro file and executed in TracePro.

    Attributes:
        name (str): Name assigned to the source in TracePro.
        source_ID (str): Internal Scheme identifier for the source (e.g., "sourceID_1").
    """

    def __init__(self, name: str, source_num: int):
        self.name = name
        self.source_ID = f"sourceID_{source_num}"

    @classmethod
    def raytrace(cls, analysis_mode: bool=True):

        # TO DO: SI LO QUEREMOS EN MODO SIMULACIÓN SE DEBE AÑADIR UNA SUPERFICIE DE SALIDA. 

        """
        Traces rays from all discrete sources in the active model.

        Args:
            analysis_mode (bool): If True sets analysis mode to "on"; otherwise sets it to "off" while maintaining simulation mode.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        if analysis_mode:
            analysis_mode = "on"
        else:
            analysis_mode = "off"

        texto = f"""
        
        ; Raytrace
        (raytrace:set-analysis-mode-{analysis_mode})
        (raytrace:all-sources)"""

        return texto

    def add_grid_source(self):

        """
        Creates a grid source in TracePro.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        text = f"""

        ; New grid source:
        (define {self.source_ID} (raytrace:add-grid-source "{self.name}"))"""

        return text
 

    def grid_settings(self, position: tuple[float, float, float], boundary_type: str, boundary1: float, boundary2: float, pattern_type: str, pattern1: float, pattern2: float, flux: float, units: str, emission_type: int, 
                     normal_vector: tuple[float, float, float] = (0, 0, 1), up_vector: tuple[float, float, float] = (0, 1, 0)):
    
        """
        Modifies the grid source parameters.

        Args:
            position [float, float, float]: Source position (x, y, z).
            boundary_type (str): Grid boundary shape. Options:
                - "annular":
                    boundary1 (float): Outer radius
                    boundary2 (float): Inner radius
                - "rectangular":
                    boundary1 (float): Y half-width
                    boundary2 (float): X half-width
            pattern_type (str): Grid emission pattern. Options: "circular", "cross",
                "dithered", "random", "rectangular".
                - "circular":
                    pattern1 (float): Number of rings
                    pattern2 (float): ""
                - "cross" / "dithered" / "rectangular":
                    pattern1 (float): Y points
                    pattern2 (float): X points
                - "random":
                    pattern1 (float): Total rays
                    pattern2 (float): ""
            flux (float): Grid source flux.
            units (str): Emission units ("photometric" or "radiometric").
            emission_type (int): Emission mode:
                0: Flux per ray (W / lm)
                1: Total flux (W / lm)
                2: Irradiance / illuminance (W/m² / lux)
            normal_vector (float, float, float): Source normal vector (x, y, z). Default: (0, 0, 1).
            up_vector (float, float, float): Up direction vector (x, y, z). Default: (0, 1, 0).

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        text = f"""
        
        ; Modifications of the grid source:
        (raytrace:set-grid-boundary-{boundary_type} {boundary1} {boundary2} {self.source_ID})
        (raytrace:set-grid-pattern-{pattern_type} {pattern1} {pattern2} {flux} {self.source_ID})
        (raytrace:set-grid-total-flux {flux} {self.source_ID})
        (raytrace:set-grid-units-{units} {self.source_ID})
        (raytrace:set-grid-emission-type {emission_type} {self.source_ID})
        (raytrace:set-grid-origin (position3d {position[0]} {position[1]} {position[2]}) {self.source_ID})
        (raytrace:set-grid-orientation-direction-vectors (vector3d {normal_vector[0]} {normal_vector[1]} {normal_vector[2]}) (vector3d {up_vector[0]} {up_vector[1]} {up_vector[2]}))"""

        return text
    
    def grid_beam_setup(self, spatial_profile: tuple[str, float, float], angular_profile: tuple[str, float, float], units: str):

        # TO DO: Falta lo de los pesos pero no se si es necesario. 

        """
        Modifies the grid source beam setup.

        Args:
            spatial_profile (str, int, int): (Beam spatial profile, x axis, y axis). It can be "uniform" or "gaussian".
                Example: 
                 ("uniform", "", "")
                 ("gaussian", 0.5, 0.2)
            anular_profile (str, int, int): It can be "uniform", "gaussian", "lambertian" or "solar".
             - uniform: ("uniform", half angle, "")
             - gaussian: ("gaussian", half angle x, "half angle y)
             - lambertian: ("lambertian", " half angle)
             - solar: ("solar", "", "")
            units (str): degrees or radians. 
            
        Returns:
        text (str): Scheme code fragment to append to the macro file.
            """
        
        text = f"""

        ; Grid source beam setup:
        (raytrace:set-beam-spatial-profile-{spatial_profile[0]} {spatial_profile[1]} {spatial_profile[2]} {self.source_ID})
        (raytrace:set-beam-angular-profile-{angular_profile[0]}-{units} {angular_profile[1]} {angular_profile[2]} {self.source_ID})
        (raytrace:set-beam-orientation-perpendicular {self.source_ID})"""

        return text
    
    def add_surface_source(self, object_name: str, surface_num: int, emission_type: str, emission: float, units: str, ang_dist: int, flux: int):

        """
            Creates a surface source using one face of an object.

            Args:
                element_class (type[Element]): Element class used to increment the object ID counter.
                object_name (str): Name of the object that will act as the source.
                surface_num (int): Number of the surface that will emit light.
                emission_type (str): Type of emission. Options: "flux", "irradiance", "lambertian", or "gaussian".
                emission (float): Emission value in the units specified.
                units (str): Units for the emission value.
                    Radiometric: "W" (flux) or "W/m^2" (irradiance).
                    Photometric: "lm" (flux) or "lx" (illuminance), if enabled.
                ang_dist (int): Angular distribution of the source.
                    For "flux" or "irradiance":
                        1: Lambertian
                        2: Normal to Surface
                        3: Surface Absorptance
                        4: Uniform
                    For "lambertian" or "gaussian": angular half‑angle from 5° to 90°.
                        After 5°, values increase in steps of 10°. Example: 30.
                flux (int): Total number of rays to generate.

            Returns:
                str: Scheme code fragment to append to the macro file.
            """

        self.source_ID = f"{object_name}/Surface {surface_num}"

        suppress_rays = "#f"  # Do not suppress rays. All rays are traced normally.
        min_rays = 0          # Minimum number of importance-sampled rays (0 means none).

        if emission_type == "irradiance" or emission_type == "flux":

            text = f"""

        ; New surface source
        (property:apply-{emission_type}-surface-source (tools:face-in-body {surface_num} {object_name}) {emission} {flux} {ang_dist} {suppress_rays} {min_rays})
        (raytrace:set-surface-source-units-{units} (tools:face-in-body {surface_num} {object_name}))"""
        else:

            text = f"""

        ; New surface source
        (property:apply-surface-source-property (tools:face-in-body {surface_num} {object_name}) "{emission_type} sources" "{ang_dist}-degree Half Angle" {flux} {min_rays} 1 #f)
        (raytrace:set-surface-source-units-{units} (tools:face-in-body {surface_num} {object_name}))"""

        return text


    def set_wavelength(self, wavelength: tuple[float, float]):
    
        """
         Defines a wavelength and its weight for the source

        Args:
            wavelength (float, float): (wavelength, weight). The units are um.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        if "sourceID" in self.source_ID:

            text = f"""
            
        ; Wavelength definition:
        (define wvList (list (list {wavelength[0]} {wavelength[1]})))
        (raytrace:set-wavelengths wvList {self.source_ID})"""
    
        elif "Surface" in self.source_ID:

            text = f"""
            
        ; Wavelength definition:
        (raytrace:set-surface-source-discrete-wavelength "{self.source_ID}")
        (raytrace:clear-wavelengths (raytrace:source-get-by-name "{self.source_ID}"))
        (raytrace:set-wavelengths (list (list {wavelength[0]} {wavelength[1]})) (raytrace:source-get-by-name "{self.source_ID}"))"""

        return text
    
    def irradiance_analysis(self, ray_type: str, colormap: int = 0, bucket: int = 50, smooth: bool = False):

        """
        Analyzes the irradiance on the detection plane.

        Args:
            ray_type (str): Type of ray data used in the irradiance plot ("absorbed", "incident",
                "reverse", "exiting", "leave").
            colormap (int): Colormap index:
                0 – 3 use a black background (grayscale, blue-max, step, rainbow),
                4 – 7 use a white background (grayscale, blue-max, step, rainbow).
            bucket (int): Number of buckets used to compute the irradiance map (e.g., 50).
            smooth (bool): Enables or disables smoothing of the irradiance map.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        if smooth:
            smooth = "#t"
        else:
            smooth = "#f"


        text = f"""
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "{ray_type}")
        (analysis:irradiance-color-map {colormap})
        (analysis:irradiance-buckets {bucket})
        (analysis:irradiance-smooth {smooth})
        (analysis:irradiance) ;; Display an irradiance map for the current model."""

        return text

