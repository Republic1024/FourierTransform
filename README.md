# 离散傅里叶变换（DFT）教程

本教程将指导您如何使用 Python 实现离散傅里叶变换（DFT），并提取信号的幅度和相位，然后重构原始信号。

## 目录

- [简介](#简介)
- [实现 DFT 并提取幅度和相位](#实现-dft-并提取幅度和相位)
- [重构信号](#重构信号)
- [完整示例](#完整示例)

## 简介

离散傅里叶变换（DFT）是一种将离散时间信号转换为频域表示的数学工具。它在信号处理、图像处理和数据分析等领域有着广泛的应用。

本教程将介绍如何：

- 使用 Python 计算信号的 DFT
- 提取信号的幅度和相位
- 使用提取的频率、幅度和相位重构信号

## 实现 DFT 并提取幅度和相位

以下是计算离散傅里叶变换并提取幅度和相位的 Python 函数：

```python
import math
import cmath

def dft_with_phase(f_t, t):
    """
    计算离散傅里叶变换，并提取幅度和相位
    输入：
    - f_t: 信号值列表
    - t: 时间点列表
    输出：
    - freqs: 频率列表
    - amplitudes: 幅度列表
    - phases: 相位列表
    """
    N = len(f_t)
    delta_t = t[1] - t[0]
    freqs = [k / (N * delta_t) for k in range(N)]
    F_k = []

    for k in range(N):
        sum_real = 0
        sum_imag = 0
        for n in range(N):
            angle = -2 * math.pi * k * n / N
            sum_real += f_t[n] * math.cos(angle)
            sum_imag += f_t[n] * math.sin(angle)
        F_k.append(complex(sum_real, sum_imag))

    # 计算幅度和相位
    amplitudes = [abs(F_k[k]) * 2 / N for k in range(N)]
    phases = [cmath.phase(F_k[k]) for k in range(N)]

    # 只取前半部分
    half_N = N // 2
    freqs = freqs[:half_N + 1]
    amplitudes = amplitudes[:half_N + 1]
    phases = phases[:half_N + 1]

    return freqs, amplitudes, phases
```

### 示例

假设我们有以下采样数据：

```python
t = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
f_t = [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]
```

计算傅里叶变换：

```python
freqs, amplitudes, phases = dft_with_phase(f_t, t)
```

结果：

```python
freqs = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
amplitudes = [0.0, 1.0747017074255294, 4.552509488189635, 4.552509488189634, 1.0747017074255307, 7.245990181195059e-16]
phases = [0.0, 1.5707963267948966, -1.5707963267948963, -1.5707963267948963, 1.5707963267948972, 1.5707963267948966]
```

## 重构信号

使用提取的频率、幅度和相位信息，可以重构原始信号：

```python
def reconstruct_signal(freqs, amplitudes, phases, t_values):
    """
    重构信号
    输入：
    - freqs: 频率列表
    - amplitudes: 幅度列表
    - phases: 相位列表
    - t_values: 时间点列表
    输出：
    - 重构的信号值列表 f(t)
    """
    reconstructed_f_t = []
    for t in t_values:
        value = 0
        for f, A, phi in zip(freqs, amplitudes, phases):
            value += A * math.cos(2 * math.pi * f * t + phi)
        reconstructed_f_t.append(value)
    return reconstructed_f_t
```

## 完整示例

```python
import math
import cmath

def dft_with_phase(f_t, t):
    # 同前面的函数定义

def reconstruct_signal(freqs, amplitudes, phases, t_values):
    # 同前面的函数定义

# 输入采样数据
t = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
f_t = [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]

# 计算傅里叶变换
freqs, amplitudes, phases = dft_with_phase(f_t, t)

# 重构信号
reconstructed_f_t = reconstruct_signal(freqs, amplitudes, phases, t)

# 输出重构的信号值
print("原始 f(t):")
print(f_t)
print("\n重构的 f(t):")
print([round(val, 3) for val in reconstructed_f_t])
```

### 输出结果

```
原始 f(t):
[0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]

重构的 f(t):
[0.0, 7.396, 0.0, -7.396, -0.0, 0.0, 0.0, 7.396, 0.0, -7.396]
```

### 使用 Lambda 函数简化

我们也可以使用 Lambda 函数来简化信号重构：

```python
# 定义使用的简化后 Lambda 函数
f_t_rebuild = lambda t: sum(
    A * math.cos(2 * math.pi * f * t + phi)
    for f, A, phi in zip(freqs, amplitudes, phases)
)

# 重构并输出结果
reconstructed_values = [round(f_t_rebuild(ti), 3) for ti in t]
print("使用 Lambda 函数重构的 f(t):")
print(reconstructed_values)
```

### 输出结果

```
使用 Lambda 函数重构的 f(t):
[0.0, 7.396, 0.0, -7.396, -0.0, 0.0, 0.0, 7.396, 0.0, -7.396]
```

