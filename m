Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0D5B8A39
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiINOWl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiINOWj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A946638
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:22:38 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EED9n2000799;
        Wed, 14 Sep 2022 14:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8xSHguEJXQPshTPlOLP4rennnQLUA7tF9N5HidlCUTc=;
 b=RpavyJBuVf/dFoTgpJsbB/rL1IovEIz/jv41Iy5yDvSHcmczj8rT8PmREWG0c7jIEwPU
 Zpc/0qutwecOhPprqnqfqKAUdjPA5BgvUIsig/Af8URPLUK2eORh+RubeO+qluLon6Zm
 ru2BPLJiEw4XrJQhp1PDAVVWB+TgWiUIGVPLXTIAXVy9rTKm222kJiXx9Qi84LozkX5e
 xUOsybQy5228Q2gUTtV9VomU++gZ2v3kpYrP1H1ylreG8qtkNvyLUTMPKiu3qE1GZt60
 ymWN14YiRlQVcXEZ7i6uPJIEr6lrQA0F876YvWRglD52oSJqomkwoe65SLJCNgc5mK2P kQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkgh9gadu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EEKATY031770;
        Wed, 14 Sep 2022 14:22:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3jjyk6rtvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EEMURa38535584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:22:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA685204F;
        Wed, 14 Sep 2022 14:22:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.200.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 21E065204E;
        Wed, 14 Sep 2022 14:22:30 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/4] Don't ignore number of items read
Date:   Wed, 14 Sep 2022 10:22:22 -0400
Message-Id: <20220914142225.1381077-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914142225.1381077-1-zohar@linux.ibm.com>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IGIQ2RkhFU_oQSFVqYhPc6WyqjihSnkz
X-Proofpoint-ORIG-GUID: IGIQ2RkhFU_oQSFVqYhPc6WyqjihSnkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=941 impostorscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

fread() either returns the number of bytes read or the number of items
of data read.  Check that it returns the requested number of items read.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2e21da67c444..bcf724c828f7 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2161,7 +2161,7 @@ static int ima_measurement(const char *file)
 		}
 
 		memset(entry.name, 0x00, sizeof(entry.name));
-		if (!fread(entry.name, entry.header.name_len, 1, fp)) {
+		if (fread(entry.name, entry.header.name_len, 1, fp) != 1) {
 			log_err("Unable to read template name\n");
 			goto out;
 		}
@@ -2184,8 +2184,8 @@ static int ima_measurement(const char *file)
 
 		/* The "ima" template data is not length prefixed.  Skip it. */
 		if (!is_ima_template) {
-			if (!fread(&entry.template_len,
-				   sizeof(entry.template_len), 1, fp)) {
+			if (fread(&entry.template_len,
+				  sizeof(entry.template_len), 1, fp) != 1) {
 				log_err("Unable to read template length\n");
 				goto out;
 			}
@@ -2205,7 +2205,8 @@ static int ima_measurement(const char *file)
 		}
 
 		if (!is_ima_template) {
-			if (!fread(entry.template, entry.template_len, 1, fp)) {
+			if (fread(entry.template, entry.template_len,
+				  1, fp) != 1) {
 				log_errno("Unable to read template\n");
 				goto out;
 			}
@@ -2217,7 +2218,8 @@ static int ima_measurement(const char *file)
 			 * The "ima" template data format is digest,
 			 * filename length, filename.
 			 */
-			if (!fread(entry.template, SHA_DIGEST_LENGTH, 1, fp)) {
+			if (fread(entry.template, SHA_DIGEST_LENGTH,
+				  1, fp) != 1) {
 				log_errno("Unable to read file data hash\n");
 				goto out;
 			}
-- 
2.31.1

