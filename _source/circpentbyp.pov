#version 3.6;

#include "colors.inc"
#include "textures.inc"

#macro v_equal(v1,v2) ((v1.x=v2.x)&(v1.y=v2.y)&(v1.z=v2.z)) #end

#macro col_to_tex(col, elem_tex_map, elem_col_map, def_tex)
   #local typ=0;
   #if(col.y>=0) #local typ=1; #end
   #if(!typ & col.y=-1)
      #if(col.x<dimension_size(elem_tex_map,1))
         #ifdef(elem_tex_map[col.x]) #local typ=2; #end
      #end
      #if(!typ & col.x<dimension_size(elem_col_map,1))
         #ifdef(elem_col_map[col.x]) #local typ=3; #end
      #end
   #end
   #switch(typ)
      #case(0) texture{ def_tex } #break;
      #case(1) texture{ pigment{ rgbt col}} #break;
      #case(2) texture{ elem_tex_map[-col.x]} #break;
      #case(3) texture{ pigment{ color elem_col_map[-col.x]}} #break;
   #end
#end

#macro disp_edge(edge, col)
   #if(!v_equal(verts[edges[edge][0]], verts[edges[edge][1]]) )
      cylinder{verts[edges[edge][0]] verts[edges[edge][1]] edge_sz
         col_to_tex(col, edge_tex_map, edge_col_map, edge_tex)
      }
   #end
#end

// ###########  non-configurable section ############


// Display values
   // Size (or radius) of elements
   #declare vert_sz = 0.0237764; // 0.0237764
   #declare edge_sz = 0.01; // 0.0158509
   #declare face_sz = 0; // 0

   // Colour of elements (used to set up default textures
   #declare vert_col = <0.901961, 0.45098, 0, 0>;
   #declare edge_col = <0.8, 0.6, 0.8, 0>; // <0.8, 0.6, 0.8, 0>
   #declare face_col = <0.8, 0.901961, 0.901961, 0>; // <0.8, 0.901961, 0.901961, 0>

   // Texture of elements
   #declare vert_tex=texture{ pigment{ rgbt vert_col}}
   #declare edge_tex=texture{ pigment{ rgbt edge_col}}
   #declare face_tex=texture{ pigment{ rgbt face_col}}

#declare col_map = array[1]; // Default colourmap
#declare tex_map = array[1]; // Default texmap

// Array of vertex coordinates
#declare num_verts = 10;
#declare verts = array [num_verts] {
    <0,0,1>,
    <0,0,-1>,
    <1,0,0>,
    <cos(2*pi/5), sin(2*pi/5), 0>,
    <cos(4*pi/5), sin(4*pi/5), 0>,
    <cos(6*pi/5), sin(6*pi/5), 0>,
    <cos(8*pi/5), sin(8*pi/5), 0>,
    <cos(4*pi/5)/2,sin(4*pi/5)/2,.5>,
    <(cos(2*pi/5)+cos(4*pi/5))/3, (sin(2*pi/5)+sin(4*pi/5))/3, 1/3>,
    <0,0,0>
}

// Array of edge indexes
#declare num_edges = 20;
#declare edges = array [num_edges][2] {
   {0, 2},
   {0, 3},
   {0, 4},
   {0, 5},
   {0, 6},
   {1, 2},
   {1, 3},
   {1, 4},
   {1, 5},
   {1, 6},
   {2, 3},
   {3, 4},
   {4, 5},
   {5, 6},
   {6, 2},
   {4, 8},
   {7, 8},
   {4, 9},
   {7, 9},
   {8, 9}
}

// face colours
#declare f_col = <0.901961, 0.45098, 0, 0.6>;

// Colour Maps - redefine these, normally in an include file
   #declare col_map = array[1];
   #declare tex_map = array[1];
   #declare vert_col_map = col_map;
   #declare vert_tex_map = tex_map;
   #declare edge_col_map = col_map;
   #declare edge_tex_map = tex_map;
   #declare face_col_map = col_map;
   #declare face_tex_map = tex_map;



// Array of face vertex counts and indexes
   triangle { verts[0] verts[2] verts[3] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[0] verts[3] verts[4] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[0] verts[4] verts[5] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[0] verts[5] verts[6] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[0] verts[2] verts[6] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[1] verts[2] verts[3] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[1] verts[3] verts[4] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[1] verts[4] verts[5] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[1] verts[5] verts[6] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[1] verts[2] verts[6] col_to_tex(f_col, face_tex_map, face_col_map, face_tex) }
   triangle { verts[4] verts[7] verts[8] col_to_tex(<1,1,1,0>, face_tex_map, face_col_map, face_tex) }
   triangle { verts[4] verts[8] verts[9] col_to_tex(<1,1,1,0>, face_tex_map, face_col_map, face_tex) }
   triangle { verts[4] verts[7] verts[9] col_to_tex(<1,1,1,0>, face_tex_map, face_col_map, face_tex) }
   triangle { verts[7] verts[8] verts[9] col_to_tex(<1,1,1,0>, face_tex_map, face_col_map, face_tex) }

   #declare i=0;
   #while (i<num_verts)
      sphere{ verts[i] vert_sz col_to_tex(vert_col, vert_tex_map, vert_col_map, vert_tex) }
      #declare i=i+1;
      #end

// Display edge elements
   #declare i=0;
   #while (i<num_edges)
      disp_edge(i, edge_col)
      #declare i=i+1;
      #end

// Extra object
   sphere{<0,0,0> 1
       pigment{
           uv_mapping
           Tiles_Ptrn()
           color_map {
               [0.00 color rgb <1,1,1>] // white stanchions
               [0.1 color rgbt <0,0,0,1>] // transparent spaces
           }
           scale <0.04, 0.06, 1> // size and ratio of the grid
       }
//       finish {ambient 1 diffuse 0}
       rotate 90*x
   }

background {color <0,0,0,1>}
// Max Trace Level (10), increase if black areas appear when using transparency
global_settings{
    max_trace_level 10
    assumed_gamma 1.2
}

  camera { location <0,2.2,0.5>
           sky <0,0,1>
           look_at <0,0,0>
         }

   light_source {<0, 3, 1> color <1,1,1> shadowless}
