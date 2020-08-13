Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72451243ECD
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMSZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2DB2AE39;
        Thu, 13 Aug 2020 18:26:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 3/9] man: Generate doc targets only when XSL found
Date:   Thu, 13 Aug 2020 20:25:26 +0200
Message-Id: <20200813182532.6931-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As requiring manpages/docbook.xsl breaks build if not found.

Also rewrite the check to add more debug info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile.am               |  4 ++++
 configure.ac              |  1 +
 m4/manpage-docbook-xsl.m4 | 34 +++++++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 45c6f82..17fd478 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,5 +1,7 @@
 SUBDIRS = src tests
+if MANPAGE_DOCBOOK_XSL
 dist_man_MANS = evmctl.1
+endif
 
 doc_DATA =  examples/ima-genkey-self.sh examples/ima-genkey.sh examples/ima-gen-local-ca.sh
 EXTRA_DIST = autogen.sh $(doc_DATA)
@@ -23,6 +25,7 @@ rpm: $(tarname)
 	cp $(tarname) $(SRCS)/
 	rpmbuild -ba --nodeps $(SPEC)
 
+if MANPAGE_DOCBOOK_XSL
 evmctl.1.html: README
 	@asciidoc -o $@ $<
 
@@ -35,5 +38,6 @@ rmman:
 	rm -f evmctl.1
 
 doc: evmctl.1.html rmman evmctl.1
+endif
 
 .PHONY: $(tarname)
diff --git a/configure.ac b/configure.ac
index 8e13b61..a2e68d0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,4 +79,5 @@ echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
+echo	"            doc: $have_doc"
 echo
diff --git a/m4/manpage-docbook-xsl.m4 b/m4/manpage-docbook-xsl.m4
index 2d8436e..25c8ce5 100644
--- a/m4/manpage-docbook-xsl.m4
+++ b/m4/manpage-docbook-xsl.m4
@@ -2,6 +2,9 @@ dnl Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 dnl Find docbook manpage stylesheet
 
 AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
+	DOCBOOK_XSL_URI="http://docbook.sourceforge.net/release/xsl/current"
+	DOCBOOK_XSL_PATH="manpages/docbook.xsl"
+
 	AC_PATH_PROGS(XMLCATALOG, xmlcatalog)
 	AC_ARG_WITH([xml-catalog],
 		AC_HELP_STRING([--with-xml-catalog=CATALOG],
@@ -9,20 +12,37 @@ AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
 				[with_xml_catalog=/etc/xml/catalog])
 	XML_CATALOG_FILE="$with_xml_catalog"
 	AC_SUBST([XML_CATALOG_FILE])
-	AC_MSG_CHECKING([for XML catalog ($XML_CATALOG_FILE)])
-	if test -f "$XML_CATALOG_FILE"; then
-		have_xmlcatalog_file=yes
-		AC_MSG_RESULT([found])
+
+	if test "x${XMLCATALOG}" = "x"; then
+		AC_MSG_WARN([xmlcatalog not found, cannot search for $DOCBOOK_XSL_PATH])
 	else
-		AC_MSG_RESULT([not found])
+		AC_MSG_CHECKING([for XML catalog ($XML_CATALOG_FILE)])
+		if test -f "$XML_CATALOG_FILE"; then
+			have_xmlcatalog_file=yes
+			AC_MSG_RESULT([found])
+		else
+			AC_MSG_RESULT([not found, cannot search for $DOCBOOK_XSL_PATH])
+		fi
 	fi
+
 	if test "x${XMLCATALOG}" != "x" -a "x$have_xmlcatalog_file" = "xyes"; then
-		DOCBOOK_XSL_URI="http://docbook.sourceforge.net/release/xsl/current"
-		DOCBOOK_XSL_PATH="manpages/docbook.xsl"
 		MANPAGE_DOCBOOK_XSL=$(${XMLCATALOG} ${XML_CATALOG_FILE} ${DOCBOOK_XSL_URI}/${DOCBOOK_XSL_PATH} | sed 's|^file:/\+|/|')
 	fi
+
 	if test "x${MANPAGE_DOCBOOK_XSL}" = "x"; then
 		MANPAGE_DOCBOOK_XSL="/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl"
+		AC_MSG_WARN([trying a default path for $DOCBOOK_XSL_PATH])
 	fi
+
+	if test -f "$MANPAGE_DOCBOOK_XSL"; then
+		have_doc=yes
+		AC_MSG_NOTICE([using $MANPAGE_DOCBOOK_XSL for generating doc])
+	else
+		AC_MSG_WARN([$DOCBOOK_XSL_PATH not found, generating doc will be skipped])
+		MANPAGE_DOCBOOK_XSL=
+		have_doc=no
+	fi
+	AM_CONDITIONAL(MANPAGE_DOCBOOK_XSL, test "x$have_doc" = xyes)
+
 	AC_SUBST(MANPAGE_DOCBOOK_XSL)
 ])
-- 
2.28.0

