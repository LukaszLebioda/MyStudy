# Max/basic-ai-workflow

```bash
cd "/Users/llebioda/Desktop/Private/MyStudy/Agentic AI/Max/basic-ai-workflow"
source .venv/bin/activate
python main.py --text "some text"   # run the workflow
python -m pytest                    # run tests
deactivate
```

Dependencies (`openai`, `pytest`) are already installed. Reinstall after
recreating the venv: `python -m pip install -e . pytest`.

# Rahul/deepeval-agent-demo

```bash
cd "/Users/llebioda/Desktop/Private/MyStudy/Agentic AI/Rahul/deepeval-agent-demo"
source .venv/bin/activate
python -m pip install -r requirements.txt
python agent_instrumented.py        # run the agent
python test_agent.py                # run the evaluation
deactivate
```

Needs `ANTHROPIC_API_KEY` and `OPENAI_API_KEY` set (see `.env.example`);
`deepeval login` is optional for the Confident AI dashboard.
