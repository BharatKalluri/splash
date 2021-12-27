public class UnSplashImageMetadata: Object {
    public string url;
    public string user_name;

    public UnSplashImageMetadata(string url, string user_name) {
        this.url = url;
        this.user_name = user_name;
    }
}

class UnSplashClient {
    Soup.Session soup_session = new Soup.Session ();

    public async UnSplashImageMetadata random_unsplash_image_url () throws Error {
        var unsplash_url = "https://api.unsplash.com/photos/random/?client_id=71847d4728771faa4852ccafc9e690590df27a4ee2fe875765e61209f18a9f6c";
        InputStream stream = yield soup_session.send_async (new Soup.Message("GET", unsplash_url));
        var json_parser = new Json.Parser ();
        json_parser.load_from_stream (stream);
        string raw_image_url = json_parser
            .get_root ()
            .get_object ()
            .get_object_member ("urls")
            .get_string_member ("raw");
        string picture_by = json_parser.get_root().get_object().get_object_member("user").get_string_member("name");
        return new UnSplashImageMetadata(raw_image_url, picture_by);
    }
    
    public async InputStream get_wall_image(string unsplash_url) throws Error {
        return yield this.soup_session.send_async(
            new Soup.Message(
                "GET", 
                unsplash_url+"/?client_id=71847d4728771faa4852ccafc9e690590df27a4ee2fe875765e61209f18a9f6c"
            )
        );
    }
    
}
