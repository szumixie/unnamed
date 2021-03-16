module Unnamed.Syntax.Core (Term (..)) where

import Relude

import Unnamed.BoundMask (BoundMask)
import Unnamed.Var.Level (Level)
import Unnamed.Var.Meta (Meta)
import Unnamed.Var.Name (Name)

data Term
  = Var {-# UNPACK #-} Level
  | Meta {-# UNPACK #-} Meta (Maybe BoundMask)
  | Let {-# UNPACK #-} Name Term Term Term
  | U
  | Pi {-# UNPACK #-} Name Term Term
  | Lam {-# UNPACK #-} Name Term
  | App Term Term
  | RowType Term
  | RowCon (HashMap Name Term)
  | RecordType Term
  | RecordCon (HashMap Name Term)
  | RecordProj {-# UNPACK #-} Name Term
  deriving stock (Show)
