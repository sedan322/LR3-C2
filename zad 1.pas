type 
  PNode = ^Node;
  Node = record
    data: integer;
    next: PNode;
  end;
  
type 
  Queue = record
    head, tail: PNode;
  end;

var 
  f:text;
  g:text;

procedure PushTail( var Q: Queue; x: integer );
var 
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.data := x;
  NewNode^.next := nil;
  if Q.tail <> nil then
    Q.tail^.next := NewNode;
  Q.tail := NewNode; 
  if Q.head = nil then 
    Q.head := Q.tail;
end;

function Pop ( var Q: Queue ): integer;
var 
  top: PNode;
begin
  if Q.head = nil then begin
    Result := MaxInt;
    Exit;
  end;
  top := Q.head;
  Result := top^.data;
  Q.head := top^.next;
  if Q.head = nil then 
    Q.tail := nil;
  Dispose(top);
end;

begin
  // Открываем файлы для чтения и записи
  assign(f,'text.txt');
  assign(g,'text2.txt');
  // Открываем файл для чтения
  reset(f);
  // Создаем очередь
  var q: Queue;
  q.head := nil;
  q.tail := nil;
  // Считываем числа из файла и добавляем их в очередь
  while not eof(f) do begin
    var x: integer;
    readln(f,x);
    PushTail(q,x);
  end;
  // Открываем файл для записи
  rewrite(g);
  // Извлекаем числа из очереди и записываем их в файл
  while q.head <> nil do begin
    var x: integer;
    x := Pop(q);
    writeln(g,x);
  end;
  // Закрываем файлы
  close(f);
  close(g);
end.