---
name: cs_clean
description: clean code convensions in csharp
---

# csharp clean code
## General rules
1.  Follow standard conventions.
2.  Keep it simple stupid. Simpler is always better. Reduce complexity
    as much as possible.
3.  Boy scout rule. Leave the campground cleaner than you found it.
4.  Always find root cause. Always look for the root cause of a problem.
## Design rules
1.  Keep configurable data at high levels.
2.  Prefer polymorphism to if/else or switch/case.
3.  Separate multi-threading code.
4.  Prevent over-configurability.
5.  Use dependency injection.
6.  Follow Law of Demeter. A class should know only its direct
    dependencies.
## Understandability tips
1.  Be consistent. If you do something a certain way, do all similar
    things in the same way.
2.  Use explanatory variables.
3.  Encapsulate boundary conditions. Boundary conditions are hard to
    keep track of. Put the processing for them in one place.
4.  Prefer dedicated value objects to primitive type.
5.  Avoid logical dependency. Don't write methods which works correctly
    depending on something else in the same class.
6.  Avoid negative conditionals.
## Names rules
1.  Choose descriptive and unambiguous names.
2.  Make meaningful distinction.
3.  Use pronounceable names.
4.  Use searchable names.
5.  Replace magic numbers with named constants.
6.  Avoid encodings. Don't append prefixes or type information.
## Functions rules
1.  Small.
2.  Do one thing.
3.  Use descriptive names.
4.  Prefer fewer arguments.
5.  Have no side effects.
6.  Don't use flag arguments. Split method into several independent
    methods that can be called from the client without the flag.
## Comments rules
1.  Always try to explain yourself in code.
2.  Don't be redundant.
3.  Don't add obvious noise.
4.  Don't use closing brace comments.
5.  Don't comment out code. Just remove.
6.  Use as explanation of intent.
7.  Use as clarification of code.
8.  Use as warning of consequences.
## Source code structure
1.  Separate concepts vertically.
2.  Related code should appear vertically dense.
3.  Declare variables close to their usage.
4.  Dependent functions should be close.
5.  Similar functions should be close.
6.  Place functions in the downward direction.
7.  Keep lines short.
8.  Don't use horizontal alignment.
9.  Use white space to associate related things and disassociate weakly
    related.
10. Don't break indentation.
## Objects and data structures
1.  Hide internal structure.
2.  Prefer data structures.
3.  Avoid hybrids structures (half object and half data).
4.  Should be small.
5.  Do one thing.
6.  Small number of instance variables.
7.  Base class should know nothing about their derivatives.
8.  Better to have many functions than to pass some code into a function
    to select a behavior.
9.  Prefer non-static methods to static methods.
## Tests
1.  One assert per test.
2.  Readable.
3.  Fast.
4.  Independent.
5.  Repeatable.
## Code smells
1.  Rigidity. The software is difficult to change. A small change causes
    a cascade of subsequent changes.
2.  Fragility. The software breaks in many places due to a single
    change.
3.  Immobility. You cannot reuse parts of the code in other projects
    because of involved risks and high effort.
4.  Needless Complexity.
5.  Needless Repetition.
6.  Opacity. The code is hard to understand.
## Core Principles
- Readability \> cleverness.
- Simplicity \> unnecessary abstraction.
- Explicit intent \> implicit behavior when clarity improves.
- Consistency \> personal preference.
- Prefer maintainable code over minimal line count.
- Follow repository/project conventions before generic conventions.
- Use modern C# features when they improve clarity.
- Don't refactor unrelated code.
- Preserve existing behavior unless explicitly asked otherwise.
## Naming
- Types/classes/records/enums: `PascalCase`
- Methods: `PascalCase`
- Properties: `PascalCase`
- Public members: `PascalCase`
- Interfaces: `IPascalCase`
- Parameters: `camelCase`
- Local variables: `camelCase`
- Private/internal instance fields: `_camelCase`
- Constants: `PascalCase`
- Static fields: project convention; Microsoft code commonly uses `s_`
- Type parameters: `T`, `TItem`, `TResult`
- Async methods: suffix `Async`
- Exception classes: suffix `Exception`
- Attribute classes: suffix `Attribute`
- Avoid unnecessary abbreviations/acronyms.
- Avoid meaningless names: `data`, `obj`, `thing`, `temp`.
- Prefer descriptive names over short names.
- Avoid single-letter names except simple loop variables.
- Avoid double underscores; they are reserved for compiler-generated
  identifiers.
