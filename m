Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1128616CF7
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 19:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiKBSpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKBSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992FD2FC00
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 11:45:44 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2I0BdI021129
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dj/XHgCXUDWW+R9NjYTv7bTvQFdKhtUCgGS4ZmOxPaY=;
 b=Gz0qdlF7eQiSREcTkZp+rJPYJZTSjcZ9frxl6LFzWr4BmeLBYUC9TTbBC3uuLZlivRrl
 NPnH6pv3EX32S/oiq8tn4Vd3MrP6Wj9BE7HvyAV4zPms2wzOpzfolHcKhiRE5X2WlBNI
 BuX16Xop+GBrG3/6X+f2aEp2tGmkGcbqOMsYSWQkjDz2rrDGpTM0geZ1W5JJKgj42A4+
 fbyKSFp3P112FGMSMoB8n1DR5g/ybP6eFCu6YTEEOWgOH1B4mfONvAJyr1ZgppbKTqHI
 QEVl/w//GpaPnHO1QjlE09YMOQyogSmTsaUGZl8Bah0KHxViZFHD0lT1m0FxG8Io1Zb8 Ug== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkwet9e93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2IahCS028268
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutakhcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2IjdD317498670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:45:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B8335805D;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBF358060;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v1 2/4] Fix memory leak related to entry.template
Date:   Wed,  2 Nov 2022 14:45:32 -0400
Message-Id: <20221102184534.1075049-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nJRK4MK1SntaPnomHM2Cm1vaqvq1SdfD
X-Proofpoint-GUID: nJRK4MK1SntaPnomHM2Cm1vaqvq1SdfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=836
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c2fe152..4afc265 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2095,7 +2095,7 @@ static int ima_measurement(const char *file)
 	unsigned long entry_num = 0;
 	int c;
 
-	struct template_entry entry = { .template = 0 };
+	struct template_entry entry = { .template = NULL };
 	FILE *fp;
 	int invalid_template_digest = 0;
 	int err_padded = -1;
@@ -2206,6 +2206,10 @@ static int ima_measurement(const char *file)
 			free(entry.template);
 			entry.template_buf_len = entry.template_len;
 			entry.template = malloc(entry.template_len);
+			if (!entry.template) {
+				log_err("Out of memory\n");
+				goto out;
+			}
 		}
 
 		if (!is_ima_template) {
@@ -2325,6 +2329,7 @@ out_free:
 	free(tpm_banks);
 	free(pseudo_banks);
 	free(pseudo_padded_banks);
+	free(entry.template);
 
 	return err;
 }
-- 
2.38.1

