# **Распределенные системы**
Семестровый курс по распределенным системам для студентов 3 курса ФУПМ, МФТИ.

## **Определенный интеграл**

Задача: вычислить определенный интеграл, используя метод трапеции. 

Входные параметры:
1.Число разбиений отрезка N.

Результат работы программы: значение интеграла с точностью до 6 знаков после запятой (тип `double`). Решение в папке `integral`.


## **Одномерное уравнение теплопроводности**

Задача: решить одномерное уравнение теплопроводности при заданных граничных условиях и начальном распределении температуры f(x).

Входные параметры:
1. Момент времени Time, в который требуется узнать распределение температуры.
2. Число разбиения координаты M.

Результат работы программы — распределение температуры в стержне. Решение в папке `heatConductivity`.

### Общие требования

1. Распараллелить программу, используя среду MPI (обязательно использовать вызовы ```MPI_Send/MPI_Recv```).
2. Построить графики ускорения и эффективности для числа процессов от 1 до 28.