module Main exposing (main)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Svg exposing (svg)
import Svg.Attributes exposing (class, d, fill, height, viewBox)


class =
    -- svg & html attribute clash fix
    Html.Attributes.class


type alias Model =
    { projects : List Project
    , newclient : Contact
    }


type alias Image =
    String


type alias Link =
    String


type alias Project =
    { name : String
    , description : String
    , image : Image
    , link : Link
    , projectType : String
    }


listProjects =
    [ Project "MadBlock" "Consulting with the MadBlock team remotely, I worked to devise and develop an entire Xenforo 2 theme and framework, from scratch." "assets/img/madblock-final.jpg" "assets/img/madblock-final.jpg" "WEBSITE"
    , Project "Bibelo Gifts" "Through in-person consultations with Bibelo, we successfully moved the once brick & mortar store to a new online Shopify store, equipped with a custom theme." "assets/img/bibelo-front.png" "https://bibelo.com.au/" "WEBSITE"
    , Project "Three Sisters" "After a number of in-person meetings with the owners of Three Sisters, a multi-paged, elegant website was created to represent the new, high quality catering business." "assets/img/3sisters.png" "https://threesisterscatering.com.au/" "WEBSITE/SEO"
    , Project "Beek" "A powerful, simple app to manage your business and change the way you send and receive payments. More information will be available soon, this is the highest priority project." "assets/img/beek-website.png" "https://beek.com.au/" "APP"
    , Project "Maker Army" "Coined via a collaboration between a small team of remote developers, Maker Army is a platform built for makers to earn money from supporters, to create greater quality content and better whole creative community." "assets/img/makerarmy.png" "/maker" "APP"
    , Project "Carb CSS" "This project was inspired by my use of Elm & Elixir in a majority of recent web projects, both of which have ditched the \"{;}\" syntax - so I thought it was about time to bring CSS up to scratch." "assets/img/carb-website.png" "https://carb.now.sh/" "OPEN SOURCE"
    , Project "Vivid Fund/Agency" "A private agency and fund that I founded, in order to formalise website development projects and experiment with exciting, further-reaching projects." "assets/img/vivid.png" "https://vivid.fund/" "BUSINESS"
    , Project "Branding Portfolio" "Branding & design were a highlight of my degree. I had to opportunity to rebrand globally known companies and work with leaders of global design agencies. Let me know if you're interested in seeing my portfolio." "assets/img/branding-front.png" "https://peter-s-nsw.peter-s1.now.sh/" "PERSONAL"
    , Project "Melb. Test and Tagging" "Melbourne Test and Tagging is a local business in Melbourne, Australia. After an initial consultation, I built the business a NextJS React website, styled with TailwindCSS and hosted with Now by Zeit for free." "assets/img/mtt.png" "https://melbournetestandtagging.net.au/" "WEBSITE/SEO"
    ]


type alias Contact =
    { name : String
    , email : String
    , note : String
    }


type Msg
    = NewProject Project
    | NewClient Contact


main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


