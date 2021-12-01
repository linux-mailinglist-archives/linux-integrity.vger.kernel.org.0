Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2F464EB8
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbhLANYv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 08:24:51 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36154 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234027AbhLANYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 08:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638364890;
        bh=AsE06F8r/FoDftPpEYZFndsWsBwiBdnI5H58sNmp9dU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=j4lCoMiyKhYmXs2YJd9C5wjYGswoJOOWIfo7/Sol1RMtKndN7vpqCQE0Zp55ka08i
         BF1jiybxjzR4cgYYac2lkf2aL6sZjAwpB0HkwFOiyL6vbGqlmcBYOye4mpwJE6P9iB
         2jDjgEGx3gdPo0NDcUBsONAcMujt+zrPVzKjpXD0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2C2F01280403;
        Wed,  1 Dec 2021 08:21:30 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wVyHZZtBRIm6; Wed,  1 Dec 2021 08:21:30 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E1C9E12803C3;
        Wed,  1 Dec 2021 08:21:28 -0500 (EST)
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
Subject: [RFC v2 1/3] userns: add ima_ns_info field containing a settable namespace label
Date:   Wed,  1 Dec 2021 13:20:42 +0000
Message-Id: <20211201132044.566371-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201132044.566371-1-James.Bottomley@HansenPartnership.com>
References: <20211201132044.566371-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As a precursor to namespacing IMA a way of uniquely identifying the
namespace to appear in the IMA log is needed.  This log may be
transported away from the running system and may be analyzed even
after the system has been rebooted.  Thus we need a way of identifying
namespaces in the log which is unique.  A label is added inside the
opaque ima_ns_info structure (to make it clear this is really
something which belongs to IMA) which is added to the user_namespace.

The label is read with ima_ns_info_get_label() and is settable with
the ima_ns_info_set_label() API.  The label can only be set once and
if the label isn't set before it is read, it is set to a random uuid.
Before a label is accepted for set, it is checked for uniqueness
against every previously used label to ensure we never get a duplicate
namespace label in the log.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: replace per user_ns uuid with ima_ns_info containing a settable label
---
 include/linux/ima.h             | 14 ++++++-
 include/linux/user_namespace.h  |  4 ++
 kernel/user.c                   |  1 +
 kernel/user_namespace.c         |  6 +++
 security/integrity/ima/Makefile |  2 +-
 security/integrity/ima/ima.h    |  8 ++++
 security/integrity/ima/ima_ns.c | 73 +++++++++++++++++++++++++++++++++
 7 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..3391567b661e 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
+struct ima_ns_info;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
@@ -39,7 +40,8 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
-
+extern void ima_init_user_ns(struct user_namespace *ns);
+extern void ima_free_user_ns(struct user_namespace *ns);
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
 #else
@@ -153,6 +155,16 @@ static inline int ima_measure_critical_data(const char *event_label,
 	return -ENOENT;
 }
 
+static inline void ima_init_user_ns(struct user_namespace *ns)
+{
+	return;
+}
+
+static inline void ima_free_user_ns(struct user_namespace *ns)
+{
+	return;
+}
+
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..88d2a39596ba 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_USER_NAMESPACE_H
 #define _LINUX_USER_NAMESPACE_H
 
+#include <linux/ima.h>
 #include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
@@ -99,6 +100,9 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+#ifdef CONFIG_IMA
+	struct ima_ns_info	*ima_ns_info;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..40c0fb44ecad 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -67,6 +67,7 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+	/* ima_ns_info is initialized in user_namespaces_init() */
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..08b6aaf0382b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/export.h>
+#include <linux/ima.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
@@ -142,6 +143,9 @@ int create_user_ns(struct cred *new)
 		goto fail_keyring;
 
 	set_cred_user_ns(new, ns);
+
+	ima_init_user_ns(ns);
+
 	return 0;
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
@@ -198,6 +202,7 @@ static void free_user_ns(struct work_struct *work)
 		}
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
+		ima_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
 		kmem_cache_free(user_ns_cachep, ns);
 		dec_user_namespaces(ucounts);
@@ -1386,6 +1391,7 @@ const struct proc_ns_operations userns_operations = {
 static __init int user_namespaces_init(void)
 {
 	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC | SLAB_ACCOUNT);
+	ima_init_user_ns(&init_user_ns);
 	return 0;
 }
 subsys_initcall(user_namespaces_init);
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 2499f2485c04..1741aa5d97bc 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_ns.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..b3f90971a4f7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -301,6 +301,14 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 
+/* IMA Namespace related functions */
+struct ima_ns_info {
+	char label[40];		/* UUIDs are 37 ascii characters */
+	struct list_head entry;
+};
+const char *ima_ns_info_get_label(struct user_namespace *ns);
+int ima_ns_info_set_label(struct user_namespace *ns, const char *label);
+
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
 #define IMA_APPRAISE_FIX	0x02
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
new file mode 100644
index 000000000000..a0358806149b
--- /dev/null
+++ b/security/integrity/ima/ima_ns.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * IMA Namespace Support routines
+ */
+
+#include <linux/ima.h>
+#include <linux/mutex.h>
+#include <linux/user_namespace.h>
+
+#include "ima.h"
+
+static struct kmem_cache *ima_ns_info_cache __read_mostly;
+static DEFINE_MUTEX(ns_info_list_lock);
+static LIST_HEAD(ima_ns_info_list);
+
+int ima_ns_info_set_label(struct user_namespace *ns, const char *label)
+{
+	bool found;
+	struct ima_ns_info *entry;
+
+	if (ns->ima_ns_info->label[0] != '\0')
+		/* label is already set */
+		return -EINVAL;
+
+	if (strlen(label) >= sizeof(ns->ima_ns_info->label))
+		return -E2BIG;
+
+	mutex_lock(&ns_info_list_lock);
+	list_for_each_entry(entry, &ima_ns_info_list, entry) {
+		if (strcmp(entry->label, label) == 0) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&ns_info_list_lock);
+	if (found)
+		return -EEXIST;
+
+	strcpy(ns->ima_ns_info->label, label);
+
+	return 0;
+}
+
+const char *ima_ns_info_get_label(struct user_namespace *ns)
+{
+	if (unlikely(ns->ima_ns_info->label[0] == '\0')) {
+		uuid_t uuid;
+
+		uuid_gen(&uuid);
+		sprintf(ns->ima_ns_info->label, "%pU", &uuid);
+	}
+	return ns->ima_ns_info->label;
+}
+
+void ima_init_user_ns(struct user_namespace *ns)
+{
+	struct ima_ns_info *insi;
+
+	if (unlikely(!ima_ns_info_cache))
+		ima_ns_info_cache = KMEM_CACHE(ima_ns_info, SLAB_PANIC);
+
+	insi = kmem_cache_zalloc(ima_ns_info_cache, GFP_KERNEL);
+	ns->ima_ns_info = insi;
+	INIT_LIST_HEAD(&insi->entry);
+	mutex_lock(&ns_info_list_lock);
+	list_add_tail(&insi->entry, &ima_ns_info_list);
+	mutex_unlock(&ns_info_list_lock);
+}
+
+void ima_free_user_ns(struct user_namespace *ns)
+{
+}
-- 
2.33.0

