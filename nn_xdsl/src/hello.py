import torch
import torch._dynamo as dynamo

from stardew.frontend import torch_compiler

from torch import nn


class Model(nn.Module):
    def __init__(self, input_size, hidden_sizes, output_size):
        super().__init__()
        self.model = nn.Sequential(
            nn.Linear(input_size, hidden_sizes[0]),
            nn.ReLU(),
            nn.Linear(hidden_sizes[0], hidden_sizes[1]),
            nn.ReLU(),
            nn.Linear(hidden_sizes[1], output_size),
            nn.LogSoftmax(dim=1),
        )

    def forward(self, x):
        return self.model(x)


model = Model(784, [128, 64], 10)


@dynamo.optimize(torch_compiler(output_type="affine_ir"))
def fun(x):
    return model(x)


x = torch.randn(1, 784)
fun(x)
