import {BaseConfig, ContextBuilder, Dpp, Plugin} from "https://deno.land/x/dpp_vim@v0.0.2/types.ts";
import {Denops, fn} from "https://deno.land/x/dpp_vim@v0.2.2/deps.ts";


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

        const [context, options] = await args.contextBuilder.get(args.denops);

        const tomlPlugins = await args.dpp.extAction(
            args.denops,
            context,
            options,
            "toml",
            "load",
            {
                path: "$BASE_DIR/dein_lazy.toml",
                options: {
                    lazy: true,
                },
            },
        ) as Plugin[];

        const stateLines = await args.dpp.extAction(
            args.denops,
            context,
            options,
            "lazy",
            "makeState",
            {
                plugins: tomlPlugins,
            },
        ) as string[];

        return {
            plugins: tomlPlugins,
            stateLines,
        };
    }
}
