//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "MooseForMovieTestApp.h"
#include "MooseForMovieApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
MooseForMovieTestApp::validParams()
{
  InputParameters params = MooseForMovieApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

MooseForMovieTestApp::MooseForMovieTestApp(InputParameters parameters) : MooseApp(parameters)
{
  MooseForMovieTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

MooseForMovieTestApp::~MooseForMovieTestApp() {}

void
MooseForMovieTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  MooseForMovieApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"MooseForMovieTestApp"});
    Registry::registerActionsTo(af, {"MooseForMovieTestApp"});
  }
}

void
MooseForMovieTestApp::registerApps()
{
  registerApp(MooseForMovieApp);
  registerApp(MooseForMovieTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
MooseForMovieTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  MooseForMovieTestApp::registerAll(f, af, s);
}
extern "C" void
MooseForMovieTestApp__registerApps()
{
  MooseForMovieTestApp::registerApps();
}
