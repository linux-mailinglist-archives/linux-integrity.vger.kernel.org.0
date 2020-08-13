Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E64243ECA
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMSZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgHMSZl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78885AE07;
        Thu, 13 Aug 2020 18:26:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 2/9] man: Fix xmlcatalog path detection
Date:   Thu, 13 Aug 2020 20:25:25 +0200
Message-Id: <20200813182532.6931-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

for catalogs which return plain file path (e.g.
/usr/.../manpages/docbook.xsl) instead of URI which starts
with file://). In that case sed printed empty string.

Fixes: 5fa7d35 ("autotools: Try to find correct manpage stylesheet
path")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/manpage-docbook-xsl.m4 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/m4/manpage-docbook-xsl.m4 b/m4/manpage-docbook-xsl.m4
index 24ae55a..2d8436e 100644
--- a/m4/manpage-docbook-xsl.m4
+++ b/m4/manpage-docbook-xsl.m4
@@ -1,4 +1,4 @@
-dnl Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+dnl Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 dnl Find docbook manpage stylesheet
 
 AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
@@ -19,7 +19,7 @@ AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
 	if test "x${XMLCATALOG}" != "x" -a "x$have_xmlcatalog_file" = "xyes"; then
 		DOCBOOK_XSL_URI="http://docbook.sourceforge.net/release/xsl/current"
 		DOCBOOK_XSL_PATH="manpages/docbook.xsl"
-		MANPAGE_DOCBOOK_XSL=$(${XMLCATALOG} ${XML_CATALOG_FILE} ${DOCBOOK_XSL_URI}/${DOCBOOK_XSL_PATH} | sed -n 's|^file:/\+|/|p;q')
+		MANPAGE_DOCBOOK_XSL=$(${XMLCATALOG} ${XML_CATALOG_FILE} ${DOCBOOK_XSL_URI}/${DOCBOOK_XSL_PATH} | sed 's|^file:/\+|/|')
 	fi
 	if test "x${MANPAGE_DOCBOOK_XSL}" = "x"; then
 		MANPAGE_DOCBOOK_XSL="/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl"
-- 
2.28.0

