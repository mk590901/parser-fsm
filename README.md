# # Parser-FSM

The application demonstrates the work of a lexical parser based on a finite (flat) state machine.

## Introduction
A __finite state machine__ allows one to simplify the number of operations on text during lexical parsing of an arithmetic expression and replace the logic of lexeme detection by transitions from state to state under the action of events.

## State Machine
Below is the parser's finite (flat) state machine. It is somewhat redundant, but fairly accurately reflects the processing of all possible variants of the lexemes encountered.

![Uploading parser_fsm_2.svg…]()
