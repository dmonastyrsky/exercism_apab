CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
    
  METHOD score.
    DATA(lv_word) = to_upper( input ).
    DATA(lv_len) = strlen( lv_word ).
    DATA(lv_index) = 0.

    WHILE lv_index < lv_len.
      DATA(lv_char) = lv_word+lv_index(1).

      IF lv_char CA 'AEIOULNRST'.
        result = result + 1.
      ELSEIF lv_char CA 'DG'.
        result = result + 2.
      ELSEIF lv_char CA 'BCMP'.
        result = result + 3.
      ELSEIF lv_char CA 'FHVWY'.
        result = result + 4.
      ELSEIF lv_char CA 'K'.
        result = result + 5.
      ELSEIF lv_char CA 'JX'.
        result = result + 8.
      ELSEIF lv_char CA 'QZ'.
        result = result + 10.
      ENDIF.

      lv_index = lv_index + 1.
    ENDWHILE.
  ENDMETHOD.


ENDCLASS.
