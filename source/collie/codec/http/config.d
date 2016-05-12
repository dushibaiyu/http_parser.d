module collie.codec.http.config;

final class HTTPConfig
{
    __gshared static uint MaxBodySize = 2 * 1024 * 1024; //2M
    __gshared static uint MaxHeaderSize = 16 * 1024; //8K;
}
