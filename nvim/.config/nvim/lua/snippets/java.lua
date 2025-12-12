local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {

	-- Snippet: Método Java
	s(
		"m",
		fmt(
			[[ 
public {} {}({}) {{
    {}
}}
]],
			{ i(1, "void"), i(2, "methodName"), i(3), i(4) }
		)
	),

	-- Snippet: Logger SLF4J
	s(
		"log",
		fmt([[private static final Logger log = LoggerFactory.getLogger({}.class);]], {
			i(1, "ClassName"),
		})
	),

	-- Snippet: For clássico
	s(
		"fori",
		fmt(
			[[ 
for (int {} = 0; {} < {}; {}++) {{
    {}
}}
]],
			{ i(1, "i"), i(1), i(2, "n"), i(1), i(3) }
		)
	),

	-- Snippet: For-each
	s(
		"fore",
		fmt(
			[[ 
for ({} {} : {}) {{
    {}
}}
]],
			{ i(1, "Type"), i(2, "item"), i(3, "collection"), i(4) }
		)
	),

	-- Snippet: Try/Catch
	s(
		"try",
		fmt(
			[[ 
try {{
    {}
}} catch ({} {}) {{
    {}
}}
]],
			{ i(1), i(2, "Exception"), i(3, "e"), i(4) }
		)
	),

	-- Snippet: Teste JUnit
	s(
		"test",
		fmt(
			[[ 
@Test
void {}() {{
    {}
}}
]],
			{ i(1, "shouldDoSomething"), i(2) }
		)
	),

	-- Snippet: Record Java
	s("rec", fmt([[public record {}({}) {{}}]], { i(1, "Name"), i(2, "fields") })),

	-- Snippet: Optional.orElseThrow
	s(
		"oet",
		fmt([[Optional.ofNullable({}).orElseThrow(() -> new {}());]], {
			i(1),
			i(2, "RuntimeException"),
		})
	),

	-- Snippet: Spring @RestController
	s(
		"rest",
		fmt(
			[[ 
@RestController
@RequestMapping("{}")
public class {} {{

    {}
}}
]],
			{ i(1, "/path"), i(2, "ControllerName"), i(3) }
		)
	),

	-- Snippet: Spring @GetMapping
	s(
		"getm",
		fmt(
			[[ 
@GetMapping("{}")
public {} {}() {{
    {}
}}
]],
			{ i(1, "/path"), i(2, "ReturnType"), i(3, "methodName"), i(4) }
		)
	),

	-- Snippet: Spring @PostMapping
	s(
		"postm",
		fmt(
			[[ 
@PostMapping("{}")
public {} {}(@RequestBody {}) {{
    {}
}}
]],
			{ i(1, "/path"), i(2, "ReturnType"), i(3, "methodName"), i(4, "RequestDto"), i(5) }
		)
	),

	-- Snippet: JPA @Entity
	s(
		"entity",
		fmt(
			[[ 
@Entity
@Table(name = "{}")
public class {} {{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    {}
}}
]],
			{ i(1, "table_name"), i(2, "EntityName"), i(3) }
		)
	),

	-- Snippet: JPA Repository
	s(
		"repo",
		fmt(
			[[ 
public interface {} extends JpaRepository<{}, Long> {{}}
]],
			{ i(1, "EntityRepository"), i(2, "Entity") }
		)
	),

	-- Snippet: Mockito @Mock e @InjectMocks
	s(
		"mock",
		fmt(
			[[ 
@Mock
private {} {};

@InjectMocks
private {} {};
]],
			{ i(1, "Type"), i(2, "mockName"), i(3, "Type"), i(4, "service") }
		)
	),

	-- Snippet: JUnit + Mockito test padrão
	s(
		"mtest",
		fmt(
			[[ 
@Test
void {}() {{
    // arrange
    {}

    // act
    {}

    // assert
    {}
}}
]],
			{ i(1, "shouldDoSomething"), i(2), i(3), i(4) }
		)
	),

	-- Snippet: Lombok Logger
	s(
		"lomboklog",
		fmt(
			[[ 
private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger({}.class);
]],
			{ i(1, "ClassName") }
		)
	),
}
