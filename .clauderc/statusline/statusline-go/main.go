package main

import (
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"time"
)

// Legacy color definitions
const (
	Reset          = "\033[0m"
	Bold           = "\033[1m"
	NodeColor      = "\033[38;5;71m"
	NodeIconColor  = "\033[38;5;71m"
	PnpmColor      = "\033[38;5;202m"
	PnpmIconColor  = "\033[38;5;202m"
	DirColor       = "\033[38;5;248m"
	BranchColor    = "\033[32m"
	AddColor       = "\033[32m"
	DelColor       = "\033[31m"
	CleanColor     = "\033[2;37m"
	StashColor     = "\033[96m"
	CostColor      = "\033[38;5;214m" // orange for cost info
	SyncAheadColor = "\033[33m"     // yellow for ahead
	SyncBehindColor = "\033[31m"    // red for behind  
)

// Retro gradient colors for model name
var gradientColors = []string{
	"\033[95m", // bright magenta
	"\033[94m", // bright blue
	"\033[96m", // bright cyan
	"\033[92m", // bright green
	"\033[93m", // bright yellow
	"\033[91m", // bright red
}

// Emoji arrays
var modelEmojis = []string{
	"👽", "👻", "💫", "💨", "💭", "🤷‍♂️", "🤦‍♂️", "🏄‍♂️", "🐺", "🦊",
	"🐆", "🦄", "🦌", "🦬", "🐄", "🐖", "🐪", "🦙", "🦏", "🐇",
	"🦇", "🐻", "🦥", "🦨", "🦘", "🐓", "🐣", "🐥", "🦅", "🦢",
	"🦉", "🦩", "🐢", "🦎", "🦭", "🪸", "🐌", "🦂", "🌾", "🍀",
	"🍌", "🥭", "🥝", "🥥", "🍆", "🥕", "🌶️", "🧀", "🍕", "🎃",
	"🥋", "🔮", "🧸", "🪵", "🪂", "⛈️", "⚡️", "🌈", "🎹", "🕯️", "💡",
}

// Claude Code context structure (v1.0.85+)
type ClaudeContext struct {
	SessionID      string `json:"session_id"`
	TranscriptPath string `json:"transcript_path"`
	Cwd            string `json:"cwd"`
	Model          struct {
		ID          string `json:"id"`
		DisplayName string `json:"display_name"`
	} `json:"model"`
	Workspace struct {
		CurrentDir string `json:"current_dir"`
		ProjectDir string `json:"project_dir"`
	} `json:"workspace"`
}

// State management for emoji rotation
type EmojiState struct {
	CurrentIndex   int   `json:"current_index"`
	LastUpdateTime int64 `json:"last_update_time"`
}

// Git sync status structure
type GitSyncStatus struct {
	Ahead  int
	Behind int
	HasUpstream bool
}

func applyGradient(text string) string {
	var result strings.Builder
	colorCount := len(gradientColors)
	
	for i, char := range text {
		colorIndex := i % colorCount
		result.WriteString(gradientColors[colorIndex])
		result.WriteRune(char)
	}
	
	result.WriteString(Reset)
	return result.String()
}

func getCurrentDirName() string {
	wd, err := os.Getwd()
	if err != nil {
		return "unknown"
	}
	
	homeDir, _ := os.UserHomeDir()
	
	if wd == "/" {
		return "/"
	}
	if wd == homeDir {
		return "~"
	}
	
	if strings.HasPrefix(wd, homeDir) {
		relativePath := strings.TrimPrefix(wd, homeDir)
		if relativePath == "" {
			return "~"
		}
		return "~" + relativePath
	}
	
	return wd
}

func getGitEmoji() string {
	hour := time.Now().Hour()
	if hour >= 6 && hour < 18 {
		return "🦔" // Day hedgehog
	}
	return "🦦" // Night otter
}

func getStateFilePath() string {
	homeDir, _ := os.UserHomeDir()
	return filepath.Join(homeDir, ".claude", "statusline", "statusline-db.json")
}

