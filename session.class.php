<?php

/*
 * The MIT License
 *
 * Copyright 2014 Matija Novak <matija.novak@foi.hr>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 * Klasa za upravljanje sa sesijama
 *
 * @author Matija Novak <matija.novak@foi.hr>
 */

class Session {

    const USER = "user";
    const BASKET = "basket";
    const SESSION_NAME = "login_session";
    //Dodano, ubacit u bazu
    const TYPE = "type";
    const LEVEL = "level";
    const ERROR = "error";

    static function createSession() {
        session_name(self::SESSION_NAME);

        if (session_id() == "") {
            session_start();
        }
    }

    //idu 3 parametra treba nadopunit
    static function createUser($username, $type, $level, $numberIncorrectLogin) {
        self::createSession();
 
        $_SESSION[self::USER]['username'] = $username;
        $_SESSION[self::USER]['type'] = $type;
        $_SESSION[self::USER]['level']=$level;
        $_SESSION[self::USER]['$numberIncorrectLogin']= $numberIncorrectLogin;
    }

    static function createBasket($basket) {
        self::createSession();
        $_SESSION[self::BASKET] = $basket;
    }

    static function returnUser() {
        self::createSession();
        if (isset($_SESSION[self::USER])) {
            $user = $_SESSION[self::USER];
        } else {
            return null;
        }
        return $user;
    }

    static function returnBasket() {
        self::createSession();
        if (isset($_SESSION[self::BASKET])) {
            $basket = $_SESSION[self::BASKET];
        } else {
            return null;
        }
        return $basket;
    }

    
    static function deleteSession() {
        session_name(self::SESSION_NAME);

        if (session_id() != "") {
            session_unset();
            session_destroy();
        }
    }
    
    //vraca array
    static function returnUserData(){
        self::createSession();
        if(isset($_SESSION[self::USER])){
            $data = $_SESSION[self::USER];
        }
        else{
            return "";
        }
        return $data;
    }

}
