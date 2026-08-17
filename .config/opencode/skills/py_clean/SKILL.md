---
name: py_clean
description: clean code convensions in python
---

# python clean code convenstions
## Core Principles
- Readability \> cleverness.
- Simplicity \> unnecessary abstraction.
- Explicit \> implicit when it improves clarity.
- Consistency \> personal preference.
- Optimize for maintainability, not just fewer lines.
- Follow project conventions before generic style rules.
- PEP 8 is a guideline, not a law.
## Naming
- Variables/functions: `snake_case`
- Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Modules/packages: lowercase
- Internal/protected: `_leading_underscore`
- Use descriptive names: `user_count` \> `x`
- Booleans: `is_active`, `has_permission`, `can_edit`
- Avoid vague names: `data`, `thing`, `stuff`, `temp`
- Names should communicate intent.
## Functions
- One clear responsibility per function.
- Keep functions small enough to understand quickly.
- Prefer guard clauses over deep nesting.
- Avoid functions with too many parameters.
- Extract complex logic into named functions.
- Don't abstract until there is real complexity/duplication.
- Prefer readable code over artificially short code.
## Type Hints
- Type important/public function parameters.
- Type return values.
- Use modern syntax where appropriate:
``` python
def find_user(user_id: int) -> User | None:
...
```
- Use `dataclass`, `TypedDict`, Pydantic, or classes when structure
  matters.
- Don't force types where they add no useful information.
## Control Flow
- Avoid deeply nested `if` statements.
- Use early returns / guard clauses.
- Use `enumerate()` instead of manual counters.
- Use `zip()` for parallel iteration.
- Use `any()` / `all()` for expressive conditions.
- Avoid unnecessary boolean comparisons:
``` python
if is_active:
...
```
instead of:
``` python
if is_active == True:
...
```
## Comprehensions
- Use comprehensions for simple transformations/filtering.
- Don't use them for complicated logic.
- If a comprehension requires mental parsing, use a normal loop.
- Shorter != cleaner.
## Constants / Magic Values
Avoid unexplained numbers/strings:
``` python
if status == 3:
...
```
## Prefer named constants or enums:
``` python
APPROVED = 3
```
- Use enums when a fixed set of meaningful values exists.
## Comments / Documentation
- Prefer self-explanatory code.
- Comments should explain `why`, not obvious `what`.
- Explain workarounds, constraints, assumptions, and business rules.
- Use docstrings for public APIs where useful.
- Don't write comments that merely repeat the code.
## Exceptions
- Catch specific exceptions.
- Never silently swallow errors:
``` python
try:
...
except:
pass
```
- Avoid bare `except` unless there is a deliberate reason.
- Don't use exceptions when a normal condition is clearer.
- Don't hide failures.
## PEP 8 Formatting
- Indentation: 2 spaces.
- Don't use tabs for indentation.
- Keep line length consistent with project configuration.
- Separate logical sections with blank lines.
- Organize imports:
``` example
standard library
third-party
local/project
```
- Use consistent quotes and formatting.
- Let formatters enforce formatting automatically.
## Pythonic Code: Prefer standard Python idioms:
- `enumerate()`
- `zip()`
- `any()`
- `all()`
- comprehensions
- generators
- unpacking
- context managers
- `pathlib`
- f-strings
Example:
``` python
from pathlib import Path
config = Path.home() / ".config" / "app"
```
- Prefer `pathlib` over manual path-string manipulation.
## DRY / Abstraction
- Avoid meaningful duplication.
- Don't eliminate every repeated line.
- Don't create abstractions prematurely.
- Two similar pieces of code do not necessarily need a shared
  abstraction.
- Abstract when duplication causes maintenance problems.
## Testing
- Test behavior, not implementation details.
- Tests should clearly show:
  - input
  - expected behavior
  - expected result
- Test edge cases and failure cases.
- Use descriptive test names.
- Recommended: `pytest`
## Tooling
Recommended modern baseline:
- Formatter: `ruff format`
- Linter: `ruff check`
- Type checker: `pyright`
- Tests: `pytest`
- Environment/project manager: `uv`
- Git hooks: `pre-commit`
Example:
``` bash
ruff check .
ruff format .
pyright
pytest
```
- Automate repetitive quality checks.
## Project Structure / Configuration
- Prefer isolated virtual environments.
- Keep project configuration in `pyproject.toml` where appropriate.
- Make style/type/testing rules reproducible.
- Don't depend on global packages.
## Logging
- Use `print()` for simple scripts/debugging.
- Use `logging` for applications/services.
- Use appropriate log levels:
  - `debug`
  - `info`
  - `warning`
  - `error`
  - `critical`
## Avoid Overengineering: Don't introduce complexity without a reason:
- unnecessary classes
- excessive design patterns
- excessive abstraction layers
- wrappers around simple functions
- premature optimization
- excessive configuration
Rule: Solve the current problem simply; refactor when real complexity
appears.
## AI-Agent Clean Code Rules
### When generating/modifying Python:
- Preserve existing project conventions.
- Inspect surrounding code before introducing patterns.
- Prefer the simplest correct implementation.
- Don't introduce dependencies without justification.
- Don't refactor unrelated code.
- Keep changes narrowly scoped.
- Preserve existing behavior unless explicitly asked otherwise.
- Add/update tests for behavioral changes.
- Use type hints for new public APIs.
- Use descriptive names.
- Avoid magic values.
- Avoid deep nesting.
- Avoid unnecessary abstractions.
- Run formatter/linter/type-checker/tests when available.
- Never hide exceptions just to make code pass.
- Explain non-obvious decisions briefly.
- Prefer standard-library solutions when sufficient.
- Follow `pyproject.toml` and repository instructions over generic
  preferences.
### Quick Checklist
- [ ] Clear names
- [ ] Focused functions
- [ ] Shallow control flow
- [ ] Useful type hints
- [ ] No unexplained magic values
- [ ] No unnecessary duplication
- [ ] No premature abstraction
- [ ] Comments explain why
- [ ] Specific exception handling
- [ ] Pythonic idioms
- [ ] PEP 8 / project style
- [ ] Tests cover behavior
- [ ] Formatter passes
- [ ] Linter passes
- [ ] Type checker passes
- Mental Model
``` example
Readable
-> Simple
-> Explicit
-> Consistent
-> Typed where useful
-> Tested
-> Automatically checked
-> Easy to change
```
