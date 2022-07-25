//This function helps to fit data in datatable by flattening related fields. 
//Before using your data (ex. wire) use this function below on your data to get access to the related fields.

const _flatten = (nodeValue, flattenedRow, nodeName) => {
    let rowKeys = Object.keys(nodeValue);
    rowKeys.forEach((key) => {
        let finalKey = nodeName + '.' + key;
        flattenedRow[finalKey] = nodeValue[key];
    })
}

export function flattenData(data) {
    let eventsArray = [];

        for (let row of data) {
            const flattenedRow = {};
            let rowKeys = Object.keys(row);
            rowKeys.forEach((rowKey) => {
                const singleNodeValue = row[rowKey];

                if (singleNodeValue.constructor === Object) {
                    _flatten(singleNodeValue, flattenedRow, rowKey);
                } else flattenedRow[rowKey] = singleNodeValue;
            });

            eventsArray.push(flattenedRow);
        }
    return eventsArray;
}