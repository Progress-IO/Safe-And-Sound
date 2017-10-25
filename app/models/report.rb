class Report < ApplicationRecord
    mount_uploaders :images, ImageUploader
    serialize :images, JSON # If you use SQLite, add this line.
    def self.show_all
        return Report.all
    end
       
end
