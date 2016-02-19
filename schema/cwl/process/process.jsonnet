local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local CommandInputParameter = CWL.classes.CommandInputParameter;
local CreateFileRequirement = CWL.classes.CreateFileRequirement;
local DockerRequirement = CWL.classes.DockerRequirement;
local EnvVarRequirement = CWL.classes.EnvVarRequirement;
local Expression = CWL.classes.Expression;
local ExpressionEngineRequirement = CWL.classes.ExpressionEngineRequirement;
local InputParameter = CWL.classes.InputParameter;
local OutputParameter = CWL.classes.OutputParameter;
local Process = CWL.classes.Process;
local ProcessRequirement = CWL.classes.ProcessRequirement;
local ScatterFeatureRequirement = CWL.classes.ScatterFeatureRequirement;
local SchemaDefRequirement = CWL.classes.SchemaDefRequirement;
local SubworkflowFeatureRequirement = CWL.classes.SubworkflowFeatureRequirement;

doc(|||
  The base executable type in CWL is the `Process` object defined by the
  document.  Note that the `Process` object is abstract and cannot be directly
  executed.
|||) +

record("Process") {

  inputParameter:: InputParameter,
  outputParameter:: OutputParameter,

  fields: [
    doc("The unique identifier for this process object.") +
    field("id", [Avro.Null, Avro.string]),

    doc(|||
      Defines the input parameters of the process. The process is ready to
      run when all required input parameters are associated with concrete
      values. Input parameters include a schema for each parameter which is
      used to validate the input object. It may also be used build a user
      interface for constructing the input object.
    |||) +
    field("inputs", [
      Avro.array([self.inputParameter]),
    ]),

    doc(|||
      Defines the parameters representing the output of the process. May be
      used to generate and/or validate the output object.
    |||) +
    field("outputs", Avro.array([self.outputParameter])),

    doc(|||
      Declares requirements that apply to either the runtime environment or the
      workflow engine that must be met in order to execute this process. If
      an implementation cannot satisfy all requirements, or a requirement is
      listed which is not recognized by the implementation, it is a fatal
      error and the implementation must not attempt to run the process,
      unless overridden at user option.
    |||) +
    field("requirements", [Avro.Null, Avro.array([ProcessRequirement])]),

    doc(|||
      Declares hints applying to either the runtime environment or the
      workflow engine that may be helpful in executing this process. It is
      not an error if an implementation cannot satisfy all hints, however
      the implementation may report a warning.
    |||) +
    field("hints", Avro.types + [Avro.array(
      Avro.types + [
        CreateFileRequirement,
        DockerRequirement,
        EnvVarRequirement,
        ExpressionEngineRequirement,
        ProcessRequirement,
        ScatterFeatureRequirement,
        SchemaDefRequirement,
        SubworkflowFeatureRequirement,
      ]),
    ]),

    doc("A short, human-readable label of this process object.") +
    field("label", [Avro.Null, Avro.string]),

    doc("A long, human-readable description of this process object.") +
    field("description", [Avro.Null, Avro.string]),
  ],
}
