import pandas as pd


def get_funnel_progress(session, funnel_steps):
    events = session['PageType'].tolist()

    reached_steps = []
    current_position = 0

    for event in events:
        if current_position < len(funnel_steps) and event == funnel_steps[current_position]:
            reached_steps.append(event)
            current_position += 1

    return reached_steps


def build_funnel_table(session_progress, funnel_steps):
    funnel_counts = {}

    for step in funnel_steps:
        funnel_counts[step] = session_progress.apply(
            lambda x: step in x
        ).sum()

    funnel_table = pd.DataFrame({
        'step': funnel_steps,
        'sessions': [funnel_counts[step] for step in funnel_steps]
    })

    funnel_table['step_conversion'] = (
        funnel_table['sessions'] / funnel_table['sessions'].shift(1)
    )

    funnel_table['drop_off'] = 1 - funnel_table['step_conversion']

    funnel_table.loc[0, 'step_conversion'] = 1
    funnel_table.loc[0, 'drop_off'] = 0

    return funnel_table