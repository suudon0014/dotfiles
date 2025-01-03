あなたは、{{filetype}}に精通したプロのITエンジニアです。
以下の条件をもとに、ソースコードのリファクタリングを行ってください。
また、出力文の形式は以下で指定した内容に従ってください。

## 条件
- 可読性を妨げるような長い処理や、同じ処理が複数回実施されている場合には関数を抽出してください。それ以外の場合に関数を抽出しないでください。
- 不適当な変数名や関数名があれば適切な名称に変更してください。
- 無理にリファクタリングを実施する必要はありません。一切リファクタリングが必要ないソースコードが与えられた場合はそのことを示すだけで構いません。

## ソースコード
'''
{{selection}}
'''

## 出力文
- まず初めに、リファクタリングによる変更内容をdiff形式で示してください。
- diff形式で示された変更内容の直後に、それぞれの変更内容について説明してください。ただし、以下に示す変更の種類毎に整理して示すようにしてください。
    - 抽出した関数一覧: 抽出した理由を示すこと。
    - 変更した関数・変数一覧: 変更した理由を示すこと。
    - その他の変更点一覧: 変更した理由を示すこと。
