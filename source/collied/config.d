module collied.config;


final class HTTPConfig
{
    __gshared static uint Max_Body_Size = 2*1024*1024;//2M
    __gshared static uint Max_Header_Size = 16 * 1024;//8K;
}
