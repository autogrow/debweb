module Api
  module V1
    class DebfilesController < Api::V1::ApiController

      skip_before_filter :authenticate_user!, :upload

      def upload
        current_user = User.find_by_token(params[:token]) or raise Errors::AccessDenied

        log = Logger.new Rails.root.join('log', 'uploads.log')
        io  = params[:filedata]
        log.info "Receiving #{io.original_filename} from #{current_user.email}"
        
        filename = Rails.root.join('public', 'uploads', io.original_filename)

        File.open(filename, 'wb') do |file|
          file.write(io.read)
        end
        log.info "Saved #{io.original_filename} to uploads folder"

        svc = Services::UploadedFileImporter.new(filename, log)
        
        if svc.process(Library.new)
          render nothing: true, status: 200
        else
          render nothing: true, status: 400
        end
      end

    end
  end
end