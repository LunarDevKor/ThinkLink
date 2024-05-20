const ajax = {
    get(url, data) {
        return $.get(url,data);
    },
    postJSON(url, data) {
        return $.post(url, JSON.stringify(data));
    },
    postForm(url, data, success) {
        $.ajax({
            url: url,
            type: 'POST',
            data: data,
            processData: false,
            contentType: false,
            success: function(response) {
        		if(success) success(response);
			}
		});
	}
}