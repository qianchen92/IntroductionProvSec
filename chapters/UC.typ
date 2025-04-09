#import "/template.typ": *
#import "/commands/commands.typ": *
= Universally Composable security

We will discuss the UC framework, which is a powerful and widely used framework for analyzing the security of cryptographic protocols proposed by Canetti @FOCS:Canetti01@JACM:Canetti20. The UC framework provides a formal definition of security that captures the idea of universal composability, meaning that a protocol is secure if it remains secure even when composed with other protocols.

== Definition of UC framework
#definition(name: "Universally Composable")[
    We define the following components for the UC framework:
    - $protocol$: A protocol is a computer program (or several programs), intended to be executed by a number of communicating computational entities (or $party$).
    - $party$: A party is a computational entity that executes the protocol. Each party has its own local state, making its own random choices and can communicate with other parties.
    //- $env$: The environment is a probabilistic polynomial-time ($ppt$) machine that interacts with the protocol and can simulate the behavior of the adversary.
    - $adv$: The adversary is an entity that can control some subset of parties and in addition has some control over the communication network.
    - $env$: The environment machine represents what ever is external to the current protocol execution. It interacts with the protocol execution twice,
        + Before the protocol stars, the environment hands arbitrary inputs of its choosing to the parties and to the adversary.
        + After the protocol's termination, the environment collects the outputs from the parties and the adversary.
        The environment machine returns a single bit, which indicates whether it thinks interacting with the protocol or with the ideal process.

]





