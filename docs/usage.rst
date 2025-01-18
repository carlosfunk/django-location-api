=====
Usage
=====

1. Add "location_api" and the other required packages to your INSTALLED_APPS setting like this::

    INSTALLED_APPS = [
        ...,
        "rest_framework",
        "rest_framework_gis",
        "location_api"
    ]

2. Include the location_api URL conf in your project urls.py like this::

    path("api/", include("location_api.urls")),
    path("", include("location_api.urls.search")),

3. Run ``python manage.py migrate`` to create the location models.

4. Start the development server and visit http://127.0.0.1:8000/admin/