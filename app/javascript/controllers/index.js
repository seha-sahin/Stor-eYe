// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import HomepagemapController from "./homepagemap_controller"
application.register("homepagemap", HomepagemapController)

import MapController from "./map_controller"
application.register("map", MapController)

import WineRatioController from "./wine_ratio_controller"
application.register("wine-ratio", WineRatioController)

import WineshowmapController from "./wineshowmap_controller"
application.register("wineshowmap", WineshowmapController)
