namespace MediaCatalog.Backend.Api.Models
{
    public sealed class ApiError
    {
        public ApiError(string code, string message, string correlationId = null)
        {
            Code = code;
            Message = message;
            CorrelationId = correlationId;
        }

        public string Code { get; }
        public string Message { get; }
        public string CorrelationId { get; }
    }
}
