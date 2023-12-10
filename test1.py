from matplotlib import pyplot as plt
from qiskit import QuantumCircuit, BasicAer, transpile
from qiskit.visualization import plot_histogram, plot_bloch_multivector
from numpy.random import randint
import numpy as np

def encode_message(bits, bases):
    print("bits pe kya hai ",bits)
    message = []
    for i in range(len(bits)):
        qc = QuantumCircuit(1,1)
        if bases[i] == 0: # Prepare qubit in Z-basis
            if bits[i] == 0:
                pass 
            else:
                qc.x(0)
        else: # Prepare qubit in X-basis
            if bits[i] == 0:
                qc.h(0)
            else:
                qc.x(0)
                qc.h(0)
        qc.barrier()
        message.append(qc)
    return message
def convert_string_to_binary_array(string):
    binary_array = []
    test=""
    for char in string:
        ascii_code = ord(char)
        binary_string = format(ascii_code, '08b')
        test+=binary_string
    #binary_array.append(binary_value)
    return list(test)
def measure_message(message, bases):
    backend = BasicAer.get_backend('qasm_simulator')
    measurements = []
    for q in range(n):
        if bases[q] == 0: # measuring in Z-basis
            message[q].measure(0,0)
        if bases[q] == 1: # measuring in X-basis
            message[q].h(0)
            message[q].measure(0,0)
        aer_sim = BasicAer.get_backend('qasm_simulator')
        result = aer_sim.run(message[q], shots=100, memory=True).result()
        measured_bit = int(result.get_memory()[0])
        measurements.append(measured_bit)
    return measurements

def remove_garbage(a_bases, b_bases, bits):
    good_bits = []
    for q in range(n):
        if a_bases[q] == b_bases[q]:
            # If both used the same basis, add
            # this to the list of 'good' bits
            good_bits.append(bits[q])
    return good_bits

def sample_bits(bits, selection):
    sample = []
    for i in selection:
        # use np.mod to make sure the
        # bit we sample is always in 
        # the list range
        i = np.mod(i, len(bits))
        # pop(i) removes the element of the
        # list at index 'i'
        sample.append(bits.pop(i))
    return sample

np.random.seed(seed=0)
bits=convert_string_to_binary_array("hey hi hello ")
n = len(bits)
## Step 1
# Alice generates bits
alice_bits = randint(2, size=n)
alice_bases = randint(2, size=n)

print('bit = %i' % alice_bits[0])
print("donno ko ",alice_bits,bits)
print('basis = %i' % alice_bases[0])
message = encode_message(bits, alice_bases) # gives encoder to encrypt real data 

#eve_bases = randint(2, size=n)
#intercepted_message = measure_message(message, eve_bases)
#print(intercepted_message)
#bob_key = remove_garbage(alice_bases, eve_bases, intercepted_message)
bob_bases = randint(2, size=n)
bob_results = measure_message(message, bob_bases)


alice_key = remove_garbage(alice_bases, bob_bases, bits)
bob_key = remove_garbage(alice_bases, bob_bases, bob_results)

sample_size = 15
bit_selection = randint(n, size=sample_size)

bob_sample = sample_bits(bob_key, bit_selection)
print("  bob_sample = " + str(bob_sample))
alice_sample = sample_bits(alice_key, bit_selection)
print("alice_sample = "+ str(alice_sample))

print(bob_sample == alice_sample)