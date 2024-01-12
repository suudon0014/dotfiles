import {BaseConfig, ContextBuilder, Dpp, Plugin} from "https://deno.land/x/dpp_vim@v0.0.7/types.ts";
import {Denops, fn} from "https://deno.land/x/dpp_vim@v0.0.7/deps.ts";


export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
        dpp: Dpp;
    }): Promise<{
        plugins: Plugin[];
        stateLines: string[];
    }> {
        args.contextBuilder.setGlobal({
            protocols: ["git"],
        });

        type Toml = {
            hooks_file?: string;
            ftplugins?: Record<string, string>;
            plugins?: Plugin[];
        };

        type LazyMakeStateResult = {
            plugins: Plugin[];
            stateLines: string[];
        };

        const [context, options] = await args.contextBuilder.get(args.denops);
        const tomlFilesDir = "~/dotfiles/.vim/toml/";
        const tomls: Toml[] = [];

        tomls.push(
            await args.dpp.extAction(
                args.denops,
                context,
                options,
                "toml",
                "load", {
                    path: await fn.expand(args.denops, tomlFilesDir + "dein.toml"),
                    options: {
                        lazy: false,
                    },
                },
            ) as Toml,
        );

        // tomls.push(
        //     await args.dpp.extAction(
        //         args.denops,
        //         context,
        //         options,
        //         "toml",
        //         "load", {
        //             path: await fn.expand(args.denops, tomlFilesDir + "dpp_sample.toml"),
        //             options: {
        //                 lazy: true,
        //             },
        //         },
        //     ) as Toml,
        // );

        const recordPlugins: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hookFiles: string[] = [];

        tomls.forEach((toml) => {
            for (const plugin of toml.plugins ?? []){
                recordPlugins[plugin.name] = plugin;
            }

            if (toml.ftplugins){
                for (const filetype of Object.keys(toml.ftplugins)){
                    if (ftplugins[filetype]){
                        ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
                    } else{
                        ftplugins[filetype] = toml.ftplugins[filetype];
                    }
                }
            }

            if (toml.hooks_file){
                hookFiles.push(toml.hooks_file);
            }
        });

        const lazyResult = await args.dpp.extAction(
            args.denops,
            context,
            options,
            "lazy",
            "makeState",
            {
                plugins: Object.values(recordPlugins),
            },
        ) as LazyMakeStateResult;

	console.log(lazyResult);

        return {
            plugins: lazyResult.plugins,
            stateLines: lazyResult.stateLines,
        };
    }
}