// Prevent uploading of big images.
document.addEventListener("turbo:load", function() {
    document.addEventListener("change", function(event) {
        let image_upload = document.querySelector('#micropost_image');
         if (size_in_megabytes > 5) {
            alert("Maximum file size is 5MB. Please choose a smaller file.");
            image_upload.value = "";
         }
    });
});
