from sercom.ziputil import *
from os import path

class Downloader:
    def __init__(self, response):
        self.response = response

    def download_zip(self, zip, nombre_arch_descarga):
        self.response.headers["Content-Type"] = "application/zip"
        content_disp = "attachment;filename=%s" % nombre_arch_descarga
        self.response.headers["Content-disposition"] = content_disp
        return zip

    def download_zip_content(self, zip, nombre_arch_interno):
        self.response.headers["Content-Type"] = "text/plain"
        content_disp = "filename=%s" % nombre_arch_interno
        self.response.headers["Content-disposition"] = content_disp
        return unzip_arch_interno(zip,nombre_arch_interno)

    def download_pdf(self, pdf, nombre_arch):
        self.response.headers["Content-Type"] = "application/pdf"
        content_disp = "attachment;filename=%s" % nombre_arch
        self.response.headers["Content-disposition"] = content_disp
        return pdf

    def download_csv(self, csv, nombre_arch):
        self.response.headers["Content-Type"] = "text/csv"
        content_disp = "attachment;filename=%s" % nombre_arch
        self.response.headers["Content-disposition"] = content_disp
        return csv
 
    def download_image(self, imagen, tipo_de_contenido, nombre_arch):
        self.response.headers["Content-Type"] = tipo_de_contenido  
        content_disp = "filename=%s" % nombre_arch
        self.response.headers["Content-disposition"] = content_disp
        return imagen

