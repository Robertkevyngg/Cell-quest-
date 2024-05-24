import os
import random
import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk
from app.use_cases import authenticate, register, get_questions, get_alternatives, save_score, get_scoreboard
from functools import partial
import pygame

hits = 0
lives = 3
questions = []
current_question_index = 0
option_buttons = []
question_label = None
score_label = None
lives_label = None

def reset_game():
    global hits, lives, current_question_index, questions
    hits = 0
    lives = 3
    current_question_index = 0
    questions = get_questions()
    questions.sort(key=lambda q: q[0])
    update_lives()
    update_score()
    load_question(current_question_index)

def update_lives():
    global lives_label
    lives_label.config(text=f"Vidas: {lives}")

def update_score():
    global score_label
    score_label.config(text=f"Pontos: {hits}")

def load_question(index):
    global current_question_index, questions, question_label, option_buttons

    # Reset button colors
    for button in option_buttons:
        button.config(bg="white")

    if 0 <= index < len(questions):
        current_question_index = index
        selected_question = questions[current_question_index]

        question_id, texto, _, resposta = selected_question
        alternatives = get_alternatives(question_id)

        question_label.config(text=f"Questão {question_id}\n{texto}")

        for i, alternative in enumerate(['A', 'B', 'C', 'D']):
            if alternative in alternatives:
                option_buttons[i].config(text=f"{alternative.upper()} - {alternatives[alternative]}", command=partial(check_answer, alternative, resposta))
                option_buttons[i].grid(row=i+1, column=0, sticky="w", padx=20, pady=10)
            else:
                option_buttons[i].grid_remove()
    else:
        question_label.config(text="Fim das perguntas")
        for button in option_buttons:
            button.grid_remove()

def check_answer(selected, correct):
    global hits, lives, current_question_index
    if selected == correct:
        hits += 1
        correct_answer_sound.play()
        messagebox.showinfo("Resposta", "Correto!")
        # Change color to green
        for button in option_buttons:
            if button.cget("text").startswith(selected.upper()):
                button.config(bg="green")
    else:
        lives -= 1
        messagebox.showinfo("Resposta", "Errado!")
        # Change colors to green for correct and red for incorrect
        for button in option_buttons:
            if button.cget("text").startswith(selected.upper()):
                button.config(bg="red")
            if button.cget("text").startswith(correct.upper()):
                button.config(bg="green")
    
    update_lives()
    update_score()
    
    if lives > 0:
        root.after(1000, lambda: load_question(current_question_index + 1))  # Load next question after 1 second
    else:
        messagebox.showinfo("Fim de jogo", "Você perdeu todas as vidas!")
        save_score(username, hits)
        reset_game()

def next_question():
    load_question(current_question_index + 1)

def previous_question():
    load_question(current_question_index - 1)

def authenticate_callback():
    global username
    username = username_entry.get()
    password = password_entry.get()
    if authenticate(username, password):
        game_frame.tkraise()
        load_question(current_question_index)
    else:
        messagebox.showerror("Erro de Login", "Usuário ou senha inválidos")

def register_callback():
    username = reg_username_entry.get()
    password = reg_password_entry.get()
    if register(username, password):
        messagebox.showinfo("Registro", "Registro bem-sucedido!")
        show_login_window()
    else:
        messagebox.showerror("Erro de Registro", "Erro ao registrar usuário")

def show_register_window():
    register_frame.tkraise()

def show_login_window():
    login_frame.tkraise()

def show_scoreboard():
    scores = get_scoreboard()
    scoreboard_text = "\n".join([f"{score['username']}: {score['score']} pontos" for score in scores])
    messagebox.showinfo("Ranking", scoreboard_text)

def show_scoreboard_frame():
    scores = get_scoreboard()
    scoreboard_text = "\n".join([f"{score['username']}: {score['score']} pontos" for score in scores])
    scoreboard_label.config(text=scoreboard_text)
    scoreboard_frame.tkraise()

