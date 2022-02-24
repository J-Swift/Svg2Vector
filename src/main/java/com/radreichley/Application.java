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
    private static int numWarnings = 0;
    private static int numErrors   = 0;

    public static void main(final String[] args) {
        if (args.length != 2) {
            throw new IllegalArgumentException("Must provide input and output directory");
        }

        final String inputDir = args[0];
        final String outputDir = args[1];

        if (!new File(inputDir).isDirectory()) {
            throw new IllegalArgumentException(String.format("Not a valid directory [%s]!", inputDir));
        }
        if (!new File(outputDir).isDirectory()) {
            throw new IllegalArgumentException(String.format("Not a valid directory [%s]!", outputDir));
        }
        System.out.println(String.format("Using input [%s] output [%s]", inputDir, outputDir));

        final File outdir = new File(outputDir);
        if (!outdir.exists()) {
            outdir.mkdirs();
        }

        try (Stream<Path> paths = Files.walk(Paths.get(inputDir))) {
            paths.filter(Files::isRegularFile).filter(Application::isSvg).forEach((it) -> convertToXml(it, outputDir));
        } catch (final IOException e) {
            e.printStackTrace();
        }

        if (numErrors == 0 && numWarnings == 0) {
            System.out.println("Done!");
        } else {
            System.out.println(String.format("Done with [%d] warnings [%d] errors!", numWarnings, numErrors));
        }
        System.out.println("");
    }

    private static void convertToXml(final Path path, final String outputDir) {
        try {
            final File infile = path.toFile();
            final File outfile = new File(outputDir + "/" + getXmlFilename(infile.getName()));

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
                if (msg != null && !msg.isEmpty()) {
                    if (outfile.length() != 0) {
                        System.out.println(" warning");
                        numWarnings++;
                    } else {
                        System.out.println(" error");
                        numErrors++;
                        if (outfile.exists()) {
                            outfile.delete();
                        }
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
