function skinChanger() {
    $(".right-sidebar .choose-skin li").on("click", function () {
        var a = $("body"),
            b = $(this),
            c = $(".right-sidebar .choose-skin li.active").data("theme");
        $(".right-sidebar .choose-skin li").removeClass("active"), a.removeClass("theme-" + c), b.addClass("active"), a.addClass("theme-" + b.data("theme"))
    })
}

function loadTracking() {
    ! function (a, b, c, d, e, f, g) {
        a.GoogleAnalyticsObject = e, a[e] = a[e] || function () {
            (a[e].q = a[e].q || []).push(arguments)
        }, a[e].l = 1 * new Date, f = b.createElement(c), g = b.getElementsByTagName(c)[0], f.async = 1, f.src = "https://www.google-analytics.com/analytics.js", g.parentNode.insertBefore(f, g)
    }(window, document, "script", 0, "ga"), ga("create", trackingId, "auto"), ga("send", "pageview")
}

function setSkinListHeightAndScroll() {
    var a = $(window).height() - ($(".navbar").innerHeight() + $(".right-sidebar .nav-tabs").outerHeight()),
        b = $(".demo-choose-skin");
    b.slimScroll({
        destroy: !0
    }).height("auto"), b.parent().find(".slimScrollBar, .slimScrollRail").remove(), b.slimscroll({
        height: a + "px",
        color: "rgba(0,0,0,0.3)",
        size: "4px",
        alwaysVisible: !1,
        borderRadius: "3px",
        railBorderRadius: "0"
    })
}

function setSettingListHeightAndScroll() {
    var a = $(window).height() - ($(".navbar").innerHeight() + $(".right-sidebar .nav-tabs").outerHeight()),
        b = $(".right-sidebar .demo-settings");
    b.slimScroll({
        destroy: !0
    }).height("auto"), b.parent().find(".slimScrollBar, .slimScrollRail").remove(), b.slimscroll({
        height: a + "px",
        color: "rgba(0,0,0,0.3)",
        size: "4px",
        alwaysVisible: !1,
        borderRadius: "3px",
        railBorderRadius: "0"
    })
}

