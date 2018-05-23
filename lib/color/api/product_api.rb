=begin
#カラーミーショップ API

## カラーミーショップ API  [カラーミーショップ](https://shop-pro.jp) APIでは、受注の検索や商品情報の更新を行うことができます。  ## 利用手順  はじめに、カラーミーデベロッパーアカウントを用意します。[デベロッパー登録ページ](https://api.shop-pro.jp/developers/sign_up)から登録してください。  次に、[登録ページ](https://api.shop-pro.jp/oauth/applications/new)からアプリケーション登録を行ってください。 スマートフォンのWebViewを利用する場合は、リダイレクトURLに`urn:ietf:wg:oauth:2.0:oob`を入力してください。  その後、カラーミーショップアカウントの認証ページを開きます。認証ページのURLは、`https://api.shop-pro.jp/oauth/authorize`に必要なパラメータをつけたものです。  |パラメータ名|値| |---|---| |`client_id`|アプリケーション詳細画面で確認できるクライアントID| |`response_type`|\"code\"という文字列| |`scope`| 別表参照| |`redirect_url`|アプリケーション登録時に入力したリダイレクトURL|  `scope`は、以下のうち、アプリケーションが利用したい機能をスペース区切りで指定してください。  |スコープ|機能| |---|---| |`read_products`|商品データの参照| |`write_products`|在庫データの更新| |`read_sales`|受注・顧客データの参照| |`write_sales`|受注データの更新|  以下のようなURLとなります。  ``` https://api.shop-pro.jp/oauth/authorize?client_id=CLIENT_ID&redirect_uri=REDIRECT_URL&response_type=code&scope=read_products%20write_products ```  初めてこのページを訪れる場合は、カラーミーショップアカウントのIDとパスワードの入力を求められます。 承認ボタンを押すと、このアプリケーションがショップのデータにアクセスすることが許可され、リダイレクトURLへリダイレクトされます。  承認された場合は、`code`というクエリパラメータに認可コードが付与されます。承認がキャンセルされた、またはエラーが起きた場合は、 `error`パラメータにエラーの内容を表す文字列が与えられます。  アプリケーション登録時のリダイレクトURLに`urn:ietf:wg:oauth:2.0:oob`を指定した場合は、以下のようなURLにリダイレクトされます。 末尾のパスが認可コードになっています。  ``` https://api.shop-pro.jp/oauth/authorize/AUTH_CODE ```  認可コードの有効期限は発行から10分間です。  最後に、認可コードとアクセストークンを交換します。以下のパラメータを付けて、`https://api.shop-pro.jp/oauth/token`へリクエストを送ります。  |パラメータ名|値| |---|---| |`client_id`|アプリケーション詳細画面に表示されているクライアントID| |`client_secret`|アプリケーション詳細画面に表示されているクライアントシークレット| |`code`|取得した認可コード| |`grant_type`|\"authorization_code\"という文字列| |`redirect_uri`|アプリケーション登録時に入力したリダイレクトURL|  ```console # curl での例  $ curl -X POST \\   -d'client_id=CLIENT_ID' \\   -d'client_secret=CLIENT_SECRET' \\   -d'code=CODE' \\   -d'grant_type=authorization_code'   \\   -d'redirect_uri=REDIRECT_URI'  \\   'https://api.shop-pro.jp/oauth/token' ```  リクエストが成功すると、以下のようなJSONが返ってきます。  ```json {   \"access_token\": \"d461ab8XXXXXXXXXXXXXXXXXXXXXXXXX\",   \"token_type\": \"bearer\",   \"scope\": \"read_products write_products\" } ```  アクセストークンに有効期限はありませんが、許可済みアプリケーション一覧画面から失効させることができます。なお、同じ認可コードをアクセストークンに交換できるのは1度だけです。  取得したアクセストークンは、Authorizationヘッダに入れて使用します。以下にショップ情報を取得する際の例を示します。  ```console # curlの例  $ curl -H 'Authorization: Bearer d461ab8XXXXXXXXXXXXXXXXXXXXXXXXX' https://api.shop-pro.jp/v1/shop.json ```  ## エラー  カラーミーショップAPI v1では  - エラーコード - エラーメッセージ - ステータスコード  の配列でエラーを表現します。以下に例を示します。  ```json {   \"errors\": [     {       \"code\": 404100,       \"message\": \"レコードが見つかりませんでした。\",       \"status\": 404     }   ] } ``` 

