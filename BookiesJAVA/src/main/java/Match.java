import java.util.Date;

public class Match {

    int round;

    String teamA;
    String teamB;

    Integer scoreA;
    Integer scoreB;

    String hour;
    String matchDate;

    public Match(int round, String teamA, String teamB, Integer scoreA, Integer scoreB, String hour, String matchDate) {
        this.round = round;
        this.teamA = teamA;
        this.teamB = teamB;
        this.scoreA = scoreA;
        this.scoreB = scoreB;
        this.hour = hour;
        this.matchDate = matchDate;
    }

    @Override
    public String toString() {
        return "date: " + matchDate + " " + hour + "\n" +
                scoreA + "\t : " + teamA + "\n" +
                scoreB + "\t : " + teamB + "\n";
    }
}
