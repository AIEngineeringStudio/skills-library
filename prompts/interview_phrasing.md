Interview phrasing

Suggested card examples follow. These are models for expressing reasoning. The tutor should define technical terms before using the models.
Card	Interview phrasing
F01	“I would first identify the users and the business outcome. Then I would turn ‘real time’ into a measurable target. I would confirm which trade-offs the business can accept.”
F02	“I would use a context diagram to show system boundaries. A sequence diagram would show the steps in a transaction. I would record the decision, its alternatives, and when we should review it.”
D01	“I would map the administrator, employee, and finance journeys first. Then I would identify common capabilities, such as spending controls. I would keep customer-specific rules configurable where the business needs differ.”
T01	“I would define boundaries around business responsibilities and data ownership. I would separate a service when independent change or operation provides a clear benefit. I would also account for the extra coordination and failure handling.”
T02	“A timeout leaves the result uncertain. I would use a durable request identifier and confirm how each participating system handles retries. I would resolve the uncertain state before treating the operation as a failure.”
T03	“I would define the API contract around the consumer’s workflow. The contract would explain errors, retries, and access rules. I would check compatibility before introducing a change.”
T04	“If reporting can be delayed, purchases could continue during a reporting outage. I would retain the events and process them safely after recovery. I would monitor the backlog and show users how current the report is.”
T05	“I would define the authoritative source for each fact. Reports could contain delayed copies, so I would set a freshness target. Reconciliation would detect and correct missing or conflicting records.”
D02	“Authorization, settlement, and reconciliation represent different stages. I would compare the missing settlement record with the expected processing window. If it remains unresolved, I would investigate and preserve the audit trail.”
T06	“I would identify sensitive data and trust boundaries first. I would reduce the data the service handles and check access to each requested object. Each security control would address a specific threat.”
T07	“I would set reliability targets for the customer journey. Then I would examine each dependency and its failure impact. The design would define which actions can continue safely and how we prove recovery works.”
T08	“I would estimate peak demand using stated assumptions. Then I would measure where time and resources are spent. I would choose a scaling change based on the bottleneck, cost, and test results.”
T09	“I would monitor successful purchases as well as service health. A service can respond successfully while the business journey fails. Alerts should show customer impact and lead to a clear recovery action.”
T10	“I would map the deployment, network connections, and failure boundaries. For an on-premises dependency, I would examine latency and connection failures. I would choose the runtime based on reliability, cost, and team skills.”
T11	“I would review how the code behaves when requests overlap or a dependency times out. Tests should check duplicate actions and access failures. I would also define how we release, observe, and reverse the change.”
E01	“I would move one capability at a time. Each phase would have compatibility checks, reconciliation, and a rollback condition. I would retire the old path only after its consumers and data are accounted for.”
E02	“I would connect each roadmap item to a business outcome. Standards would address shared risks and integration needs. An exception would have a clear reason, owner, and review date.”
L01	“I would make the disagreement specific: the constraint, the risk, and the available options. Then I would agree on the decision owner and the evidence needed. When mentoring, I would ask the architect to explain the consequences of each choice.”
A01	“I would check the AI suggestion against the requirement and the security constraint. I would verify the evidence before adopting it. I would record accepted, rejected, and uncertain findings so the team can review the decision.”
L02	Truthful story template: “My responsibility was [actual responsibility]. I chose [actual option] because [reason]. The result was [verified outcome]. I learned [lesson], and I would now improve [specific point].”
X01	“I would first confirm the business goal and the main constraints. Then I would explain the workflow, data ownership, and failure behavior. I would close with the key trade-offs and an incremental delivery plan.”
X02	“My recommendation is [option]. It supports [business outcome] and carries [main risk]. I would validate it through [evidence or experiment] before making the next commitment.”


The reusable prompt needs explicit controls in addition to the examples:
- Starting point: “Treat me as a beginner in every topic. My years of experience are the interview target, not evidence of technical knowledge. Start teaching immediately. Do not begin with a baseline diagnostic.”
- Prerequisites: “Before each concept, list the minimum prerequisites. Teach any prerequisite I have not learned in this session or shown in the supplied progress record.”
- Order: “Use this sequence: plain definition → small example → focused diagram or code when useful → comprehension question → correction → application → trade-off → interview phrasing.”
- Comprehension questions: “Ask one question at a time after teaching. Use my answer to decide whether to repeat, simplify, or advance. Do not interpret silence or recognition of a term as understanding.”
- Language: “Use short sentences, short sections, bullets, labeled steps, and small tables. Define each technical term and expand each abbreviation on first use in this session.”
- Pacing: “Teach one small concept at a time. Begin with understanding. Add senior interview challenges after I can explain the basic mechanism.”
- Interview language: “Add an Interview phrasing section after each major concept, worked answer, and answer correction where it helps. Give a short, natural model answer. Then ask me to express the same idea in my own words. Separate hypothetical recommendations from claims about my actual experience.”
- Stack: “Use Python, uv, React JavaScript without TypeScript, PyCharm, and python-dotenv with .env files. Do not ask me to select the stack again. Explain why an additional tool is necessary before introducing it.”
- Portability: “Prefer one command for Apple Silicon and Intel Macs. Give labeled variants only when needed. After a PyCharm Professional-only feature, immediately provide the Community terminal fallback.”
- Progress evidence: “Record concepts taught, terms introduced, what I demonstrated, and the next prerequisite. A score is based on my demonstrated answers after teaching.”
- Time expectations: The eight-week route should remain a flexible route. Starting from basics can require several sessions per card. Completing the calendar alone should not imply interview readiness.
For independent sessions, each card should also repeat a compact reminder: “Beginner starting point. Teach prerequisites first. Define terms. Use the default stack. Include interview phrasing. Assess after teaching.” This protects the instructions if the learner copies a card without the full reusable prompt.
