import puppeteer from "puppeteer";

const main = async (): Promise<void> => {
    const browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage'
        ]
    })
    const page = await browser.newPage();

    await page.setViewport({ width: 720, height: 600 })

    await page.goto('https://www.openstreetmap.org/');

    console.log(await page.title());

    await page.screenshot({path: "/app/test.png", fullPage: true});

    await browser.close()
}

main().then(() => {
    console.log("puppeteer finish");
});