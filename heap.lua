local function heapify(arr, n, i, d)
	local maior = i

	for k = 1, d do
		local filho_k = d * (i - 1) + k + 1

		if filho_k <= n and arr[filho_k] > arr[maior] then
			maior = filho_k
		end
	end

	if maior ~= i then
		arr[i], arr[maior] = arr[maior], arr[i]
		heapify(arr, n, maior, d)
	end
end

local function heapSort(arr, d)
	if d <= 0 then
		error("d precisa ser maior que 0", 1)
	end

	local n = #arr
	local ultimo_nao_folha = math.floor((n - 2) / d) + 1

	for i = ultimo_nao_folha, 1, -1 do
		heapify(arr, n, i, d)
	end

	for i = n, 2, -1 do
		arr[1], arr[i] = arr[i], arr[1]
		heapify(arr, i - 1, 1, d)
	end
end

-- Exemplo de uso
local a = { 12, 12, 12, 124, 10, 3, 5, 1, 8, 7, 2, 9, 6 }
local d = 2

print("Antes: ")
print(table.concat(a, ", "))
heapSort(a, d)
print("Depois: ")
print(table.concat(a, ", "))
