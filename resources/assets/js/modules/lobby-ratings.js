//behavior inbox
$("#ratings").on("click-cell.bs.table", function(field, value, row, $element) {
  let me = $(this);
  let rId = $element.id;
  if (rId != undefined) {
    axios
      .get(api_url + "api/student/ratings/" + rId)
      .then(function(response) {
        let detail = response.data.detail;
        $("#plan-name").html(detail.name);
        $("#plan-group").html(detail.group);
        $("#plan-course").html(detail.course);

        let planItems = "";
        _.forEach(detail.items, function(item) {
          let studentRating =
             !_.isNull(item.rating)? item.rating.nota + "/" + item.base : "-";
          planItems +=
            '<div class="row">' +
            '<div class="col-6">' +
            item.name +
            "</div>" +
            '<div class="col">' +
            item.type +
            "</div>" +
            '<div class="col">' +
            studentRating +
            "</div>" +
            "</div>";
        });

        $("#plan-details").html(String(planItems));
        $("#ratings-item").modal();
      })
      .catch(function(error) {
        showAlert("problemas con el detalle de este plan");
      });
  }
});
