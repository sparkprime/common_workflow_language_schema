local Avro = import "../../avro.jsonnet";
local record = Avro.record;
local field = Avro.field;

local Util = import "../../util.jsonnet";
local doc = Util.doc;

local CWL = import "../../cwl.jsonnet";
local Binding = CWL.classes.Binding;
local Expression = CWL.classes.Expression;

doc("Describes how to generate an output parameter based on the files produced
    by a CommandLineTool.
    The output parameter is generated by applying these operations in
    the following order:
      - glob
      - loadContents
      - outputEval") +
Binding + record("CommandOutputBinding") {
  fields +: [
    doc("Find files relative to the output directory, using POSIX glob(3)
        pathname matching.  If provided an array, find files that match any
        pattern in the array.  If provided an expression, the expression must
        return a string or an array of strings, which will then be evaluated as
        one or more glob patterns.  Only files which actually exist will be
        matched and returned.") +
    field("outputEval", [
      Avro.Null,
      Avro.string,
      Expression,
      Avro.array([Avro.string]),
    ]),

    doc("Evaluate an expression to generate the output value.  If `glob` was
        specified, the script `context` will be an array containing any files
        that were matched.  Additionally, if `loadContents` is `true`, the File
        objects will include up to the first 64 KiB of file contents in the
        `contents` field.") +
    field("outputEval", [Avro.Null, Expression]),
  ]
}