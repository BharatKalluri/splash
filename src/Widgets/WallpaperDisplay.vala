namespace Splash.Widgets {

    public class WallpaperDisplay : Gtk.Image {

        public signal void wallpaper_loading_signal (bool is_loading);

        construct {
            on_shuffle_signal ();
        }

        public async void set_random_image () throws Error {
            var unsplash_client = new UnSplashClient();
            var random_image_url = yield unsplash_client.random_unsplash_image_url ();
            var random_image_stream = yield unsplash_client.get_wall_image (random_image_url);
            var gdk_pix_buf = yield new Gdk.Pixbuf.from_stream_at_scale_async (random_image_stream, 800, 800, true);
            this.set_from_pixbuf (gdk_pix_buf);
        }

        public void on_shuffle_signal () {
            wallpaper_loading_signal (true);
            set_random_image.begin ((obj, res) => {
                set_random_image.end (res);
                wallpaper_loading_signal (false);
            });
        }
    }
}
