Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85EBF7FCD
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKKTYT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:24:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbfKKTYS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:24:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABJNS0Y057967
        for <linux-integrity@vger.kernel.org>; Mon, 11 Nov 2019 14:24:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7bmjw7c9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Nov 2019 14:24:15 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <patrickc@linux.ibm.com>;
        Mon, 11 Nov 2019 19:24:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Nov 2019 19:24:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABJO9xR49873012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 19:24:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDAFA4C04A;
        Mon, 11 Nov 2019 19:24:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404B84C044;
        Mon, 11 Nov 2019 19:24:08 +0000 (GMT)
Received: from oc3746452103.ibm.com (unknown [9.60.73.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 19:24:08 +0000 (GMT)
From:   Patrick Callaghan <patrickc@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima: avoid appraise error for hash calc interrupt
Date:   Mon, 11 Nov 2019 14:23:48 -0500
X-Mailer: git-send-email 2.8.3
X-TM-AS-GCONF: 00
x-cbid: 19111119-0012-0000-0000-00000362BE21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111119-0013-0000-0000-0000219E2A8E
Message-Id: <20191111192348.30535-1-patrickc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The integrity_kernel_read() call in ima_calc_file_hash_tfm() can return
a value of 0 before all bytes of the file are read. A value of 0 would
normally indicate an EOF. This has been observed if a user process is
causing a file appraisal and is terminated with a SIGTERM signal. The
most common occurrence of seeing the problem is if a shutdown or systemd
reload is initiated while files are being appraised.

The problem is similar to commit <f5e1040196db> (ima: always return
negative code for error) that fixed the problem in
ima_calc_file_hash_atfm().

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Patrick Callaghan <patrickc@linux.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 73044fc..7967a69 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -362,8 +362,10 @@ static int ima_calc_file_hash_tfm(struct file *file,
 			rc = rbuf_len;
 			break;
 		}
-		if (rbuf_len == 0)
+		if (rbuf_len == 0) {	/* unexpected EOF */
+			rc = -EINVAL;
 			break;
+		}
 		offset += rbuf_len;
 
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
-- 
2.8.3

