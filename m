Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5463DF681
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhHCUk5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 16:40:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhHCUk4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 16:40:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173KXAc0135829
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 16:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=PLCftpi0YYftbLMdv61d0dGfJ0v1BLHffG9QGz3Y0Yw=;
 b=KyMXTZRwkMKI96FRpA1sIDnpCp0RI9k8PmPK9Mw3pmcoXvPYZk+sPsL7Lr//IzuTzQeW
 aovXQbEfaW6dPtvNDA4Dvqb9zjEP4Xq1tvmAcAUeHA4rfykm4h+PEo/14/m/YsBZLljb
 YNETWfSK1nLF872PzPrEJcRtYL9TZosnw8uQMVoOyWRQpfFm/wriK9JINuuwtxSK6jcI
 0qQPRwK0knja1oKjbIHws2tEKUGmMZPsiIeEAlXgOvw79SPdzGNgmwrGq7wXxqa8C0/J
 t+mcQo/YkceYAGGxL2p3bDTPf9Yrnrl5qowLYS2yWU0KQmwd1L5qNHMaEhwIiz4/fn7p +g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7brpt0ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 16:40:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173KchRP015026
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 20:40:44 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3a4x5dcgtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 20:40:44 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173KehBV43254104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 20:40:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F87B2067;
        Tue,  3 Aug 2021 20:40:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24ECAB2064;
        Tue,  3 Aug 2021 20:40:42 +0000 (GMT)
Received: from eve.home (unknown [9.211.130.149])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 20:40:41 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     zohar@linux.ibm.com, maroon@lists.linux.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     kgold@linux.ibm.com, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v5 ima-evm-utils 3/3] Create alternative tpm2_pcr_read() that uses IBM TSS
Date:   Tue,  3 Aug 2021 16:40:08 -0400
Message-Id: <20210803204008.29612-4-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803204008.29612-1-kgoldman@us.ibm.com>
References: <20210803204008.29612-1-kgoldman@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZXCg-c480NCuKidYKRJzqRiHYZJAYCpz
X-Proofpoint-GUID: ZXCg-c480NCuKidYKRJzqRiHYZJAYCpz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use the IBM TSS to implement the functions as an alternative to the
command line tools.

The algorithm_string_to_algid() function supports only the digest
algorithms in use.  The table has place holders for other algorithms
as they are needed and the C strings are defined.

The table can also be used for an algorithm ID to string function if
it's ever needed.

When using the IBM TSS, link in its library.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>

Please review the configure.ac change.
---
 configure.ac     |   8 ++
 src/Makefile.am  |  15 +++-
 src/pcr_ibmtss.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 src/pcr_ibmtss.c

diff --git a/configure.ac b/configure.ac
index e1ed100..4f6fe7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,10 +30,17 @@ AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
+# Intel TSS
 AC_CHECK_LIB([tss2-esys], [Esys_Free])
 AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
 AM_CONDITIONAL([USE_PCRTSS], [test "x$ac_cv_lib_tss2_esys_Esys_Free" = "xyes"])
 
