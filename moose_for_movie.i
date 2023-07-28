[Mesh]
  file = Compound_Mesh_1.unv
  # construct_side_list_from_node_list = true
[]

[Variables]
  [temperature]
  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = temperature
    material = concrete
  []
[]

[BCs]
  [inner]
    type = NeumannBC
    variable = temperature
    boundary = 'Mesh_1_Face'
    value = 5000
  []
[]

[Materials]
  [concrete]
    type = GenericConstantMaterial
    prop_names = 'thermal_conductivity'
    prop_values = '1.0'
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  exodus = true
[]
