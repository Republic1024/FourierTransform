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
        #     print(k, sum_real, sum_imag)
        # print("-------------------------")  
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


# 输入采样数据
t = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
f_t = [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]
dft_with_phase(f_t, t)
```




    ([0.0, 1.0, 2.0, 3.0, 4.0, 5.0],
     [0.0,
      1.0747017074255294,
      4.552509488189635,
      4.552509488189634,
      1.0747017074255307,
      7.245990181195059e-16],
     [0.0,
      1.5707963267948966,
      -1.5707963267948963,
      -1.5707963267948963,
      1.5707963267948972,
      1.5707963267948966])




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
            # print(f, A, phi)
        reconstructed_f_t.append(value)
    return reconstructed_f_t

# def
```


```python
# 输入采样数据
t = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
f_t = [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]

# 计算傅里叶变换
freqs, amplitudes, phases = dft_with_phase(f_t, t)
# print(freqs, amplitudes, phases)
# 重构信号
reconstructed_f_t = reconstruct_signal(freqs, amplitudes, phases, [0.1 * i for i in range(10)])

# 输出重构的信号值
print("原始 f(t):")
print(f_t)
print("\n重构的 f(t):")
print([round(val, 3) for val in reconstructed_f_t])

```

    原始 f(t):
    [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396]
    
    重构的 f(t):
    [0.0, 7.396, 0.0, -7.396, -0.0, 0.0, 0.0, 7.396, 0.0, -7.396]
    


```python

# 定义使用的简化后 Lambda 函数
f_t_rebuild = lambda t: sum(
    A * math.cos(2 * math.pi * f * t + phi)
    for f, A, phi in zip(freqs, amplitudes, phases)
)

[round(f_t_rebuild(t * 1.0 / 10), 3) for t in range(10)], f_t
```




    ([0.0, 7.396, 0.0, -7.396, -0.0, 0.0, 0.0, 7.396, 0.0, -7.396],
     [0, 7.396, 0, -7.396, 0, 0, 0, 7.396, 0, -7.396])




```python
# Python 脚本来生成等效的 Windows CMD 命令，并将它们打印出来
import os

# 获取当前文件夹名
current_directory = os.getcwd()
folder_name = os.path.basename(current_directory)

# 要执行的CMD命令
cmd_commands = [
    f':: 获取当前文件夹名\nfor %I in ("%cd%") do set "folder_name={folder_name}"',
    f':: 使用当前文件夹名创建一个新的 GitHub 仓库\ngh repo create "{folder_name}" --public',
    ':: 初始化一个新的 Git 仓库\ngit init',
    f':: 将远程仓库添加为 origin\ngit remote add origin https://github.com/Republic1024/{folder_name}.git',
    ':: 从远程仓库的 main 分支拉取最新代码\ngit pull origin main',
    ':: 移除未跟踪的文件，例如 .DS_Store（Mac 系统生成的隐藏文件）\ndel /F /Q .DS_Store',
    ':: 将所有更改添加到暂存区，排除 .pth 文件\ngit add .',
    ':: 提交暂存区的更改并添加提交信息\ngit commit -m "Initial commit or merge or rebase remote changes"',
    ':: 将本地的 main 分支变基到远程 main 分支的最新提交\ngit branch -M main',
    ':: 将本地 main 分支的更改推送到远程 main 分支\ngit push -u origin main'
]
# git remote add origin https://github.com/Republic1024/Colorization.git
# git branch -M main
# git push -u origin main
# 打印命令
cmd_output = "\n\n".join(cmd_commands)
print(cmd_output)
```

    :: 获取当前文件夹名
    for %I in ("%cd%") do set "folder_name=FourierTransform"
    
    :: 使用当前文件夹名创建一个新的 GitHub 仓库
    gh repo create "FourierTransform" --public
    
    :: 初始化一个新的 Git 仓库
    git init
    
    :: 将远程仓库添加为 origin
    git remote add origin https://github.com/Republic1024/FourierTransform.git
    
    :: 从远程仓库的 main 分支拉取最新代码
    git pull origin main
    
    :: 移除未跟踪的文件，例如 .DS_Store（Mac 系统生成的隐藏文件）
    del /F /Q .DS_Store
    
    :: 将所有更改添加到暂存区，排除 .pth 文件
    git add .
    
    :: 提交暂存区的更改并添加提交信息
    git commit -m "Initial commit or merge or rebase remote changes"
    
    :: 将本地的 main 分支变基到远程 main 分支的最新提交
    git branch -M main
    
    :: 将本地 main 分支的更改推送到远程 main 分支
    git push -u origin main
    


```python
!jupyter nbconvert --to markdown main.ipynb
```

    [NbConvertApp] Converting notebook main.ipynb to markdown
    [NbConvertApp] Writing 4892 bytes to main.md
    
