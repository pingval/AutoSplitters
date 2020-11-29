startup
{
  // key, enabled, label
  vars.split_defs = new List<Tuple<string, bool, string>> {
    Tuple.Create("stage1", true, "STAGE 1"),
    Tuple.Create("stage2", true, "STAGE 2"),
    Tuple.Create("stage3", true, "STAGE 3"),
    Tuple.Create("stage4", true, "STAGE 4"),
    Tuple.Create("stage5", true, "STAGE 5"),
    Tuple.Create("stage6", true, "STAGE 6"),
    Tuple.Create("stage7", true, "STAGE 7"),
    Tuple.Create("finish", true, "TAIGANJOUJU"),
  };

  foreach(var v in vars.split_defs) {
    settings.Add(v.Item1, v.Item2, v.Item3);
  }
}

init
{
  vars.thresholds = new Dictionary<string, double> {
    {"start", 91.0},
    {"reset", 92.5},
    {"stage1", 93.5},
    {"stage2", 93.5},
    {"stage3", 92.0},
    {"stage4", 92.0},
    {"stage5", 93.0},
    {"stage6", 92.0},
    {"stage7", 92.0},
    {"finish", 92.0},
  };
  // delay for TAIGANJOUJU
  // 10.1s
  vars.finish_delay = (long)1000 * 101000;

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
    if (key == "finish") {
      vars.split_when = Stopwatch.GetTimestamp() + vars.finish_delay;
    }
    vars.splits.RemoveAt(0);
  }
  if (vars.split_when > 0)
    vars.split = false;
}

start
{
  var ok = features["start"].current > vars.thresholds["start"];
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
  return features["reset"].current > vars.thresholds["reset"];
}

split
{
  return vars.split;
}

isLoading
{
}
