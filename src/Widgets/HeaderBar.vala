namespace Splash.Widgets {
    public class HeaderBar : Hdy.HeaderBar {

        public Gtk.Spinner loading_spinner;
        public Gtk.Button download_button;

        public signal void wallpaper_shuffle_signal ();

        public signal void wallpaper_download_signal ();

        public HeaderBar () {
            Object (
                title: _("Splash"),
                has_subtitle: true,
                subtitle: "Wallpapers from Unsplash!",
                show_close_button: true,
                hexpand: true
            );

            var shuffleButton = new Gtk.Button.with_label (_("Shuffle!"));
            this.add (shuffleButton);

            loading_spinner = new Gtk.Spinner();
            this.add (loading_spinner);

            download_button = new Gtk.Button.from_icon_name ("folder-download", Gtk.IconSize.LARGE_TOOLBAR);
            this.pack_end (download_button);

            // Explicit start since the signal is sent before the widget creation
            loading_start ();

            // Signals
            shuffleButton.clicked.connect (()=>{
                wallpaper_shuffle_signal ();
            });
            download_button.clicked.connect (() => {
                wallpaper_download_signal ();
            });
        }

        public void loading_start() {
            this.download_button.sensitive = false;
            this.loading_spinner.start ();
            return;
        }

        public void loading_stop () {
            this.download_button.sensitive = true;
            this.loading_spinner.stop ();
            return;
        }
    }
}
