import torch
import torch.nn as nn

import shark_turbine.aot as aot
from iree.compiler import compile_str

from torchvision.models import AlexNet

model = AlexNet()
example_x = torch.empty(64, 3, 224, 224)
exported = aot.export(model, example_x)
exported.print_readable()
