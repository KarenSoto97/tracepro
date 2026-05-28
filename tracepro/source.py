
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

        """
        Traces rays from all discrete sources in the active model.

        TODO:
            If simulation mode is required, an output surface must be added to the system
            in order to properly perform the propagation.

        Args:
            analysis_mode (bool): If True sets analysis mode to "on"; otherwise sets it to
                "off" while maintaining simulation mode.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """
        
        analysis_flag = "on" if analysis_mode else "off"

        text = f"""
        
        ; Raytrace
        (raytrace:set-analysis-mode-{analysis_flag})
        (raytrace:all-sources)"""

        return text

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
            flux (float): Grid source flux. Units depend on 'units' and 'emission_type'.
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

        if emission_type == 0:
            text_1 = f"""(raytrace:set-grid-flux-per-ray {flux} {self.source_ID})"""
        elif emission_type == 1:
            text_1 = f"""(raytrace:set-grid-total-flux {flux} {self.source_ID})"""
        elif emission_type == 2:
            text_1 = f"""(raytrace:set-grid-irradiance {flux} {self.source_ID})"""
        else:
            raise ValueError(f"Invalid emission_type '{emission_type}'. "
        "Valid options are: 0 (flux per ray), 1 (total flux), 2 (irradiance).")

        text = f"""
        
        ; Modifications of the grid source:
        (raytrace:set-grid-boundary-{boundary_type} {boundary1} {boundary2} {self.source_ID})
        (raytrace:set-grid-pattern-{pattern_type} {pattern1} {pattern2} {flux} {self.source_ID})
        (raytrace:set-grid-emission-type {emission_type} {self.source_ID})
        (raytrace:set-grid-units-{units} {self.source_ID})
        (raytrace:set-grid-origin (position3d {position[0]} {position[1]} {position[2]}) {self.source_ID})
        (raytrace:set-grid-orientation-direction-vectors (vector3d {normal_vector[0]} {normal_vector[1]} {normal_vector[2]}) (vector3d {up_vector[0]} {up_vector[1]} {up_vector[2]}))"""

        return text + text_1
    
    def grid_beam_setup(self, spatial_profile: tuple[str, float, float], angular_profile: tuple[str, float, float], units: str):

        """
        Modifies the grid source beam setup.

        Args:
            spatial_profile (str, int, int): (Beam spatial profile, x axis, y axis). It can be "uniform" or "gaussian".
                Example: 
                 ("uniform", "", "")
                 ("gaussian", 0.5, 0.2)
            angular_profile (str, int, int): It can be "uniform", "gaussian", "lambertian" or "solar".
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
    

    def grid_rotation(self, angle: float, axis: int, rotation_point: tuple[float, float, float], object_ref: bool):

        """
        Rotate the selected grid source around a specified axis.

        The rotation is defined by:
        - the direction of the rotational axis (controlled by axis_direction),
        - and a point through which that axis passes (rotation_point or the object reference origin).

        The rotational axis will pass through the specified rotation_point. If object_ref is True,
        the rotation_point is ignored and the axis will pass through the origin of the object
        reference system. Note that object_ref only affects the position of the axis, not its direction.

        Args:
            angle (float): Angle of rotation about the axis in degrees.
            axis_type (int): Controls the direction of the rotational axis.
                0: rotation about global X axis.
                1: rotation about global Y axis.
                2: rotation about global Z axis.
            rotation_point (float, float, float): Point through which the rotational axis passes. 
            This parameter is ignored if object_ref is True.
            object_ref (bool): If True, the rotational axis passes through the origin of the object reference system, resulting in a rotation about the object itself,
            independently of its position in the global coordinate system.
        """

        if axis == 0:
            direction = (1, 0, 0)
        elif axis == 1:
            direction = (0, 1, 0)
        elif axis == 2:
            direction = (0, 0, 1)
        else:
            raise ValueError("axis must be 0 (X), 1 (Y) or 2 (Z)")


        object_ref_flag = "#t" if object_ref else "#f"

        text = f"""

        ; Grid source rotation:
        (edit:rotate-grid-source "{self.name}" {rotation_point[0]} {rotation_point[1]} {rotation_point[2]} {direction[0]} {direction[1]} {direction[2]} 
        {angle} #f {object_ref_flag})"""

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

        # Discrete sources and surface sources require different Scheme commands.

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

        smooth_flag = "#t" if smooth else "#f"

        text = f"""
        
        ; Irradiance analysis
        (analysis:display-selected-rays #t)
        (analysis:irradiance-ray-type "{ray_type}")
        (analysis:irradiance-color-map {colormap})
        (analysis:irradiance-buckets {bucket})
        (analysis:irradiance-smooth {smooth_flag})
        (analysis:irradiance) ;; Display an irradiance map for the current model."""

        return text

    
    def candela_iso(self, plot_type: str, half_angle: int, ray_type: str, flux_units: int = 0, normal_vector: tuple[float, float, float] = (0, 1, 0),
                up_vector: tuple[float, float, float] = (0, 1, 0), log: bool = False, smooth: bool = False, contour: bool = False, gradient_display: bool = False):
        
        # TODO: Consider splitting 'candela_iso' into 'candela_iso_polar' and 'candela_iso_rectangular'
        # to handle plot-specific parameters more cleanly.

        """
        Creates a candela iso plot. It can be polar or rectangular.

        Args:
            plot_type (str): Type of candela iso plot. Can be 'rectangular' or 'polar'.
            half_angle (int): Sets the half angle for the iso candela plot.
            ray_type (str): Sets the ray selection for the candela iso plots.
                Possible values: "missed", "exiting" or "incident".
            flux_units (int): Sets the units for candela iso plots.
                Possible values:
                    0 - W/sr
                    1 - mW/sr
                    2 - kW/sr
                    3 - MW/sr
                    4 - mcd
                    5 - cd
                    6 - cd/klm
            normal_vector (tuple[float, float, float]): Normal vector that defines the polar origin (x, y, z).
            up_vector (tuple[float, float, float]): Up vector that defines the plot orientation (x, y, z).
            log (bool): Enables logarithmic scale for the candela iso plot.
            smooth (bool): Smooths the irradiance map.
            contour (bool): Enables contour plot (only for polar iso-candela).
            gradient_display (bool): Enables gradient display (only for polar iso-candela).

        Returns:
            str: Scheme code fragment to append to the macro file.
        """

        if plot_type not in {'polar', 'rectangular'}:
            raise ValueError("plot_type must be 'polar' or 'rectangular'")

        if ray_type not in {'missed', 'exiting', 'incident'}:
            raise ValueError("ray_type must be 'missed', 'exiting' or 'incident'")

        log_tag = '#t' if log else '#f'
        smooth_tag = '#t' if smooth else '#f'
        contour_tag = '#t' if contour else '#f'
        gradient_display_tag = '#t' if gradient_display else '#f'

        text = f"""
            
            ; Candela iso {plot_type}
            (analysis:candela-{plot_type}-iso)
            (analysis:candela-{plot_type}-angular-width {half_angle})
            (analysis:candela-ray-type "{ray_type}")
            (analysis:candela-{plot_type}-flux-units {flux_units})
            (analysis:candela-{plot_type}-log-plot {log_tag})
            (analysis:candela-{plot_type}-smooth {smooth_tag})
            (analysis:candela-{plot_type}-max #f 0)
            (analysis:candela-{plot_type}-min #f 0)
            (analysis:candela-normal (vector3d {normal_vector[0]} {normal_vector[1]} {normal_vector[2]}))
            (analysis:candela-up (vector3d {up_vector[0]} {up_vector[1]} {up_vector[2]}))
            (analysis:candela-{plot_type}-contour {contour_tag})
            (analysis:candela-{plot_type}-gradient-display {gradient_display_tag})"""

        return text
    
    def candela_distribution(self, plot_type: str, half_angle: int, ray_type: str, flux_units: int = 0, normal_vector: tuple[float, float, float] = (0, 1, 0),
                         up_vector: tuple[float, float, float] = (1, 0, 0), horizontal_angles: int = 4, log: bool = False, smooth: bool = False, 
                         luminaire: (bool) = False):

        """
        Creates a candela distribution plot. It can be polar or rectangular.

        Args:
            plot_type (str): Type of candela distribution plot. Can be 'rectangular' or 'polar'.
            half_angle (int): Sets the half angle for the distribution.
            ray_type (str): Sets the ray selection for the candela plots.
                Possible values: "missed", "exiting" or "incident".
            flux_units (int): Sets the units for candela distribution plots.
                Possible values:
                    0 - W/sr
                    1 - mW/sr
                    2 - kW/sr
                    3 - MW/sr
                    4 - mcd
                    5 - cd
                    6 - cd/klm
            normal_vector (tuple[float, float, float]): Normal vector that defines the polar origin (x, y, z).
            up_vector (tuple[float, float, float]): Up vector that defines the polar origin (x, y, z).
            horizontal_angles (int): Number of horizontal photometric sections used to sample the candela distribution.
            log (bool): Enables logarithmic scale for the candela distribution.
            smooth (bool): Smooths the irradiance map.
            luminaire (bool, int): Enables luminaire plot.
                Note: This option is only effective when plot_type='polar'.
                It is ignored for 'rectangular' plots.

        Returns:
            str: Scheme code fragment to append to the macro file.
        """
        
        if plot_type not in {'polar', 'rectangular'}:
            raise ValueError("plot_type must be 'polar' or 'rectangular'")

        if ray_type not in {'missed', 'exiting', 'incident'}:
            raise ValueError("ray_type must be 'missed', 'exiting' or 'incident'")

        log_tag = '#t' if log else '#f'
        smooth_tag = '#t' if smooth else '#f'
        luminaire_tag = '#t' if luminaire else '#f'

        text = f"""
            
            ; Candela {plot_type} distribution
            (analysis:candela-{plot_type}-distribution)
            (analysis:candela-distribution {horizontal_angles} {smooth_tag} 360 {luminaire_tag})
            (analysis:candela-ray-type "{ray_type}")
            (analysis:candela-distribution-flux-units {flux_units})
            (analysis:candela-distribution-log-plot {log_tag})
            (analysis:candela-distribution-max #f 0)
            (analysis:candela-distribution-min #f 0)
            (analysis:candela-distribution-{plot_type} {half_angle})
            (analysis:candela-normal (vector3d {normal_vector[0]} {normal_vector[1]} {normal_vector[2]}))
            (analysis:candela-up (vector3d {up_vector[0]} {up_vector[1]} {up_vector[2]}))
            """

        if luminaire:
            text += f"""
            (analysis:candela-distribution-luminaire {half_angle})
            """

        return text


