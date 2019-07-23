Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3E71AE8
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfGWO40 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 10:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbfGWO40 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 10:56:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NEsj6U046585
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 10:56:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx395uf6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 10:56:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 23 Jul 2019 15:56:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 15:56:18 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NEuHQf20775154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 14:56:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B35D4C040;
        Tue, 23 Jul 2019 14:56:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F294C044;
        Tue, 23 Jul 2019 14:56:16 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.145])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 14:56:16 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Date:   Tue, 23 Jul 2019 10:55:43 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19072314-4275-0000-0000-0000034FDE7C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072314-4276-0000-0000-0000386003E2
Message-Id: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel does not expose the crypto agile TPM 2.0 PCR banks to
userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
application is required to read PCRs.

This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
tsspcrread is one application included in the ibmtss package.

Sample error messages:
Failed to read PCRs: (tsspcrread failed: No such file or directory)
Failed to read PCRs: (TSS_Dev_Open: Error opening /dev/tpmrm0)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v2:
- Fix "errmsg" not always being initialized within tpm_pcr_read2().
  Reported by Bruno.
- Shortened error msg length.
- Renamed tpm_pcr_read2() to tpm2_pcr_read().
- Included Petr Vorel's autotool change, which looks for tsspcrread,
  rather than the tss library.

Changelog v1:
- Based on Vitaly's review, test the popen "cmd"  return code.  Use
pclose to determine if the result of the popen command succeeded or
failed.  Removed the now unneeded checking for spaces.
- Dynamically allocated the error msg and other changes based on
Vitaly's review.
- Based on Bruno's review, reverted the return code change.  At some
point, we'll need to re-visit the return codes in general.

 configure.ac |  6 ++++++
 src/evmctl.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9beb4b6c2377..09b111c4ca4a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,11 @@ AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
+AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
+if test "x$TSSPCRREAD" = "xyes"; then
+	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binary installed])],
+fi
+
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
 
@@ -71,4 +76,5 @@ echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
+echo	"     tsspcrread: $TSSPCRREAD"
 echo
diff --git a/src/evmctl.c b/src/evmctl.c
index 9e0926f10404..9a2bfad928d1 100644
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
@@ -1402,6 +1400,41 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }
 
+#ifdef HAVE_TSSPCRREAD
+static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
+{
+	FILE *fp;
+	char pcr[100];	/* may contain an error */
+	char cmd[50];
+	int ret;
+
+	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
+	fp = popen(cmd, "r");
+	if (!fp) {
+		snprintf(pcr, sizeof(pcr), "popen failed: %s", strerror(errno));
+		*errmsg = strdup("popen failed:");
+		return -1;
+	}
+
+	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
+		snprintf(pcr, sizeof(pcr), "tsspcrread failed: %s",
+			 strerror(errno));
+		*errmsg = strdup(pcr);
+		ret = pclose(fp);
+		return -1;
+	}
+
+	/* get the popen "cmd" return code */
+	ret = pclose(fp);
+	if (!ret)
+		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
+	else
+		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
+
+	return ret;
+}
+#endif
+
 #define TCG_EVENT_NAME_LEN_MAX	255
 
 struct template_entry {
@@ -1658,8 +1691,22 @@ static int ima_measurement(const char *file)
 		log_info("PCRAgg %.2d: ", i);
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);
 
-		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
+		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
+#ifdef HAVE_TSSPCRREAD
+			char *errmsg = NULL;
+
+			err = tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);
+			if (err) {
+				log_info("Failed to read PCRs: (%s)\n", errmsg);
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

