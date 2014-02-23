var FTControllers = angular.module('FTControllers', []);

FTControllers.controller('FTidle', ['$scope', function($scope) {
    $scope.title = "환영합니다.";
}]);
FTControllers.controller('FTgameMenu', ['$scope', function($scope) {
    $scope.title = "게임메뉴 - 난이도를 선택하세요.";
}]);
FTControllers.controller('FTgameAction', ['$scope', "$routeParams", function($scope, $routeParams) {
    var difficulty = $routeParams.difficulty;
    if(!difficulty)
        $scope.title = "게임실행"
    else
        $scope.title = "게임실행 " + difficulty + " 단계";
}]);
FTControllers.controller('FTgameResult', ['$scope', function($scope) {
    $scope.title = "게임결과";
}]);
FTControllers.controller('FTtestMenu', ['$scope', function($scope) {
    $scope.title = "검사메뉴";
}]);
FTControllers.controller('FTtestAction', ['$scope', function($scope) {
    $scope.title = "검사실행";
}]);
FTControllers.controller('FTtestResult', ['$scope', function($scope) {
    $scope.title = "검사결과";
}]);
FTControllers.controller('FTconfig', ['$scope', function($scope) {
    $scope.title = "설정";
}]);