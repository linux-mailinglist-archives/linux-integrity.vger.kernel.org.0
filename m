Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA535ECE2
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhDNGJu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 02:09:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDNGJt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 02:09:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E64ZWa128459;
        Wed, 14 Apr 2021 06:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=QVyht9+yJ8dfT9u8/h2qi0FFBihCppmvtUsB/7xN34o=;
 b=XD221qAHFQ7YOfWFC+j5D3mO++IQ1s/pBnb6VxCzqPofgai4zSWydUihR44gjLxLaou3
 B8P4B0w6F4+7n3e3YBz8CPop2eN8/BgHCwlK6j42ps8/p/pyhgfEIFLPTyJWBg5088Qh
 9XgHd2tDYcud+fKbyj2i6ORnERurWKyqNKvenDdqyyKAn/3ykoY3mDJULXr7ekPtVx2E
 4tMi5XAZRcgPpr1G/2vhTh6Ku0pt66bPLxw9LRAB6UPkYPVcS9w40Grx77WKDQ3OmIxA
 p+/NccSwwaaBUdMJo970w7tjfxYSdLOpc4Ow1CHlACTbf3ThL9xE3NS7/RLHR50h114d FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymh5sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 06:09:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E64Vfn112554;
        Wed, 14 Apr 2021 06:09:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37unkqjppa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 06:09:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E695DF023914;
        Wed, 14 Apr 2021 06:09:09 GMT
Received: from mwanda (/10.175.166.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 06:09:05 +0000
Date:   Wed, 14 Apr 2021 09:08:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] KEYS: trusted: fix a couple error pointer dereferences
Message-ID: <YHaG+p5nlOXQFp1n@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140043
X-Proofpoint-GUID: RJNP3oqmP6_MQGiSmuiOdzohr_7cx_9X
X-Proofpoint-ORIG-GUID: RJNP3oqmP6_MQGiSmuiOdzohr_7cx_9X
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140043
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If registering "reg_shm_out" fails, then it is an error pointer and the
error handling will call tee_shm_free(reg_shm_out) which leads to an
error pointer dereference and an Oops.

I've re-arranged it so we only free things that have been allocated
successfully.

Fixes: 6dd95e650c8a ("KEYS: trusted: Introduce TEE based Trusted Keys")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 security/keys/trusted-keys/trusted_tee.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 2ce66c199e1d..45f96f6ed673 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -65,7 +65,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+	struct tee_shm *reg_shm_in, *reg_shm_out;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
@@ -84,7 +84,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "blob shm register failed\n");
 		ret = PTR_ERR(reg_shm_out);
-		goto out;
+		goto free_shm_in;
 	}
 
 	inv_arg.func = TA_CMD_SEAL;
@@ -109,11 +109,9 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 		p->blob_len = param[1].u.memref.size;
 	}
 
-out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(reg_shm_out);
+free_shm_in:
+	tee_shm_free(reg_shm_in);
 
 	return ret;
 }
@@ -126,7 +124,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	int ret;
 	struct tee_ioctl_invoke_arg inv_arg;
 	struct tee_param param[4];
-	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
+	struct tee_shm *reg_shm_in, *reg_shm_out;
 
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
@@ -145,7 +143,7 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		ret = PTR_ERR(reg_shm_out);
-		goto out;
+		goto free_shm_in;
 	}
 
 	inv_arg.func = TA_CMD_UNSEAL;
@@ -170,11 +168,9 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 		p->key_len = param[1].u.memref.size;
 	}
 
-out:
-	if (reg_shm_out)
-		tee_shm_free(reg_shm_out);
-	if (reg_shm_in)
-		tee_shm_free(reg_shm_in);
+	tee_shm_free(reg_shm_out);
+free_shm_in:
+	tee_shm_free(reg_shm_in);
 
 	return ret;
 }
-- 
2.30.2

