namespace Splash.Widgets {
    public class ApplicationWidget : Gtk.Grid {
        construct {
            var header_bar = new Splash.Widgets.HeaderBar ();
            this.attach (header_bar, 0, 0);

            var wallpaperDisplay = new Splash.Widgets.WallpaperDisplay ();
            this.attach (wallpaperDisplay, 0, 1);

            header_bar.wallpaper_shuffle_signal.connect (()=>{
                wallpaperDisplay.on_shuffle_signal (); 
            });

            wallpaperDisplay.wallpaper_loading_signal.connect ((is_loading) => {
                if (is_loading == true) {
                    header_bar.loading_start ();
                } else {
                    header_bar.loading_stop ();
                }
            });

            wallpaperDisplay.wallpaper_loaded_signal.connect ((image_metadata) => {
                header_bar.set_subtitle ("Picture by " + image_metadata.user_name);
            });

            header_bar.wallpaper_download_signal.connect (() => {
                wallpaperDisplay.on_wallpaper_download ();
            });
        }
    }
}