function activateNotificationAndTasksScroll() {
    $(".navbar-right .dropdown-menu .body .menu").slimscroll({
        height: "254px",
        color: "rgba(0,0,0,0.3)",
        size: "4px",
        alwaysVisible: !1,
        borderRadius: "3px",
        railBorderRadius: "0"
    })
}
if ("undefined" == typeof jQuery) throw new Error("jQuery plugins need to be before this file");
$.adminX = {}, $.adminX.options = {
    colors: {
        red: "#ec3b57",
        pink: "#E91E63",
        purple: "#ba3bd0",
        deepPurple: "#673AB7",
        indigo: "#3F51B5",
        blue: "#457fca",
        lightBlue: "#03A9F4",
        cyan: "#01b4ae",
        green: "#78b83e",
        lightGreen: "#8BC34A",
        yellow: "#ffe821",
        orange: "#FF9800",
        deepOrange: "#f83600",
        grey: "#9E9E9E",
        blueGrey: "#607D8B",
        black: "#000000",
        blush: "#F15F79",
        white: "#ffffff"
    },
    leftSideBar: {
        scrollColor: "rgba(0,0,0,0.01)",
        scrollWidth: "4px",
        scrollAlwaysVisible: !1,
        scrollBorderRadius: "0",
        scrollRailBorderRadius: "0"
    },
    dropdownMenu: {
        effectIn: "fadeIn",
        effectOut: "fadeOut"
    }
}, $.adminX.leftSideBar = {
    activate: function () {
        var a = this,
            b = $("body"),
            c = $(".overlay");
        $(window).click(function (d) {
            var e = $(d.target);
            "i" === d.target.nodeName.toLowerCase() && (e = $(d.target).parent()), !e.hasClass("bars") && a.isOpen() && 0 === e.parents("#leftsidebar").length && (e.hasClass("js-right-sidebar") || c.fadeOut(), b.removeClass("overlay-open"))
        }), $.each($(".menu-toggle.toggled"), function (a, b) {
            $(b).next().slideToggle(0)
        }), $.each($(".menu .list li.active"), function (a, b) {
            var c = $(b).find("a:eq(0)");
            c.addClass("toggled"), c.next().show()
        }), $(".menu-toggle").on("click", function (a) {
            var b = $(this),
                c = b.next();
            if ($(b.parents("ul")[0]).hasClass("list")) {
                var d = $(a.target).hasClass("menu-toggle") ? a.target : $(a.target).parents(".menu-toggle");
                $.each($(".menu-toggle.toggled").not(d).next(), function (a, b) {
                    $(b).is(":visible") && ($(b).prev().toggleClass("toggled"), $(b).slideUp())
                })
            }
            b.toggleClass("toggled"), c.slideToggle(320)
        }), a.setMenuHeight(), a.checkStatuForResize(!0), $(window).resize(function () {
            a.setMenuHeight(), a.checkStatuForResize(!1)
        }), Waves.attach(".menu .list a", ["waves-block"]), Waves.init()
    },
    setMenuHeight: function () {
        if (void 0 !== $.fn.slimScroll) {
            var a = $.adminX.options.leftSideBar,
                b = ($(window).height(), $(".legal").outerHeight(), $(".navbar").innerHeight(), $("#leftsidebar .list"));
            b.slimScroll({
                destroy: !0
            }).height("auto"), b.parent().find(".slimScrollBar, .slimScrollRail").remove(), b.slimscroll({
                height: "calc(100vh - 56px)",
                color: a.scrollColor,
                size: a.scrollWidth,
                alwaysVisible: a.scrollAlwaysVisible,
                borderRadius: a.scrollBorderRadius,
                railBorderRadius: a.scrollRailBorderRadius
            })
        }
    },
    checkStatuForResize: function (a) {
        var b = $("body"),
            c = $(".navbar .navbar-header .bars"),
            d = b.width();
        a && b.find(".content, .sidebar").addClass("no-animate").delay(1e3).queue(function () {
            $(this).removeClass("no-animate").dequeue()
        }), d < 1170 ? (b.addClass("ls-closed"), c.fadeIn()) : (b.removeClass("ls-closed"), c.fadeOut())
    },
    isOpen: function () {
        return $("body").hasClass("overlay-open")
    }
}, $.adminX.rightSideBar = {
    activate: function () {
        var a = this,
            b = $("#rightsidebar"),
            c = $(".overlay");
        $(window).click(function (d) {
            var e = $(d.target);
            "i" === d.target.nodeName.toLowerCase() && (e = $(d.target).parent()), !e.hasClass("js-right-sidebar") && a.isOpen() && 0 === e.parents("#rightsidebar").length && (e.hasClass("bars") || c.fadeOut(), b.removeClass("open"))
        }), $(".js-right-sidebar").on("click", function () {
            b.toggleClass("open"), a.isOpen() ? c.fadeIn() : c.fadeOut()
        })
    },
    isOpen: function () {
        return $(".right-sidebar").hasClass("open")
    }
};
var $searchBar = $(".search-bar");
$.adminX.search = {
    activate: function () {
        var a = this;
        $(".js-search").on("click", function () {
            a.showSearchBar()
        }), $searchBar.find(".close-search").on("click", function () {
            a.hideSearchBar()
        }), $searchBar.find('input[type="text"]').on("keyup", function (b) {
            27 == b.keyCode && a.hideSearchBar()
        })
    },
    showSearchBar: function () {
        $searchBar.addClass("open"), $searchBar.find('input[type="text"]').focus()
    },
    hideSearchBar: function () {
        $searchBar.removeClass("open"), $searchBar.find('input[type="text"]').val("")
    }
}, $.adminX.navbar = {
    activate: function () {
        var a = $("body"),
            b = $(".overlay");
        $(".bars").on("click", function () {
            a.toggleClass("overlay-open"), a.hasClass("overlay-open") ? b.fadeIn() : b.fadeOut()
        }), $('.nav [data-close="true"]').on("click", function () {
            var a = $(".navbar-toggle").is(":visible"),
                b = $(".navbar-collapse");
            a && b.slideUp(function () {
                b.removeClass("in").removeAttr("style")
            })
        })
    }
}, $.adminX.input = {
    activate: function () {
        $(".form-control").focus(function () {
            $(this).parent().addClass("focused")
        }), $(".form-control").focusout(function () {
            var a = $(this);
            a.parents(".form-group").hasClass("form-float") ? "" == a.val() && a.parents(".form-line").removeClass("focused") : a.parents(".form-line").removeClass("focused")
        }), $("body").on("click", ".form-float .form-line .form-label", function () {
            $(this).parent().find("input").focus()
        })
    }
}, $.adminX.select = {
    activate: function () {
        $.fn.selectpicker && $("select:not(.ms)").selectpicker()
    }
};
var edge = "Microsoft Edge",
    ie10 = "Internet Explorer 10",
    ie11 = "Internet Explorer 11",
    opera = "Opera",
    firefox = "Mozilla Firefox",
    chrome = "Google Chrome",
    safari = "Safari";
