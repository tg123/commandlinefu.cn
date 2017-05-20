jQuery(function ($) {

    $('body').terminal(
        {
            random: function (count) {
                var term = this;

                term.echo('Loading commands...');
                term.pause();
                
                $.get('/api/Random', { count: count })
                    .success(function (cmds) {

                        cmds.forEach(function (cmd) {
                            term.echo('\n[[;cyan;]' + $.terminal.escape_brackets(cmd.command) + ']');
                            term.echo('[[;green;]' + $.terminal.escape_brackets(cmd.summary) + ']');
                        }
                        );

                    }).always(function () {
                        term.set_command('random');
                        term.resume();
                    });
            },

            grep: function (str) {
                var term = this;

                if (!str) term.error('grep <str>');
                term.echo('Loading commands...');
                term.pause();
                $.get('/api/Search', { str: str })
                    .success(function (cmds) {

                        term.echo('showing top ' + Math.min(10, cmds.length) + ' of records');

                        cmds.forEach(function (cmd) {
                            term.echo('\n[[;cyan;]' + $.terminal.escape_brackets(cmd.command) + ']');
                            term.echo('[[;green;]' + $.terminal.escape_brackets(cmd.summary) + ']');
                        }
                        );

                    }).always(function () {
                        term.resume();
                    });
            },

            help: function () {
                var term = this;

                var helpcmd = function (cmd) {
                    $(cmd).find('a').click(function () {
                        var self = $(this);
                        term.set_command(self.text() + ' ');
                    });

                };

                var echohelp = function (cmd, text) {

                    term.echo('<a href="javascript:;">' + cmd + '</a>' + $.terminal.encode(text),
                        { raw: true, finalize: helpcmd });
                };

                term.echo('Commandlinefu.cn:');
                term.echo('weibo: http://weibo.com/commandlinefu');
                term.echo('github: http://github.com/tg123/commandlinefu.cn\n');
                term.echo('Commands:\n');

                echohelp('random', ' [count=1]: 随机显示[count]条命令和介绍');
                echohelp('grep', ' <str>: 查找包含str的命令');
                echohelp('help', ': 显示本帮助');
            }

        },
        {
            greetings: false,
            onInit: function (term) {
                term.exec('random 10');
                term.pause();
                term.exec('help');
                term.set_command('random');
            },
            checkArity: false,
            width: '100%',
            name: 'commandlinefu.cn',
            prompt: 'commandlinefu.cn>'
        });
});