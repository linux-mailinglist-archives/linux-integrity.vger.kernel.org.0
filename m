Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B295B7EF5
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiINCaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCaQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF845057
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:13 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1u6VW011370;
        Wed, 14 Sep 2022 02:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bniy1ulIUzo3NXXzZuvQMD4AY5vSfcSUm9l7WXv7ZwA=;
 b=q9xkTSBpYnROuA2eCno0H1r2z2pjUw+A0AH+uC8dwpDNzO9P2eqHtht/s0KzQgoN4po+
 yA02btQwTzJh3AxeuSmyTauQdM8Vp00eysBnjwQa1ymRYTxUAdZZkV8rj0VMQ44SajIa
 oUkmJ+wpXIhXG3hOtOqj45C3wdpr1fBrZN0ROPJIe4p3hTJg8TPAEEArdQ7PK2XdruoN
 f2gfpMmZwxNJ9H76CRqXDnrici37/foeqHBBo2O7YMNNcElv32fBHtDzfPpKWFtLMGRA
 FFYBBAk8i38vr/hgX3V3oD8s7lulc2/nmGiq655/jfnHpFYJ4rVTr7hoBIXzPNs8urNe 8Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk5qn0r2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2KkFR026717;
        Wed, 14 Sep 2022 02:30:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jjytx0aut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2U35Q40436028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF8FBA4055;
        Wed, 14 Sep 2022 02:30:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FD90A4040;
        Wed, 14 Sep 2022 02:30:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 02/15] Update configure.ac to address a couple of obsolete warnings
Date:   Tue, 13 Sep 2022 22:29:43 -0400
Message-Id: <20220914022956.1359218-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sq5mjpmNJprfCu9J38-zsCu7GRROSrEM
X-Proofpoint-ORIG-GUID: Sq5mjpmNJprfCu9J38-zsCu7GRROSrEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove AC_PROG_LIBTOOL and AC_HEAD_STDC. Replace AC_HELP_STRING with
AS_HELP_STRING.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 acinclude.m4              | 2 +-
 configure.ac              | 4 ----
 m4/manpage-docbook-xsl.m4 | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index dd430d4f0565..bb962f81a9c0 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -2,7 +2,7 @@
 AC_DEFUN([PKG_ARG_ENABLE],
 	[
 	AC_MSG_CHECKING(whether to enable $1)
-	AC_ARG_ENABLE([$1], AC_HELP_STRING([--enable-$1], [enable $1 (default is $2)]), 
+	AC_ARG_ENABLE([$1], AS_HELP_STRING([--enable-$1], [enable $1 (default is $2)]),
 	[pkg_cv_enable_$1=$enableval],	
 	[AC_CACHE_VAL([pkg_cv_enable_$1], [pkg_cv_enable_$1=$2])])
 	if test $pkg_cv_enable_$1 = yes; then
diff --git a/configure.ac b/configure.ac
index 1a0f093df562..9d3b23ff8def 100644
--- a/configure.ac
+++ b/configure.ac
@@ -15,16 +15,12 @@ AM_PROG_CC_C_O
 #AC_PROG_CXX
 #AC_PROG_CPP
 AC_PROG_INSTALL
-AC_PROG_LIBTOOL
 #AC_PROG_LN_S
 LT_INIT
 
 # FIXME: Replace `main' with a function in `-lpthread':
 #AC_CHECK_LIB([pthread], [main])
 
-# Checks for header files.
-AC_HEADER_STDC
-
 PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
 AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
diff --git a/m4/manpage-docbook-xsl.m4 b/m4/manpage-docbook-xsl.m4
index 25c8ce54b068..f2ee912ed1be 100644
--- a/m4/manpage-docbook-xsl.m4
+++ b/m4/manpage-docbook-xsl.m4
@@ -7,7 +7,7 @@ AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
 
 	AC_PATH_PROGS(XMLCATALOG, xmlcatalog)
 	AC_ARG_WITH([xml-catalog],
-		AC_HELP_STRING([--with-xml-catalog=CATALOG],
+		AS_HELP_STRING([--with-xml-catalog=CATALOG],
 				[path to xml catalog to use]),,
 				[with_xml_catalog=/etc/xml/catalog])
 	XML_CATALOG_FILE="$with_xml_catalog"
-- 
2.31.1

