namespace Splash.Widgets {
    public class HeaderBar : Hdy.HeaderBar {

        public signal void wallpaper_shuffle_signal ();

        public HeaderBar () {
            Object (
                title: _("Splash"),
                has_subtitle: false,
                show_close_button: true,
                hexpand: true
            );

            var shuffleButton = new Gtk.Button.with_label ("Shuffle!");
            this.add (shuffleButton);

            shuffleButton.clicked.connect (()=>{
                wallpaper_shuffle_signal ();
            });
        }
    }
}
