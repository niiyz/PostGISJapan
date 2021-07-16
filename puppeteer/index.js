console.log('puppeteer')

const pptr = require('puppeteer');

async function run() {
    const browser = await pptr.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage'
        ]
    })
    // create page
    const page = await browser.newPage();

    // fix screen size
    await page.setViewport({ width: 720, height: 600 })

    // select url
    await page.goto('https://www.google.co.jp/');

    console.log(await page.title());

    await page.screenshot({path: "/app/test.png", fullPage: true});

    // close browser
    await browser.close()
}

run();