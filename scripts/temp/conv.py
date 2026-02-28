import os

SNIPPET_DIR = "/home/archboom/.config/nvim/lua/snippets"  # change if needed

for filename in os.listdir(SNIPPET_DIR):
    if filename.endswith(".lua"):
        path = os.path.join(SNIPPET_DIR, filename)
        with open(path, "r") as f:
            content = f.read()

        # Replace ls.add_snippets("lang", { ... }) with return { ... }
        new_content = content.replace("ls.add_snippets(", "return ")

        # Remove the first argument ("lang",)
        if new_content.startswith("return "):
            first_paren = new_content.find("(")
            if first_paren != -1:
                second_comma = new_content.find(",", first_paren)
                if second_comma != -1:
                    new_content = "return " + new_content[second_comma+1:].strip()

        # Remove trailing ')' if exists at the end
        if new_content.strip().endswith(")"):
            new_content = new_content.strip()
            new_content = new_content[:-1]

        with open(path, "w") as f:
            f.write(new_content)

print("All snippet files converted to return { ... } format.")

