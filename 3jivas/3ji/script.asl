startup
{
  // key, enabled, label
  vars.split_defs = new List<Tuple<string, bool, string>> {
    Tuple.Create("stage1", true, "STAGE 1"),
    Tuple.Create("stage2", true, "STAGE 2"),
    Tuple.Create("stage3", true, "STAGE 3"),
    Tuple.Create("stage4", true, "STAGE 4"),
    Tuple.Create("stage5", true, "STAGE 5"),
    Tuple.Create("finish", true, "CONGLATULATIONS!"),
  };

  foreach(var v in vars.split_defs) {
    settings.Add(v.Item1, v.Item2, v.Item3);
  }
}

init
{
  vars.thresholds = new Dictionary<string, double> {
    {"reset-normal", 92.5},
    {"reset-pushed", 92.5},
    {"start", 94.0},
    {"stage1", 92.5},
    {"stage2", 92.5},
    {"stage3", 92.0},
    {"stage4", 92.5},
    {"stage5", 95.5},
    {"finish", 94.0},
  };

  vars.splits = new List<string>();
  // vars.splits = null;
  vars.split = false;
  vars.split_when = 0;
}

update
{
  vars.split = false;

  if (timer.CurrentPhase == TimerPhase.NotRunning)
    return;
  if (vars.split_when > 0) {
    vars.split = Stopwatch.GetTimestamp() >= vars.split_when;
    if (vars.split)
      vars.split_when = 0;
    return;
  }
  if (vars.splits.Count == 0)
    return;

  var key = vars.splits[0];
  vars.split = features[key].current > vars.thresholds[key];
  if (vars.split) {
    print(key);
    print(vars.splits.Count.ToString());
    vars.splits.RemoveAt(0);
  }
  if (vars.split_when > 0)
    vars.split = false;
}

start
{
  // RESETボタン離す
  var ok = features["reset-pushed"].old > vars.thresholds["reset-pushed"];
  ok = ok && features["reset-normal"].current > vars.thresholds["reset-normal"];
  // STAGE 1(要らんかも)
  ok = ok && features["start"].current > vars.thresholds["start"];
  if (ok) {
    vars.splits.Clear();
    foreach(var v in vars.split_defs) {
      var key = v.Item1;
      if (settings[key])
        vars.splits.Add(key);
    }

    vars.split = false;
    vars.split_when = 0;
  }
  return ok;
}

reset
{
  // RESETボタン離す
  // var ok = features["reset-pushed"].old > vars.thresholds["reset-pushed"];
  // ok = ok && features["reset-normal"].current > vars.thresholds["reset-normal"];
  // RESETボタン押下
  var ok = features["reset-normal"].old > vars.thresholds["reset-normal"];
  ok = ok && features["reset-pushed"].current > vars.thresholds["reset-pushed"];
  return ok;
}

split
{
  return vars.split;
}

isLoading
{
}
