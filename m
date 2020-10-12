Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50D728C55B
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgJLXoc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388814AbgJLXoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNX2rM169710
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9xQTIS7xQtyJR/HMaQCsr/hBQtctJigfzU9FxsbVrrk=;
 b=E5esfEW1o5ZcUC4gONHUPtpL0B1GPmoSV1QWBlEbopBSXTdiNlbv3I0/YpJAmhmJ2fYs
 xoFuxlt6QZQEZp3aRI+Gx3tlio7hi4XiQP25+4vMK/p3WvhK7fc1YBovVV6EbNOUuHsX
 b0YKvLaCqWMV5D1xXJyzBgRPN2RvOADOtabfYMuE8Ku4O6hVJ8eiY4WaATPji2D6uEy1
 o9xQG+0Nwp1V8KBPyWcI9g0ZRXYeHfFWPDjG6YrIRB7uDA9Zz9uqvqUkPT4HJonOPjGV
 4jfWLO7XRTfY8APp8byh2vywLD2VNoUArdTLJbEbK4jxrTx2+lSN/oC967ePgWH8yaZ3 fA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344yrfhhr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNfhOa000555
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:30 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3434k8g0hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiSFb50135474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCEDCB2064;
        Mon, 12 Oct 2020 23:44:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F1B9B205F;
        Mon, 12 Oct 2020 23:44:28 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:28 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 3/5] ima-evm-utils: Change tpm2_pcr_read() to use C code
Date:   Mon, 12 Oct 2020 19:44:14 -0400
Message-Id: <20201012234416.20995-4-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012234416.20995-1-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace the call out to the command line tools with C functions.

The algorithm_string_to_algid() function supports only the digest
algorithms in use.  The table has place holders for other agorithms as
they are needed and the C strings are defined.

The table can also be used for an algrithm ID to string function if
it's ever needed.

When using the IBM TSS, link in its library.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 src/Makefile.am      |   1 +
 src/pcr_tsspcrread.c | 156 +++++++++++++++++++++++++++++++++----------
 2 files changed, 123 insertions(+), 34 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index d6c779f..bf18caf 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -26,6 +26,7 @@ if USE_PCRTSS
 evmctl_SOURCES += pcr_tss.c
 else
 evmctl_SOURCES += pcr_tsspcrread.c
+evmctl_LDADD += -libmtss
 endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 118c7d2..eae68b7 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -50,6 +50,10 @@
 #include "utils.h"
 #include "imaevm.h"
 
+#define TPM_POSIX	/* use Posix, not Windows constructs in TSS */
+#undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
+#include <ibmtss/tss.h>
+
 #define CMD "tsspcrread"
 
 static char path[PATH_MAX];
@@ -68,44 +72,128 @@ int tpm2_pcr_supported(void)
 	return 1;
 }
 
