%{
  title: "Mocking Third Party APIs in Elixir Phoenix",
  tags: ~w(elixir testing phoenix),
  description: "A guide on how I mock third party APIs while testing.",
  rating: 1,
  draft: true
}
---

Testing in Elixir is awesome. Unlike other languages and frameworks, testing is a first class citizen in Elixir. This means almost everything is testable. 

When writing LiveView apps, I mostly write integration tests that span an entire user action. Since the tests are executed by a GenServer instead of an actual browser the tests and fast and stable. Issues start to come up when the code path contains third-party dependencies that call external APIs. If you do not mock those dependencies, the APIs get hit everytime you run your tests, making those tests slow and brittle. In this post I'll explain how I mock those third party APIs with an expected static reply, so our tests run fast again.


## Abstracting to Services
The first step is to abstract away calls to the API in it's own service module. Let's say that I want to integrate with [Plaid](https://plaid.com) for my new payments app Nello so customers can connect their bank accounts. The connection requires two API calls, so I create a new service in my `lib/nello/services/plaid.ex`

``` elixir
defmodule Nello.Services.Plaid do
  alias Nello.Services.Plaid

  alias Nello.Customers.Customer

  def generate_link_token(%Customer{id: customer_id}) do
    case Plaid.Api.link_token_create(:auth, %{client_user_id: customer_id}) do
      {:ok, %{body: %{"link_token" => link_token}}} -> {:ok, %{link_token: link_token}}
      {:error, _} -> {:error, "There was an error connecting to Plaid"}
    end
  end

  def exchange_token(public_token) do
    case Plaid.Api.item_public_token_exchange(public_token) do
      {:ok, %{body: %{"access_token" => access_token, "item_id" => item_id}}} ->
        {:ok, %{access_token: access_token, item_id: item_id}}

      {:error, _} ->
        {:error, "There was an error exchanging token with Plaid"}
    end
  end
end
```

This module will be our interface which will be used by our app to consume the API. This module reflects how your business rules require the use of Plaid. Now we have to implement the `Nello.Services.Plaid.Api` module.


## Implementation Module
We have to now implement the module to do the heavy lifting of calling the API. Create a new `lib/nello/services/plaid/api.ex` file.

```elixir
defmodule Nello.Services.Plaid.Api do
  @services_plaid_api Application.compile_env(
                        :nello,
                        :services_plaid_api,
                        Nello.Services.Plaid.ExternalApi
                      )

  @callback link_token_create(Atom.t(), Map.t()) :: Tesla.Env.result()
  @callback item_public_token_exchange(String.t()) :: Tesla.Env.result()
  
  def link_token_create(type, attrs), do: @services_plaid_api.link_token_create(type, attrs)

  def item_public_token_exchange(public_token),
    do: @services_plaid_api.item_public_token_exchange(public_token)
end
```

