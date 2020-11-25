function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function partyOnScreen() {
  party.screen({ 
    count: 1000 * (window.innerWidth / 1980),
    countVariation: 10,
    angleSpan: 0,
    yVelocity: -100,
    yVelocityVariation: 10,
    rotationVelocityLimit: 9,
    scaleVariation: 2
  });
}

function sendProgram() {
  var email = document.getElementById("email").value;
  var params = { 
    full_program: {
      email: email,
    }
  }
  fetch('/full-program', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Transaction': 'POST',
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    body: JSON.stringify(params)
  }).then(function(response){
    console.log(response.json)
    console.log(response)
    if(response.status === 200) {
      $("#alert-success").fadeIn();
      partyOnScreen();
      sleep(2500).then(() => { 
        $('#programEmail').modal('hide'); 
        $("#alert-success").fadeOut();
      })
    } else {
      $("#alert-danger").fadeIn();
      sleep(4000).then(() => { $("#alert-danger").fadeOut(); })
    }
    return
  }).catch(function(error){
    $("#alert-danger").show();
    console.log(error);
    return
  });
  return

}