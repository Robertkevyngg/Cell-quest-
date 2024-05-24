from core.database.connector import establish_connection
from mysql.connector import Error

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

# Example usage
alternatives = get_alternatives(1)
print(alternatives)
