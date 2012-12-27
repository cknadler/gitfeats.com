class ApiController < ApplicationController

  # POST /api/feats
  def feats
    # check for unprocessable errors
    unprocessable_error = validate_feats_params(params)
    if unprocessable_error
      return render :json => unprocessable_error, :status => 422
    end

    # check for authentication errors
    @user = User.find_by_nickname(params[:username])

    unless @user
      msg = { message: "Invalid username" }
      return render :json => msg, :status => 401
    end

    unless @user.apikey == params[:key]
      msg = { message: "Invalid API key" }
      return render :json => msg, :status => 401
    end

    # standard response
    if @user
      update_history(params[:history]) if params[:history]
      complete_feats
    end

    msg = { message: "OK" }
    render :json => msg
  end
  
  private

  # Validate params POST to /api/feats
  #
  # Returns an error hash if params are missing or malformatted
  # Returns nil otherwise
  #
  # There are three types of errors possible:
  # - missing: the key is not present and is required
  # - invalid: the key is invalid (currently only with respect to history)
  # - wrong_type: the formatting for the value of specified key is wrong
  def validate_feats_params(params_hash)
    @error = {}

    params_keys = params_hash.keys
    required_keys = required_feats_params.keys

    # check for missing params
    required_keys.each do |required_key|

      # if the param is present
      if params_keys.include?(required_key)

        # check for proper param types
        unless params_hash[required_key].class == required_feats_params[required_key]
          @error[required_key] = "wrong_type"
        end
        
      # add the missing param to the errors hash
      else
        @error[required_key] = "missing"
      end
    end

    # check for invalid keys in history
    # if the history has passed all other validations so far
    if @error["history"].nil?
      history_errors = {}
      params_hash["history"].each do |key, value|
        unless Command.find_by_name(key)
          history_errors[key] = "invalid"
        end
      end
      @error["history"] = history_errors unless history_errors.empty?
    end

    return @error.empty? ? nil : format_unprocessable_error(@error)
  end

  def format_unprocessable_error(error)
    {
      :message => "Unprocessable",
      :error => error
    }
  end

  def required_feats_params
    @required_feats_params ||= 
      {
        "username" => String,
        "key"      => String,
        "history"  => ActiveSupport::HashWithIndifferentAccess
      }
  end

  # TODO: Refactor
  def update_history(histories)
    histories.each do |h_name, h_count|
      command = Command.find_by_name(h_name)
      ch = CommandHistory.find_or_create_by_user_id_and_command_id(@user.id, command.id)
      ch.count = h_count
      ch.save
    end
  end
  
  # TODO: Refactor
  def complete_feats
    feats = Feat.joins(:command => "command_histories")
                .where("command_histories.user_id = ? AND 
                        command_histories.count >= feats.threshold", @user.id)
    feats.each do |feat|
      CompletedFeat.find_or_create_by_user_id_and_feat_id(@user.id, feat.id)
    end
  end
end
