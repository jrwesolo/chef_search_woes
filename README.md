# Search Woes

This cookbook is here to demonstrate a weird situation with searches in Chef.

## Example

Normally, if you wanted to find nodes that were in a chef environment called production you would do something like this:

```ruby
nodes = search(:node, 'chef_environment:production')
```

Chef uses SOLR underneath to perform searches. SOLR will look for the field (`chef_environment` in this case) no matter how nested it may be in a node's attributes.

Let's say we have two nodes. `alice` is in the `production` environment and `bob` is in the `development` environment. Bob also has a node attribute set to:

```ruby
node['break']['search']['with']['chef_environment'] = 'production'
```

Performing the search above would return both `alice` and `bob`.

## Testing

This cookbook has unit and integration tests that fail due to this search behavior. The unit tests contain contexts with and without the conflicting nested attribute.

Tests were performed with ChefDK 0.5.1 using the following commands:

```bash
chef exec rspec        # for unit tests
chef exec kitchen test # for integration tests
```