from core.database.connector import establish_connection
from mysql.connector import Error

def save_score(current_player_id: int, score: int):
    QUERY = "INSERT INTO pontuacoes (jogador_id, pontuacao) VALUES (%s, %s)"

    conn = None
    cursor = None
    try:
        conn = establish_connection()
        cursor = conn.cursor()
        cursor.execute(QUERY, (current_player_id, score))
        conn.commit()  # Commit the transaction
        print("Score saved successfully.")
    except Error as e:
        print(f"Error: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# Example usage
save_score(1, 100)
