
export default {
    theme: defaultTheme({
        navbar: [
            // NavbarItem
            {
                text: 'Foo',
                link: '/foo/',
            },
            // NavbarGroup
            {
                text: 'Group',
                children: ['/group/foo.md', '/group/bar.md'],
            },
            // string - page file path
            '/bar/README.md',
        ],
    }),
}