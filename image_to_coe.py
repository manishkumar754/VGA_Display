from PIL import Image

# ================================
# User Settings
# ================================
INPUT_IMAGE = "download.jpg"       # Your image
OUTPUT_COE  = "image.coe"       # Output file
WIDTH       = 300
HEIGHT      = 200
# ================================


def rgb888_to_rgb444(r, g, b):
    """Convert 8-bit RGB to 4-bit RGB444."""
    r4 = r >> 4
    g4 = g >> 4
    b4 = b >> 4
    return (r4 << 8) | (g4 << 4) | b4


def generate_coe(img_path, coe_path):
    print("Loading image:", img_path)

    # Load image
    img = Image.open(img_path).convert("RGB")
    
    # Resize to 300x200 exactly
    img = img.resize((WIDTH, HEIGHT), Image.LANCZOS)
    pixels = img.load()

    # Start building COE file
    coe_lines = []
    coe_lines.append("memory_initialization_radix=16;")
    coe_lines.append("memory_initialization_vector=")

    print("Converting pixels to RGB444...")

    # Loop through 200 rows
    for y in range(HEIGHT):
        for x in range(WIDTH):
            r, g, b = pixels[x, y]
            value_12bit = rgb888_to_rgb444(r, g, b)
            coe_lines.append("{:03X},".format(value_12bit))

    # Replace last comma with semicolon
    coe_lines[-1] = coe_lines[-1].rstrip(',') + ";"

    # Write .coe file
    with open(coe_path, "w") as f:
        f.write("\n".join(coe_lines))

    print("COE file generated:", coe_path)


if __name__ == "__main__":
    generate_coe(INPUT_IMAGE, OUTPUT_COE)