$.adminX.browser = {
    activate: function () {
        var a = this;
        "" !== a.getClassName() && $("html").addClass(a.getClassName())
    },
    getBrowser: function () {
        var a = navigator.userAgent.toLowerCase();
        return /edge/i.test(a) ? edge : /rv:11/i.test(a) ? ie11 : /msie 10/i.test(a) ? ie10 : /opr/i.test(a) ? opera : /chrome/i.test(a) ? chrome : /firefox/i.test(a) ? firefox : navigator.userAgent.match(/Version\/[\d\.]+.*Safari/) ? safari : void 0
    },
    getClassName: function () {
        var a = this.getBrowser();
        return a === edge ? "edge" : a === ie11 ? "ie11" : a === ie10 ? "ie10" : a === opera ? "opera" : a === chrome ? "chrome" : a === firefox ? "firefox" : a === safari ? "safari" : ""
    }
}, $(function () {
    $.adminX.browser.activate(), $.adminX.leftSideBar.activate(), $.adminX.rightSideBar.activate(), $.adminX.navbar.activate(), $.adminX.input.activate(), $.adminX.select.activate(), $.adminX.search.activate(), setTimeout(function () {
        $(".page-loader-wrapper").fadeOut()
    }, 50)
}), $(function () {
    skinChanger(), activateNotificationAndTasksScroll(), setSkinListHeightAndScroll(), setSettingListHeightAndScroll(), $(window).resize(function () {
        setSkinListHeightAndScroll(), setSettingListHeightAndScroll()
    })
}), $(window).scroll(function () {
    var a = $(window).scrollTop();
    a >= 30 ? $(".clearHeader").addClass("n-top") : $(".clearHeader").removeClass("n-top");
    var a = $(window).scrollTop();
    a >= 30 ? $(".morphsearch").addClass("m-top") : $(".morphsearch").removeClass("m-top")
}), $(".chat-app .chat .chat-history").slimscroll({
    height: "550px",
    color: "rgba(0,0,0,0.5)",
    size: "4px",
    alwaysVisible: !1,
    borderRadius: "3px",
    railBorderRadius: "0"
}), $(".chat-app .people-list .chat-list").slimscroll({
    height: "700px",
    color: "rgba(0,0,0,0.5)",
    size: "4px",
    alwaysVisible: !1,
    borderRadius: "3px",
    railBorderRadius: "0"
}), $(".chat-widget .chat-scroll-list").slimscroll({
    height: "334px",
    color: "rgba(0,0,0,0.5)",
    size: "4px",
    alwaysVisible: !1,
    borderRadius: "3px",
    railBorderRadius: "0"
}), $(".right-sidebar .slim-scroll").slimscroll({
    height: "calc(100vh - 56px)",
    color: "rgba(0,0,0,0.5)",
    size: "2px",
    alwaysVisible: !1,
    borderRadius: "3px",
    railBorderRadius: "0"
}), $(".theme-light-dark .t-dark").on("click", function () {
    $("body").removeClass("light")
}), $(".theme-light-dark .t-light").on("click", function () {
    $("body").addClass("light")
});