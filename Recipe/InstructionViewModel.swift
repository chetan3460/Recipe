/*
 * Copyright (c) 2016 Razeware LLC
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
 */

import Foundation

//ingredient 食材
//cookingInstructions 烹食简介
enum RecipeInstructionType {
  case ingredient, cookingInstructions
}

struct InstructionViewModel {
  let recipe: Recipe?
  var type: RecipeInstructionType   //代表是食材还是烹饪简介
  var ingredientsState = [Bool]()   //食材状态 //bool类型的数组
  var directionsState = [Bool]()    //指示，简介状态  //bool类型的数组
  
  init(recipe: Recipe, type: RecipeInstructionType) {
    self.recipe = recipe
    self.type = type
    
    if let ingredients = recipe.ingredients {
      ingredientsState = [Bool](repeating: false, count:ingredients.count)   //初始化数组，其实bool类型的
    }
    
    if let directions = recipe.directions {
      directionsState = [Bool](repeating: false, count:directions.count)   //初始化数组，其实bool类型的
    }
  }
  
  mutating func numberOfItems() -> Int {  //mutating 表示可以在这个方法中修改这个struct中定义的变量 根据type值，来获取某个type数据的个数
    
    switch type {
    case .ingredient:
      if let ingredients = recipe?.ingredients {
        return ingredients.count
      }
    case .cookingInstructions:
      if let directions = recipe?.directions {
        return directions.count
      }
    }
    
    return 0
  }
  
  func numberOfSections() -> Int {   //获取section
    return 1
  }
  
  func itemFor(_ index: Int) -> String? {  //通过不同type类型，获取不同type中数组某一项的数据
    switch type {
    case .ingredient:
      if let ingredients = recipe?.ingredients {
        return ingredients[index]
      }
    case .cookingInstructions:
      if let directions = recipe?.directions {
        return directions[index]
      }
    }
    return nil
  }
  
  func getStateFor(_ index: Int) -> Bool {   //通过不同type类型，获取不同type种是否选择的状态值
    switch type {
    case .ingredient:
      return ingredientsState[index]
    case .cookingInstructions:
      return directionsState[index]
    }
  }
  
  mutating func selectItemFor(_ index: Int) {  //通过不同type值，选择其点击的那一项，把状态值修改一下
    switch type {
    case .ingredient:
      let previousState = ingredientsState[index]
      ingredientsState[index] = !previousState
    case .cookingInstructions:
      let previousState = directionsState[index]
      directionsState[index] = !previousState
    }
  }
}
