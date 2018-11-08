module Pokedex exposing (getNameFromJson, nameDecoder, testData)

import Http
import Json.Decode exposing (Decoder, decodeString, field, int, string)



-- DECODERS


nameDecoder : String -> Result Json.Decode.Error String
nameDecoder json =
    decodeString (field "pokemon_species" (field "pokemon_entries" (field "name" string))) json



-- TEST DATA


testData : String
testData =
    "{\"pokemon_species\": {\"pokemon_entries\": {\"name\": \"Bob\"}}}"



-- UTILITIES


getNameFromJson : Result Json.Decode.Error String -> String
getNameFromJson result =
    case result of
        Ok value ->
            value

        Err e ->
            Json.Decode.errorToString e
