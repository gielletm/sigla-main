package it.cnr.contab.util.servlet;

import it.cnr.contab.cmis.service.SiglaCMISService;
import it.cnr.contab.service.SpringUtil;
import it.cnr.jada.action.BusinessProcess;
import it.cnr.jada.action.HttpActionContext;
import it.cnr.jada.util.Introspector;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Servlet implementation class GenericDownload
 */
public class GenericDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private transient final static Logger LOGGER = LoggerFactory.getLogger(GenericDownloadServlet.class);
	private static final String AUTHORIZATION = "Authorization";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenericDownloadServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SiglaCMISService cmisService = SpringUtil.getBean("cmisService", SiglaCMISService.class);
		if (request.getParameter("nodeRef")!= null){

			UsernamePasswordCredentials customCredentials = getCredentials(request.getHeader(AUTHORIZATION));
			Document node = (Document)cmisService.getNodeByNodeRef(request.getParameter("nodeRef"), customCredentials);
			InputStream is = cmisService.getResource(node);
			response.setContentLength(Long.valueOf(node.getContentStreamLength()).intValue());
			response.setContentType(node.getContentStreamMimeType());
			OutputStream os = response.getOutputStream();
			response.setDateHeader("Expires", 0);
			byte[] buffer = new byte[response.getBufferSize()];
			int buflength;
			while ((buflength = is.read(buffer)) > 0) {
				os.write(buffer,0,buflength);
			}
			is.close();
			os.flush();
		}else{
			HttpActionContext actionContext = new HttpActionContext(this, request, response);
			try {
				if (request.getParameter("methodName") != null)
					Introspector.invoke(BusinessProcess.getBusinessProcess(request), request.getParameter("methodName"), actionContext);
			} catch (NoSuchMethodException e) {
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			} catch (InvocationTargetException e) {
				throw new ServletException(e.getTargetException().getMessage(), e);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	private UsernamePasswordCredentials getCredentials(String authorization){

		if (authorization != null) {
			String[] values = authorization.split(" ");

			if (values.length == 2 && values[0].equals("Basic")) {

				String base64 = values[1];
				String decoded = new String(
						DatatypeConverter.parseBase64Binary(base64));

				int sep = decoded.indexOf(':');
				LOGGER.debug("decoded value: " + decoded);

				String username = decoded.substring(0, sep);
				String password = decoded.substring(sep + 1);

				LOGGER.info("username: " + username);
				LOGGER.info("password: " + password);

				return new UsernamePasswordCredentials(username,
						password);


			} else {
				LOGGER.info("Problemi con Authorization Header: " + authorization);
			}
		} else {
			LOGGER.info("authorization is null");
		}

		return null;
	}

}