## Classes / Types
- Classes should have one clear responsibility.
- Prefer composition over inheritance when appropriate.
- Keep public APIs small.
- Hide implementation details.
- Prefer immutable types when practical.
- Use `record` for data/value-oriented models when appropriate.
- Use `class` for identity/mutable behavior.
- Use `struct` only for small value types with appropriate semantics.
- Use `enum` for a fixed set of related values.
- Non-flags enums: singular name.
- `Flags` enums: plural name.
- Avoid classes that exist only as containers for unrelated methods.
## Interfaces
- Use interfaces for meaningful contracts/abstractions.
- Name interfaces with `I` prefix:
``` csharp
public interface IUserRepository 
```
- Don't create an interface for every class automatically.
- Prefer abstractions at architectural boundaries.
## Methods
- One clear responsibility per method.
- Keep methods reasonably short.
- Prefer guard clauses over deep nesting.
- Avoid excessive parameter counts.
- Use parameter objects when many parameters form one concept.
- Avoid methods with surprising side effects.
- Method names should describe the action/result.
- `Get` implies retrieval; `Create` implies creation; `Delete` implies
  deletion.
- Async methods should end in `Async`.
- Don't return unnecessary mutable state.
## Properties
- Prefer properties over public fields.
- Keep setters private when callers shouldn't mutate state.
- Prefer init-only properties for immutable initialization:
``` csharp
public string Name  = "";
```
- Use computed properties when appropriate.
- Don't put expensive operations behind ordinary properties.
- Avoid properties with surprising side effects.
## Fields
- Keep fields private unless exposure is intentional.
- Prefer `readonly` when a field shouldn't be reassigned.
- Prefer `const` for compile-time constants.
- Use `static readonly` for runtime constants.
- Don't expose mutable collections directly.
## Variables / `var`
- Use `var` when the type is obvious from the right-hand side:
``` csharp
var user = new User();
var users = new List<User>();
```
- Use explicit types when `var` would obscure important information:
``` csharp
CancellationToken token = GetToken();
IUserRepository repository = GetRepository();
```
- Don't make `var` vs explicit typing a personal battle.
- Follow the project's \`.editorconfig\`.
## Nullability
- Enable nullable reference types:
<!-- -->
- Treat `string` and `string?` as meaningful API contracts.
- Use `?` when null is a valid state.
- Don't use =!\` (null-forgiving operator) to silence warnings without
  understanding why.
- Prefer fixing the null-state rather than suppressing warnings.
- Initialize non-nullable fields/properties correctly.
- Use nullable annotations to communicate API intent.
Example:
``` csharp
public User? FindUser(int id)
public User GetRequiredUser(int id)
```
## Collections
- Prefer interfaces for parameters/return types when implementation
  isn't relevant:
``` csharp
IReadOnlyList<User>
IEnumerable<User>
ICollection<User>
```
- Don't expose mutable collections unnecessarily.
- Prefer read-only interfaces for read-only APIs.
- Use collection expressions when they improve readability:
``` csharp
List<int> numbers = [1, 2, 3];
```
- Choose the collection based on semantics, not habit.
- Avoid unnecessary conversions between collection types.
## LINQ
- Use LINQ when it makes collection operations clearer.
- Common operations:
``` example
Where     -> filter
Select    -> transform
Any       -> existence check
All       -> every element matches
First     -> first expected element
FirstOrDefault -> first or absence
Single    -> exactly one expected element
Count     -> number of elements
OrderBy   -> sorting
GroupBy   -> grouping
```
- Prefer `Any()` over `Count() > 0` for existence checks.
- Don't use LINQ when a simple loop is clearer.
- Avoid excessively long LINQ chains.
- Be aware of deferred execution.
- With EF Core/IQueryable, understand whether operations execute in the
  database or in memory.
