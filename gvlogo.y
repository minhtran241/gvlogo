%{
#define WIDTH 640
#define HEIGHT 480

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_thread.h>

static SDL_Window* window;
static SDL_Renderer* rend;
static SDL_Texture* texture;
static SDL_Thread* background_id;
static SDL_Event event;
static int running = 1;
static const int PEN_EVENT = SDL_USEREVENT + 1;
static const int DRAW_EVENT = SDL_USEREVENT + 2;
static const int COLOR_EVENT = SDL_USEREVENT + 3;

// Current color struct
typedef struct color_t {
	unsigned char r;
	unsigned char g;
	unsigned char b;
} color;

// Current coordinates struct
typedef struct coord_t {
	int x;
	int y;
} coords;

// Current color of the turtle
static color current_color;

// Current coordinates of the turtle on the screen
static coords current_coords;

static double x = WIDTH / 2;
static double y = HEIGHT / 2;
static int pen_state = 1;
static double direction = 0.0;

int yylex(void);
int yyerror(const char* s);
void startup();
int run(void* data);
void prompt();
void penup();
void pendown();
void move(int num);
void turn(int dir);
void output(const char* s);
void change_color(int r, int g, int b);
void print_color();
void clear();
void save(const char* path);
void shutdown();
void goTo(int x, int y);
void where();
// void store_variables(int *variable, char variable_name, int expression_result);

%}

%union {
	float f;
	char* s;
	char c;
}

%locations

%token RUN
%token SHUTDOWN
%token GOTO
%token WHERE
%token SEP
%token PENUP
%token PENDOWN
%token PRINT
%token CHANGE_COLOR
%token PRINT_COLOR
%token CLEAR
%token TURN
%token LOOP
%token MOVE
%token NUMBER
%token END
%token SAVE
%token PLUS SUB MULT DIV EQUAL
%token<s> STRING QSTRING
%token<c> CHAR
%type<f> expression expression_list NUMBER

%%

// Grammar rules
program:    		statement_list END              				{ printf("Program complete."); shutdown(); exit(0); }
        ;
statement_list:    	statement                   
        |    	   	statement statement_list
        ;
statement:    		command SEP                						{ prompt(); }
        |     		error '\n'                 						{ yyerrok; prompt(); }
        ;
command:    		PENUP                    						{ penup(); }
        |    		PENDOWN                    						{ pendown(); }
        |    		PRINT STRING                					{ output($2); }
        |    		CLEAR                   						{ clear(); }
        |    		GOTO expression expression    					{ goTo((int)$2, (int)$3); }
        |    		WHERE                    						{ where(); }
        |    		CHANGE_COLOR expression expression expression   { change_color((int)$2, (int)$3, (int)$4); }
        |    		PRINT_COLOR                						{ print_color(); }
        |    		TURN expression                    				{ turn($2); }
        |    		MOVE expression                 				{ move((int)$2); }
        |    		SAVE STRING                    					{ save($2); }
        |    		SHUTDOWN                    					{ shutdown(); }
        ;
expression_list:    expression       
        |    		expression expression_list   
        |    		expression PLUS expression_list        
        ;
expression:    		NUMBER PLUS expression                			{ $$ = $1 + $3; }
        |    		NUMBER MULT expression                			{ $$ = $1 * $3; }
        |    		NUMBER SUB expression               			{ $$ = $1 - $3; }
        |    		NUMBER DIV expression                			{ $$ = $1 / $3; }
        |    		NUMBER                             				{ $$ = $1; }
        ;

%%

// Main function to start the program
int main(int argc, char** argv){
	startup();
	return 0;
}

// Error function to print out error messages
int yyerror(const char* s){
	printf("Error: %s\n", s);
	return -1;
};

// Prompt function to print out the prompt
void prompt(){
	printf("gv_logo > ");
}

// Function to raise the pen (stop drawing)
void penup(){
	event.type = PEN_EVENT;		
	event.user.code = 0;
	SDL_PushEvent(&event);
}

// Function to lower the pen (start drawing)
void pendown() {
	event.type = PEN_EVENT;		
	event.user.code = 1;
	SDL_PushEvent(&event);
}

// Function to move the turtle to a new position
void move(int num){
	printf("Moving to position: %d\n", num);
	event.type = DRAW_EVENT;
	event.user.code = 1;
	event.user.data1 = num;
	SDL_PushEvent(&event);
}

// Function to turn the turtle in a direction
void turn(int dir){
	event.type = PEN_EVENT;
	event.user.code = 2;
	event.user.data1 = dir;
	SDL_PushEvent(&event);
}

// Function to print out a string
void output(const char* s){
	printf("%s\n", s);
}

// Function to change the color of the turtle pen
void change_color(int r, int g, int b){
	event.type = COLOR_EVENT;
	current_color.r = r;
	current_color.g = g;
	current_color.b = b;
	SDL_PushEvent(&event);
}

