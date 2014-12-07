'use strict'

angular.module('app.tables', [])

.controller('tableCtrl', [
    '$scope', '$filter'
    ($scope, $filter) ->
        # filter
        $scope.stores = [
            {name: 'Nijiya Market', price: '$$', sales: 292, rating: 4.0}
        ]
        $scope.searchKeywords = ''
        $scope.filteredStores = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageStores = $scope.filteredStores.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredStores = $filter('filter')($scope.stores, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredStores = $filter('orderBy')($scope.stores, rowName)
            # console.log $scope.filteredStores
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageStores = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        init()


])