[Mesh]
  file = movie_attempt_fewer_elements_3.e
  # construct_side_list_from_node_list = true
[]

[Variables]
  [temperature]
    # initial_condition = '300'
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = temperature
    block = 'plasma_chamber plasma_chamber_wall_volume first_wall_volume outer_walls_volume'
  []
  [time_derivative]
    type = ADHeatConductionTimeDerivative
    variable = temperature
    block = 'plasma_chamber plasma_chamber_wall_volume first_wall_volume outer_walls_volume'
  []
  [heat_source]
    type = ADMatHeatSource
    variable = temperature
    material_property = 'volumetric_heat'
    block = 'plasma_chamber_wall_volume'
  []
  # [heat_source]
  #   type = HeatSource
  #   variable = temperature
  #   function = 1000
  #   block = 'plasma_chamber'
  # []
[]

[ICs]
  [initial_temperature]
    type = ConstantIC
    variable = temperature
    block = 'plasma_chamber plasma_chamber_wall_volume first_wall_volume outer_walls_volume'
    value = '300'
  []
[]

[BCs]
  # [inner]
  #   type = FunctionDirichletBC
  #   variable = temperature
  #   boundary = 'plasma_chamber_wall'
  #   function = '10*t + 300'
  #   # value = 1000
  # []
  # [inner]
  #   type = NeumannBC
  #   variable = temperature
  #   boundary = 'plasma_chamber_wall'
  #   value = 10000
  # []
  [outer]
    type = DirichletBC
    variable = temperature
    boundary = 'outermost_wall'
    value = 300 # Assume room temperature outside reactor
  []
[]

[SolidProperties]
  [sp_graphite]
    type = ThermalGraphiteProperties
    grade = 'H_451'
  []
  [sp_316]
    type = ThermalSS316Properties
  []
[]

[Materials]
  [constant_heat_source]
    type = ADGenericConstantMaterial
    prop_names = 'volumetric_heat'
    prop_values = '100000'
    block = 'plasma_chamber_wall_volume'
  []
  [air]
    type = ADGenericConstantMaterial
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '0.025 1005 1.225'
    block = 'plasma_chamber'
  []
  [graphite]
    type = ADThermalSolidPropertiesMaterial
    temperature = temperature
    sp = sp_graphite
    block = 'plasma_chamber_wall_volume'
  []
  [steel]
    type = ADThermalSolidPropertiesMaterial
    temperature = temperature
    sp = sp_316
    block = 'first_wall_volume outer_walls_volume'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON

  # Set PETSc parameters to optimize solver efficiency
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = ' hypre    boomeramg'
  # petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -pc_hypre_boomeramg_coarsen_type -pc_hypre_boomeramg_interp_type'
  # petsc_options_value = 'hypre boomeramg 0.7 HMIS ext+i'

  # automatic_scaling = true
  line_search = none
  steady_state_detection = true
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-8
  l_max_its = 100
  nl_max_its = 10

  dt = 1
  num_steps = 50
[]

[Outputs]
  exodus = true
  csv = true
[]
