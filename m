Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE15AB688
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiIBQ3J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiIBQ3H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FDDB076
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:28:59 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282FTBPH028281;
        Fri, 2 Sep 2022 16:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=97ey7KZn+OAZRHrHvGlZPORcciAJ4tYoTtU1J+6T4+0=;
 b=M/u91k++xXUpVj+zP8tUflfGf16/boB/hkDHaSj7SsooqGmIkVEbAJll8NMyDLoBgM+7
 iWTuSIkozJuvvxDXj+oRNVFbGwTMmFvlC50fPF31S74UbWyxJEhMVAmb80eWEs13gm+B
 jvSeaCusLbpjo67jDc2nrbdhokSgeW9ETPhc3Ocn8hX6k9CSOm63EJ/P/ZIKGkWwFO4W
 aa/jkL6I5c+0hKWnapKt+k3hzP7+YLM7LYJyPD+N1eAoJw6V0mYUpRpcLuS913YHKezA
 tIrGni8/O4VRXBNlYlgv4faU+LKPwYw/WTcOtVcoW0/akgnzS2GTQ24d6vvMMlmM3HVi 4w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbmh01y4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:55 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G8YP4007865;
        Fri, 2 Sep 2022 16:28:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3j7aw9e6be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GTDlw39125468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:29:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 121BC5204E;
        Fri,  2 Sep 2022 16:28:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E26FD52050;
        Fri,  2 Sep 2022 16:28:49 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 03/11] Update configure.ac to address a couple of obsolete warnings
Date:   Fri,  2 Sep 2022 12:28:28 -0400
Message-Id: <20220902162836.554839-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902162836.554839-1-zohar@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GwWa16xKz-0DYmDNw2Dfs525C9yCSSKF
X-Proofpoint-ORIG-GUID: GwWa16xKz-0DYmDNw2Dfs525C9yCSSKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020075
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

