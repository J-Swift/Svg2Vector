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
    private static final String DIR_INPUT = "/mounts/input";
    private static final String DIR_OUTPUT = "/mounts/output/android";

    private static int numErrors = 0;

    public static void main(final String[] args) {
        final File outdir = new File(DIR_OUTPUT);
        if (!outdir.exists()) {
            outdir.mkdirs();
        }

        try (Stream<Path> paths = Files.walk(Paths.get(DIR_INPUT))) {
            paths.filter(Files::isRegularFile).filter(Application::isSvg).forEach(Application::convertToXml);
        } catch (final IOException e) {
            e.printStackTrace();
        }

        if (numErrors == 0) {
            System.out.println("Done!");
        } else {
            System.out.println(String.format("Done with [%d] errors!", numErrors));
        }
        System.out.println("");
    }

    private static void convertToXml(final Path path) {
        try {
            final File infile = path.toFile();
            final File outfile = new File(DIR_OUTPUT + "/" + getXmlFilename(infile.getName()));

            if (outfile.exists()) {
                System.out.println(String.format("[%s] already exists... skipping", outfile.getName()));
                return;
            }

            try (OutputStream output = new FileOutputStream(outfile)) {
                System.out.print(String.format("Converting [%s] to [%s]...", infile.getName(), outfile.getName()));
                final String msg = Svg2Vector.parseSvgToXml(infile, output);
                // NOTE(jpr): Svg2Vector has some odd behaviour with regard to error messages. Even though it initializes
                // the message to `null`, it comes through as an empty string in a lot of cases. There are also times where
                // something is logged to the message but the file is still generated (e.g. `defs` is special cased in
                // their code)
                if (msg != null && !msg.isEmpty() && outfile.length() == 0) {
                    System.out.println(" error");
                    numErrors++;
                    if (outfile.exists()) {
                        outfile.delete();
                    }
                } else {
                    System.out.println(" done");
                }
            }
        } catch (final FileNotFoundException fnf) {
            System.out.println(" error");
        } catch (final IOException io) {
            System.out.println(" error");
        }
    }

    private static String getXmlFilename(final String svgFilename) {
        return String.format("%s.xml", svgFilename.substring(0, svgFilename.length() - 4));
    }

    private static boolean isSvg(final Path path) {
        return path.toString().toLowerCase().endsWith(".svg");
    }
}
