const vscode = require('vscode');
const fs = require('fs');
const os = require('os');
const path = require('path');

// The file your bash script will update
const THEME_FILE_PATH = path.join(os.homedir(), '.cache', 'vscode-active-theme.json');
let fileWatcher = null;
let isEnabled = true;

function activate(context) {
    console.log('Live Theme Injector is active');

    // 1. Register Toggle Command
    let toggleCommand = vscode.commands.registerCommand('liveTheme.toggle', () => {
        isEnabled = !isEnabled;
        if (isEnabled) {
            applyTheme();
            vscode.window.showInformationMessage('Live Theme: Enabled');
        } else {
            clearTheme();
            vscode.window.showInformationMessage('Live Theme: Disabled (Standard themes will work now)');
        }
    });

    context.subscriptions.push(toggleCommand);

    // 2. Watch for file changes
    try {
        if (fs.existsSync(THEME_FILE_PATH)) {
            applyTheme();
        }

        const themeDir = path.dirname(THEME_FILE_PATH);
        const themeFileName = path.basename(THEME_FILE_PATH);

        fileWatcher = fs.watch(themeDir, (eventType, filename) => {
            if (filename === themeFileName && isEnabled) {
                // Wait briefly for the write to finish
                setTimeout(applyTheme, 100);
            }
        });
    } catch (err) {
        console.error("Failed to watch theme file:", err);
    }
}

function deactivate() {
    if (fileWatcher) fileWatcher.close();
}

function applyTheme() {
    if (!isEnabled) return;

    fs.readFile(THEME_FILE_PATH, 'utf8', (err, data) => {
        if (err) return;

        try {
            const theme = JSON.parse(data);
            const config = vscode.workspace.getConfiguration();

            // 1. Workbench Colors (Direct map)
            config.update('workbench.colorCustomizations', theme.colors || {}, vscode.ConfigurationTarget.Global);

            // 2. Token Colors (Wrap in textMateRules)
            if (theme.tokenColors) {
                config.update('editor.tokenColorCustomizations', {
                    "textMateRules": theme.tokenColors
                }, vscode.ConfigurationTarget.Global);
            }

            // 3. Semantic Colors (Wrap in enabled + rules)
            if (theme.semanticTokenColors) {
                config.update('editor.semanticTokenColorCustomizations', {
                    "enabled": true,
                    "rules": theme.semanticTokenColors
                }, vscode.ConfigurationTarget.Global);
            }

        } catch (parseError) {
            console.error("Error parsing theme JSON:", parseError);
        }
    });
}

function clearTheme() {
    const config = vscode.workspace.getConfiguration();
    // Remove the overrides so standard themes work
    config.update('workbench.colorCustomizations', undefined, vscode.ConfigurationTarget.Global);
    config.update('editor.tokenColorCustomizations', undefined, vscode.ConfigurationTarget.Global);
    config.update('editor.semanticTokenColorCustomizations', undefined, vscode.ConfigurationTarget.Global);
}

module.exports = {
    activate,
    deactivate
};
