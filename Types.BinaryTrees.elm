{- OVERVIEW ------------------------------------------------------
A "Tree" represents a binary tree. A "Node" in a binary tree
always has two children. A tree can also be "Empty". Below I have
defined "Tree" and a number of useful functions.
-----------------------------------------------------------------}

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

-- TREES

type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


empty : Tree a
empty =
    Empty


singleton : a -> Tree a
singleton v =
    Node v Empty Empty


insert : comparable -> Tree comparable -> Tree comparable
insert x tree =
    case tree of
      Empty ->
          singleton x

      Node y left right ->
          if x > y then
              Node y left (insert x right)

          else if x < y then
              Node y (insert x left) right

          else
              tree


fromList : List comparable -> Tree comparable
fromList xs =
    List.foldl insert empty xs


depth : Tree a -> Int
depth tree =
    case tree of
      Empty -> 0

      Node v left right ->
          1 + max (depth left) (depth right)


mapTree : (a -> b) -> Tree a -> Tree b
mapTree f tree =
    case tree of
      Empty -> Empty

      Node v left right ->
          Node (f v) (mapTree f left) (mapTree f right)

deepList = [1,2,5,6,3,51,99,9]
deepTree = fromList deepList
niceList = [2,1,3]
niceTree = fromList niceList


main =
  div [ style [ ("font-family", "monospace") ] ]
    [ display "niceList" (toString niceList)
    , display "depth niceTree" (depth niceTree)
    , display "sum niceTree" (sumTree niceTree)
    , display "flattened niceTree" (flattenTree niceTree)
    , display "incremented niceTree" (mapTree (\n -> n + 1) niceTree)
    , display "deepList" (toString deepList)
    , display "depth deepTree" (depth deepTree)
    , display "sum deepTree" (sumTree deepTree)
    , display "flattened deepTree" (flattenTree deepTree)
    , display "incremented deepTree" (mapTree (\n -> n + 1) deepTree)
    , display "isElement 3 deepTree" (isElement 3 deepTree)
    , display "isElement 4 deepTree" (isElement 4 deepTree)
    , display "isElement 99 deepTree" (isElement 99 deepTree)
    , display "isElement 1 deepTree" (isElement 1 deepTree)
    ]


display : String -> a -> Html msg
display name value =
  div [] [ text (name ++ " ==> " ++ toString value) ]



{-----------------------------------------------------------------
(1) Sum all of the elements of a tree.

       sum : Tree number -> number
-----------------------------------------------------------------}

sumTree : Tree number -> number
sumTree tree =
    case tree of
        Empty -> 0
        Node v left right ->
            v + (sumTree left) + (sumTree right)

{-----------------------------------------------------------------
(2) Flatten a tree into a list.

       flatten : Tree a -> List a
-----------------------------------------------------------------}

flattenTree : Tree a -> List a
flattenTree tree =
    case tree of
        Empty -> []
        Node v left right ->
            v :: (flattenTree right ++ flattenTree left)


{-----------------------------------------------------------------
(3) Check to see if an element is in a given tree.

       isElement : a -> Tree a -> Bool
-----------------------------------------------------------------}

isElement : comparable -> Tree comparable -> Bool
isElement x tree =
    case tree of
        Empty -> False
        Node y left right ->
            if x == y then
                True
            else if x < y then
                isElement x left
            else
                isElement x right


{-----------------------------------------------------------------
(4) Write a general fold function that acts on trees. The fold
    function does not need to guarantee a particular order of
    traversal.

       fold : (a -> b -> b) -> b -> Tree a -> b
-----------------------------------------------------------------}

foldTree : (a -> b -> b) -> b -> Tree a -> b
foldTree f init tree =
    case tree of
        Empty -> init

        Node datum left right ->
            foldTree f (f datum (foldTree f init right)) left



{-----------------------------------------------------------------
(5) Use "fold" to do exercises 1-3 in one line each. The best
    readable versions I have come up have the following length
    in characters including spaces and function name:
      sum: 16
      flatten: 21
      isElement: 46
    See if you can match or beat me! Don't forget about currying
    and partial application!
-----------------------------------------------------------------}


{-----------------------------------------------------------------
(6) Can "fold" be used to implement "mapTree" or "depth"?
-----------------------------------------------------------------}


{-----------------------------------------------------------------
(7) Try experimenting with different ways to traverse a
    tree: pre-order, in-order, post-order, depth-first, etc.
    More info at: http://en.wikipedia.org/wiki/Tree_traversal
-----------------------------------------------------------------}
