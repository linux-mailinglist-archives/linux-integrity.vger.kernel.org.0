Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB17E1CFC9B
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELRtk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 13:49:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRtj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 13:49:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CHXA5E161167;
        Tue, 12 May 2020 17:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=Mkh8GoveSy71S2uynw0exMpKGBlYfJ4yRqogZfsF/Vo=;
 b=az9qtCtxpcAV7j7x0NkX6oDdwrflYUB4tduJ9hd4MiA76p+B1CV5IYS1cajq8oqWuWbO
 jZ5CRgEnxT0RueNWnwbjuRQ05KHvmgnkrEUxkEUAgGUl4QGIsxgzhINlBuZYbjc0/Yq/
 2IWHYx81/3GDTgvNj3pip9msoSiQbMt4su74HqKiiPo1jL0QL1jsAaCpO48mJmZ/1wgF
 B17zhwloc2tNDBhX51fCmOcy240VyoaZxbAGx3OVT9ksRxb21Wq57WcJV86pRM1THYjA
 8nfUjH4qzI2x3dMJjZRqq1benphxsoqeNwJeOoWlp2XhdrY0k4RpkA0YoAWUXumst3Ud iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30x3mbvg8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 17:49:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CHWZGJ143384;
        Tue, 12 May 2020 17:47:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30xbgkf75x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 17:47:17 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CHlFmd025612;
        Tue, 12 May 2020 17:47:15 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 10:47:14 -0700
Date:   Tue, 12 May 2020 20:47:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] evm: Fix a small race in init_desc()
Message-ID: <20200512174706.GA298379@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7743ab21a574eeeac40d783e0b8581c@huawei.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=2 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=2 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch avoids a kernel panic due to accessing an error pointer set by
crypto_alloc_shash(). It occurs especially when there are many files that
require an unsupported algorithm, as it would increase the likelihood of
the following race condition.

Imagine we have two threads and in the first thread crypto_alloc_shash()
fails and returns an error pointer.

		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
		if (IS_ERR(*tfm)) {
			rc = PTR_ERR(*tfm); <--- FIRST THREAD HERE!
			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
			*tfm = NULL;

And the second thread is here:

	if (*tfm == NULL) {  <--- SECOND THREAD HERE!
		mutex_lock(&mutex);
		if (*tfm)
			goto out;

Since "*tfm" is non-NULL, we assume that it is valid and that leads to
a crash when it dereferences "*tfm".

	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
                                                             ^^^^

This patch fixes the problem by introducing a temporary "tmp_tfm" and
only setting "*tfm" at the very end after everything has succeeded.  The
other change is that I reversed the initial "if (!*tfm) {" condition and
pull the code in one indent level.

Cc: stable@vger.kernel.org
Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Reported-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: I folded mine patch together with Roberto's

 security/integrity/evm/evm_crypto.c | 44 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 35682852ddea9..c9f7206591b30 100644
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
 
-	if (*tfm == NULL) {
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