- Avoid accidental multiple enumeration.
- Don't call `ToList()` / `ToArray()` prematurely.
- Query syntax and method syntax are semantically equivalent; use the
  style that is clearest.
## Async / Await
- Use `async/await` for asynchronous I/O.
- Async methods should normally return `Task`, `Task<T>`, or
  `ValueTask<T>` when justified.
- Suffix asynchronous methods with `Async`.
- Don't block async code with `.Result` or `.Wait()`.
- Prefer `await` all the way through the call chain.
- Accept and propagate `CancellationToken` for cancellable operations.
- Pass the token to underlying async APIs.
- Don't create unnecessary `Task.Run()` for I/O-bound work.
- Don't use `async void` except event handlers.
- Don't ignore returned Tasks.
- Handle `OperationCanceledException` appropriately.
- Don't confuse cancellation with failure.
Example:
``` csharp
public async Task<User?> GetUserAsync(
int id,
CancellationToken cancellationToken)
```
## Exceptions
- Exceptions represent exceptional/failure conditions, not normal
  control flow.
- Catch only exceptions you can meaningfully handle.
- Catch specific exception types.
- Don't use:
``` csharp
catch (Exception) 
```
- Don't silently swallow exceptions.
- Don't catch and rethrow using `throw ex;` because it loses the
  original stack trace.
- Use `throw;` when rethrowing from a catch block.
- Prefer predefined exception types.
- Validate arguments early.
- Use `ArgumentNullException.ThrowIfNull()` where appropriate.
- Use `TryParse` / `TryGetValue` patterns for expected failure
  conditions.
- Use `using` / `await using` for disposable resources.
- Don't throw exceptions from ordinary methods such as `ToString()`
  without strong justification.
- Custom exceptions should end with `Exception`.
- Catch `OperationCanceledException` for cancellation when needed.
## Resource Management
- Dispose `IDisposable` objects deterministically.
- Use `using` statements/declarations.
- Use `await using` for `IAsyncDisposable`.
- Don't manually call `Dispose()` when a using declaration is
  appropriate.
- Don't dispose objects whose lifetime is owned elsewhere.
- Understand ownership before disposing injected dependencies.
## Pattern Matching
Prefer pattern matching when it improves clarity:
``` csharp
if (user is )
```
- Useful patterns:
  - `is null`
  - `is not null`
  - type patterns
  - property patterns
  - relational patterns
  - switch expressions
- Avoid clever patterns that make simple logic harder to understand.
## Switch
- Prefer switch expressions for straightforward value mapping:
``` csharp
var message = status switch
;
```
- Use ordinary `switch` statements when multiple statements or side
  effects make them clearer.
## Equality
- Use `=` null= only when appropriate; prefer `is null` for null checks.
- Understand value vs reference equality.
- Implement `Equals()` and `GetHashCode()` consistently when defining
  value equality.
- Prefer records when their built-in value semantics fit the model.
- Don't compare objects by reference when value equality is intended.
## Strings
- Use interpolation for readable string construction:
``` csharp
var message = $"Hello, ";
```
- Use `StringBuilder` only when repeated mutation actually benefits from
  it.
- Use appropriate string comparison rules.
- Never assume default string comparison semantics are correct for
  security-sensitive or culture-sensitive operations.
- Avoid unnecessary string allocations.
- Don't concatenate strings in complex loops without considering
  performance.
