local function quicksort_k_pivos(a, k, lo, hi)
	if k <= 0 then
		error("k precisa ser maior que 0", 1)
	end

	lo = lo or 1
	hi = hi or #a
	local n = hi - lo + 1

	-- Caso Base --
	if n <= 1 then
		return
	end

	-- hard cap --
	k = math.min(k, n - 1) -- Se tiver mais pivos do que elementos no vetor aponte K = n - 1

	-- k primeiros elementos ordenados
	local pivos = table.move(a, lo, lo + k - 1, 1, {})
	table.sort(pivos)

	-- Divide em Baldes --
	local function balde(x)
		local i = 0
		while i < k and pivos[i + 1] < x do
			i = i + 1
		end
		if i < k and pivos[i + 1] == x then
			return 2 * i + 1
		end
		return 2 * i
	end

	-- Cria baldes Como Uma Table de Tables
	local baldes = {}
	for b = 0, 2 * k do
		baldes[b] = {}
	end

	-- Separa os Elementos em Listas --
	for i = lo, hi do
		-- table.insert(baldes[balde(a[i])], a[i]) --
		local lista = baldes[balde(a[i])]
		table.insert(lista, a[i])
	end

	-- Reescrever os Valores em a, Recursão nos Pares
	local pos = lo
	for b = 0, 2 * k do
		local ini = pos
		for _, x in ipairs(baldes[b]) do
			a[pos] = x
			pos = pos + 1
		end
		if b % 2 == 0 then
			quicksort_k_pivos(a, k, ini, pos - 1)
		end
	end
end

-- Exemplo de uso --

local v = { 5, 44, 3, 3, 3, 11, 123, 67, 0 }
local k = 4

print("Antes:  " .. table.concat(v, " "))
quicksort_k_pivos(v, k)
print("Depois: " .. table.concat(v, " "))
