Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161273AE911
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFUMbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 08:31:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3295 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFUMbq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 08:31:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7pQw6HZLz6H8DN;
        Mon, 21 Jun 2021 20:16:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 14:29:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>,
        <stephen.smalley.work@gmail.com>, <casey@schaufler-ca.com>,
        <stefanb@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] evm: Check xattr size discrepancy between kernel and user
Date:   Mon, 21 Jun 2021 14:29:12 +0200
Message-ID: <20210621122912.1472470-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel and the user obtain an xattr value in two different ways:

kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value from
              the filesystem handler (raw value);

user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
                      from the LSMs (normalized value).

Normally, this does not have an impact unless security.selinux is set with
setfattr, with a value not terminated by '\0' (this is not the recommended
way, security.selinux should be set with the appropriate tools such as
chcon and restorecon).

In this case, the kernel and the user see two different xattr values: the
former sees the xattr value without '\0' (raw value), the latter sees the
value with '\0' (value normalized by SELinux).

This could result in two different verification outcomes from EVM and
ima-evm-utils, if a signature was calculated with a security.selinux value
terminated by '\0' and the value set in the filesystem is not terminated by
'\0'. The former would report verification failure due to the missing '\0',
while the latter would report verification success (because it gets the
normalized value with '\0').

This patch mitigates this issue by comparing in evm_calc_hmac_or_hash() the
size of the xattr returned by the two xattr functions and by warning the
user if there is a discrepancy.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm_crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 96b22f2ac27a..462c5258322a 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -221,7 +221,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	size_t xattr_size = 0;
 	char *xattr_value = NULL;
 	int error;
-	int size;
+	int size, user_space_size;
 	bool ima_present = false;
 
 	if (!(inode->i_opflags & IOP_XATTR) ||
@@ -276,6 +276,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (size < 0)
 			continue;
 
+		user_space_size = vfs_getxattr(&init_user_ns, dentry,
+					       xattr->name, NULL, 0);
+		if (user_space_size != size)
+			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
+				 dentry->d_name.name, xattr->name, size,
+				 user_space_size);
 		error = 0;
 		xattr_size = size;
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
-- 
2.25.1

