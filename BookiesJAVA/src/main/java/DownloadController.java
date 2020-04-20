import network.HtmlParser;
import network.HttpRequestFunctions;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DownloadController {

    public static ArrayList<Match> getMatches(String link, int round) {

        DownloadController.DownloadSite(link, "files/site.html");
        HtmlParser.parse("files/site.html");

        Document html = Jsoup.parse(DownloadController.getCodeFromFile("files/site.html"));
        ArrayList<Match> matchStorage = new ArrayList<>();

        Elements matches = html.body().getElementsByClass("game-info");
        for (Element match : matches) {

            Elements teams = match.getElementsByClass("left");
            Elements scores = match.getElementsByClass("right");
            Elements hours = match.getElementsByClass("game-data");
            Elements dates = match.getElementsByClass("game-ldate");

            int tempScoreA = 0;
            int tempScoreB = 0;


            if(scores.get(0).text().equals("") || scores.get(1).text().equals("")){
                matchStorage.add(new Match(round,
                        teams.get(0).text(),
                        teams.get(1).text(),
                        null,
                        null,
                        DownloadController.ExtractDate(hours.get(0).text()),
                        DownloadController.FormatDate(dates.get(0).text())));
            }
            else {
                matchStorage.add(new Match(round,
                        teams.get(0).text(),
                        teams.get(1).text(),
                        Integer.parseInt(scores.get(0).text()),
                        Integer.parseInt(scores.get(1).text()),
                        DownloadController.ExtractDate(hours.get(0).text()),
                        DownloadController.FormatDate(dates.get(0).text())));
            }
        }
        return matchStorage;
    }

    private static String getCodeFromFile(String filename) {
        StringBuilder content_site = new StringBuilder();
        File file = new File(filename);
        String line;
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            while ((line = br.readLine()) != null) {
                content_site.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return content_site.toString();
    }

    private static void DownloadSite(String link, String filenameOut) {
        try {
            HttpRequestFunctions.httpRequest1(link, "", filenameOut);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String ExtractDate(String date) {
        String output = "";

        String regex = "\\d{1,2}:\\d{1,2}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(date);

        while (matcher.find()) {
            output = matcher.group();
        }
        return output;
    }

    private static String FormatDate(String date) {
        StringBuilder output = new StringBuilder();
        String[] components;

        components = date.split("[/:\\-]");
        for (int i = 0; i < components.length; i++) {
            if (components[i].length() <= 1) {
                components[i] = "0" + components[i];
            }
            output.append(components[i]);
            if (i < components.length - 1) {
                output.append("/");
            }
        }
        return output.toString();
    }
}
