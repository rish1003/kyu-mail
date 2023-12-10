from rest_framework.response import Response
from .models import *
from .serializers import *
from rest_framework.decorators import api_view
import io
from django.views.decorators.csrf import csrf_exempt
from matplotlib import pyplot as plt
from qiskit import QuantumCircuit, BasicAer, transpile
from qiskit.visualization import plot_histogram, plot_bloch_multivector
from numpy.random import randint
import numpy as np
n=100
def encode_message(bits, bases):
    message=[]
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
def convert_string_to_binary_array(string):
  binary_array = []
  for char in string:
    ascii_code = ord(char)
    binary_string = format(ascii_code, '08b')
    binary_array.append(binary_string)
  return binary_array
@api_view(["POST"])
@csrf_exempt
def enc_stage2(request):
    m=request.data["m"]

    alice_bases = randint(2, size=n)
    message =convert_string_to_binary_array(m)
    enm=encode_message(message,alice_bases)
    return Response(str(enm))








