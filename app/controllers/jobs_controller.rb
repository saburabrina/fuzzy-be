class JobsController < ApplicationController
    before_action :authenticate_user!

    def status
        job_id = params[:id]
        status = Sidekiq::Status::status(job_id)
        return render json: { message: "Bad Request" }, status: 404 if !status
        render json: { status: status }, status: 200
    end
end