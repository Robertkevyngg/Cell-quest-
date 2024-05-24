from core.database.connector import establish_connection
from mysql.connector import Error

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

# Example usage
questions = get_questions()
print(questions)
