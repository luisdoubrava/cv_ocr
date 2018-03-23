$(document).ready(function() {

    $('#processedVouchers .input-group').on('click', function() {
        var value = $(this).find('input').val();
        $(this).closest('.voucher-row').find('.voucher-code [type=text]').val(value);
    });

});
