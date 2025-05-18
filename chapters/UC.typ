//#import "/template.typ": *
#import "/commands/commands.typ": *
= Universally Composable Security

This chapter discusses the UC framework, a powerful and widely adopted framework for analyzing the security of cryptographic protocols, proposed by Canetti @FOCS:Canetti01@JACM:Canetti20. The UC framework provides a formal definition of security that captures the concept of universal composability. A protocol is considered secure under this framework if it remains secure even when composed with other protocols.

== Definition of the UC Framework (Simplified Version)
Before giving the definition of the $UC$ framework, we need to introduce some notations.
=== Machines. 
A machine in $UC$ model is a triple $Machine = (ID, ComSet, Program)$ where $ID$ is the machine's identity, $ComSet$ is the communication set, and $Program$ is the program of the machine.
==== Identity.
The identity of a machine is a unique identifier that distinguishes it from other machines. It can be any string or number that is unique within the context of the protocol.
==== Communication.
Every machine is interacting with other machine through a communication channel with three different types of messages.
- The $input$ is a message from the caller machine to the subroutine machine. It is a request for the subroutine to perform some computation or action.
- The $subOut$ is a message received from the $subroutine$. Basically, it is a result of a call to the $subroutine$.
- The $backdoor$ is a special message coming from the adversary.

In a normal execution, the $env$ first send $input$ to some machines of the protocol, then the machines will send $input$ to its subroutines, and the subroutines will send $subOut$ back to the machines, and finally the machines will send $subOut$ back to the $env$. The $backdoor$ message is used by the adversary to control the execution of the protocol. The adversary can send $backdoor$ messages to any machine in the protocol, and these messages can be used to manipulate the behavior of the protocol. 
==== Communication Set. 
The communication set of a machine is the set of all possible machines that it can communicate with. There are two types of entities in the communication set:
- The $caller$ is the machine that invokes the $subroutine$. It is the machine that sends the $input$ message to the $subroutine$.
- The $subroutine$ is the machine that is being invoked. It is the machine that receives the $input$ message from the $caller$ and sends the $subOut$ message back to the $caller$.
Moreover, we also define the $subsidiary$ as the machine that is invoked by the $subroutine$. The $subsidiary$ is a machine that is called by the $subroutine$ to perform some computation or action. The $subsidiary$ can also send messages back to the $subroutine$, which will then send the messages back to the $caller$.

=== Protocol.
A protocol is a set of machines that interact with each other to achieve a common goal. The protocol $Protocol = (Machine_1, dots.h, Machine_NumMachines)$ is defined by the set of machines that are involved in the protocol. We require that the machines $Machine_1, dots.h, Machine_NumMachines$ satisfy the following requirements:
- If $Protocol$ contains a machine $Machine_i = (ID_i, ComSet_i, Program_i)$ that is a caller of the identity $ID_j$ (namely $(input, ID_j) in ComSet_i$), then $(input, ID_i)$ must be in the communication set of $Machine_j$. This can be interpreted as $ forall Machine_i, Machine_j in Protocol. (input, ID_j) in ComSet_i => (subroutine, ID_i) in ComSet_j $
- If $Protocol$ contains a machine $Machine_j = (ID_j, ComSet_j, Program_j)$ that is a subroutine of the identity $ID_i$ (namely $(subroutine, ID_j) in ComSet_i$), then $(subroutine, ID_j)$ must be in the communication set of $Machine_i$. This can be interpreted as $ forall Machine_j in Protocol. forall Machine_i. (subroutine, ID_j) in ComSet_i => (input, ID_i) in ComSet_j. $ If $ID_i$ is not an identity of any machine in $Protocol$, we say that $Machine_j$ is a main machine of $Protocol$, and $ID_i$ is an external identity of $Machine_i$ with respect to $Protocol$. If machine $Machine in Protocol$ is not a main machine, we say that $Machine$ is an internal machine of $Protocol$.

For multi-party protocol with $NumParties$ parties, we can translate it into $NumParties$ main machines, and several other internal machines.

== Security
To formally define the $UC$ security, we need to introduce the following notions:
- Execution within an environment
- Protocol emulation
- Ideal protocol

=== Protocol execution and emulation
When we execute a protocol $Protocol$, there are three different types of machines involved:
- Protocol machines $(Machine_1, dots.h, Machine_NumMachines)$: including all machines involved in the protocol. Their identity are different from $0$ or $1$.
- Adversary machine $Adv$: the machine that is trying to break the security of the protocol. The adversary can be any machine that is not part of the protocol, and it can interact with the protocol machines in any way it wants. The adversary has identity $1$, and its communication set allows it to provide inputs to the protocol machines and receive outputs from them. The adversary can also send $backdoor$ messages to the protocol machines, which can be used to manipulate the behavior of the protocol.
- Environment machine $Env$: the machine that is responsible for setting up the protocol and interacting with the adversary. The environment can be any machine that is not part of the protocol, and it can interact with the protocol machines and the adversary in any way it wants. $Env$ has identity $0$, and its communication set allows it to provide inputs to $Adv$ and the main machines of $Protocol$.

#definition[
    In the $UC$ framework, an execution of a protocol is modeled as an interaction between three entities: $(protocol, adv, env)$ in the real world, and $(idealf, sim, env)$ in the ideal world. To prove the $UC$ security of a protocol, we need to show that the $env$ cannot decide whether it is interacting with the real world or the ideal world. Therefore, we need to build the simulator $sim$ that simulates the behavior of an adversary.
]
== UC vs. Simulation-Based Security

In the simulation-based security model, a similar approach is employed to define an ideal functionality that is assumed to be secure. Subsequently, a simulator is constructed to interact with the ideal functionality.





