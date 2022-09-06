Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD65AF4FA
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIFTyp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiIFTw5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421DA3479
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:46 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JTY73026540;
        Tue, 6 Sep 2022 19:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=97ey7KZn+OAZRHrHvGlZPORcciAJ4tYoTtU1J+6T4+0=;
 b=cOWWMUrbzGu1pdnL/Ls46XD36bTvxbfs02b7MEHkqOqybCtJ59kq/5+M73BEd6xRpefr
 oLwv5SSjjGLy6ykIzSJf9o3n2oX/yo3S0lphUKc7+DpNcU/yATT6YHDaIu9V+ji8B2sC
 8TGpMbu/RiasYf7YROLo5DubfFDjFpfWjJbYsBVBsCHDASvyGsBtI2wbo6Ipsph7Rqs7
 H78GgFseRS46r74q5Aano+o4f694uC2wJ9roiU4BZmWzTMTnQhwXaSa4ivVDUO3HwqjT
 zRqGEN1obsObpVFYGJwGf1jFom2mot299nod3z/n5hg7D/hhKZfyJ/uhbPiTl+Cs1W/u uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jea8nvx96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286Jafgv013187;
        Tue, 6 Sep 2022 19:50:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hm6kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:39 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Joa0t38339066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A801211C04A;
        Tue,  6 Sep 2022 19:50:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7180311C052;
        Tue,  6 Sep 2022 19:50:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:35 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 03/12] Update configure.ac to address a couple of obsolete warnings
Date:   Tue,  6 Sep 2022 15:50:12 -0400
Message-Id: <20220906195021.854090-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gsntP2kaX3Om6xIoKWrn9QcMHt_Tl-xI
X-Proofpoint-ORIG-GUID: gsntP2kaX3Om6xIoKWrn9QcMHt_Tl-xI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
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