initialModel =
    { projects = []
    , newclient = Contact "" "" ""
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewProject project ->
            ( { model | projects = model.projects ++ [] }, Cmd.none )

        NewClient client ->
            ( { model | newclient = Contact "test" "test" "tester" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Peter S: Simplify & Unify"
    , body = [ githubLink ] ++ [ page model ]
    }


page model =
    -- general website layout
    div [ class "container" ]
        [ sectionNav
        , section [ class "blurb" ]
            [ div [ class "wrapper-inner" ]
                [ p []
                    [ text "Hi there, I'm "
                    , strong "Peter,"
                    , text " a multi-stack developer and part-time designer, located in "
                    , strong "Australia."
                    , br [] []
                    , br [] []
                    , text "I’ve worked remotely with a multitude of clients across the globe for over "
                    , strong "5"
                    , text " years, utilising unique design to "
                    , strong "forge brands"
                    , text " and accelerate "
                    , strong "user base growth."
                    , br [] []
                    , br [] []
                    , text "I am also currently enrolled at the "
                    , strong "University of Melbourne"
                    , text ", undertaking studies in software and computer systems engineering."
                    ]
                ]
            ]
        , contactCard model
        , viewPortfolioSection
        , section [ style "marginBottom" "3rem" ]
            [ div [ class "wrapper-inner", style "textAlign" "center" ]
                [ label [ style "textTransform" "unset" ] [ text "Site powered by ", a [ href "https://now.sh", target "_blank" ] [ text "now.sh" ], text ". ", text "Written in ", a [ href "https://elm-lang.org", target "_blank" ] [ text "Elm" ], text "." ]
                ]
            ]
        , sectionFooter
        ]


contactCard model =
    section [ class "notices" ]
        [ div [ class "wrapper-inner" ]
            [ div [ class "notice" ]
                [ h2 [] [ text "Up for a chat? 👋" ]
                , p [] [ text "If you would like to discuss a project or simply say g'day, please send me a direct message on Twitter and I will try to get back to you as soon as possible." ]
                , a [ class "button button-primary", href "https://twitter.com/messages/compose?recipient_id=2795772691" ]
                    [ text "Hi, Peter.." ]
                , small [ class "tiny", tinyStyle ] [ text "Additional communication channels coming." ]
                ]
            ]
        ]


tinyStyle : Html.Attribute msg
tinyStyle =
    -- custom styling for small text next to button
    style "marginLeft" "1rem"


strong word =
    span [ class "strong" ] [ text word ]


githubLink =
    -- floating github link
    a [ href "https://github.com/p-skal", target "_blank", class "github-corner", attribute "aria-label" "Check out my GitHub" ]
        [ svg [ Svg.Attributes.width "80", Svg.Attributes.height "80", Svg.Attributes.viewBox "0 0 250 250", Svg.Attributes.style "fill: #f5deb3;color: #151513;position: absolute;top: 0;border: 0;right: 0;" ]
            [ Svg.path [ d "M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z" ]
                []
            , Svg.path [ d "M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2", Svg.Attributes.fill "currentColor", Svg.Attributes.style "transform-origin: 130px 106px;", Svg.Attributes.class "octo-arm" ]
                []
            , Svg.path [ d "M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z", Svg.Attributes.fill "currentColor", Svg.Attributes.class "octo-body" ]
                []
            ]
        ]


primaryButton =
    -- primary button layout
    let
        path =
            "#"
    in
    a
        [ class "button button-primary"
        , href path
        ]
        [ text "Hi, Peter.." ]


viewPortfolioSection =
    section [ class "recents" ]
        [ div [ class "wrapper-inner" ]
            [ h1 [ style "alignItems" "center", style "display" "flex" ]
                [ text "Previous work"
                , label [ class "section-identifier" ] [ text "Starred ", i [ class "fas fa-star" ] [] ]
                ]
            , List.map viewPortfolioItem listProjects
                |> div [ class "grid" ]
            ]
        ]


viewPortfolioItem : Project -> Html msg
viewPortfolioItem { name, description, image, link, projectType } =
    let
        projectLink =
            isLink link

        isLink url =
            if url == "" then
                [ href "#" ]

            else
                [ href link, target "_blank" ]
    in
    -- Recent work items
    div [ class "item" ]
        [ a ([ class "image" ] ++ projectLink)
            [ if image == "" then
                h5 [] [ text "Coming Soon" ]

              else
                img [ draggable "false", src image, alt name ] []
            ]
        , h4 [] [ text name, small [ class "tag" ] [ text projectType ] ]
        , p []
            [ text description
            ]
        , a projectLink [ text "View project »" ]
        ]


sectionNav =
    section
        [ class "navigation-bar" ]
        [ div [ class "wrapper-inner" ]
            [ a [ class "nav-logo" ]
                [ div [ class "brand-img-ps" ]
                    [ div [] [ text "PS" ]
                    ]
                ]
            , ul [ class "nav nav-right" ]
                [ li [] [ a [ class "" ] [ text "Work" ] ]
                , li [] [ a [ class "" ] [ text "Play" ] ]
                , li [] [ a [ class "" ] [ text "Need a hand?" ] ]
                ]
            , div [ class "nav-trigger" ]
                [ i [ class "fas fa-ellipsis-v" ] []
                , ul [ class "dropdown" ]
                    [ li [] [ a [ class "" ] [ text "Work" ] ]
                    , li [] [ a [ class "" ] [ text "Play" ] ]
                    , li [] [ a [ class "" ] [ text "Need a hand?" ] ]
                    ]
                ]
            ]
        ]


sectionFooter =
    section [ class "footer" ]
        [ div [ class "wrapper-inner" ]
            [ ul [ class "nav" ]
                [ li [] [ a [ href "https://twitter.com/ps300300", target "_blank" ] [ i [ class "fab fa-twitter" ] [] ] ]
                , li [] [ a [ href "https://medium.com/@p.skal", target "_blank" ] [ i [ class "fab fa-medium-m" ] [] ] ]
                , li [] [ a [ href "https://linkedin.com/in/peter-skaltsis-1a05b3111", target "_blank" ] [ i [ class "fab fa-linkedin" ] [] ] ]
                ]
            ]
        ]


site_title =
    "Peter S: Simplify & Unify"
