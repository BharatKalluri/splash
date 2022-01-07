namespace Splash.Widgets {

    public class WallpaperDisplay : Gtk.Image {

        public signal void wallpaper_loading_signal (bool is_loading);
        public signal void wallpaper_loaded_signal (UnSplashImageMetadata image_metadata);

        private string SPLASH_IMAGE_PATH = Path.build_filename (Environment.get_user_cache_dir ()) + "/splash.jpg";

        construct {
            on_shuffle_signal ();
        }

        public async void set_random_image () throws Error {
            var unsplash_client = new UnSplashClient();
            var random_image_url_metadata = yield unsplash_client.random_unsplash_image_url ();
            File local_file = File.new_for_uri (random_image_url_metadata.url);
            yield local_file.copy_async (File.new_for_path(SPLASH_IMAGE_PATH), FileCopyFlags.OVERWRITE);
            Splash.Contractor.set_wallpaper_by_contract (File.new_for_path (SPLASH_IMAGE_PATH));
            wallpaper_loaded_signal (random_image_url_metadata);
            var gdk_pix_buf = new Gdk.Pixbuf.from_file_at_scale (SPLASH_IMAGE_PATH, 1024, 768, true);
            this.set_from_pixbuf (gdk_pix_buf);
        }

        public void on_shuffle_signal () {
            wallpaper_loading_signal (true);
            set_random_image.begin ((obj, res) => {
                wallpaper_loading_signal (false);
                set_random_image.end (res);
            });
        }

        public async void copy_file_to_pictures_folder () throws Error {
            string destination_folder_path =  Path.build_filename (Environment.get_user_special_dir (UserDirectory.PICTURES)) + "/unsplash.jpg";
            File local_file = File.new_for_path (SPLASH_IMAGE_PATH);
            yield local_file.copy_async (File.new_for_path(destination_folder_path), FileCopyFlags.OVERWRITE); 
        }

        public void create_dialog (string text) {
            var dialog = new Gtk.MessageDialog (null, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, text);
            dialog.set_title (_("Status"));
            dialog.run ();
            dialog.destroy ();
        }

        public void on_wallpaper_download () {
            copy_file_to_pictures_folder.begin ((obj, res) => {
                copy_file_to_pictures_folder.end (res);
                GLib.Application.get_default ().send_notification (
                    "notify.app", 
                    new Notification (_("Downloaded to your pictures folder!"))
                );
            });
        }
    }
}
