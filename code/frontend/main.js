window.addEventListener('DOMContentLoaded', (event) => {
    getVisitCount();
});


const localApi = 'http://localhost:7071/api/GetResumeCounter';
//const functionApi = 'https://getresumecounterfuncj42k4jb.azurewebsites.net/api/GetResumeCounter?code=ZqJPl/2ss0o8ma9v3ScuBrtvbMchcoUOY17Rvnh0lHkn0Jm/5df8QQ=='; 

const getVisitCount = () => {
    let count = 30;
    fetch(functionApi)
    .then(response => {
        return response.json()
    })
    .then(response => {
        console.log("Website called function API.");
        count = response.count;
        document.getElementById('counter').innerText = count;
    }).catch(function(error) {
        console.log(error);
      });
    return count;
}