OpenAPI spec version: 1.0.0

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 3.0.0-SNAPSHOT

=end

require 'uri'

module Color
  class ProductApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # おすすめ商品情報の削除
    # 商品に付加されたおすすめ商品情報を削除します
    # @param product_id 商品ID
    # @param pickup_type おすすめ商品情報種別（0:おすすめ商品, 1:売れ筋商品, 3:新着商品, 4:イチオシ商品）
    # @param [Hash] opts the optional parameters
    # @return [Object]
    def delete_product_pickup(product_id, pickup_type, opts = {})
      data, _status_code, _headers = delete_product_pickup_with_http_info(product_id, pickup_type, opts)
      data
    end

    # おすすめ商品情報の削除
    # 商品に付加されたおすすめ商品情報を削除します
    # @param product_id 商品ID
    # @param pickup_type おすすめ商品情報種別（0:おすすめ商品, 1:売れ筋商品, 3:新着商品, 4:イチオシ商品）
    # @param [Hash] opts the optional parameters
    # @return [Array<(Object, Fixnum, Hash)>] Object data, response status code and response headers
    def delete_product_pickup_with_http_info(product_id, pickup_type, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ProductApi.delete_product_pickup ...'
      end
      # verify the required parameter 'product_id' is set
      if @api_client.config.client_side_validation && product_id.nil?
        fail ArgumentError, "Missing the required parameter 'product_id' when calling ProductApi.delete_product_pickup"
      end
      # verify the required parameter 'pickup_type' is set
      if @api_client.config.client_side_validation && pickup_type.nil?
        fail ArgumentError, "Missing the required parameter 'pickup_type' when calling ProductApi.delete_product_pickup"
      end
      # resource path
      local_var_path = '/v1/products/{productId}/pickups/{pickupType}.json'.sub('{' + 'productId' + '}', product_id.to_s).sub('{' + 'pickupType' + '}', pickup_type.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['OAuth2']
      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Object')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ProductApi#delete_product_pickup\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # 商品データの取得
    # @param product_id 商品ID
    # @param [Hash] opts the optional parameters
    # @return [Object]
    def get_product(product_id, opts = {})
      data, _status_code, _headers = get_product_with_http_info(product_id, opts)
      data
    end

    # 商品データの取得
    # @param product_id 商品ID
    # @param [Hash] opts the optional parameters
    # @return [Array<(Object, Fixnum, Hash)>] Object data, response status code and response headers
    def get_product_with_http_info(product_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ProductApi.get_product ...'
      end
      # verify the required parameter 'product_id' is set
      if @api_client.config.client_side_validation && product_id.nil?
        fail ArgumentError, "Missing the required parameter 'product_id' when calling ProductApi.get_product"
      end
      # resource path
      local_var_path = '/v1/products/{productId}.json'.sub('{' + 'productId' + '}', product_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['OAuth2']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Object')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ProductApi#get_product\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # 商品一覧の取得
    # @param [Hash] opts the optional parameters
    # @option opts [String] :ids 商品IDで検索。カンマ区切りにすることで複数検索が可能
    # @option opts [Integer] :category_id_big 大カテゴリーIDで検索
    # @option opts [Integer] :category_id_small 小カテゴリーIDで検索
    # @option opts [String] :model_number 型番で部分一致検索
    # @option opts [String] :name 商品名で部分一致検索
    # @option opts [String] :display_state 掲載設定で検索
    # @option opts [Integer] :stocks 在庫管理している商品のうち、在庫数が指定した数値以下の商品を検索。オプションごとに在庫管理している商品は、合計在庫数で検索される
    # @option opts [BOOLEAN] :stock_managed 在庫管理している、またはしていない商品から検索
    # @option opts [BOOLEAN] :recent_zero_stocks &#x60;true&#x60; の場合、過去1週間以内に更新された商品から検索
    # @option opts [String] :make_date_min 指定日時以降に作成された商品から検索
    # @option opts [String] :make_date_max 指定日時以前に作成された商品から検索
    # @option opts [String] :update_date_min 指定日時以降に更新された商品から検索
    # @option opts [String] :update_date_max 指定日時以降に更新された商品から検索
    # @option opts [String] :fields レスポンスJSONのキーをカンマ区切りで指定
    # @option opts [Integer] :limit レスポンスの件数を指定。指定がない場合は10。最大50
    # @option opts [Integer] :offset 指定した数値+1件目以降のデータを返す
    # @return [Object]
    def get_products(opts = {})
      data, _status_code, _headers = get_products_with_http_info(opts)
      data
    end

    # 商品一覧の取得
    # @param [Hash] opts the optional parameters
    # @option opts [String] :ids 商品IDで検索。カンマ区切りにすることで複数検索が可能
    # @option opts [Integer] :category_id_big 大カテゴリーIDで検索
    # @option opts [Integer] :category_id_small 小カテゴリーIDで検索
    # @option opts [String] :model_number 型番で部分一致検索
    # @option opts [String] :name 商品名で部分一致検索
    # @option opts [String] :display_state 掲載設定で検索
    # @option opts [Integer] :stocks 在庫管理している商品のうち、在庫数が指定した数値以下の商品を検索。オプションごとに在庫管理している商品は、合計在庫数で検索される
    # @option opts [BOOLEAN] :stock_managed 在庫管理している、またはしていない商品から検索
    # @option opts [BOOLEAN] :recent_zero_stocks &#x60;true&#x60; の場合、過去1週間以内に更新された商品から検索
    # @option opts [String] :make_date_min 指定日時以降に作成された商品から検索
    # @option opts [String] :make_date_max 指定日時以前に作成された商品から検索
    # @option opts [String] :update_date_min 指定日時以降に更新された商品から検索
    # @option opts [String] :update_date_max 指定日時以降に更新された商品から検索
    # @option opts [String] :fields レスポンスJSONのキーをカンマ区切りで指定
    # @option opts [Integer] :limit レスポンスの件数を指定。指定がない場合は10。最大50
    # @option opts [Integer] :offset 指定した数値+1件目以降のデータを返す
    # @return [Array<(Object, Fixnum, Hash)>] Object data, response status code and response headers
    def get_products_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ProductApi.get_products ...'
      end
      if @api_client.config.client_side_validation && opts[:'display_state'] && !['showing', 'hidden', 'showing_for_members', 'sale_for_members'].include?(opts[:'display_state'])
        fail ArgumentError, 'invalid value for "display_state", must be one of showing, hidden, showing_for_members, sale_for_members'
      end
      # resource path
      local_var_path = '/v1/products.json'

      # query parameters
      query_params = {}
      query_params[:'ids'] = opts[:'ids'] if !opts[:'ids'].nil?
      query_params[:'category_id_big'] = opts[:'category_id_big'] if !opts[:'category_id_big'].nil?
      query_params[:'category_id_small'] = opts[:'category_id_small'] if !opts[:'category_id_small'].nil?
      query_params[:'model_number'] = opts[:'model_number'] if !opts[:'model_number'].nil?
      query_params[:'name'] = opts[:'name'] if !opts[:'name'].nil?
      query_params[:'display_state'] = opts[:'display_state'] if !opts[:'display_state'].nil?
      query_params[:'stocks'] = opts[:'stocks'] if !opts[:'stocks'].nil?
      query_params[:'stock_managed'] = opts[:'stock_managed'] if !opts[:'stock_managed'].nil?
      query_params[:'recent_zero_stocks'] = opts[:'recent_zero_stocks'] if !opts[:'recent_zero_stocks'].nil?
      query_params[:'make_date_min'] = opts[:'make_date_min'] if !opts[:'make_date_min'].nil?
      query_params[:'make_date_max'] = opts[:'make_date_max'] if !opts[:'make_date_max'].nil?
      query_params[:'update_date_min'] = opts[:'update_date_min'] if !opts[:'update_date_min'].nil?
      query_params[:'update_date_max'] = opts[:'update_date_max'] if !opts[:'update_date_max'].nil?
      query_params[:'fields'] = opts[:'fields'] if !opts[:'fields'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?
      query_params[:'offset'] = opts[:'offset'] if !opts[:'offset'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = ['OAuth2']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Object')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ProductApi#get_products\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # おすすめ商品情報の追加
    # おすすめ商品情報(おすすめ商品、売れ筋商品、新着商品、イチオシ商品のいずれか)を商品に追加します。
    # @param product_id 商品ID
    # @param unknown_base_type 
    # @param [Hash] opts the optional parameters
    # @return [Object]
    def post_product_pickup(product_id, unknown_base_type, opts = {})
      data, _status_code, _headers = post_product_pickup_with_http_info(product_id, unknown_base_type, opts)
      data
    end

    # おすすめ商品情報の追加
    # おすすめ商品情報(おすすめ商品、売れ筋商品、新着商品、イチオシ商品のいずれか)を商品に追加します。
    # @param product_id 商品ID
    # @param unknown_base_type 
    # @param [Hash] opts the optional parameters
    # @return [Array<(Object, Fixnum, Hash)>] Object data, response status code and response headers
    def post_product_pickup_with_http_info(product_id, unknown_base_type, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ProductApi.post_product_pickup ...'
      end
      # verify the required parameter 'product_id' is set
      if @api_client.config.client_side_validation && product_id.nil?
        fail ArgumentError, "Missing the required parameter 'product_id' when calling ProductApi.post_product_pickup"
      end
      # verify the required parameter 'unknown_base_type' is set
      if @api_client.config.client_side_validation && unknown_base_type.nil?
        fail ArgumentError, "Missing the required parameter 'unknown_base_type' when calling ProductApi.post_product_pickup"
      end
      # resource path
      local_var_path = '/v1/products/{productId}/pickups.json'.sub('{' + 'productId' + '}', product_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(unknown_base_type)
      auth_names = ['OAuth2']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Object')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ProductApi#post_product_pickup\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # 商品データの更新
    # @param product_id 商品ID
    # @param [Hash] opts the optional parameters
    # @option opts [ProductUpdateRequest] :product_update_request 商品データ
    # @return [Object]
    def update_product(product_id, opts = {})
      data, _status_code, _headers = update_product_with_http_info(product_id, opts)
      data
    end

    # 商品データの更新
    # @param product_id 商品ID
    # @param [Hash] opts the optional parameters
    # @option opts [ProductUpdateRequest] :product_update_request 商品データ
    # @return [Array<(Object, Fixnum, Hash)>] Object data, response status code and response headers
    def update_product_with_http_info(product_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ProductApi.update_product ...'
      end
      # verify the required parameter 'product_id' is set
      if @api_client.config.client_side_validation && product_id.nil?
        fail ArgumentError, "Missing the required parameter 'product_id' when calling ProductApi.update_product"
      end
      # resource path
      local_var_path = '/v1/products/{productId}.json'.sub('{' + 'productId' + '}', product_id.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(opts[:'product_update_request'])
      auth_names = ['OAuth2']
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'Object')
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ProductApi#update_product\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end