func initStateFile(filePath string) {
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		os.MkdirAll(filepath.Dir(filePath), 0755)
		state := EmojiState{CurrentIndex: 0, LastUpdateTime: 0}
		data, _ := json.Marshal(state)
		ioutil.WriteFile(filePath, data, 0644)
	}
}

func getModelEmoji() string {
	stateFile := getStateFilePath()
	initStateFile(stateFile)
	
	data, err := ioutil.ReadFile(stateFile)
	if err != nil {
		return modelEmojis[0]
	}
	
	var state EmojiState
	if err := json.Unmarshal(data, &state); err != nil {
		return modelEmojis[0]
	}
	
	currentTime := time.Now().Unix()
	
	if currentTime-state.LastUpdateTime >= 3600 {
		state.CurrentIndex = (state.CurrentIndex + 1) % len(modelEmojis)
		state.LastUpdateTime = currentTime
		
		data, _ := json.Marshal(state)
		ioutil.WriteFile(stateFile, data, 0644)
	}
	
	return modelEmojis[state.CurrentIndex]
}

func getModelFromSettings() string {
	homeDir, _ := os.UserHomeDir()
	settingsPath := filepath.Join(homeDir, ".claude", "settings.json")
	
	data, err := ioutil.ReadFile(settingsPath)
	if err != nil {
		return "sonnet"
	}
	
	re := regexp.MustCompile(`"model"\s*:\s*"([^"]*)"`)
	matches := re.FindStringSubmatch(string(data))
	if len(matches) > 1 {
		return matches[1]
	}
	
	return "sonnet"
}

func getModelDisplayName() string {
	modelName := getModelFromSettings()
	lightGrayColor := "\033[38;5;250m"
	enSpace := "\u2002"
	
	switch modelName {
	case "opus":
		return enSpace + applyGradient("opus") + lightGrayColor + " 4.1" + Reset
	case "opusplan":
		return enSpace + applyGradient("opus plan") + lightGrayColor + " 4.1" + Reset
	case "sonnet":
		return enSpace + applyGradient("sonnet") + lightGrayColor + " 4.0" + Reset
	case "haiku":
		return enSpace + applyGradient("haiku") + lightGrayColor + " 3.5" + Reset
	default:
		return enSpace + applyGradient(modelName)
	}
}

func runCommand(command string, args ...string) string {
	cmd := exec.Command(command, args...)
	output, err := cmd.Output()
	if err != nil {
		return ""
	}
	return strings.TrimSpace(string(output))
}

func getNodeVersion() string {
	version := runCommand("node", "--version")
	if version != "" {
		return version
	}
	return "none"
}

func getPnpmVersion() string {
	version := runCommand("pnpm", "--version")
	if version != "" {
		return "v" + version
	}
	return "none"
}

func isGitRepo() bool {
	cmd := exec.Command("git", "rev-parse", "--git-dir")
	return cmd.Run() == nil
}

func getGitBranch() string {
	branch := runCommand("git", "branch", "--show-current")
	if branch == "" {
		return "detached"
	}
	return branch
}

func parseIntSafe(s string) int {
	val, err := strconv.Atoi(s)
	if err != nil {
		return 0
	}
	return val
}

func toSuperscript(n int) string {
	superscripts := []string{"⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"}
	
	if n == 0 {
		return superscripts[0]
	}
	
	result := ""
	temp := n
	
	for temp > 0 {
		digit := temp % 10
		result = superscripts[digit] + result
		temp /= 10
	}
	
	return result
}

func getBranchSyncStatus() GitSyncStatus {
	status := GitSyncStatus{Ahead: 0, Behind: 0, HasUpstream: false}
	
	output := runCommand("git", "status", "-b", "--porcelain")
	if output == "" {
		return status
	}
	
	lines := strings.Split(output, "\n")
	if len(lines) == 0 {
		return status
	}
	
	branchLine := lines[0]
	if !strings.HasPrefix(branchLine, "## ") {
		return status
	}
	
	if !strings.Contains(branchLine, "...") {
		return status
	}
	
	status.HasUpstream = true
	
	if strings.Contains(branchLine, "[ahead ") {
		re := regexp.MustCompile(`\[ahead (\d+)`)
		matches := re.FindStringSubmatch(branchLine)
		if len(matches) > 1 {
			if val := parseIntSafe(matches[1]); val > 0 {
				status.Ahead = val
			}
		}
	}
	
	if strings.Contains(branchLine, "behind ") {
		re := regexp.MustCompile(`behind (\d+)`)
		matches := re.FindStringSubmatch(branchLine)
		if len(matches) > 1 {
			if val := parseIntSafe(matches[1]); val > 0 {
				status.Behind = val
			}
		}
	}
	
	return status
}

