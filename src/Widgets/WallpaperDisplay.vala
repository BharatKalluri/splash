namespace Splash.Widgets {

    public class WallpaperDisplay : Gtk.Image {

        public signal void wallpaper_loading_signal (bool is_loading);

        construct {
            set_random_image.begin ();
        }

        public async void set_random_image () throws Error {
            var unsplash_client = new UnSplashClient();
            var random_image_url = yield unsplash_client.random_unsplash_image_url ();
            var random_image_stream = yield unsplash_client.get_wall_image (random_image_url);
            var gdk_pix_buf = new Gdk.Pixbuf.from_stream_at_scale (random_image_stream, 800, 800, true);
            this.set_from_pixbuf (gdk_pix_buf);
        }

        public void on_shuffle_signal () {
            var loop = new MainLoop ();
            wallpaper_loading_signal (true);
            set_random_image.begin ((obj, res)=>{
                loop.quit ();
                wallpaper_loading_signal (false);
            });
            loop.run();
        }
    }
}
