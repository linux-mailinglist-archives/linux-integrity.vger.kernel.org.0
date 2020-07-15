Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27081221660
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGOUiw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:38:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgGOUiv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:38:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FKWI0U022086;
        Wed, 15 Jul 2020 16:38:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wj0w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:38:46 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FKWPDU022330;
        Wed, 15 Jul 2020 16:38:46 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792wj0ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:38:45 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FKVlPX005711;
        Wed, 15 Jul 2020 20:38:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 327527vycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:38:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FKbQgG60030996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 20:37:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A8E9A4053;
        Wed, 15 Jul 2020 20:37:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F08FA404D;
        Wed, 15 Jul 2020 20:37:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 20:37:25 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 3/3] ima-evm-utils: add missing license info
Date:   Wed, 15 Jul 2020 16:37:15 -0400
Message-Id: <1594845435-19164-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
References: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

src/utils.c contains some common functions.

Fixes: 03f99ea6d05b ("ima-evm-utils: Add support for Intel TSS2 for PCR reading")

Reported-by: Petr Vorel <pvorel@suse.cz>
Cc: Patrick Uiterwijk <patrick@puiterwijk.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/utils.c b/src/utils.c
index 416a88c6dbe4..fbb6a4b540af 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * utils: set of common functions
+ *
+ * Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>
+ * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
+ */
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.7.5

