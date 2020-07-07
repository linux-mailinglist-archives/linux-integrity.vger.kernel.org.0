Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80732163FB
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGC0v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgGGC0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06721FG9143161;
        Mon, 6 Jul 2020 22:26:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324ffdh02q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:46 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067280Pw168824;
        Mon, 6 Jul 2020 22:26:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324ffdh027-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672Qijn014549;
        Tue, 7 Jul 2020 02:26:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 322hd7tv9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:26:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672QgGQ43778288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:26:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08E224C040;
        Tue,  7 Jul 2020 02:26:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 542824C046;
        Tue,  7 Jul 2020 02:26:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:26:41 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 5/6] ima-evm-utils: use uint32_t for template length
Date:   Mon,  6 Jul 2020 22:26:30 -0400
Message-Id: <1594088791-27370-6-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
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

The template length should never be less than zero.  Replace "int" with
"uint32_t".

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index eda7dd845930..9162de2a5aeb 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1404,9 +1404,9 @@ struct template_entry {
 		uint32_t name_len;
 	} header  __packed;
 	char name[TCG_EVENT_NAME_LEN_MAX + 1];
-	int template_len;
+	uint32_t template_buf_len;
+	uint32_t template_len;
 	uint8_t *template;
-	int template_buf_len;
 };
 
 static uint8_t zero[MAX_DIGEST_SIZE];
-- 
2.7.5

