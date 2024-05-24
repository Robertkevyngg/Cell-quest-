from core.database.connector import establish_connection
from mysql.connector import Error

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

# Example usage
scoreboard = get_scoreboard()
print(scoreboard)