func formatSyncIndicator(status GitSyncStatus) string {
	if !status.HasUpstream {
		return ""
	}
	
	if status.Ahead > 0 && status.Behind > 0 {
		aheadStr := toSuperscript(status.Ahead)
		behindStr := toSuperscript(status.Behind)
		return fmt.Sprintf("%s↕%s%s↓%s", SyncBehindColor, aheadStr, behindStr, Reset)
	} else if status.Ahead > 0 {
		aheadStr := toSuperscript(status.Ahead)
		return fmt.Sprintf("%s↑%s%s", BranchColor, aheadStr, Reset)
	} else if status.Behind > 0 {
		behindStr := toSuperscript(status.Behind)
		return fmt.Sprintf("%s↓%s%s", SyncAheadColor, behindStr, Reset)
	}
	
	return ""
}

func parseGitStats(stats string) (insertions, deletions string) {
	if stats == "" {
		return "0", "0"
	}
	
	insertionRe := regexp.MustCompile(`(\d+) insertion`)
	deletionRe := regexp.MustCompile(`(\d+) deletion`)
	
	insertionMatches := insertionRe.FindStringSubmatch(stats)
	deletionMatches := deletionRe.FindStringSubmatch(stats)
	
	insertions = "0"
	deletions = "0"
	
	if len(insertionMatches) > 1 {
		insertions = insertionMatches[1]
	}
	
	if len(deletionMatches) > 1 {
		deletions = deletionMatches[1]
	}
	
	return insertions, deletions
}

func getFileCount(command string, args ...string) int {
	output := runCommand(command, args...)
	if output == "" {
		return 0
	}
	return len(strings.Split(strings.TrimSpace(output), "\n"))
}

func getStashCount() int {
	output := runCommand("git", "stash", "list")
	if output == "" {
		return 0
	}
	return len(strings.Split(output, "\n"))
}

// Helper function to check if file descriptor is a terminal
func isTerminal(fd int) bool {
	stat, err := os.Stdin.Stat()
	if err != nil {
		return false
	}
	return (stat.Mode() & os.ModeCharDevice) != 0
}

func getCostInfo(context *ClaudeContext) string {
	if context == nil {
		return ""
	}
	
	// Convert context back to JSON
	contextJSON, err := json.Marshal(context)
	if err != nil {
		return ""
	}
	
	// Call ccusage statusline
	cmd := exec.Command("bun", "x", "ccusage", "statusline", "--visual-burn-rate", "emoji")
	cmd.Stdin = strings.NewReader(string(contextJSON))
	output, err := cmd.Output()
	if err != nil {
		return ""
	}
	
	ccusageOutput := strings.TrimSpace(string(output))
	if strings.Contains(ccusageOutput, "❌") {
		return ""
	}
	
	// Extract cost part using regex: | 💰 costs | 🔥
	re := regexp.MustCompile(`\| (💰.*) \| 🔥`)
	matches := re.FindStringSubmatch(ccusageOutput)
	if len(matches) > 1 {
		return fmt.Sprintf("%s%s%s", CostColor, matches[1], Reset)
	}
	
	return ""
}

