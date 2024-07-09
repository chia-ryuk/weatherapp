package weatherapp;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet(urlPatterns = { "/location" })
public class WeatherAPIController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HashMap<String, String> map = new HashMap<String, String>();
		PreferredLocationModel preferredLocationById = new PreferredLocationDAO().getPreferredLocationById(1);
		if (preferredLocationById != null)
			map.put("data", preferredLocationById.getPreferredLocation());
		else
			map.put("data", "NA");
		resp.setContentType("application/json");
		String json = new Gson().toJson(map);
		System.out.println(json);
		resp.getWriter().append(json);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String body = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
		if (body.length() > 0) {
			PreferredLocationModel preferredLocationById = new PreferredLocationDAO().getPreferredLocationById(1);
			PreferredLocationModel location = new PreferredLocationModel();
			location.setId(1);
			location.setPreferredLocation(body);
			if (preferredLocationById == null) {
				new PreferredLocationDAO().addPreferredLocation(location);
			} else {
				new PreferredLocationDAO().updatePreferredLocation(location);
			}

		}
	}
}
