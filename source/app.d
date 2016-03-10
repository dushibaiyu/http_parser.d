	import std.functional;
	import collied.httpparser;
	import std.stdio;

	void on_message_begin(HTTPParser)
	{
		writeln("_on_message_begin");
		writeln(" ");
	}
	
	void on_url(HTTPParser par,ubyte[] data, bool adv)
	{
		writeln("_on_url, is NOADVANCE = ",adv);
		writeln("\" ",cast(string)data, " \"");
		writeln("HTTPMethod is = ",par.methodString);
		writeln(" ");
	}
	
	void on_status(HTTPParser par,ubyte[] data, bool adv)
	{
		writeln("_on_status, is NOADVANCE = ",adv);
		writeln("\" ",cast(string)data, " \"");
		writeln(" ");
	}
	
	void on_header_field(HTTPParser par,ubyte[] data, bool adv)
	{
		static bool frist = true;
		writeln("_on_header_field, is NOADVANCE = ",adv);
		writeln("len = ", data.length);
		writeln("\" ",cast(string)data, " \"");
		if(frist){
			writeln("\t http_major",par.major);
			writeln("\t http_minor",par.minor);
			frist = false;
		}
		writeln(" ");
	}
	
	void on_header_value(HTTPParser par,ubyte[] data, bool adv)
	{
		writeln("_on_header_value, is NOADVANCE = ",adv);
		writeln("\" ",cast(string)data, " \"");
		writeln(" ");
	}
	
	void  on_headers_complete(HTTPParser par)
	{
		writeln("_on_headers_complete");
		writeln(" ");
	}
	
	void on_body(HTTPParser par,ubyte[] data, bool adv)
	{
		writeln("_on_body, is NOADVANCE = ",adv);
		writeln("\" ",cast(string)data, " \"");
		writeln(" ");
	}
	
	void on_message_complete(HTTPParser par)
	{
		writeln("_on_message_complete");
		writeln(" ");
	}
	
	void on_chunk_header(HTTPParser par)
	{
		writeln("_on_chunk_header");
		writeln(" ");
	}
	
	void on_chunk_complete(HTTPParser par)
	{
		writeln("_on_chunk_complete");
		writeln(" ");
	}

	void main()
	{
	string data ="GET /test HTTP/1.1\r\nUser-Agent: curl/7.18.0 (i486-pc-linux-gnu) libcurl/7.18.0 OpenSSL/0.9.8g zlib/1.2.3.3 libidn/1.1\r\nHo";
	string data2 = "st: 0.0.0.0=5000\r\nAccept: */*\r\n\r\n";
	HTTPParser par = new HTTPParser();
	par.onMessageBegin = toDelegate(&on_message_begin);
	par.onMessageComplete =  toDelegate(&on_message_complete);
	par.onUrl = toDelegate(&on_url);
	par.onStatus = toDelegate(&on_status);
	par.onHeaderField = toDelegate(&on_header_field);
	par.onHeaderValue = toDelegate(&on_header_value);
	par.onChunkHeader = toDelegate(&on_chunk_header);
	par.onChunkComplete = toDelegate(&on_chunk_complete);
	par.onBody = toDelegate(&on_body);
	
	ulong len = par.httpParserExecute(cast(ubyte[])data);
	if(data.length != len){
		writeln("\t error ! ", par.error);
		return;
	}
	len = par.httpParserExecute(cast(ubyte[])data2);
	if(data2.length != len){
		writeln("\t error ! ", par.errorString);
		writeln("\tHTTPMethod is = ",par.methodString);
	}
	par.rest(HTTPParserType.HTTP_BOTH);
	data = "POST /post_chunked_all_your_base HTTP/1.1\r\nHost:0.0.0.0=5000\r\nTransfer-Encoding:chunked\r\n\r\n5\r\nhello\r\n";
	
        data2 = "0\r\n\r\n";

	len = par.httpParserExecute(cast(ubyte[])data);
	if(data.length != len){
		writeln("error1 ! ", par.error);
		writeln("\t error1 ! ", par.errorString);
		return;
	}
	writeln("data 1 is over!");
	len = par.httpParserExecute(cast(ubyte[])data2);
	writeln("last len = ",len);
	if(data2.length != len){
		writeln("\t error ! ", par.errorString);
		writeln("HTTPMethod is = ",par.methodString);
		writeln("erro!!!!!");
	}
}
 
