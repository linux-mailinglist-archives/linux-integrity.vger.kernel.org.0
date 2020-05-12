Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55471CF58A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgELNTx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 09:19:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNTx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 09:19:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CD8PjT073618;
        Tue, 12 May 2020 13:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=Zk2itBX5ky6S7MoSFghl5gy+sxxKrVt9n5cKiFg4BOc=;
 b=C+OTellQzgs8NzBI/38wiDd0jWsYqKyALC1sBuzZuJqC46xwd4U+erLMVWHd7DfUvMrv
 ccM+oAxx9oqPaiQwGIJYsniT/h9uwdmyFjC/Nn4fkVephV5tusTnaEQ6Lm9zrUyqoIaV
 w8PMAkWirt7V33lh3XZqNGq9xfGPSG+CLPRFBdREMMjPZ7JDVB8HVmM26fTBB904+pDm
 cbwLnAi+9mfAwPtkKG/MPKPBMP3kjI2U69H/1H+fWrLtQeIETzRm0xRgmVb//J/q9g9p
 9DVosQOzOlu5w29B1KtY/apeK9nPrUrMH85vJMi1rr3zTm+OSLyhnKWvNUPvAs0fGzeC Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30x3gmjx71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 13:19:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CD7i48071839;
        Tue, 12 May 2020 13:19:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30x63psu3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 13:19:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CDJPjR020648;
        Tue, 12 May 2020 13:19:25 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 06:19:25 -0700
Date:   Tue, 12 May 2020 16:19:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] evm: Fix a small race in init_desc()
Message-ID: <20200512131917.GA287386@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512130410.GB2056@kadam>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=2
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=2
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IS_ERR_OR_NULL() function has two conditions and if we got really
unlucky we could hit a race where "ptr" started as an error pointer and
then was set to NULL.  Both conditions would be false even though the
pointer at the end was NULL.

This patch fixes the problem by ensuring that "*tfm" can only be NULL
or valid.  I have introduced a "tmp_tfm" variable to make that work.  I
also reversed a condition and pulled the code in one tab.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: 53de3b080d5e: "evm: Check also if *tfm is an error pointer in init_desc()"
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I just had a go at the fix.  I'm not super wedded to this solution, but
I hoped it was nice.

 security/integrity/evm/evm_crypto.c | 44 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 5d3789edab71f..168c3b78ac47b 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -73,7 +73,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 {
 	long rc;
 	const char *algo;
-	struct crypto_shash **tfm;
+	struct crypto_shash **tfm, *tmp_tfm;
 	struct shash_desc *desc;
 
 	if (type == EVM_XATTR_HMAC) {
@@ -91,31 +91,31 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 		algo = hash_algo_name[hash_algo];
 	}
 
-	if (IS_ERR_OR_NULL(*tfm)) {
-		mutex_lock(&mutex);
-		if (*tfm)
-			goto out;
-		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
-		if (IS_ERR(*tfm)) {
-			rc = PTR_ERR(*tfm);
-			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
-			*tfm = NULL;
+	if (*tfm)
+		goto alloc;
+	mutex_lock(&mutex);
+	if (*tfm)
+		goto unlock;
+
+	tmp_tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
+	if (IS_ERR(tmp_tfm)) {
+		pr_err("Can not allocate %s (reason: %ld)\n", algo,
+		       PTR_ERR(tmp_tfm));
+		mutex_unlock(&mutex);
+		return ERR_CAST(tmp_tfm);
+	}
+	if (type == EVM_XATTR_HMAC) {
+		rc = crypto_shash_setkey(tmp_tfm, evmkey, evmkey_len);
+		if (rc) {
+			crypto_free_shash(tmp_tfm);
 			mutex_unlock(&mutex);
 			return ERR_PTR(rc);
 		}
-		if (type == EVM_XATTR_HMAC) {
-			rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
-			if (rc) {
-				crypto_free_shash(*tfm);
-				*tfm = NULL;
-				mutex_unlock(&mutex);
-				return ERR_PTR(rc);
-			}
-		}
-out:
-		mutex_unlock(&mutex);
 	}
-
+	*tfm = tmp_tfm;
+unlock:
+	mutex_unlock(&mutex);
+alloc:
 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
 			GFP_KERNEL);
 	if (!desc)
-- 
2.26.2