## Formatting
- Use 2-space indentation.
- Prefer spaces over tabs unless the repository says otherwise.
- Use braces consistently.
- Keep one statement per line.
- Use blank lines to separate logical sections.
- Keep lines reasonably short.
- Follow the repository's formatter configuration.
- Don't manually fight automated formatting.
## Namespaces / Files
- Prefer file-scoped namespaces when consistent with the project:
``` csharp
namespace MyApp.Services;
public class UserService 
```
- Keep namespace names meaningful.
- Keep namespaces aligned with project structure.
- Usually one primary type per file.
- File name should normally match the primary type.
- Don't create unnecessary namespace nesting.
## Using Directives
- Remove unused imports.
- Keep imports consistent.
- Prefer global usings for genuinely universal dependencies.
- Don't add global usings merely to avoid a few lines.
- Follow the project's ordering/style rules.
## Access Modifiers
- Explicitly specify access modifiers when project conventions require
  it.
- Default to the narrowest visibility necessary.
- Prefer `private` over exposing implementation details.
- Public APIs should be intentional.
- Don't make fields/methods public just for convenience.
## Constants / Magic Values
Avoid:
``` csharp
if (retryCount > 5) 
```
Prefer:
``` csharp
const int MaxRetries = 5;
if (retryCount > MaxRetries) 
```
Use enums for meaningful finite states.
## Comments / XML Documentation
- Prefer expressive code over comments.
- Comments explain `why`, constraints, or non-obvious behavior.
- Don't comment obvious code.
- Update comments when behavior changes.
- Use XML documentation for public APIs when documentation is required.
- Don't generate useless XML documentation merely to satisfy a rule.
## Dependency Injection
- Depend on abstractions when they represent real boundaries.
- Inject dependencies instead of constructing infrastructure inside
  business logic.
- Keep constructors understandable.
- Avoid service locator patterns.
- Don't inject dependencies that aren't actually needed.
- Avoid giant constructors; excessive dependencies often indicate
  excessive responsibilities.
- Keep dependency lifetimes correct.
- Don't inject scoped services into singleton services.
## SOLID — Practical Version
- Single Responsibility: \* One class should have one coherent reason to
  change.
- Open/Closed: \* Extend behavior without constantly modifying stable
  code when practical.
- Liskov Substitution: \* Derived types must honor the contracts of
  their base types.
- Interface Segregation: \* Prefer focused interfaces over giant
  interfaces.
- Dependency Inversion: \* High-level logic should not depend directly
  on replaceable infrastructure.
Don't apply SOLID mechanically. Use it to reduce real coupling and
complexity.
## DTOs / Entities / Models
- Don't use database entities everywhere by default.
- DTOs represent data crossing boundaries.
- Entities represent domain/database concepts.
- API request/response models should represent API contracts.
- Avoid exposing persistence models directly when it creates coupling.
- Keep mapping logic explicit and understandable.
## EF Core
- Prefer async database APIs.
- Pass `CancellationToken`.
- Avoid unnecessary tracking for read-only queries:
``` csharp
var users = await db.Users
.AsNoTracking()
.ToListAsync(cancellationToken);
```
- Avoid `ToList()` before filtering.
- Let EF translate database operations when appropriate.
- Avoid accidental N+1 queries.
- Don't load entire tables unnecessarily.
- Project only required fields when appropriate.
- Keep transactions intentional.
- Don't expose `DbContext` throughout unrelated application layers.
- Keep database concerns separated from domain/business logic where
  architecture requires it.
## ASP.NET Core
- Keep controllers/endpoints thin.
- Put business logic in application/domain services rather than
  controllers.
- Validate input at boundaries.
- Use dependency injection.
- Use appropriate HTTP status codes.
- Don't return entities blindly from public APIs.
- Use DTOs for API contracts when appropriate.
- Propagate `CancellationToken`.
- Don't duplicate validation/business logic across endpoints.
- Keep middleware focused.
- Don't put everything into one giant service.
## Validation
- Validate external input at system boundaries.
- Fail early for invalid arguments.
- Keep business invariants inside the domain/application layer where
  appropriate.
