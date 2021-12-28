namespace Splash.Widgets {
    public class HeaderBar : Hdy.HeaderBar {

        public Gtk.Spinner loading_spinner;

        public signal void wallpaper_shuffle_signal ();

        public HeaderBar () {
            Object (
                title: _("Splash"),
                has_subtitle: true,
                subtitle: "Wallpapers from Unsplash!",
                show_close_button: true,
                hexpand: true
            );

            var shuffleButton = new Gtk.Button.with_label ("Shuffle!");
            this.add (shuffleButton);

            loading_spinner = new Gtk.Spinner();
            this.add (loading_spinner);

            // Explicit start since the signal is sent before the widget creation
            loading_start ();

            shuffleButton.clicked.connect (()=>{
                wallpaper_shuffle_signal ();
            });
        }

        public void loading_start() {
            this.loading_spinner.start();
        }

        public void loading_stop () {
            this.loading_spinner.stop();
        }
    }
}
