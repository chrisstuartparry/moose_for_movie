#include "MooseForMovieApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"
#include "HeatConduction.h"

InputParameters
MooseForMovieApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

MooseForMovieApp::MooseForMovieApp(InputParameters parameters) : MooseApp(parameters)
{
  MooseForMovieApp::registerAll(_factory, _action_factory, _syntax);
}

MooseForMovieApp::~MooseForMovieApp() {}

void
MooseForMovieApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<MooseForMovieApp>(f, af, s);
  Registry::registerObjectsTo(f, {"MooseForMovieApp"});
  Registry::registerActionsTo(af, {"MooseForMovieApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
MooseForMovieApp::registerApps()
{
  registerApp(MooseForMovieApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
MooseForMovieApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  MooseForMovieApp::registerAll(f, af, s);
}
extern "C" void
MooseForMovieApp__registerApps()
{
  MooseForMovieApp::registerApps();
}