func generateStatusline() string {
	var output strings.Builder
	
	// Check for JSON input from Claude Code v1.0.85+
	var claudeContext *ClaudeContext
	if !isTerminal(0) {
		input, err := io.ReadAll(os.Stdin)
		if err == nil && len(input) > 0 {
			var ctx ClaudeContext
			if json.Unmarshal(input, &ctx) == nil && ctx.SessionID != "" {
				claudeContext = &ctx
			}
		}
	}
	
	// Add explicit reset at start
	output.WriteString(Reset)
	
	// Directory section
	dirName := getCurrentDirName()
	output.WriteString(fmt.Sprintf("%s%s%s", DirColor, dirName, Reset))
	
	// Model section
	model := getModelDisplayName()
	modelEmoji := getModelEmoji()
	output.WriteString(fmt.Sprintf(" • %s%s", modelEmoji, model))
	
	// Node and PNPM section
	nodeVersion := getNodeVersion()
	pnpmVersion := getPnpmVersion()
	output.WriteString(fmt.Sprintf(" • %s%s󰎙%s %s%s%s • %s📦%s %s%s%s", 
		Bold, NodeIconColor, Reset, NodeColor, nodeVersion, Reset, 
		PnpmIconColor, Reset, PnpmColor, pnpmVersion, Reset))
	
	// Git section
	if isGitRepo() {
		branch := getGitBranch()
		syncStatus := getBranchSyncStatus()
		syncIndicator := formatSyncIndicator(syncStatus)
		
		if syncIndicator != "" {
			output.WriteString(fmt.Sprintf(" • 🌿 %s%s%s %s", BranchColor, branch, Reset, syncIndicator))
		} else {
			output.WriteString(fmt.Sprintf(" • 🌿 %s%s%s", BranchColor, branch, Reset))
		}
		
		// Git diff stats
		stagedStats := runCommand("git", "diff", "--cached", "--shortstat")
		unstagedStats := runCommand("git", "diff", "--shortstat")
		
		stagedFileCount := getFileCount("git", "diff", "--cached", "--name-only")
		modifiedFileCount := getFileCount("git", "diff", "--name-only") 
		untrackedCount := getFileCount("git", "ls-files", "--others", "--exclude-standard")
		totalFileCount := stagedFileCount + modifiedFileCount + untrackedCount
		
		stagedInsertions, stagedDeletions := parseGitStats(stagedStats)
		unstagedInsertions, unstagedDeletions := parseGitStats(unstagedStats)
		
		gitEmoji := getGitEmoji()
		hasUnstagedChanges := unstagedStats != "" || untrackedCount > 0
		
		if stagedStats != "" && hasUnstagedChanges {
			output.WriteString(fmt.Sprintf(" • %s %s(%d)%s %s+%s%s%s-%s%s %s✓%s | %s+%s%s%s-%s%s",
				gitEmoji, CleanColor, totalFileCount, Reset, AddColor, stagedInsertions, Reset, 
				DelColor, stagedDeletions, Reset, AddColor, Reset, AddColor, unstagedInsertions, 
				Reset, DelColor, unstagedDeletions, Reset))
		} else if stagedStats != "" {
			output.WriteString(fmt.Sprintf(" • %s %s(%d)%s %s+%s%s%s-%s%s %s✓%s",
				gitEmoji, CleanColor, stagedFileCount, Reset, AddColor, stagedInsertions, Reset, 
				DelColor, stagedDeletions, Reset, AddColor, Reset))
		} else if hasUnstagedChanges {
			unstagedFileCount := modifiedFileCount + untrackedCount
			output.WriteString(fmt.Sprintf(" • %s %s(%d)%s %s+%s%s%s-%s%s",
				gitEmoji, CleanColor, unstagedFileCount, Reset, AddColor, unstagedInsertions, 
				Reset, DelColor, unstagedDeletions, Reset))
		} else {
			output.WriteString(fmt.Sprintf(" • %s %sclean%s", gitEmoji, CleanColor, Reset))
		}
		
		// Stash count
		stashCount := getStashCount()
		if stashCount > 0 {
			output.WriteString(fmt.Sprintf(" • 💾 %sstash: %d%s", StashColor, stashCount, Reset))
		}
	} else {
		gitEmoji := getGitEmoji()
		output.WriteString(fmt.Sprintf(" • %s %sno git%s", gitEmoji, CleanColor, Reset))
	}
	
	// Cost information section
	costInfo := getCostInfo(claudeContext)
	if costInfo != "" {
		output.WriteString(fmt.Sprintf(" • %s", costInfo))
	}
	
	output.WriteString("\n")
	return output.String()
}

func main() {
	output := generateStatusline()
	fmt.Print(output)
}