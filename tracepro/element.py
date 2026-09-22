import numpy as np


class Element:

    """
    Builds Scheme macro fragments to define, configure, and manipulate optical elements in TracePro. 
    The generated text can be appended to a .scm macro file and executed in TracePro.

    Attributes:
        name (str): Name assigned to the element in TracePro.
    """

    def __init__(self, name: str):
        self.name = name


    def lens(self, thickness: float, r1: tuple[str, float], r2: tuple[str, float], aperture: tuple[str, float], obstruction: tuple[str, float], material: tuple[str, str], surf_1_pos: tuple[float, float, float], 
             surf_1_tilt: tuple[float, float, float] = (0, 0, 0), surf_2_pos: tuple[float, float, float] = (0, 0, 0), surf_2_tilt: tuple[float, float, float] = (0, 0, 0), degrees: bool = True):
    
        """
        Creates a lens in TracePro.

        Args:
            thickness (float): Thickness of the lens.
            r1 (str, float): First surface shape and radius. Example: ("sphere", 15).
            r2 (str, float): Second surface shape and radius. Example: ("plane", "").
            aperture (str, float): Aperture type and size of the lens. Example: ("circle", "12").
            obstruction (str, float): Obstruction type and size. Example: ("ellipse", 4), ("none", "").
            material (str, str): Manufacturer and material. Example: ("SCHOTT", "BK7").
            surf_1_pos (float, float, float): Position of the first surface (x, y, z).
            surf_1_tilt (float, float, float): Tilt of the first surface (x, y, z).
            surf_2_pos (float, float, float): Decenter of the second surface relative to first (x, y, z).
            surf_2_tilt (float, float, float): Tilt of the second surface relative to first (x, y, z).
            degrees (bool): If True, tilts are given in degrees. If False, in radians.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """
    
        degrees_flag = '#t' if degrees else '#f'

        text = f"""
        
        ; New lens: 
        (define {self.name}
        (geometry:lens-element-2 "{material[0]}" "{material[1]}" {thickness} "{r1[0]}" {r1[1]} "{r2[0]}" {r2[1]} "{aperture[0]}" 
        {f'(list {aperture[1]})'} "{obstruction[0]}" {f'(list {obstruction[1]})'} (position3d {surf_1_pos[0]} {surf_1_pos[1]} {surf_1_pos[2]}) {surf_1_tilt[0]} 
        {surf_1_tilt[1]} {surf_1_tilt[2]} (position3d {surf_2_pos[0]} {surf_2_pos[1]} {surf_2_pos[2]}) {surf_2_tilt[0]} {surf_2_tilt[1]}
        {surf_2_tilt[2]} {degrees_flag} "{self.name}"))"""
        
        return text
    

    def block(self, dimensions: tuple[float, float, float], center: tuple[float, float, float], orientation_method: tuple[str, list, list], degrees: bool):
    
        """
        Creates a block in TracePro.

        Args:
            dimensions (float, float, float): Block dimensions (x, y, z).
            center (float, float, float): Block center position (x, y, z).
            orientation_method (tuple[str, tuple, tuple]): Orientation definition method. It can be "angles" or "vectors".
                For angles: ("angles", rotation (x, y, z), "").
                    Example: ("angles", (1, 2, 0), "").
                For vectors: ("vectors", object_z (x, y, z), object_y (x, y, z)).
                    Example: ("vectors", (0, 0, 1), (0, 1, 0)).
            degrees (bool): If True, rotation angles are given in degrees. If False, in radians.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """
        
        degrees_flag = '#t' if degrees else '#f'

        # orientation_method:
        # ("angles", (rx, ry, rz), "")
        # ("vectors", (zx, zy, zz), (yx, yy, yz))

        if orientation_method[0] == "angles": 

            text = f"""

        ; New block:
        (define {self.name}
        (geometry:primitive-block "{self.name}" {dimensions[0]} {dimensions[1]} {dimensions[2]} (position3d {center[0]} {center[1]} {center[2]}) "{orientation_method[0]}" 
        {orientation_method[1][0]} {orientation_method[1][1]} {orientation_method[1][2]} {degrees_flag}))"""

        elif orientation_method[0] == "vectors":

            text = f"""

        ; New block:
        (define {self.name}
        (geometry:primitive-block "{self.name}" {dimensions[0]} {dimensions[1]} {dimensions[2]} (position3d {center[0]} {center[1]} {center[2]}) "{orientation_method[0]}" 
        (vector3d {orientation_method[1][0]} {orientation_method[1][1]} {orientation_method[1][2]}) (vector3d {orientation_method[2][0]} {orientation_method[2][1]} {orientation_method[2][2]}) 
        {degrees_flag}))"""
            
        else:
            raise ValueError("orientation_method[0] must be 'angles' or 'vectors'")
            
        return text
    
    def sphere(self, radius: float, center: tuple[float, float, float]):
    
        """
        Creates a sphere in TracePro.

        Args:
            radius (float): Radius of the sphere.
            center (float, float, float): Block center position (x, y, z).

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        text = f"""

        ; New sphere:
        (define {self.name}
        (geometry:sphere {radius}))
        (property:apply-name {self.name} "{self.name}")"""
            
        return text
    
    def elliptical_tube(self, length: float, thickness: float, base_major_radius: float, base_minor_radius: float, top_radius: int, center: tuple[float, float, float], 
                        close_bottom: bool = False, close_top: bool = False, rotation: tuple[float, float, float] = (0, 0, 0)):
        
        """
        Creates an elliptical tube aligned with the global Z axis. The length, wall thickness, 
        and base radii are mandatory parameters. The tube can be cylindrical or tapered 
        depending on the top radius (or scaling factor) provided.

        Args:
            length (float): Length of the tube.
            thickness (float): Wall thickness of the tube. If no thickness is desired, 
                a small value such as 0.01 is recommended.
            base_major_radius (float): Major radius of the base ellipse. If equal to the minor radius,
                the base section becomes circular.
            base_minor_radius (float): Minor radius of the base ellipse.
            top_radius (float): Top radius or scaling factor applied to the base radii. 
                For circular bases it behaves as a true radius, while for elliptical bases 
                it scales both radii proportionally. Values smaller than the base produce 
                a tapered (converging) tube.
            center (tuple[float, float, float]): Tube center position (x, y, z).
            close_bottom (bool): If True, the bottom surface will be closed.
            close_top (bool): If True, the top surface will be closed.
            rotation (tuple[float, float, float]): Rotation angles of the tube in radians (x, y, z).

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        close_bottom_flag = '#t' if close_bottom else '#f'
        close_top_flag = '#t' if close_top else '#f'

        text = f"""
        
        ; New elliptical tube: 
        (define {self.name}
        (geometry:elliptical-tube {length} {thickness} {base_major_radius} {base_minor_radius} {top_radius}
        (position3d {center [0]} {center[1]} {center[2]}) {rotation[0]} {rotation[1]} {rotation[2]} {close_bottom_flag} {close_top_flag}))
        (property:apply-name {self.name} "{self.name}")"""
        
        return text

    def _polygon_vertices(self, num_sides: int, radius: float, center: tuple[float, float] = (0, 0)):
    
        """
        Generates the XY coordinates of a regular polygon.

        Args:
            num_sides (int): Number of polygon sides.
            radius (float): Circumradius of the polygon.
            center (tuple[float, float]): Polygon center (x, y).

        Returns:
            list[tuple[float, float]]: Vertex coordinates in counterclockwise order.
        """

        cx, cy = center

        vertices = []

        for i in range(num_sides):
            angle = np.pi / 2 + 2 * np.pi * i / num_sides

            x = cx + radius * np.cos(angle)
            y = cy + radius * np.sin(angle)

            vertices.append((x, y))

        return vertices
    

    def polygon_3D(self, num_sides: int, radius: float, height: float, material: tuple[str, str], position: tuple[float, float, float] = (0, 0, 0), wall_thickness: float = None,
                   rotation: tuple[float, float, float] = (0, 0, 0)):

        """
        Creates a 3D polygonal prism along the z axis.

        Args:
            num_sides (int): Number of sides of the polygon.
            radius (float): Circumradius of the polygon base, measured from the center to any vertex.
            height (float): Height of the prism along its extrusion axis (z).
            material (str, str): Manufacturer and material. Example: ("SCHOTT", "BK7").
            position (tuple[float, float, float]): Center position of the polygon in (x, y, z).
            wall_thickness (float | None): Wall thickness of the prism. If None, the polygon is created as a solid prism. 
            If a value is provided, a hollow polygon is created with the specified wall thickness.
            rotation (tuple[float, float, float]): Rotation angles of the tube in degrees (x, y, z). A rotation of (0, 0, 0) creates the prism with its
            extrusion axis aligned with the global Z axis.

        Returns:
            text (str): Scheme code fragment to append to the macro file.
        """

        outer_vertices = self._polygon_vertices(num_sides=num_sides, radius=radius, center=(position[0], position[1]))
        outer_vertices_string = " ".join(str(value) for vertex in outer_vertices for value in vertex)

        obstruction = ("none", "")
       
        if wall_thickness:
            
            assert wall_thickness < radius

            inner_vertices = self._polygon_vertices(num_sides=num_sides, radius=(radius - wall_thickness), center=(position[0], position[1]))
            inner_vertices_string = " ".join(str(value) for vertex in inner_vertices for value in vertex)
            obstruction = ("polygon", inner_vertices_string)
       
        text = self.lens(thickness=height, r1=("plane", ""), r2=("plane", ""), aperture=("polygon", outer_vertices_string), 
                            obstruction=obstruction, material=material, surf_1_pos=position, surf_1_tilt=rotation)

        return text
        
       

        