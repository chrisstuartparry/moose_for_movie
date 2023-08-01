[Mesh]
  file = Revolve_0-V2_no_vols_2.unv
  # construct_side_list_from_node_list = true
[]

[Variables]
  [T]
    initial_condition = 500

  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = T
  []
  [time_derivative]
    type = SpecificHeatConductionTimeDerivative
    variable = T
  []
  [heat_source]
    type = HeatSource
    variable = T
    function = 'sin(2 * pi * t) * exp(0.001 * x) * exp(0.001 * y)'
  []
[]

[Materials]
  [specific_heat_steel]
    type = ParsedMaterial
    f_name = 'specific_heat'
    args = T
    function = '0.248 * T + 381.496'
  []
  [thermal_conductivity]
    type = ParsedMaterial
    f_name = 'thermal_conductivity'
    args = T
    function = '25.5'
  []
  [density_steel]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = 7700
  []
[]

# [BCs]
#   [heating]
#     type = FunctionDirichletBC
#     variable = T
#     function = '400 * sin(2 * pi * t) + 773.15'
#     # boundary = 'revolve_0_surface'
#     value = 2898
#   []
# []

[Preconditioning]
  [smp]
    type = SMP # FDP finite difference preconditioning, SMP analytic Jacobian
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  start_time = 0.0
  dt = 1
  num_steps = 10
[]

[Postprocessors]
  [temp]
    type = PointValue
    point = '2343.936 5658.762 500'
    variable = T
  []
[]

[Outputs]
  exodus = true
  csv = true
[]
