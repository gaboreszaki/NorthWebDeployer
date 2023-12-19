import {defaultTheme} from '@vuepress/theme-default'
import {defineUserConfig} from 'vuepress'


export default defineUserConfig({
    lang: 'en-US',
    title: 'NWS - Deployer',
    description: 'North Web Solutions - deployer app & documentations',

    theme: defaultTheme({

        // You can also set it to a URL directly
        repo: 'https://github.com/gaboreszaki/deployer',
        navbar: [
            // nested group - max depth is 2
            {
                text: 'Guide',
                children: [
                    {
                        text: "Configure Github Actions",
                        link: "",
                    },
                    {
                        text: "Configure Apache",
                        link: "",
                    },
                    {
                        text: "Create deployer User ",
                        link: "",
                    },
                ],
            },
            // control when should the item be active
            {
                text: 'Deployer App',
                children: [
                    {
                        text: 'Always active',
                        link: '/',
                        // this item will always be active
                        activeMatch: '/',
                    },
                    {
                        text: 'Active on /foo/',
                        link: '/not-foo/',
                        // this item will be active when current route path starts with /foo/
                        // regular expression is supported
                        activeMatch: '^/foo/',
                    },
                ],
            },
        ],
    }),
})