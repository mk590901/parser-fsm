# Parser-FSM

The application demonstrates the work of a lexical parser based on a finite (flat) state machine.

## Introduction
A __finite state machine__ allows one to simplify the number of operations on text during lexical parsing of an arithmetic expression and replace the logic of lexeme detection by transitions from state to state under the action of events.

## State Machine
Below is the parser's finite (flat) state machine. It is somewhat redundant, but fairly accurately reflects the processing of all possible variants of the lexemes encountered.

![fsm](https://github.com/user-attachments/assets/059f9911-25ff-4229-a4dc-2fd8338f5797)

## Implementation
The set of classes consists of event classes, a basic state machine, and a transition matrix in the __ParserStateMachine__ class. The transition functions reference functions in the __ParserController__ object perform the splitting of the string into tokens. A reference to the parser is passed to the event, which allows isolate data processing from the transition entity. The result of the processing is a Tokens container containing the tokens of the original arithmetic expression.

## Description of application
The application is a Flutter app with a predefined set of arithmetic expressions. They can be selected using a combo box and parsed by pressing the parse button. The result of parsing is a list of tokens indicating the type and classification.

## Note
Note. The two applications Parser HSM (https://github.com/mk590901/parser-hsm/) and Parser FSM are made in the same style and from the GUI point of view are twin brothers. That is, they completely coincide except for the engine used. In fact, the main goal of these projects was the idea to show that the same tasks can be solved with both FSM and HSM. What exactly to choose is a matter of taste and sympathy of the developer.

## Movie

https://github.com/user-attachments/assets/67ff5a97-2593-426b-80a5-be57ce663b3b