+# IBM TSS include files
+AC_CHECK_HEADER(ibmtss/tss.h, [have_ibmtss=true],
+			      [have_ibmtss=false],
+			      [[#define TPM_POSIX]])
+AM_CONDITIONAL([USE_IBMTSS], $have_ibmtss)
+
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
 
@@ -79,5 +86,6 @@ echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
+echo    "         ibmtss: $have_ibmtss"
 echo	"            doc: $have_doc"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index d6c779f..f89d971 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -22,10 +22,21 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 
+# USE_PCRTSS uses the Intel TSS
 if USE_PCRTSS
-evmctl_SOURCES += pcr_tss.c
+ evmctl_SOURCES += pcr_tss.c
+
+# USE_IBMTSS uses the IBM TSS
+else
+if USE_IBMTSS
+ evmctl_SOURCES += pcr_ibmtss.c
+ evmctl_LDADD += -libmtss
+
+# uses the IBM TSS command line utilities
 else
-evmctl_SOURCES += pcr_tsspcrread.c
+ evmctl_SOURCES += pcr_tsspcrread.c
+
+endif
 endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
diff --git a/src/pcr_ibmtss.c b/src/pcr_ibmtss.c
new file mode 100644
index 0000000..551f9c4
--- /dev/null
+++ b/src/pcr_ibmtss.c
@@ -0,0 +1,192 @@
+/*
+ * ima-evm-utils - IMA/EVM support utilities
+ *
+ * Copyright (C) 2021 IBM
+ *
+ * Authors:
+ * Ken Goldman <kgoldman@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * As a special exception, the copyright holders give permission to link the
+ * code of portions of this program with the OpenSSL library under certain
+ * conditions as described in each individual source file and distribute
+ * linked combinations including the program with the OpenSSL library. You
+ * must comply with the GNU General Public License in all respects
+ * for all of the code used other than as permitted herein. If you modify
+ * file(s) with this exception, you may extend this exception to your
+ * version of the file(s), but you are not obligated to do so. If you do not
+ * wish to do so, delete this exception statement from your version. If you
+ * delete this exception statement from all source files in the program,
+ * then also delete it in the license file.
+ *
+ * File: pcr_tsspcrread.c
+ *	 PCR reading implementation based on IBM TSS2
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+
+#include <openssl/sha.h>
+
+#define USE_FPRINTF
+#include "utils.h"
+#include "imaevm.h"
+
+#define TPM_POSIX	/* use Posix, not Windows constructs in TSS */
+#undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
+#include <ibmtss/tss.h>
+
+#define CMD "tsspcrread"
+
+static char path[PATH_MAX];
+
+int tpm2_pcr_supported(void)
+{
+	if (imaevm_params.verbose > LOG_INFO)
+		log_info("Using %s to read PCRs.\n", CMD);
+
+	if (get_cmd_path(CMD, path, sizeof(path))) {
+		log_debug("Couldn't find '%s' in $PATH\n", CMD);
+		return 0;
+	}
+
+	log_debug("Found '%s' in $PATH\n", CMD);
+	return 1;
+}
+
+/* Table mapping C strings to TCG algorithm identifiers */
+typedef struct tdAlgorithm_Map {
+	const char *algorithm_string;
+	TPMI_ALG_HASH algid;
+} Algorithm_Map;
+
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
+/*
+ * algorithm_string_to_algid() converts a digest algorithm from a C string to a
+ * TCG algorithm identifier as defined in the TCG Algorithm Regisrty..
+ *
+ *  Returns TPM_ALG_ERROR if the string has an unsupported value.
+ */
+static TPMI_ALG_HASH algorithm_string_to_algid(const char *algorithm_string)
+{
+	size_t 	i;
+
+	for (i=0 ; i < sizeof(algorithm_map)/sizeof(Algorithm_Map) ; i++) {
+		if (strcmp(algorithm_string, algorithm_map[i].algorithm_string)
+		    == 0) {
+			return algorithm_map[i].algid; 		/* if match */
+		}
+	}
+	return TPM_ALG_ERROR;
+}
+
+/* tpm2_pcr_read() reads the PCR
+ *
+ * algo_name: PCR digest algorithm (the PCR bank) as a C string
+ * pcr_handle: PCR number to read
+ * hwpcr: buffer for the PCR output in binary
+ * len: allocated size of hwpcr and should match the digest algorithm
+ */
+int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
+		  int len, char **errmsg)
+{
+        int 			ret = 0;	/* function return code */
+	TPM_RC			rc = 0;		/* TCG return code */
+	TPM_RC 			rc1 = 0;	/* secondary return code */
+	PCR_Read_In 		pcr_read_in;	/* command input */
+	PCR_Read_Out 		pcr_read_out;	/* response output */
+	TSS_CONTEXT		*tss_context = NULL;
+	TPMI_ALG_HASH 		alg_id;		/* PCR algorithm */
+
+	alg_id = algorithm_string_to_algid(algo_name);
+	if (alg_id == TPM_ALG_ERROR) {
+		ret = asprintf(errmsg, "tpm2_pcr_read: unknown algorithm %s",
+			       algo_name);
+		if (ret == -1) 	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		rc = 1;
+		goto end;
+	}
+	rc = TSS_Create(&tss_context);
+	if (rc != 0)
+		goto end;
+	/* call TSS to execute the command */
+	pcr_read_in.pcrSelectionIn.count = 1;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].hash = alg_id;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].sizeofSelect = 3;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[0] = 0;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[1] = 0;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[2] = 0;
+	pcr_read_in.pcrSelectionIn.pcrSelections[0].pcrSelect[pcr_handle / 8] =
+		1 << (pcr_handle % 8);
+	rc = TSS_Execute(tss_context,
+			 (RESPONSE_PARAMETERS *)&pcr_read_out,
+			 (COMMAND_PARAMETERS *)&pcr_read_in,
+			 NULL,
+			 TPM_CC_PCR_Read,
+			 TPM_RH_NULL, NULL, 0);
+	if (rc != 0)
+		goto end;
+	/* nothing read, bank missing */
+	if (pcr_read_out.pcrValues.count == 0) {
+		ret = asprintf(errmsg, "tpm2_pcr_read: returned count 0 for %s",
+			       algo_name);
+		if (ret == -1) /* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		rc = 1;
+		goto end;
+	}
+	/* len parameter did not match the digest algorithm */
+	else if (pcr_read_out.pcrValues.digests[0].t.size != len) {
+		ret = asprintf(errmsg,
+			       "tpm2_pcr_read: "
+			       "expected length %d actual %u for %s",
+			       len, pcr_read_out.pcrValues.digests[0].t.size,
+			       algo_name);
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		rc = 1;
+		goto end;
+	}
+	else {
+		memcpy(hwpcr,
+		       pcr_read_out.pcrValues.digests[0].t.buffer,
+		       pcr_read_out.pcrValues.digests[0].t.size);
+	}
+ end:
+	rc1 = TSS_Delete(tss_context);
+	if (rc == 0)
+		rc = rc1;
+	/* map TCG return code to function return code */
+	if (rc == 0)
+		return 0;
+	else
+		return -1;
+}
+
-- 
2.25.1

