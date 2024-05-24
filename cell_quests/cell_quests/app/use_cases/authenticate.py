from core.database.connector import establish_connection
from mysql.connector import Error

def authenticate(username: str, password: str) -> bool:
    QUERY = 'SELECT * FROM jogadores WHERE login = %s AND senha = %s'

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return False
        cursor = conn.cursor()
        cursor.execute(QUERY, (username, password))
        users = cursor.fetchall()
        return len(users) > 0
    except Error as e:
        print(f"Error: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def register(username: str, password: str) -> bool:
    QUERY = 'INSERT INTO jogadores (login, senha) VALUES (%s, %s)'

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return False
        cursor = conn.cursor()
        cursor.execute(QUERY, (username, password))
        conn.commit()
        return True
    except Error as e:
        print(f"Error: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def get_questions():
    QUERY = (
        "SELECT q.*, o.letra_opcao as resposta "
        "FROM questoes as q "
        "INNER JOIN opcoes_resposta as o ON q.questao_id = o.questao_id "
        "INNER JOIN respostas_corretas as r ON r.questao_id = q.questao_id AND r.opcao_id = o.opcao_id"
    )

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return []
        cursor = conn.cursor()
        cursor.execute(QUERY)
        return cursor.fetchall()
    except Error as e:
        print(f"Error: {e}")
        return []
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def get_alternatives(id: int) -> dict:
    QUERY = (
        "SELECT opcao_id, questao_id, texto_opcao, letra_opcao "
        "FROM opcoes_resposta "
        "WHERE questao_id = %s"
    )

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return {}
        cursor = conn.cursor()
        cursor.execute(QUERY, (id,))
        alternatives = cursor.fetchall()

        formatted_response = {}
        for _, _, text, letter in alternatives:
            formatted_response[str(letter)] = text

        return formatted_response
    except Error as e:
        print(f"Error: {e}")
        return {}
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def save_score(current_player_id: int, score: int):
    QUERY = "INSERT INTO pontuacoes (jogador_id, pontuacao) VALUES (%s, %s)"

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return False
        cursor = conn.cursor()
        cursor.execute(QUERY, (current_player_id, score))
        conn.commit()
        return True
    except Error as e:
        print(f"Error: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def get_scoreboard() -> list:
    QUERY = (
        "SELECT j.id, j.nome, MAX(p.pontuacao) "
        "FROM pontuacoes as p, jogadores as j "
        "WHERE p.jogador_id = j.id "
        "GROUP BY j.id"
    )

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        if conn is None:
            return []
        cursor = conn.cursor()
        cursor.execute(QUERY)
        scores = cursor.fetchall()

        return [{"id": id, "nome": nome, "pontuacao": score} for id, nome, score in scores]
    except Error as e:
        print(f"Error: {e}")
        return []
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
