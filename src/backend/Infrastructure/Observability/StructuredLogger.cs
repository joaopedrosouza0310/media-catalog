using System;
using System.Collections.Generic;
using System.Diagnostics;
using Newtonsoft.Json;

namespace MediaCatalog.Backend.Infrastructure.Observability
{
    public static class StructuredLogger
    {
        public static void Information(string eventName, object properties) => Write("Information", eventName, properties, null);
        public static void Error(string eventName, Exception exception, object properties) => Write("Error", eventName, properties, exception);

        private static void Write(string level, string eventName, object properties, Exception exception)
        {
            var entry = new Dictionary<string, object>
            {
                ["timestampUtc"] = DateTime.UtcNow,
                ["level"] = level,
                ["event"] = eventName,
                ["properties"] = properties
            };
            if (exception != null)
            {
                entry["exceptionType"] = exception.GetType().FullName;
                entry["exceptionMessage"] = exception.Message;
                entry["stackTrace"] = exception.StackTrace;
            }
            Trace.WriteLine(JsonConvert.SerializeObject(entry));
        }
    }
}
