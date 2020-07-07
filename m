Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51E216403
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGC1g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:27:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgGGC1g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:27:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06721Fup143103;
        Mon, 6 Jul 2020 22:27:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324ffdh0kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:34 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0672ItXd015956;
        Mon, 6 Jul 2020 22:27:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324ffdh0k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672RI4A001687;
        Tue, 7 Jul 2020 02:27:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7tvk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:27:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672RTAD62324964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:27:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5EE8A404D;
        Tue,  7 Jul 2020 02:27:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1EC4A4059;
        Tue,  7 Jul 2020 02:27:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:27:28 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 3/3] ima-evm-utils: mixed "ima" and other template formats not supported
Date:   Mon,  6 Jul 2020 22:27:17 -0400
Message-Id: <1594088837-27526-4-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
References: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 clxscore=1015
 impostorscore=0 cotscore=-2147483648 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

An IMA measurement list may not contain "ima" and other template
formats.  Fail verifying the ima_measurement test.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9ee440f6a50a..21809b3229e9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1830,8 +1830,9 @@ static int ima_measurement(const char *file)
 {
 	struct tpm_bank_info *pseudo_banks;
 	struct tpm_bank_info *tpm_banks;
-	int is_ima_template;
+	int is_ima_template, cur_template_fmt;
 	int num_banks = 0;
+	int first_record = 1;
 
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
@@ -1869,7 +1870,21 @@ static int ima_measurement(const char *file)
 			goto out;
 		}
 
-		is_ima_template = strcmp(entry.name, "ima") == 0 ? 1 : 0;
+	       /*
+		* The "ima" template format can not be mixed with other
+		* template formats records.
+		*/
+		if (!first_record) {
+			cur_template_fmt = strcmp(entry.name, "ima") == 0 ? 1 : 0;
+			if ((is_ima_template && !cur_template_fmt) ||
+			    (!is_ima_template && cur_template_fmt)) {
+				log_err("Mixed measurement list containing \"ima\" and other template formats not supported.\n");
+				goto out;
+			}
+		} else {
+			first_record = 0;
+			is_ima_template = strcmp(entry.name, "ima") == 0 ? 1 : 0;
+		}
 
 		/* The "ima" template data is not length prefixed.  Skip it. */
 		if (!is_ima_template) {
-- 
2.7.5