def start_app():
    global questions, question_label, option_buttons, score_label, lives_label
    global username_entry, password_entry, reg_username_entry, reg_password_entry
    global login_frame, register_frame, game_frame, scoreboard_frame, scoreboard_label, root
    global correct_answer_sound

    # Inicializar pygame
    pygame.init()
    pygame.mixer.init()

    # Carregar e tocar música de fundo
    pygame.mixer.music.load('Perfect Cell Theme Phonk.mp3')
    pygame.mixer.music.play(-1)  # Tocar em loop

    # Carregar som de clique do botão
    button_click_sound = pygame.mixer.Sound('Minecraft Menu Button Sound Effect _ Sounffex.mp3')

    # Carregar som de resposta correta
    correct_answer_sound = pygame.mixer.Sound('Minecraft Menu Button Sound Effect _ Sounffex.mp3')

    # Criação da janela principal
    root = tk.Tk()
    root.title("Quiz de Citologia")
    root.geometry("1280x720")  # Dimensões ajustadas
    root.configure(bg="lightblue")

    container = tk.Frame(root, bg="lightblue")
    container.pack(fill="both", expand=True, padx=20, pady=20)

    for i in range(4):
        container.grid_rowconfigure(i, weight=1)
        container.grid_columnconfigure(i, weight=1)

    # Frame de registro
    register_frame = tk.Frame(container, bg="white", bd=2, relief=tk.RIDGE)
    register_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

    tk.Label(register_frame, text="Nome de usuário", bg="white", font=("Arial", 18)).grid(row=0, column=0, pady=10, padx=10, sticky="ew")
    reg_username_entry = tk.Entry(register_frame, font=("Arial", 18), width=20, bd=2, relief=tk.SUNKEN)
    reg_username_entry.grid(row=1, column=0, pady=10, padx=10, sticky="ew")

    tk.Label(register_frame, text="Senha", bg="white", font=("Arial", 18)).grid(row=2, column=0, pady=10, padx=10, sticky="ew")
    reg_password_entry = tk.Entry(register_frame, show="*", font=("Arial", 18), width=20, bd=2, relief=tk.SUNKEN)
    reg_password_entry.grid(row=3, column=0, pady=10, padx=10, sticky="ew")

    tk.Button(register_frame, text="Registrar", command=register_callback, bg="green", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=4, column=0, pady=10, padx=10)
    tk.Button(register_frame, text="Voltar ao login", command=show_login_window, bg="blue", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=5, column=0, pady=10, padx=10)

    # Frame de login
    login_frame = tk.Frame(container, bg="white", bd=2, relief=tk.RIDGE)
    login_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

    # Adicionar imagem de fundo ao frame de login
    login_bg_image = Image.open("backgroundlogin.png")  # Certifique-se de que a imagem esteja no caminho correto
    login_bg_image = login_bg_image.resize((1280, 720), Image.LANCZOS)
    login_bg_photo = ImageTk.PhotoImage(login_bg_image)

    login_bg_label = tk.Label(login_frame, image=login_bg_photo)
    login_bg_label.place(x=0, y=0, relwidth=1, relheight=1)

    # Container para centralizar o formulário de login
    login_label_frame = tk.Frame(login_frame, bg="white")
    login_label_frame.place(relx=0.5, rely=0.5, anchor="center")

    tk.Label(login_label_frame, text="Nome de usuário", bg="white", font=("Arial", 18)).grid(row=0, column=0, pady=10, padx=10, sticky="ew")
    username_entry = tk.Entry(login_label_frame, font=("Arial", 18), width=20, bd=2, relief=tk.SUNKEN)
    username_entry.grid(row=1, column=0, pady=10, padx=10, sticky="ew")

    tk.Label(login_label_frame, text="Senha", bg="white", font=("Arial", 18)).grid(row=2, column=0, pady=10, padx=10, sticky="ew")
    password_entry = tk.Entry(login_label_frame, show="*", font=("Arial", 18), width=20, bd=2, relief=tk.SUNKEN)
    password_entry.grid(row=3, column=0, pady=10, padx=10, sticky="ew")

    tk.Button(login_label_frame, text="Entrar", command=authenticate_callback, bg="blue", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=4, column=0, pady=10, padx=10)
    tk.Button(login_label_frame, text="Registrar", command=show_register_window, bg="green", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=5, column=0, pady=10, padx=10)

    # Frame do jogo
    game_frame = tk.Frame(container, bg="white", bd=2, relief=tk.RIDGE)
    game_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)

    # Adicionar imagem de fundo ao frame do jogo
    bg_image = Image.open("background.png")  # Certifique-se de que a imagem esteja no mesmo diretório ou forneça o caminho correto
    bg_image = bg_image.resize((1280, 720), Image.LANCZOS)
    bg_photo = ImageTk.PhotoImage(bg_image)

    bg_label = tk.Label(game_frame, image=bg_photo)
    bg_label.place(x=0, y=0, relwidth=1, relheight=1)

    question_label = tk.Label(game_frame, text="", wraplength=1200, justify="left", bg="white", font=("Arial", 20))
    question_label.grid(row=0, column=0, pady=20, padx=20, sticky="ew")

    option_buttons = [tk.Button(game_frame, bg="white", font=("Arial", 18), bd=2, relief=tk.RAISED, command=button_click_sound.play) for _ in range(4)]
    for i, button in enumerate(option_buttons):
        button.grid(row=i+1, column=0, sticky="ew", padx=20, pady=10)

    # Botões de navegação e rótulos de pontuação/vidas
    navigation_frame = tk.Frame(game_frame, bg="white")
    navigation_frame.grid(row=5, column=0, pady=10)

    tk.Button(navigation_frame, text="Questão Anterior", command=previous_question, bg="orange", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=0, column=0, pady=10, padx=10)
    tk.Button(navigation_frame, text="Próxima Questão", command=next_question, bg="blue", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=0, column=1, pady=10, padx=10)

    score_label = tk.Label(game_frame, text=f"Pontos: {hits}", bg="white", font=("Arial", 18))
    score_label.grid(row=6, column=0, pady=10, padx=10)

    lives_label = tk.Label(game_frame, text=f"Vidas: {lives}", bg="white", font=("Arial", 18))
    lives_label.grid(row=7, column=0, pady=10, padx=10)

    # Botão de ranking
    tk.Button(game_frame, text="Ver Ranking", command=show_scoreboard, bg="purple", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).grid(row=8, column=0, pady=10, padx=10)

    # Frame de ranking
    scoreboard_frame = tk.Frame(container, bg="white", bd=2, relief=tk.RIDGE)
    scoreboard_frame.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)
    
    scoreboard_label = tk.Label(scoreboard_frame, text="", bg="white", font=("Arial", 18))
    scoreboard_label.pack(pady=20, padx=20)

    tk.Button(scoreboard_frame, text="Voltar ao início", command=show_login_window, bg="blue", fg="white", font=("Arial", 18), width=15, bd=2, relief=tk.RAISED).pack(pady=10, padx=10)

    # Mostrar o frame de login inicialmente
    login_frame.tkraise()

    # Carregar perguntas
    questions = get_questions()
    questions.sort(key=lambda q: q[0])  # Ordena as perguntas pelo ID (assumindo que o ID é o primeiro elemento)

    # Iniciar a aplicação
    root.mainloop()

# Código principal
if __name__ == "__main__":
    from dotenv import load_dotenv
    load_dotenv()
    start_app()
