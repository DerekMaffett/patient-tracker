function readURL(input) {
if (input.files && input.files[0]) {
var reader = new FileReader();

reader.onload = function (e) {
$('#img_prev').attr('src', e.target.result)
$('#img_prev').css('visibility', 'visible')
.width(200)
.height(150);
};

reader.readAsDataURL(input.files[0]);
}
}
