Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5D1C0122
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD3QCW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgD3QCV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 12:02:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96AC035494;
        Thu, 30 Apr 2020 09:02:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so11595pfa.1;
        Thu, 30 Apr 2020 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cNV8wBKZnzVBtfymmveclI4KpbJZuqPxmoI95kkMdEk=;
        b=gUF51ZdEmMNREvmXqCvOQL6dUB2acFhJN4T+qV1lyQaqLu19s6doZkP4sgYp+HFDxZ
         vB0lbjGzTxRL0fE/0T+K+CkxGMAw3phFJpqHqgcsu395S+hUjHM5tAqQTmfF4iNiTK0S
         rUy19yKokxXhSnhmACYx4qtBM0xXlI+/94J8U8fhHMisdBW4uA2nlERs8MexdDiujgcZ
         owtBIRwsLeE/PmzeQlKTzRuCL3sk/LZ2tdoyH5VDaq9dBHU2/0EM0T/Zls4dXbKeiLK1
         6fCIg28YSOEKSUTj0xoShyBrKt5gcQKodO8WzxA4w7+0WouJT5aiUzn2W9DlzrOGIU/i
         usYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cNV8wBKZnzVBtfymmveclI4KpbJZuqPxmoI95kkMdEk=;
        b=i7OpEODc4npCC8mfXm1lhF/LZ6A4mKhw1tyuUpzTgysIU6cbDkD6ZRZXJNIwefDlMW
         ZJwz+/LxIRrCnvBPfvNHJNadoCNfe1jLDq97rWl7CVapasboEn0W4li7z4Wp7lNtSDxu
         MPEKbliIkeliAdhHReI8jPaQo4Ywmv9fD4G1//xU7+fWPYUFghc6ftcbv5WI67jZaK8v
         5i0VflgXss13Tvwba5VxwBtXtqLJ6zYHp8hwNLMsvTHX8hbtbd2J45InmWtGt6QCFxzN
         TUrO7SUO3ocTBtf47Kt6TpXAJ5QACWr2bWcC5OJDMaA++efxJln95/OWd/abFxWCErcL
         D18w==
X-Gm-Message-State: AGi0PuYqAmoYBM/boydJyRPuVmVi8wm/O9jCioC7ETcY3/i5RlO3btym
        Sk687PFzK2bToX0WTZuXFczmxhY=
X-Google-Smtp-Source: APiQypKDW2dWa9U3zBxfHDvIfC7dS46oUZwZ5hSH0zqX0CXg5Qavgg068rmwXmccEmvXAV0Z3Zj/ng==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr28538pfl.70.1588262541257;
        Thu, 30 Apr 2020 09:02:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:d32:dd79:2591:468a:ee81:9c85])
        by smtp.gmail.com with ESMTPSA id 5sm244359pjf.19.2020.04.30.09.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:02:20 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        paulmck@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] integrity: evm: Fix RCU list related warnings.
Date:   Thu, 30 Apr 2020 21:32:05 +0530
Message-Id: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following warning and few other
instances of traversal of evm_config_xattrnames list:

[   32.848432] =============================
[   32.848707] WARNING: suspicious RCU usage
[   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
[   32.849308] -----------------------------
[   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed in non-reader section!!

Since entries are only added to the list and never deleted,
use list_For_each_entry_lockless() instead of
list_for_each_entry_rcu() for traversing the list.
Also, add a relevant comment in evm_secfs.c to indicate this fact.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 security/integrity/evm/evm_main.c   | 4 ++--
 security/integrity/evm/evm_secfs.c  | 9 ++++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 35682852ddea..b2dc87da5f50 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -207,7 +207,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	data->hdr.length = crypto_shash_digestsize(desc->tfm);
 
 	error = -ENODATA;
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		bool is_ima = false;
 
 		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index d361d7fdafc4..0d36259b690d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -97,7 +97,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
@@ -228,7 +228,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
 	struct xattr_list *xattr;
 
 	namelen = strlen(req_xattr_name);
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		if ((strlen(xattr->name) == namelen)
 		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
 			found = 1;
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 39ad1038d45d..cfc3075769bb 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -232,7 +232,14 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	/* Guard against races in evm_read_xattrs */
+	/*
+	 * xattr_list_mutex guards against races in evm_read_xattrs().
+	 * Entries are only added to the evm_config_xattrnames list
+	 * and never deleted. Therefore, the list is traversed
+	 * using list_for_each_entry_lockless() without holding
+	 * the mutex in evm_calc_hmac_or_hash(), evm_find_protected_xattrs()
+	 * and evm_protected_xattr().
+	 */
 	mutex_lock(&xattr_list_mutex);
 	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
 		if (strcmp(xattr->name, tmp->name) == 0) {
-- 
2.17.1

