Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3253870B17
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfGVVPW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 17:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729697AbfGVVPW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 17:15:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ML8jNX017101
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 17:15:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twhpsqb3c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 17:15:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 22 Jul 2019 22:15:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 22:15:15 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MLFEhr63111422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 21:15:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74D0711C04A;
        Mon, 22 Jul 2019 21:15:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B2C11C05C;
        Mon, 22 Jul 2019 21:15:13 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.145])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 21:15:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Date:   Mon, 22 Jul 2019 17:14:40 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19072221-0008-0000-0000-000002FFE048
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072221-0009-0000-0000-0000226D6AAD
Message-Id: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220233
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel does not expose the crypto agile TPM 2.0 PCR banks to
userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
application is required to read PCRs.

This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
tsspcrread is one application included in the ibmtss package.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v1:
- Based on Vitaly's review, test the popen "cmd"  return code.  Use
pclose to determine if the result of the popen command succeeded or
failed.  Removed the now unneeded checking for spaces.
- Dynamically allocated the error msg and other changes based on
Vitaly's review.
- Based on Bruno's review, reverted the return code change.  At some
point, we'll need to re-visit the return codes in general.

 configure.ac    |  3 +++
 src/Makefile.am |  3 +++
 src/evmctl.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9beb4b6c2377..40fea93fef2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,6 +28,8 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
 AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
+AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=yes], [have_ibmtss=no])
+AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" = "xyes"])
 
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
@@ -71,4 +73,5 @@ echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
+echo	"         ibmtss: $have_ibmtss"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index 9c037e21dc4f..f0990fb01210 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -21,6 +21,9 @@ evmctl_SOURCES = evmctl.c
 evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
+if CONFIG_IBMTSS
+evmctl_CFLAGS = -DIBMTSS
+endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
 
diff --git a/src/evmctl.c b/src/evmctl.c
index 9e0926f10404..f726b2186678 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1383,10 +1383,8 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	if (!fp)
 		fp = fopen(misc_pcrs, "r");
 
-	if (!fp) {
-		log_err("Unable to open %s or %s\n", pcrs, misc_pcrs);
+	if (!fp)
 		return -1;
-	}
 
 	for (;;) {
 		p = fgets(buf, sizeof(buf), fp);
@@ -1402,6 +1400,32 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }
 
+#ifdef IBMTSS
+static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
+{
+	FILE *fp;
+	char pcr[100];	/* may contain an error */
+	char cmd[36];
+	int ret;
+
+	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
+	fp = popen(cmd, "r");
+	if (!fp)
+		return -1;
+
+	fgets(pcr, sizeof(pcr), fp);
+
+	/* get the popen "cmd" return code */
+	ret = pclose(fp);
+	if (!ret)
+		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
+	else
+		*errmsg = strdup(pcr);
+
+	return ret;
+}
+#endif
+
 #define TCG_EVENT_NAME_LEN_MAX	255
 
 struct template_entry {
@@ -1658,8 +1682,24 @@ static int ima_measurement(const char *file)
 		log_info("PCRAgg %.2d: ", i);
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);
 
-		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
+		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
+#ifdef IBMTSS
+			char *errmsg = NULL;
+
+			err = tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
+			if (err) {
+				errmsg[strlen(errmsg) - 1] = 0;
+
+				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n (%s)\n", errmsg);
+				free(errmsg);
+				exit(1);
+			}
+#else
+			log_info("Failed to read TPM 1.2 PCRs.\n");
 			exit(1);
+#endif
+		}
+
 		log_info("HW PCR-%d: ", i);
 		log_dump(hwpcr, sizeof(hwpcr));
 
-- 
2.7.5

