package com.radreichley;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

import com.android.ide.common.vectordrawable.Svg2Vector;

public class Application {
    public static void main(final String[] args) {
        try (Stream<Path> paths = Files.walk(Paths.get("/mounts/input"))) {
            paths.filter(Files::isRegularFile).filter(Application::isSvg).forEach(Application::convertToXml);
        } catch (final IOException e) {
            e.printStackTrace();
        }

        System.out.println("");
        System.out.println("Done!");
    }

    private static void convertToXml(final Path path) {
        try {
            final File infile = path.toFile();
            final File outfile = new File(String.format("/mounts/output/%s", getXmlFilename(infile.getName())));

            if (outfile.exists()) {
                System.out.println(String.format("[%s] already exists... skipping", outfile.getName()));
                return;
            }

            try (OutputStream output = new FileOutputStream(outfile)) {
                System.out.print(String.format("Converting [%s] to [%s]...", infile.getName(), outfile.getName()));
                Svg2Vector.parseSvgToXml(infile, output);
            }
        } catch (final FileNotFoundException fnf) {
            System.out.println(" error");
            System.out.println();
            fnf.printStackTrace();
        } catch (final IOException io) {
            System.out.println(" error");
            System.out.println();
            io.printStackTrace();
        }
    }

    private static String getXmlFilename(final String svgFilename) {
        return String.format("%s.xml", svgFilename.substring(0, svgFilename.length() - 4));
    }

    private static boolean isSvg(final Path path) {
        return path.toString().toLowerCase().endsWith(".svg");
    }
}
