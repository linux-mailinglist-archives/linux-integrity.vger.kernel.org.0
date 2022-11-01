Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B861615304
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiKAUSa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKAUS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC54DEC1
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:26 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1IqDci018205;
        Tue, 1 Nov 2022 20:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L/b9wibu6EHs2iyh9mGy88SYY/spqL+EkdquebrQBLo=;
 b=mGnI7fXrLOXPnRT6bHXobSnvOxHm+S1amhw1Tq67rQtWLYoyfpiLDlarSiyeiQoc7E6U
 +I46bMsjKYCulwhmBUhu+L+NqEnIGGWMgbHj0lF8DKdlE9qyKMdnAU1h7sJ8/Gzp/lM1
 VpfxBEe1WdLecRY/Dw37jLAbzhbwp6v1fvaqeQN66BZVbygHijyqXkGPjwPZxL907qvZ
 61Ry6/mkMshldaCjAxrXZehUKmhdwu884ZAtCIHzKzodsrJqUj3EbT+ERnRnF4UMvt/Y
 cCPyygIksAY35tHzpvicnUPpXWtiAco5lAU5hHeNZv+19UjkvecLq2YW3I4EbghwVCkd zA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtg5qapt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K5ZOM004786;
        Tue, 1 Nov 2022 20:18:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut8w8c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KII9F55509370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9A7A4064;
        Tue,  1 Nov 2022 20:18:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D68BA405C;
        Tue,  1 Nov 2022 20:18:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:17 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 11/17] Fix potential use after free in read_tpm_banks()
Date:   Tue,  1 Nov 2022 16:17:57 -0400
Message-Id: <20221101201803.372652-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JTCZjiNZOnknqdK0J9DUvsiaTiZF86Hv
X-Proofpoint-GUID: JTCZjiNZOnknqdK0J9DUvsiaTiZF86Hv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=990 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On failure to read TPM 2.0 bank PCRs 'errmsg' is not properly set to
NULL after being freed.  Fix potential use after free.

Fixes: 3472f9ba9c05 ("ima-evm-utils: read the PCRs for the requested TPM banks")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4817eeba01c0..c224e17ee620 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2070,6 +2070,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 				log_debug("Failed to read %s PCRs: (%s)\n",
 					  bank[i].algo_name, errmsg);
 				free(errmsg);
+				errmsg = NULL;
 				bank[i].supported = 0;
 			}
 		}
-- 
2.31.1

