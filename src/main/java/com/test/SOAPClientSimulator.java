package com.test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class SOAPClientSimulator {
	private String url;
	private String fName;
	private String input_xml;

	public SOAPClientSimulator(String url, String fName) {
		this.url = url;
		this.fName = fName;
	}

	public SOAPClientSimulator(String url, String input_xml, boolean dummy) {
		this.url = url;
		this.input_xml = input_xml;
	}

	public String triggerTransactionStr() {
		String xmlResponseString = "";

		try {
			OutputStream out = null;
			OutputStreamWriter wout = null;
			InputStream in = null;
			HttpURLConnection connection = null;

			String server = this.url;

			System.out.println("\nURL: " + server);
			try {
				URL u = new URL(server);
				URLConnection uc = u.openConnection();
				connection = (HttpURLConnection) uc;
				connection.setRequestMethod("POST");
				connection.setRequestProperty("content-type", "text/xml; charset=utf-8");
				connection.setRequestProperty("accept",
						"application/soap+xml, application/dime, multipart/related, text/*");
				connection.setRequestProperty("user-agent", "Axis/1.1");
				connection.setRequestProperty("host", "<server>:<port>");
				connection.setRequestProperty("cache-control", "no-cache");
				connection.setRequestProperty("pragma", "no-cache");
				connection.setRequestProperty("soapaction", "\"\"");

				connection.setDoOutput(true);
				connection.setDoInput(true);
				connection.setUseCaches(false);

				connection.connect();

				System.out.println("\nGetting the o/p stream:\n");
				OutputStream os = connection.getOutputStream();

				wout = new OutputStreamWriter(os, "UTF-8");
				wout.write(this.input_xml);
				wout.flush();
				os.close();

				int resCode = connection.getResponseCode();
				System.out.println("===================================================");
				System.out.println("Response Code from server: " + resCode);
				System.out.println("Response Message from server: " + connection.getResponseMessage());
				System.out.println("===================================================");
				StringBuffer response = new StringBuffer(10);
				if (resCode != HttpURLConnection.HTTP_OK) {
					in = connection.getErrorStream();
				} else {
					in = connection.getInputStream();
					if (in == null) {
						in = connection.getErrorStream();
					}
				}
				int c;
				while ((c = in.read()) != -1) {
					response.append((char) c);
				}

				xmlResponseString = response.toString();

				System.out.println(
						"\nFinal response from the server: \n=====================Starts========================");
				System.out.println(xmlResponseString);
				System.out.println("======================Ends=========================");

			} catch (ThreadDeath th) {
				System.out.println("Caught ThreadDeath: " + th);
				ThreadDeath tdExp = new ThreadDeath();
				tdExp.initCause(th);
				throw tdExp;
			} catch (java.net.ConnectException ce) {
				System.out.println("Caught ConnectException: " + ce);
				xmlResponseString = "Error:" + ce;
			} catch (FileNotFoundException fnfe) {
				System.out.println("Error !!! Can't read the input file: " + this.fName);
				xmlResponseString = "Error:" + fnfe;
			} catch (IOException ioe) {
				System.out.println("Caught IOException: " + ioe);
				xmlResponseString = "Error:" + ioe;
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
				if (null != wout) {
					wout.close();
				}
			}

		} catch (Exception e) {
			System.out.println("Caught Exception: " + e);
			xmlResponseString = "Error:" + e;

		}
		return xmlResponseString;
	}

	/*
	 * public static void main(String[] args) { if (args == null || args.length !=
	 * 1) { System.out.println("Wrong input parameter");
	 * System.out.println("Usage:");
	 * System.out.println("Java TestURL2 <inputXMLFileName>"); return; }
	 * SOAPClientSimulator client = new SOAPClientSimulator("target URL", args[0]);
	 * client.triggerTransactionStr(); }
	 */

}