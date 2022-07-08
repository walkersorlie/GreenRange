const contactForm = document.getElementById('contactForm');
const submitButton = document.getElementById('submitButton');


function handleSubmit(event) {
	if (!contactForm.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();
	} else {
		let formData = new FormData(contactForm);
		console.log(formData.get("nameInput"));
		console.log(formData.get("emailInput"));
		fetch("/", {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: new URLSearchParams(formData).toString(),
		})
		.then(() => {
			document.getElementById("formSubmitSuccess").style.display = 'block';
			console.log("Form successfully submitted");
		})
		.catch((error) => {
			alert('There was a problem submitting the form. Please try again.');
			console.log(error);
		});
	}
	
	contactForm.classList.add('was-validated');
};

submitButton.addEventListener('click', handleSubmit, false);
