class UsersController < ApplicationController
    def create
        @task = Task.new(task_params)
    end
end
