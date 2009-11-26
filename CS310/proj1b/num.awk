BEGIN { Lhs=6 }
      { printf("%" Lhs ".0f:   %s\n", ++N, $0) }
