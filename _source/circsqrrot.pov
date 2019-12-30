#version 3.7;

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
         col_to_tex(col, tex_map, col_map, edge_tex)
      }
   #end
#end

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
#declare num_verts = 14;
#declare verts = array [num_verts] {
    <1/sqrt(2-sqrt(2)), 0, 1/2>,
    <cos(pi/4)/sqrt(2-sqrt(2)), sin(pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(2*pi/4)/sqrt(2-sqrt(2)), sin(2*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(3*pi/4)/sqrt(2-sqrt(2)), sin(3*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(4*pi/4)/sqrt(2-sqrt(2)), sin(4*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(5*pi/4)/sqrt(2-sqrt(2)), sin(5*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(6*pi/4)/sqrt(2-sqrt(2)), sin(6*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(7*pi/4)/sqrt(2-sqrt(2)), sin(7*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(0*pi/2+pi/8)/sqrt(2), sin(0*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(1*pi/2+pi/8)/sqrt(2), sin(1*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(2*pi/2+pi/8)/sqrt(2), sin(2*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(3*pi/2+pi/8)/sqrt(2), sin(3*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <0,0,0>,
    <sqrt(1 + 1/sqrt(2))/4, sqrt(5 + 7/sqrt(2))/4, (2+sqrt(2))/4>
}

// Array of edge indexes
#declare num_edges = 20;
#declare edges = array [num_edges][2] {
   {0, 1},
   {1, 2},
   {2, 3},
   {3, 4},
   {4, 5},
   {5, 6},
   {6, 7},
   {7, 0},
   {8, 9},
   {9, 10},
   {10, 11},
   {11, 8},
   {0, 8},
   {1, 8},
   {2, 9},
   {3, 9},
   {4, 10},
   {5, 10},
   {6, 11},
   {7, 11}
}

// face colours
#declare f_col = <0.901961, 0.45098, 0, 0.6>;

// Array of face vertex counts and indexes
   triangle { verts[0] verts[1] verts[8] col_to_tex(f_col, tex_map, col_map, face_tex) }
   triangle { verts[2] verts[3] verts[9] col_to_tex(f_col, tex_map, col_map, face_tex) }
   triangle { verts[4] verts[5] verts[10] col_to_tex(f_col, tex_map, col_map, face_tex) }
   triangle { verts[6] verts[7] verts[11] col_to_tex(f_col, tex_map, col_map, face_tex) }
   polygon { 4, verts[1] verts[2] verts[9] verts[8] col_to_tex(f_col, tex_map, col_map, face_tex) }
   polygon { 4, verts[3] verts[4] verts[10] verts[9] col_to_tex(f_col, tex_map, col_map, face_tex) }
   polygon { 4, verts[5] verts[6] verts[11] verts[10] col_to_tex(f_col, tex_map, col_map, face_tex) }
   polygon { 4, verts[7] verts[0] verts[8] verts[11] col_to_tex(f_col, tex_map, col_map, face_tex) }
   polygon { 4, verts[8] verts[9] verts[10] verts[11] col_to_tex(f_col, tex_map, col_map, face_tex) }

   #declare i=0;
   #while (i<num_verts)
      sphere{ verts[i] vert_sz col_to_tex(vert_col, tex_map, col_map, vert_tex) }
      #declare i=i+1;
      #end

// Display edge elements
   #declare i=0;
   #while (i<num_edges)
      disp_edge(i, edge_col)
      #declare i=i+1;
      #end

// Extra object
      sphere{<0,0,0> vlength(verts[0]) texture{ pigment{color White filter 0.8 }}}
/*   sphere{<0,0,0> vlength(verts[0])
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
   }*/

background {color <0,0,0,1>}
// Max Trace Level (10), increase if black areas appear when using transparency
global_settings{
    max_trace_level 10
    assumed_gamma 1.2
}

  camera { location <0,3.2,0.9>
           sky <0,0,1>
           look_at <0,0,0>
         }

   light_source {<0.1, 3, 1> color <1,1,1> shadowless}
