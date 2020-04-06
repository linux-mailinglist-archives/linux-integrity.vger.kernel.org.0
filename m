Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE519F482
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFLZN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 07:25:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFLZN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 07:25:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id f20so6348411wmh.3
        for <linux-integrity@vger.kernel.org>; Mon, 06 Apr 2020 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p01tcQYIV50I3M1bLTva1fqAmJhQog5D8h+bmFXeBpk=;
        b=CmHfjmg4x18ZbT8wwzwwGVd7bfIHu20ZfmW19dzskPh37RE8Z8ytNYvioug3ZnzVe+
         NKVBt83dM/3AyLdwfU48kEYvkIrWh1VGT5WcbJrqKFMkWHqA3977U7nRixTBLsB/XjYE
         FhAs0p6GKBy05GYS6pDBEZOqv6ZaorXKThXQF3s2St+PTq1LoicGs5UWo5SaGohnSyXn
         9zaggOj04NYfeSD3PpYQrvQ8jK7upKrQEuubTKXHdtQSr+ZwnRLqzpnJ/GwM9xiaS4KN
         cifACHi/z5S+lDJBNpZU1nUXbnWKkWZiS5R5wzUpIjUkB43tOBI7bpG3cxtzUsxv/7nK
         uf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p01tcQYIV50I3M1bLTva1fqAmJhQog5D8h+bmFXeBpk=;
        b=X4R3n5bF/2mdTYx9RB1LT8m9WDgAYlvOaeoCUmfOc8SJlIKKmVn1p92oMou6WLP7A6
         Q8A0l1OBQHpKrxF02CTuhj2LG229ONV0S5Cjy8vrpLR5CBIOwV9rt4H22BSIMDyHlee0
         l5h+eBF1Si6M5hDqw9xDzcpDMdi15yH27V7+E5iuhVXJHjXNl/x858pOzHZ4zVDX0H2V
         auWNTO2Pvh8qoxqMzc2PpuZTv68o3wjWWRcBX6JPo879gfumbuo0TBOcHqwHuGeM1G8U
         M/M74WtG2/BRY6sZbLdIOLchal+zUCBOlvSBzi8JIsR6f0DWnIxGiwJhZAwkyI1Okhfd
         idMw==
X-Gm-Message-State: AGi0PuZFTVVmT3/oPIcm+aBgSDi/NCSvrpRmsD8w97yyCtS+DDb7wPtO
        cnRuh07zYP736OBWMLFV3RjEWLdzvmM=
X-Google-Smtp-Source: APiQypLzIvS3yVZOMjLL9JBLMSyjc1Mh1MJ7PQ/h2bnnjfbF/ew7cBekz/RzQz0OAjjqDwp224OGzQ==
X-Received: by 2002:a1c:2489:: with SMTP id k131mr22930907wmk.86.1586172310458;
        Mon, 06 Apr 2020 04:25:10 -0700 (PDT)
Received: from localhost ([87.71.128.21])
        by smtp.gmail.com with ESMTPSA id b7sm26789215wrn.67.2020.04.06.04.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 04:25:09 -0700 (PDT)
Date:   Mon, 6 Apr 2020 14:25:08 +0300
From:   Lev Olshvang <levonshe@gmail.com>
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH] integrity : Preserve i_flags of inode in signature hash
Message-ID: <20200406112507.GA20611@kl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


From af94cf8c8e0976dfc7889d7f3d83dd1c9db96e59 Mon Sep 17 00:00:00 2001
From: Lev Olshvang <levonshe@gmail.com>
Date: Mon, 30 Mar 2020 16:00:27 +0300
Subject: [RFC PATCH v1] integrity - add inode's i_flags to signature

Add more inode fields to inode HMAC : attributes [i_flags].
Naming is a but confusing - chattr, lsattr utilities uses
attributes term, while inside inode they are stored in i_flags.

File/directory attributes define (affect) how User space and
filesystem behaves and should be considered therefore as
file metadata content.

For example immutable flag preserve file from removal or change.
Files in ext4 filesystem might have encrypted attribute and
in ubifs filesystem compressed attribute might be used.
In a total 32 attributes might be in use.
It is important to verify these attributes were not changed.

Function hmac_add_misc() ignored errors from crypto functions
This patch changes hmac_add_misc() not to be silent about errors

Signed-off-by: Lev Olshvang <levonshe@gmail.com>
---
 security/integrity/evm/evm_crypto.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index d485f6fc908e..927fab54c67c 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -139,15 +139,17 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 			  char type, char *digest)
 {
+	int rc = 0;
 	struct h_misc {
 		unsigned long ino;
 		__u32 generation;
 		uid_t uid;
 		gid_t gid;
 		umode_t mode;
+		__u32   flags;
 	} hmac_misc;

 	memset(&hmac_misc, 0, sizeof(hmac_misc));
@@ -169,11 +171,18 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	hmac_misc.flags = inode->i_flags;
+	rc = crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	if (unlikely(!rc))
+		return rc;
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
+		rc = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
+		if (unlikely(!rc))
+			return rc;
+	}
+	rc = crypto_shash_final(desc, digest);
+	return rc;
 }

 /*
@@ -239,7 +248,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	error = hmac_add_misc(desc, inode, type, data->digest);
+	if (error < 0)
+		return error;

 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
--
2.17.1