-int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
-		 int len, char **errmsg)
-{
-	FILE *fp;
-	char pcr[100];	/* may contain an error */
-	char cmd[PATH_MAX + 50];
-	int ret;
-
-	sprintf(cmd, "%s -halg %s -ha %d -ns 2> /dev/null",
-		path, algo_name, pcrHandle);
-	fp = popen(cmd, "r");
-	if (!fp) {
-		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
-		if (ret == -1)	/* the contents of errmsg is undefined */
-			*errmsg = NULL;
-		return -1;
-	}
+/* Table mapping C strings to TCG algorithm identifiers */
+
+typedef struct tdAlgorithm_Map {
+    const char *algorithm_string;
+    TPMI_ALG_HASH algid;
+} Algorithm_Map;
 
-	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
-		ret = asprintf(errmsg, "tsspcrread failed: %s",
-			       strerror(errno));
-		if (ret == -1)	/* the contents of errmsg is undefined */
-			*errmsg = NULL;
-		ret = pclose(fp);
-		return -1;
+Algorithm_Map algorithm_map[] = {
+				 { "sha1", TPM_ALG_SHA1},
+				 { "sha256", TPM_ALG_SHA256},
+#if 0	/* uncomment as these digest algorithms are supported */
+				 { "", TPM_ALG_SHA384},
+				 { "", TPM_ALG_SHA512},
+				 { "", TPM_ALG_SM3_256},
+				 { "", TPM_ALG_SHA3_256},
+				 { "", TPM_ALG_SHA3_384},
+				 { "", TPM_ALG_SHA3_512},
+#endif
+};
+
+/* algorithm_string_to_algid() converts a digest algorithm from a C string to a TCG algorithm
+   identifier as defined in the TCG Algorithm Regisrty..
+
+   Returns TPM_ALG_ERROR if the string has an unsupported value.
+*/
+
+static TPMI_ALG_HASH algorithm_string_to_algid(const char *algorithm_string)
+{
+    size_t 	i;
+    for (i=0 ; i < sizeof(algorithm_map)/sizeof(Algorithm_Map) ; i++) {
+	if (strcmp(algorithm_string, algorithm_map[i].algorithm_string) == 0) {
+	    return algorithm_map[i].algid; /* if match */
 	}
+    }
+    return TPM_ALG_ERROR;
+}
 
-	/* get the popen "cmd" return code */
-	ret = pclose(fp);
+/* tpm2_pcr_read() reads the PCR
 
-	/* Treat an unallocated bank as an error */
-	if (!ret && (strlen(pcr) < SHA_DIGEST_LENGTH))
-		ret = -1;
+   algo_name is the PCR digest algorithm (the PCR bank) as a C string
+   pcrHandle is the PCR number to read
+   hwpcr is a buffer for the PCR output in binary
+   len is the allocated size of hwpcr and should match the digest algorithm
+*/
 
-	if (!ret)
-		hex2bin(hwpcr, pcr, len);
-	else
-		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
+int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
+		 int len, char **errmsg)
+{
+        int 			ret = 0;	/* function return code */
+	TPM_RC			rc = 0;		/* TCG return code */
+	PCR_Read_In 		pcrReadIn;	/* command input */
+	PCR_Read_Out 		pcrReadOut;	/* response output */
+	TSS_CONTEXT		*tssContext = NULL;
+	TPMI_ALG_HASH 		alg_id;		/* PCR algorithm */
 
-	return ret;
+	if (rc == 0) {		/* map algorithm string to TCG value */
+	    alg_id = algorithm_string_to_algid(algo_name);
+	    if (alg_id == TPM_ALG_ERROR) {
+		ret = asprintf(errmsg, "tpm2_pcr_read: unknown algorithm %s", algo_name);
+		if (ret == -1) {	/* the contents of errmsg is undefined */
+		    *errmsg = NULL;
+		}
+		rc = 1;
+	    }
+	}
+	if (rc == 0) {
+	    rc = TSS_Create(&tssContext);
+	}
+	/* call TSS to execute the command */
+	if (rc == 0) {
+	    pcrReadIn.pcrSelectionIn.count = 1;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].hash = alg_id;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].sizeofSelect = 3;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[0] = 0;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[1] = 0;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[2] = 0;
+	    pcrReadIn.pcrSelectionIn.pcrSelections[0].pcrSelect[pcrHandle / 8] =
+		1 << (pcrHandle % 8);
+	    rc = TSS_Execute(tssContext,
+			     (RESPONSE_PARAMETERS *)&pcrReadOut,
+			     (COMMAND_PARAMETERS *)&pcrReadIn,
+			     NULL,
+			     TPM_CC_PCR_Read,
+			     TPM_RH_NULL, NULL, 0);
+	}
+	if (rc == 0) {
+	    /* nothing read, bank missing */
+	    if (pcrReadOut.pcrValues.count == 0) {
+		ret = asprintf(errmsg, "tpm2_pcr_read: returned count 0 for %s", algo_name);
+		if (ret == -1) {	/* the contents of errmsg is undefined */
+		    *errmsg = NULL;
+		}
+		rc = 1;
+	    }
+	    /* len parameter did not match the digest algorithm */
+	    else if (pcrReadOut.pcrValues.digests[0].t.size != len) {
+		ret = asprintf(errmsg,
+			       "tpm2_pcr_read: expected length %d actual %u for %s",
+			       len, pcrReadOut.pcrValues.digests[0].t.size, algo_name);
+		if (ret == -1) {	/* the contents of errmsg is undefined */
+		    *errmsg = NULL;
+		}
+		rc = 1;
+	    }
+	    else {
+		memcpy(hwpcr,
+		       pcrReadOut.pcrValues.digests[0].t.buffer,
+		       pcrReadOut.pcrValues.digests[0].t.size);
+	    }
+	}
+	{
+	    TPM_RC rc1 = TSS_Delete(tssContext);
+	    if (rc == 0) {
+		rc = rc1;
+	    }
+	}
+	/* map TCG return code to function return code */
+	if (rc == 0) {
+	    return 0;
+	}
+	else {
+	    return -1;
+	}
 }
+
-- 
2.25.1

