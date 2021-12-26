namespace Splash.Widgets {
    public class ApplicationWidget : Gtk.Grid {
        construct {
            var toolbar = new Splash.Widgets.HeaderBar ();
            this.attach (toolbar, 0, 0);

            var wallpaperDisplay = new Splash.Widgets.WallpaperDisplay ();
            this.attach (wallpaperDisplay, 0, 1);

            toolbar.wallpaper_shuffle_signal.connect (()=>{
                wallpaperDisplay.on_shuffle_signal (); 
            });
        }
    }
}