- Don't rely solely on UI validation.
- Don't duplicate identical validation across every layer without
  reason.
## Testing
- Test behavior, not implementation details.
- Tests should be deterministic.
- Test one behavior per test when practical.
- Use descriptive test names.
- Follow Arrange / Act / Assert when it improves clarity.
- Test happy paths and important edge cases.
- Test failure behavior.
- Avoid excessive mocking.
- Prefer real implementations for simple/value-like dependencies.
- Unit tests should be fast.
- Integration tests should test real boundaries such as database/API
  behavior.
Example:
```` csharp
[Fact]
public async Task GetUserAsync_ReturnsUser_WhenUserExists() 
````
## Performance
- Correctness and clarity come before premature optimization.
- Measure before optimizing.
- Avoid unnecessary allocations in hot paths.
- Avoid repeated enumeration.
- Avoid unnecessary `ToList()` / `ToArray()`.
- Understand LINQ allocation/performance implications.
- Use async I/O instead of blocking threads.
- Avoid `Task.Run()` for I/O.
- Use efficient collections for the actual access pattern.
- Optimize only where measurements justify it.
## Security
- Never hardcode secrets.
- Never log passwords, tokens, API keys, or sensitive data.
- Validate and sanitize external input.
- Use parameterized database queries / EF Core rather than string-built
  SQL.
- Don't disable TLS/certificate validation casually.
- Don't trust client-provided authorization information.
- Enforce authorization server-side.
- Avoid leaking sensitive information through exception messages/API
  responses.
