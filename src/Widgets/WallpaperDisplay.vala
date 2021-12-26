namespace Splash.Widgets {

    public class WallpaperDisplay : Gtk.Image {
        Soup.Session soup_session = new Soup.Session ();

        construct {
            set_random_image ();
        }

        public void set_random_image () {
            var random_image_url = random_unsplash_image_url ();
            var request = soup_session.request (random_image_url+"/?client_id=71847d4728771faa4852ccafc9e690590df27a4ee2fe875765e61209f18a9f6c");
            var response_stream = request.send();
            var gdk_pix_buf = new Gdk.Pixbuf.from_stream_at_scale (response_stream, 800, 800, true);
            this.set_from_pixbuf (gdk_pix_buf);
        }

        public string random_unsplash_image_url () {
            var request = soup_session.request ("https://api.unsplash.com/photos/random/?client_id=71847d4728771faa4852ccafc9e690590df27a4ee2fe875765e61209f18a9f6c");
            InputStream stream = request.send ();
            var json_parser = new Json.Parser ();
            var json_contents = json_parser.load_from_stream (stream);
            string raw_image_url = json_parser
                .get_root ()
                .get_object ()
                .get_object_member ("urls")
                .get_string_member ("raw");
            return raw_image_url;
        }

        public void on_shuffle_signal () {
            set_random_image ();
        }
    }
}
