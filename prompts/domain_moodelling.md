Domain modelling from first principles


https://learn.microsoft.com/en-ca/azure/architecture/microservices/model/tactical-domain-driven-design?utm_source=chatgpt.com#overview-of-the-tactical-patterns

https://learn.microsoft.com/en-ca/azure/architecture

https://learn.microsoft.com/en-us/azure/architecture/patterns

https://learn.microsoft.com/en-us/azure/architecture/browse/

https://learn.microsoft.com/en-ca/azure/architecture/guide/design-principles/

https://learn.microsoft.com/en-us/azure/architecture/guide/design-principles/self-healing?source=recommendations

https://learn.microsoft.com/en-ca/azure/architecture/microservices/model/tactical-ddd?utm_source=chatgpt.com


https://learn.microsoft.com/en-ca/azure/architecture/microservices/design/

https://learn.microsoft.com/en-ca/azure/architecture/guide/architecture-styles/microservices

https://learn.microsoft.com/en-ca/azure/architecture/microservices/model/microservice-boundaries



Domain modelling means:
Represent the important concepts, rules, and behaviors of a business directly in code.

DDD treats the model as a way to capture business rules, behavior, constraints, and language inside a bounded context. Microsoft Learn

1. Start with the domain, not the database
Suppose we are building an ordering system.

A domain-first mindset starts here:
What can a customer do?

Place order
Add item
Remove item
Confirm order
Cancel order
Pay order
Ship order

Then ask:
What rules must always be true?

Examples:
- quantity must be positive
- a cancelled order cannot be shipped
- an empty order cannot be submitted
- currency must match
- shipping address must be valid
- confirmed orders cannot be arbitrarily edited
Those rules are the beginning of the domain model.


2. State + behavior + rules
A stronger model puts the behavior with the state:

Microsoft's DDD guidance explicitly recommends putting validation, state transitions, and business rules inside domain entities rather than scattering them across service classes.

(https://learn.microsoft.com/en-ca/azure/architecture/microservices/model/tactical-ddd?utm_source=chatgpt.com)


3. Invariants: the most important idea
An invariant is a rule that must always remain true.

Good domain modelling revolves around invariants.

This principle is fundamental:
Parse or construct data into valid domain types as early as possible.


4. Primitive obsession
One of the first modelling problems to learn is primitive obsession.

The types carry meaning.
This:
	String
	String
	BigDecimal
	String
becomes:
	AccountId
	AccountId
	Money
That is domain modelling.

5. Value Objects
A Value Object has no important identity.
It is defined by its value.

Microsoft's DDD guidance explicitly describes value objects as immutable: changes should produce replacement values rather than mutating the existing one. 
(https://learn.microsoft.com/en-ca/azure/architecture/microservices/model/tactical-ddd?utm_source=chatgpt.com)


7. Entity
An Entity is different.

An entity is defined primarily by its identity over time. 
- identity stays
- attributes may change

(https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/microservice-domain-model?utm_source=chatgpt.com)


8. Entity vs Value Object

This distinction is critical.
Ask:
Do I care which particular instance this is, or only what value it represents?


9. Context matters
There is no universal answer like: Address is always a Value Object

Microsoft gives essentially this example: an address may be a value object in one bounded context and an entity in another.

(https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/microservice-domain-model?utm_source=chatgpt.com)

An address in e-commerce checkout may simply represent:
123 Main St
Phoenix
AZ
So it is probably a value object.

But in a utility company:
ServiceLocation #84713

the physical location may have:
- meters
- inspection history
- service lifecycle
- identity
Now it may be an entity

A domain concept gets its meaning from its context.

10. Ubiquitous Language

This shared vocabulary is called Ubiquitous Language. DDD treats it as a shared language created by developers and domain experts within a bounded context.
(https://learn.microsoft.com/en-nz/azure/architecture/microservices/model/domain-analysis?utm_source=chatgpt.com)

Your code should increasingly resemble: business language
rather than: database operations

11. Avoid setters
order.setStatus(CONFIRMED);
is technically convenient but semantically weak.

Because it exposes: HOW state changes
instead of: WHY state changes

order.cancel();
can enforce:

public void cancel() {

    if (status == SHIPPED) {
        throw new OrderCannotBeCancelled();
    }

    status = CANCELLED;
}
Meaningful operations are usually better than generic mutation.



Microsoft's DDD guidance describes an aggregate as a transactional consistency boundary. The aggregate root should guard the invariants and be the entry point for changes.

https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/microservice-domain-model?utm_source=chatgpt.com
