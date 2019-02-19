# frozen_string_literal: true

class FacilitiesController < CalsBaseController
  before_action -> { require_search_privilege(method(:show)) }, only: [:show]
  include Response

  def show; end

  def profile
    @facility = facility_helper.find_by_id(params[:facility_id])
    json_response @facility
  rescue ApiError => e
    render json: e.response, status: e.status
  end

  def search
    page_params = pagination_params
    query_hash = QueryPreprocessor.params_to_query_with_types(JSON.parse(request.body.read).deep_symbolize_keys)
    logger.info "query_hash: #{query_hash}"
    es_query_json = Elastic::QueryBuilder.facility_search_v1(query_hash, page_params).to_json
    logger.info "es query: #{es_query_json}"

    facilities = facility_helper.search es_query_json
    json_response build_facilities_response(facilities)
  rescue ApiError => e
    render json: e.response, status: e.status
  end

  private

  def build_facilities_response(facilities)
    facilities_response = {}
    facilities_response['facilities'] = facilities['hits']['hits'].collect { |facility| facility['_source'] }
    facilities_response['total'] = total_upto_5k(facilities['hits']['total'])
    facilities_response
  end

  def pagination_params
    page_params = {}
    page_params['size_params'] = params[:size] || 50
    page_params['from_params'] = params[:from] || 0
    page_params['sort_params'] = params[:sort]
    page_params['order_params'] = params[:order]
    page_params
  end

  def total_upto_5k(total)
    total > 5000 ? 5000 : total
  end

  def facility_helper
    Helpers::Facility.new(auth_header: get_session_token)
  end
end
