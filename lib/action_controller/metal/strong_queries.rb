module ActionController
  class Parameters
    PARSER = StrongQueries::Parser.new

    def permit_query_params(*filters)
      params = self.class.new

      filters.flatten.each do |filter|
        case filter
        when Symbol, String
         permitted_scalar_filter(params, filter)
        when Hash then
         hash_filter(params, filter)
        end
      end

      params.permit!

      query_params = iterate_filtered_parameters(params)

      query_params
    end

    def permit_json_query(*filters)
      params = self.class.new

      filters.flatten.each do |filter|
        case filter
        when Symbol, String
         permitted_scalar_filter(params, filter)
        when Hash then
         hash_filter(params, filter)
        end
      end

      # query_params = {}
      #
      # params.each do |k, v|
      #   query_params[k.to_sym] = SafeParser.new(v).safe_load
      # end
      #
      # query_params
    end

    private

    def iterate_filtered_parameters(params)
      result = {}

      params.each do |k, v|
        if v.kind_of? String
          result[k.to_sym] = PARSER.parse_query_param_argument(v)
        elsif v.class == ActionController::Parameters
          result[k.to_sym] = iterate_filtered_parameters(v)
        else
          result[k.to_sym] = v
        end
      end

      result
    end
  end
end