- Treat authentication and authorization as separate concerns.
## Architecture
Prefer clear boundaries:
``` example
API / Presentation
↓
Application
↓
Domain
↓
Infrastructure
```
- Keep business rules out of controllers.
- Keep infrastructure concerns out of domain models.
- Keep domain logic independent of frameworks where practical.
- Don't create layers merely for ceremony.
- Dependencies should point toward stable/core abstractions.
- Avoid circular dependencies.
## Modern C# Features
Use modern language features when they improve clarity:
- nullable reference types
- records
- init-only setters
- pattern matching
- switch expressions
- expression-bodied members
- file-scoped namespaces
- target-typed `new`
- collection expressions
- required members
- primary constructors where appropriate
- top-level statements for simple applications
Don't use a feature merely because it is newer. Clarity and project
consistency win.
## Expression-Bodied Members
Good for genuinely simple expressions:
``` csharp
public bool IsAdult => Age >= 18;
```
Avoid when they make complex logic harder to scan.
## Records
Use records when value-oriented semantics are appropriate:
``` csharp
public record UserDto(int Id, string Name);
```
Don't automatically convert every class into a record.
## Primary Constructors
Useful for simple dependency injection:
``` csharp
public class UserService(IUserRepository repository) 
```
Avoid when constructor logic/state becomes difficult to understand.
## File / Project Organization
Typical organization:
``` example
src/
MyApp.Api/
MyApp.Application/
MyApp.Domain/
MyApp.Infrastructure/
tests/
MyApp.UnitTests/
MyApp.IntegrationTests/
```
Prefer organization by feature/responsibility when it improves
discoverability.
## Tooling
Recommended baseline:
- Formatting: `dotnet format`
- Compiler/analyzers: .NET SDK analyzers
- Style configuration: `.editorconfig`
- Testing: `xUnit` / `NUnit` / `MSTest`
- Coverage: `coverlet`
- Static analysis: built-in .NET analyzers
- CI: `dotnet build` + `dotnet test`
- Package management: NuGet
- Documentation: XML docs where appropriate
.NET analyzers include code-style rules and code-quality rules and can
be configured/enforced through \`.editorconfig\` and project settings.
## .editorconfig
Keep repository conventions machine-readable. Recommended categories:
- indentation (i prefer 1tab = 2spaces)
- newlines
- naming
- `var` preferences
- expression-bodied members
- namespace style
- using directives
- accessibility modifiers
- nullable warnings
- analyzer severity
- formatting
Use \`.editorconfig\` so conventions apply consistently across editors
and CI.
## Build / CI Quality Gate
A healthy project should aim for:
``` bash
dotnet restore
dotnet build --no-restore
dotnet test --no-build
dotnet format --verify-no-changes
```
Depending on the project, also enforce:
- analyzer warnings
- nullable warnings
- code coverage thresholds
- security scanning
- package vulnerability checks
## ai-agent rules, when generating or modifying c#:
- Read `.editorconfig` first.
- Read `Directory.Build.props` / `Directory.Build.targets` when present.
- Read existing neighboring classes before creating new patterns.
- Follow the project's target .NET/C# version.
- Preserve existing architectural boundaries.
- Prefer existing abstractions over inventing new ones.
- Search for existing helpers/services before duplicating functionality.
- Don't introduce a new NuGet package when the BCL already solves the
  problem.
- Don't introduce a design pattern without a concrete reason.
- Keep changes narrowly scoped.
- Don't refactor unrelated code.
- Preserve public API behavior unless explicitly asked to change it.
- Respect nullable reference type warnings.
- Propagate `CancellationToken` through async operations.
- Avoid blocking async code.
- Use specific exception handling.
- Don't swallow exceptions.
- Don't use =!\` merely to silence nullable warnings.
- Don't add unnecessary comments.
- Don't expose database entities unnecessarily through APIs.
- Don't put business logic into controllers/endpoints.
- Don't duplicate validation/business rules.
- Add/update tests for behavior changes.
- Run formatter/analyzers/tests after modifications when available.
- Fix warnings introduced by your changes.
- Prefer the simplest correct implementation.
## AI-Agent Decision Rules
- Before adding code:
  - Is there already a helper/service for this?
  - Does the project already use a pattern for this?
  - Does \`.editorconfig\` specify the style?
  - Is this abstraction actually needed?
  - Can the BCL solve this without a dependency?
  - Is this operation synchronous or asynchronous?
  - Can this value be null?
  - Who owns/disposes this resource?
  - Is this code executing in memory or in the database?
  - What happens when this operation fails?
  - Is cancellation supported?
  - Does this change require a test?
- Before finishing:
  - [ ] Build succeeds.
  - [ ] Tests pass.
  - [ ] No new compiler/analyzer warnings.
  - [ ] Nullable warnings addressed.
  - [ ] Formatting passes.
  - [ ] No unnecessary dependencies.
  - [ ] No unrelated refactoring.
  - [ ] Public API changes are intentional.
  - [ ] Cancellation propagated where appropriate.
  - [ ] Exceptions are handled intentionally.
  - [ ] Existing project conventions preserved.
- Quick Checklist
  - [ ] PascalCase public/type names
  - [ ] camelCase locals/parameters
  - [ ] <sub>camelCase</sub> private fields
  - [ ] I-prefixed interfaces
  - [ ] Async suffix for async methods
  - [ ] Nullable enabled
  - [ ] Small focused classes/methods
  - [ ] Guard clauses
  - [ ] Specific exceptions
  - [ ] No swallowed exceptions
  - [ ] Proper disposal
  - [ ] CancellationToken propagation
  - [ ] LINQ used for clarity
  - [ ] No unnecessary materialization
  - [ ] DTO/API boundaries intentional
  - [ ] Business logic outside controllers
  - [ ] EF Core queries efficient
  - [ ] No hardcoded secrets
  - [ ] Tests cover behavior
  - [ ] \`.editorconfig\` respected
  - [ ] Analyzers enabled
  - [ ] Formatter passes
  - [ ] Build passes
  - [ ] Tests pass
## Mental Model
``` example
Readable
-> Explicit
-> Consistent
-> Null-safe
-> Async-aware
-> Exception-safe
-> Resource-safe
-> Testable
-> Maintainable
-> Automatically checked
-> Extensible
```
