namespace Splash.Widgets {
    public class HeaderBar : Hdy.HeaderBar {
        public HeaderBar () {
            Object (
                title: _("Splash"),
                has_subtitle: false,
                show_close_button: true,
                hexpand: true
            );
        }
    }
}
