﻿(function () {
    'use strict';

    angular
        .module('Nidan')
        .factory('CourseService', CourseService);

    CourseService.$inject = ['$http'];

    function CourseService($http) {
        var service = {
            retrieveCourses: retrieveCourses,
            canDeleteCourse: canDeleteCourse,
            deleteCourse: deleteCourse,
            searchCourse: searchCourse,
            retrieveCourseInstallments: retrieveCourseInstallments
        };

        return service;

        function retrieveCourses(Paging, OrderBy) {

            var url = "/Course/List",
                data = {
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function retrieveCourseInstallments(Paging, OrderBy) {

            var url = "/Course/CourseInstallmentList",
                data = {
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchCourse(SearchKeyword, Paging, OrderBy) {
            var url = "/Course/Search",
            data = {
                searchKeyword: SearchKeyword,
                paging: Paging,
                orderBy: new Array(OrderBy)
            };

            return $http.post(url, data);
        }

        function canDeleteCourse(id) {
            var url = "/Course/CanDeleteCourse",
                data = { id: id };

            return $http.post(url, data);
        }

        function deleteCourse(id) {
            var url = "/Course/Delete",
                data = { id: id };

            return $http.post(url, data);
        }
    }
})();