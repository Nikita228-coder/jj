## Общие функции
# Поменять местами строки
function swaprows(A::Array{Int64,2},row::Int64,row2::Int64)
   for j = 1:size(A)[end]
      r = A[row,j]
      A[row,j] = A[row2,j]
      A[row2,j] = r
   end
   return A
end

#Поменять местами столбцы
function swapcols(A::Array{Int64,2},col::Int64,col2::Int64)
   for i = 1:size(A)[1]
      c = A[i,col]
      A[i,col] = A[i,col2]
      A[i,col2] = c
   end
   return A
end

#Поиск элемента с указанным или отличным значением, возвращает координаты этого элемента
function search(sr::Int64,A::Array{Int64,2},startr::Int64,startc::Int64,same::Bool)
   for i = startr+1:size(A)[1], j = startc+1:size(A)[end]
      if (same == true)
         if (A[i,j] == sr)
            return (i,j)
         end
      else
         if (A[i,j] != sr)
            return (i,j)
         end
      end
   end
   return 0
end

## Транспонирование
function trans(A::Array{Int64,2})
   S = Array{Int64,2}(undef,size(A)[1],size(A)[end])
   for i=1:size(A)[end]
      for j=1:size(A)[1]
         S[j,i] = A[i,j]
      end
   end
   return S
end

## Умножение
function mul(A::Array{Int64,2},B::Array{Int64,2})
   @assert size(A)[end] == size(B)[1] "The number of columns of the first matrix should be equal to the number of rows of the second"
   S = Array{Int64,2}(undef,size(A)[1],size(B)[end])
   for i = 1:size(A)[1], j = 1:size(B)[end]
      S[i,j] = 0
      for k = 1:size(A)[end]
         S[i,j] += a[i,k] * b[k,j]
      end
   end
   return S
end

## Определитель
# Функция получения матрицы без i-ой строки и j-ого столбца
function dethelp(A::Array{Int64,2},str::Int64,stlb::Int64)
   S = Array{Int64,2}(undef,size(A)[1]-1,size(A)[end]-1)
   di=0
   for i = 1:size(A)[1]-1
      if (i == str)
         di = 1
      end
      dj = 0
      for j = 1:size(A)[1] - 1
         if (j == stlb)
            dj = 1
         end
          S[i,j] = A[i + di ,j + dj];
      end
   end
   return S
end

# Рекурсивная функция определителя
function det(A::Array{Int64,2})
   @assert size(A)[end] == size(A)[1] "gag"
   d = 0
   k = 1
   if (size(A)[end] == 1)
      d=A[1,1]
      return d
   end
   if (size(A)[end] == 2)
      d = A[1,1] * A[2,2] - A[2,1] * A[1,2]
      return d
   end
   if (size(A)[end] > 2)
      for i = 1:size(A)[1]
         S = dethelp(A,i,1)
         d = d + k * A[i,1] * det(S)
         k = -k
      end
   end
   return d
end

## След
function tr(A::Array{Int64,2})
   @assert size(A)[end] == size(A)[1] "Kv"
   t = 0
   for i = 1:size(A)[1]
      t += A[i,i]
   end
   return t
end

##Ранг
function rang(A::Array{Int64,2})
   iter = min(size(A)[end],size(A)[1])
   for i = 1:iter
      if (A[i,i] == 0)
         check = search(0,A,i,i,false)
         if (!(typeof((1,1))==typeof(check)))
            break
         end
         if (i != check[1])
            swaprows(A,i,check[1])
         end
         if (i != check[2])
            swapcols(A,i,check[2])
         end
      end
      tmp=A[i,i]
      for x = i:size(A)[end]
         A[i,x] = div(A[i,x],tmp)
      end
      for y = (i+1):size(A)[1]
         tmp = A[y,i]
         for x = i:size(A)[end]
            A[y,x] -= (A[i,x] * tmp)
         end
      end
      for x = (i+1):size(A)[end]
         tmp = A[i,x]
         for y = i:size(A)[1]
            A[y,x] -= (A[y,i] * tmp)
         end
      end
   end
   cnt = 0
   for i = 1:iter
      if (A[i,i] == 0)
         break
      else
         cnt += 1
      end
   end
   if (cnt == 0)
      cnt += 1
   end
   return cnt
end

##Сложение матриц
function plus(A::Array{Int64,2},B::Array{Int64,2})
   @assert (size(A)[end] == size(B)[end]) || (size(A)[1] == size(B)[1]) "Kv"
   S = Array{Int64,2}(undef,size(A)[1],size(A)[end])
   for i = 1:size(A)[1], j = 1:size(A)[end]
      S[i,j] = A[i,j] + B[i,j]
   end
   return S
end

##Разность матриц
function minus(A::Array{Int64,2},B::Array{Int64,2})
   @assert (size(A)[end] == size(B)[end]) || (size(A)[1] == size(B)[1]) "Kv"
   S = Array{Int64,2}(undef,size(A)[1],size(A)[end])
   for i = 1:size(A)[1], j = 1:size(A)[end]
      S[i,j] = A[i,j] - B[i,j]
   end
   return S
end

##Обращение
function obr(A::Array{Int64,2})
   @assert size(A)[end] == size(A)[1] "Kv"
   @assert det(A) != 0 "det = 0"
   B = A
   S = zeros(size(A)[1],size(A)[1])
   for i = 1:size(A)[1]
      S[i,i] = 1
   end
   for k = 1:size(A)[1]
      tmp = A[k,k]
      for j = 1:size(A)[1]
         A[k,j] = A[k,j]/tmp
         S[k,j] = S[k,j]/tmp
      end
      for i = k + 1:size(A)[1]
         tmp = A[i,k]
         for j = 1:size(A)[1]
            A[i,j] -= A[k,j] * tmp;
            S[i,j] -= S[k,j] * tmp;
         end
      end
   end
   k = size(A)[1] - 1
   while (k > 1)
      while (i >= 1)
         tmp = A[i,k]
         for j=1:size(A)[1]
            A[i,j] -= A[k,j] * tmp;
            S[i,j] -= S[k,j] * tmp;
            println("A[",i,j,"]=",A[i,j])
            println("S[",i,j,"]=",S[i,j])
         end
         i -= 1
      end
      k -= 1
   end
   return S
end
b = [2 4; 1 4]
print(obr(b))
