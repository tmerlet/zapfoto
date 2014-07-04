require 'httparty'
module Pwinty
  class Api
    ROOT_URL = 'https://sandbox.pwinty.com'

    def initialize
      @merchantId = ENV['PWINTY_MERCHANT_ID']
      @apiKey = ENV['PWINTY_API_KEY']
    end

    def get_orders
      request(:get,'/v2.1/Orders',{})
    end

    def get_order id
      request(:get,'/v2.1/Orders', { 'query' => { 'id' => id } })
    end

    def new_order roll, current_user
      # get an order id
      order = request(:post,'/Orders',{params:{
        countryCode: 'GB',
        qualityLevel: 'Pro',
        useTracked: true,
        recipientName: "#{current_user.name}",
        payment:'InvoiceRecipient'
      }})

      order_id = order['id']
      order_payment_url = order['paymentUrl']

      # add roll to pwinty
      roll.photos.each do |photo|
        request(:post, "/v2.1/Orders/#{order_id}/Photos", {body:{
          type: '4x4',
          url: "#{photo.image}",
          copies: '1',
          priceToUser: '299',
          sizing: 'Crop'
        }})
      end

      order_valid = request(:get, "/v2.1/Orders/#{order_id}/SubmissionStatus", {})['isValid']

      if order_valid
        request(:post, "/v2.1/Orders/#{order_id}/Status", {body:{
          status: 'AwaitingPayment'
        }})
        order_payment_url
      else
        "error"
      end
    end

    def request(action,path,options)
      headers = { 'X-Pwinty-MerchantId'=> @merchantId,
                  'X-Pwinty-REST-API-Key' => @apiKey }
      headers.merge!(options[:headers]) if options[:headers]
      uri = [ROOT_URL, path].join
      HTTParty.send(action, uri, headers: headers, query: options[:params], body: options[:body])
    end
  end
end
