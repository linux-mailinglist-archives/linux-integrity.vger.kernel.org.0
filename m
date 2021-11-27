Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF746004D
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Nov 2021 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhK0QwD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Nov 2021 11:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhK0QuD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Nov 2021 11:50:03 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85175C06173E
        for <linux-integrity@vger.kernel.org>; Sat, 27 Nov 2021 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638031608;
        bh=5ah6AxdfuuD0MZT2VqRIK0hSzcNTKo4O78noGVJ2uJQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=njGCo5Tdm9jijSkAdLP70yvLqq5iEYYKkXsiTQiojxEQawWokxQ16RbMYS6hBSoZx
         paiIamBvzue628J0V/8o/tIIhVeXRXDX0h5QfqdAcNmBWJhEAr/oMrAMuHJPTGY5as
         n4f5SHQIRADQ3QTiveSF7alzcC+Mq12w+xcxGvCc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5B0BE12809DF;
        Sat, 27 Nov 2021 11:46:48 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M61YihtRPkeo; Sat, 27 Nov 2021 11:46:48 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0F5F71280693;
        Sat, 27 Nov 2021 11:46:46 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     containers@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC 1/3] userns: add uuid field
Date:   Sat, 27 Nov 2021 16:45:47 +0000
Message-Id: <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As a precursor to namespacing IMA a way of uniquely identifying the
namespace to appear in the IMA log is needed.  This log may be
transported away from the running system and may be analyzed even
after the system has been rebooted.  Thus we need a way of identifying
namespaces in the log which is unique.  UUID, being designed
probabilistically never to repeat, fits this bill so add it to the
user_namespace which we'll also use for namespacing IMA.

uuid_gen() is used to create each uuid uniquely.  It feeds off the
pseudo random number generator, but this should be as unique as we
need for probabilistic non repeats without depleting the entropy
pool.  Since there is no random initializer for a uuid, this is done
in user_namespaces_init().  This should be safe because IMA is a late
initcall.

This patch contains no exposure mechanisms, and the subsequent patches
only add uuid entries in the IMA log.  However, it is not unlikely
that eventually orchestration systems will want to know what the uuid
is (to tie their container ID to the one in the IMA log), so
additional patches exposing this via NSIO and /proc/<pid>/ns could be
added.

For checkpoint/restore, the uuid should not be a property that
transports because otherwise we'll have to have a set mechanism with a
uniqueness check.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/user_namespace.h | 2 ++
 kernel/user.c                  | 1 +
 kernel/user_namespace.c        | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..d155788abdc1 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -10,6 +10,7 @@
 #include <linux/rwsem.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
+#include <linux/uuid.h>
 
 #define UID_GID_MAP_MAX_BASE_EXTENTS 5
 #define UID_GID_MAP_MAX_EXTENTS 340
@@ -99,6 +100,7 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+	uuid_t			uuid;
 } __randomize_layout;
 
 struct ucounts {
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..bf9ae1d0b670 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -67,6 +67,7 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+	/* .uuid is initialized in user_namespaces_init() */
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..8ce57c16ddd3 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -141,6 +141,8 @@ int create_user_ns(struct cred *new)
 	if (!setup_userns_sysctls(ns))
 		goto fail_keyring;
 
+	uuid_gen(&ns->uuid);
+
 	set_cred_user_ns(new, ns);
 	return 0;
 fail_keyring:
@@ -1386,6 +1388,7 @@ const struct proc_ns_operations userns_operations = {
 static __init int user_namespaces_init(void)
 {
 	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC | SLAB_ACCOUNT);
+	uuid_gen(&init_user_ns.uuid);
 	return 0;
 }
 subsys_initcall(user_namespaces_init);
-- 
2.33.0

