Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83C5B8A3C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiINOWo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiINOWn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0246638
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:22:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDIxsI029338;
        Wed, 14 Sep 2022 14:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eBEWFzlKnohU2rGR/5DbGOVVqpYSwven9lDXVL5UxXo=;
 b=VyEyQ38mtq+COAwGT4JOF6IqV1RCDWDhKptGoHrCbVCNJBdULstXsWIxE2mDEbbURhoV
 zgS1FvaTR4+3cOrwH7bX9xZ0lc69HZZPNcGgCEPB+mUX44ElyEdIBTD/ZO7FsakZxTgF
 pCNpXi3DMMXz8liNFpC8Djdjkxm7xy+sdorF0VP7al6Gb0u8qg6+862uYHSh5KoeI6sv
 9/AtTUD4cAGYR4HWP2tzCy9m3xlUplLANIZRfO9qRrEKspJHhnFy+fn1Ji8/Sw1uvUBV
 mbt8FfpCjAn2a06PhZYK0hU5/b1Xp4AKgyifhSBSCeqhhMgWUGDFauMX1vEXq/tIIthZ /g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkfqytj5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EEKqgw021851;
        Wed, 14 Sep 2022 14:22:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3jjyfr93vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EEMWwe27787758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:22:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BF955204E;
        Wed, 14 Sep 2022 14:22:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.200.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A756E52050;
        Wed, 14 Sep 2022 14:22:31 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 3/4] Sanity check the template data field sizes
Date:   Wed, 14 Sep 2022 10:22:24 -0400
Message-Id: <20220914142225.1381077-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914142225.1381077-1-zohar@linux.ibm.com>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sPh5aFTjhXfYudbqcxR2hxpR5AZZ0wTh
X-Proofpoint-ORIG-GUID: sPh5aFTjhXfYudbqcxR2hxpR5AZZ0wTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The field sizes of the original "ima" template data are static, but
the other template data fields are not.  They're prefixed with a size.

Add some data field size sanity checks in ima_show_ng().

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9ab804fee37a..4a071143679e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1591,8 +1591,9 @@ void ima_ng_show(struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
-	int total_len = entry->template_len, digest_len, len, sig_len, fbuf_len;
+	int total_len = entry->template_len, digest_len, len, fbuf_len;
 	uint8_t *digest, *sig = NULL, *fbuf = NULL;
+	int sig_len = 0;
 	char *algo, *path;
 	int found;
 	int err;
@@ -1601,33 +1602,65 @@ void ima_ng_show(struct template_entry *entry)
 	field_len = *(uint32_t *)fieldp;
 	fieldp += sizeof(field_len);
 	total_len -= sizeof(field_len);
+	if (total_len < 0) {
+		log_err("Template \"%s\" invalid template data\n", entry->name);
+		return;
+	}
 
 	algo = (char *)fieldp;
 	len = strnlen(algo, field_len - 1) + 1;
 	digest_len = field_len - len;
+	if (digest_len < SHA_DIGEST_LENGTH ||
+	    digest_len > MAX_DIGEST_SIZE) {
+		log_err("Template \"%s\" invalid digest length\n", entry->name);
+		return;
+	}
 	digest = fieldp + len;
 
 	/* move to next field */
 	fieldp += field_len;
 	total_len -= field_len;
+	if (total_len < 0) {
+		log_err("Template \"%s\" invalid template data\n", entry->name);
+		return;
+	}
 
 	/* get path */
 	field_len = *(uint32_t *)fieldp;
 	fieldp += sizeof(field_len);
 	total_len -= sizeof(field_len);
+	if (field_len == 0 || field_len > PATH_MAX || total_len < field_len) {
+		log_err("Template \"%s\" invalid file pathname\n", entry->name);
+		return;
+	}
 
 	path = (char *)fieldp;
 
 	/* move to next field */
 	fieldp += field_len;
 	total_len -= field_len;
+	if (total_len < 0) {
+		log_err("Template \"%s\" invalid template data\n", entry->name);
+		return;
+	}
 
 	if (!strcmp(entry->name, "ima-sig") ||
 	    !strcmp(entry->name, "ima-sigv2")) {
-		/* get signature */
+		/* get signature, if it exists */
 		field_len = *(uint32_t *)fieldp;
 		fieldp += sizeof(field_len);
+		if (field_len > MAX_SIGNATURE_SIZE) {
+			log_err("Template \"%s\" invalid file signature size\n",
+				entry->name);
+			return;
+		}
+
 		total_len -= sizeof(field_len);
+		if (total_len < 0) {
+			log_err("Template \"%s\" invalid template data\n",
+				entry->name);
+			return;
+		}
 
 		if (field_len) {
 			sig = fieldp;
@@ -1651,6 +1684,11 @@ void ima_ng_show(struct template_entry *entry)
 		}
 	}
 
+	if (total_len < 0) {
+		log_err("Template \"%s\" invalid template data\n", entry->name);
+		return;
+	}
+
 	/* ascii_runtime_measurements */
 	if (imaevm_params.verbose > LOG_INFO) {
 		log_info("%d ", entry->header.pcr);
-- 
2.31.1