// Function to clear the screen of all drawings
void clear(){
	event.type = DRAW_EVENT;
	event.user.code = 2;
	SDL_PushEvent(&event);
}

// Function to save the current screen to a file
void startup(){
	SDL_Init(SDL_INIT_VIDEO);
	window = SDL_CreateWindow("GV-Logo", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
	if (window == NULL){
		yyerror("Can't create SDL window.\n");
	}
	
	//rend = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_TARGETTEXTURE);
	rend = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE | SDL_RENDERER_TARGETTEXTURE);
	SDL_SetRenderDrawBlendMode(rend, SDL_BLENDMODE_BLEND);
	texture = SDL_CreateTexture(rend, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, WIDTH, HEIGHT);
	if(texture == NULL){
		printf("Texture NULL.\n");
		exit(1);
	}
	SDL_SetRenderTarget(rend, texture);
	SDL_RenderSetScale(rend, 3.0, 3.0);

	background_id = SDL_CreateThread(run, "Parser thread", (void*)NULL);
	if(background_id == NULL){
		yyerror("Can't create thread.");
	}
	while(running){
		SDL_Event e;
		while( SDL_PollEvent(&e) ){
			if(e.type == SDL_QUIT){
				running = 0;
			}
			if(e.type == PEN_EVENT){
				if(e.user.code == 2){
					double degrees = ((int)e.user.data1) * M_PI / 180.0;
					direction += degrees;
				}
				pen_state = e.user.code;
			}
			if(e.type == DRAW_EVENT){
				if(e.user.code == 1){
					int num = (int)event.user.data1;
					double x2 = x + num * cos(direction);
					double y2 = y + num * sin(direction);
					if(pen_state != 0){
						SDL_SetRenderTarget(rend, texture);
						SDL_RenderDrawLine(rend, x, y, x2, y2);
						SDL_SetRenderTarget(rend, NULL);
						SDL_RenderCopy(rend, texture, NULL, NULL);
					}
					x = x2;
					y = y2;
				} else if(e.user.code == 2){
					SDL_SetRenderTarget(rend, texture);
					SDL_RenderClear(rend);
					SDL_SetTextureColorMod(texture, current_color.r, current_color.g, current_color.b);
					SDL_SetRenderTarget(rend, NULL);
					SDL_RenderClear(rend);
				}
			}
			if(e.type == COLOR_EVENT){
				SDL_SetRenderTarget(rend, NULL);
				SDL_SetRenderDrawColor(rend, current_color.r, current_color.g, current_color.b, 255);
			}
			if(e.type == SDL_KEYDOWN){
			}

		}
		//SDL_RenderClear(rend);
		SDL_RenderPresent(rend);
		SDL_Delay(1000 / 60);
	}
}

// Function to run the parser
int run(void* data){
	prompt();
	yyparse();
}

// Function to shutdown the program
void shutdown(){
	running = 0;
	SDL_WaitThread(background_id, NULL);
	SDL_DestroyWindow(window);
	SDL_Quit();
}

// Function to save the current screen to a file
void save(const char* path){
	SDL_Surface *surface = SDL_CreateRGBSurface(0, WIDTH, HEIGHT, 32, 0, 0, 0, 0);
	SDL_RenderReadPixels(rend, NULL, SDL_PIXELFORMAT_ARGB8888, surface->pixels, surface->pitch);
	SDL_SaveBMP(surface, path);
	SDL_FreeSurface(surface);
}

// Function to move the turtle to a new position , draw if pen is down
void goTo(int x, int y) {
	// Change current coordinates
	coords prev_coords = current_coords;
	current_coords.x = x;
	current_coords.y = y;

	// Calculate change in x and y
    int delta_x = current_coords.x - prev_coords.x;
    int delta_y = current_coords.y - prev_coords.y;

	// Calculate the angle to turn
	double angle = atan2(delta_y, delta_x) * 180.0 / M_PI;

	// Calculate the difference in angles
	double angle_diff = angle - direction;

	// Normalize the angle difference to be within the range [-180, 180]
	if (angle_diff > 180.0) {
		angle_diff -= 360.0;
	} else if (angle_diff < -180.0) {
		angle_diff += 360.0;
	}

	// Turn the turtle
	turn(angle_diff);

	printf("Moved to coordinates: (%d, %d)\n", current_coords.x, current_coords.y);

	// Draw if pen is down
	if(pen_state == 1){
		printf("Drawing line from (%d, %d) to (%d, %d)\n", prev_coords.x, prev_coords.y, current_coords.x, current_coords.y);

        // Move by the calculated delta
        move(sqrt(delta_x * delta_x + delta_y * delta_y));
	}
}


// Function to print the current coordinates of the turtle on the canvas
void where() {
	printf("Current coordinates: (%d, %d)\n", current_coords.x, current_coords.y);
}

// Function to print the current color of the turtle
void print_color() {
	printf("Current color: (%d, %d, %d)\n", current_color.r, current_color.g, current_color.b);
}