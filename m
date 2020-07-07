Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B52163FA
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGGC0v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgGGC0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06721M9x178608;
        Mon, 6 Jul 2020 22:26:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324fdgs35g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:44 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06724Hcs189575;
        Mon, 6 Jul 2020 22:26:43 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324fdgs352-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:43 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672QGkc025185;
        Tue, 7 Jul 2020 02:26:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 322hd82wrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:26:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672QdUx56164680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:26:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E2094C04E;
        Tue,  7 Jul 2020 02:26:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8488E4C040;
        Tue,  7 Jul 2020 02:26:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:26:38 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 2/6] ima-evm-utils: fix measurement violation checking
Date:   Mon,  6 Jul 2020 22:26:27 -0400
Message-Id: <1594088791-27370-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 cotscore=-2147483648 suspectscore=1 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The template data digest for file measurement time of measure, time of
use (ToMToU) violations is zero.  Don't calculate the template data
digest for the different banks.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1a5f3545d844..71712d91703a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1736,10 +1736,19 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 			continue;
 		}
 
-		err = calculate_template_digest(pctx, md, entry, &bank[i]);
-		if (!err) {
-			bank[i].supported = 0;
-			continue;
+		/*
+		 * Measurement violations are 0x00 digests.  No need to
+		 * calculate the per TPM bank template digests.
+		 */
+		if (memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH) == 0)
+			memset(bank[i].digest, 0x00, bank[i].digest_size);
+		else {
+			err = calculate_template_digest(pctx, md, entry,
+							&bank[i]);
+			if (!err) {
+				bank[i].supported = 0;
+				continue;
+			}
 		}
 
 		/* extend TPM BANK with template digest */
-- 
2.7.5

