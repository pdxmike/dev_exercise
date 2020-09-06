class OrganizationsController < ApplicationController
  before_action :authorize

  def index
    @search_name = params[:name]
    @organizations = Organization.order(:name)
    @organizations = @organizations.search_by_name(@search_name) if @search_name.present?
    @search_result_count = @organizations.count
  end

  def show
    @organization = Organization.find(params[:id])
    @members = @organization.users
    @members_count = @members.count
  end
end
