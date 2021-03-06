package com.ucsd.whatsup;

import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    public static Boolean channel = false;

    public static final boolean ENABLE_LOGGING = false;

    public static void main(String[] args) {

        if (args.length != 7) {
            WLogger.Error("invalid number of arguments!");
            WLogger.Error("simulator.jar server_ip server_port total_clients messages_per_client " +
                    "message_size client_message_delay number_of_contacts");
            WLogger.Error("- server_ip: XMPP server ip address");
            WLogger.Error("- server_port: XMPP server port number (should be 5222)");
            WLogger.Error("- total_clients: total number of clients in the system (e.g. 100)");
            WLogger.Error("- messages_per_client: number of messages that each simulated client should send (e.g. 10)");
            WLogger.Error("- message_size: size of each message in bytes");
            WLogger.Error("- client_message_delay: the period that the each client waits between subsequent " +
                    "submissions (milliseconds)");
            WLogger.Error("- number_of_contacts: the number of contacts each client connects to (e.g. 10)");
            System.exit(1);
        }

        // Server configuration
        String server_ip = args[0];
        int server_port = Integer.parseInt(args[1]);

        // Simulator configuration
        int total_clients = Integer.parseInt(args[2]);
        int messages_per_client = Integer.parseInt(args[3]);
        int message_size = Integer.parseInt(args[4]);
        int client_message_delay = Integer.parseInt(args[5]);
        int number_of_contacts = Integer.parseInt(args[6]);

        // Read clients information
        ArrayList<String> my_clients = new ArrayList<String>();
        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNextLine()) {
            String c = scanner.nextLine();
            if (c.indexOf('|') < 0) {
                WLogger.Error("invalid input format for clients!");
                WLogger.Error("username|password expected, " + c + " received!");
                System.exit(1);
            }
            my_clients.add(c);
        }

        if (Main.ENABLE_LOGGING)
            WLogger.Log("Start initializing the clients");

        // Initialize the clients
        ArrayList<WClient> clients = new ArrayList<WClient>();
        for (String client : my_clients) {
            String username = client.substring(0, client.indexOf("|"));
            String password = client.substring(client.indexOf("|") + 1);

            WClient c = new WClient("T" + username);
            c.server_ip = server_ip;
            c.server_port = server_port;
            c.username = username;
            c.password = password;
            c.total_clients = total_clients;
            c.message_size = message_size;
            c.total_messages = messages_per_client;
            c.number_of_contacts = number_of_contacts;
            c.delay = client_message_delay;

            clients.add(c);
            c.start();

            if (Main.ENABLE_LOGGING)
                WLogger.Log(username + " initialized!");
        }

        if (Main.ENABLE_LOGGING)
            WLogger.Log("Finished initializing clients");

        channel = true;
        WLogger.StartTimer();

        // Wait for the clients to join
        for(WClient client : clients) {
            try { client.join(0); }
            catch (InterruptedException e) { /*e.printStackTrace();*/ WLogger.Error(e); }
        }

        WLogger.StopTimer();
        WLogger.Log("Terminated successfully");
        WLogger.PrintStats();


        System.exit(0);
    }
}
