module Unnamed.Value (
  Closure (..),
  Value (..),
  Var (..),
  Spine (..),
  var,
  meta,
) where

import Relude

import Unnamed.Env (Env)
import Unnamed.Syntax.Core (Term)
import Unnamed.Var.Level (Level (..))
import Unnamed.Var.Meta (Meta)
import Unnamed.Var.Name (Name)

data Closure = Closure (Env Value) Term
  deriving stock (Show)

data Value
  = Neut Var Spine
  | U
  | Pi {-# UNPACK #-} Name ~Value Closure
  | Lam {-# UNPACK #-} Name {-# UNPACK #-} Closure
  | RowType Value
  | RowCon (HashMap Name Value)
  | RecordType Value
  | RecordCon (HashMap Name Value)
  deriving stock (Show)

data Var
  = Rigid {-# UNPACK #-} Level
  | Flex {-# UNPACK #-} Meta
  deriving stock (Show, Eq)

data Spine
  = Nil
  | App Spine ~Value
  | RecordProj {-# UNPACK #-} Name Spine
  deriving stock (Show)

var :: Level -> Value
var lx = Neut (Rigid lx) Nil

meta :: Meta -> Value
meta mx = Neut (Flex mx) Nil
