Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E772D8329
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437578AbgLLAAJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 19:00:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgLKX7n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 18:59:43 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A4FB520B7194;
        Fri, 11 Dec 2020 15:58:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4FB520B7194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607731104;
        bh=LZbRzTNLbA6BART7PXSLF9WZQhXaNd0fiKC3gDjsPZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpNXsFSXlo5ylbmxljGVjXHxKM7RkTpsJtfs9omadk3fgT/dlaSMa96kFORshsBxk
         XnrtZfo76ELmCZMO5ByUgnshPZLaD/BV5fgyXYCJWEU+4sUQiLsHxt5kzOgfsTVkQN
         x+Bb0B2/ZhSGIAGO1WUiqVpTn/qFWTdvE5/wU5rI=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v8 8/8] selinux: include a consumer of the new IMA critical data hook
Date:   Fri, 11 Dec 2020 15:58:07 -0800
Message-Id: <20201211235807.30815-9-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

SELinux stores the active policy in memory, so the changes to this data
at runtime would have an impact on the security guarantees provided
by SELinux. Measuring in-memory SELinux policy through IMA subsystem
provides a secure way for the attestation service to remotely validate
the policy contents at runtime.

Measure the hash of the loaded policy by calling the IMA hook
ima_measure_critical_data(). Since the size of the loaded policy can
be large (several MB), measure the hash of the policy instead of
the entire policy to avoid bloating the IMA log entry.

Add "selinux" to the list of supported data sources maintained by IMA
to enable measuring SELinux data.

To enable SELinux data measurement, the following steps are required:

1, Add "ima_policy=critical_data" to the kernel command line arguments
   to enable measuring SELinux data at boot time.
For example,
  BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data

2, Add the following rule to /etc/ima/ima-policy
   measure func=CRITICAL_DATA data_source=selinux

Sample measurement of the hash of SELinux policy:

To verify the measured data with the current SELinux policy run
the following commands and verify the output hash values match.

  sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1

  grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6

Note that the actual verification of SELinux policy would require loading
the expected policy into an identical kernel on a pristine/known-safe
system and run the sha256sum /sys/kernel/selinux/policy there to get
the expected hash.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  3 +-
 security/selinux/Makefile            |  2 +
 security/selinux/include/security.h  | 11 +++-
 security/selinux/measure.c           | 81 ++++++++++++++++++++++++++++
 security/selinux/ss/services.c       | 71 ++++++++++++++++++++----
 5 files changed, 157 insertions(+), 11 deletions(-)
 create mode 100644 security/selinux/measure.c

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 0f4ee9e0a455..7c7023f7986b 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -52,8 +52,9 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
-			data_source:= [label]
+			data_source:= [selinux]|[label]
 			label:= a unique string used for grouping and limiting critical data.
+			For example, "selinux" to measure critical data for SELinux.
 
 		  default policy:
 			# PROC_SUPER_MAGIC
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 4d8e0e8adf0b..83d512116341 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -16,6 +16,8 @@ selinux-$(CONFIG_NETLABEL) += netlabel.o
 
 selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
 
+selinux-$(CONFIG_IMA) += measure.o
+
 ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 3cc8bab31ea8..18ee65c98446 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -229,7 +229,8 @@ void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
-
+int security_read_policy_kernel(struct selinux_state *state,
+				void **data, size_t *len);
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
@@ -446,4 +447,12 @@ extern void ebitmap_cache_init(void);
 extern void hashtab_cache_init(void);
 extern int security_sidtab_hash_stats(struct selinux_state *state, char *page);
 
+#ifdef CONFIG_IMA
+extern void selinux_measure_state(struct selinux_state *selinux_state);
+#else
+static inline void selinux_measure_state(struct selinux_state *selinux_state)
+{
+}
+#endif
+
 #endif /* _SELINUX_SECURITY_H_ */
diff --git a/security/selinux/measure.c b/security/selinux/measure.c
new file mode 100644
index 000000000000..a070d8dae403
--- /dev/null
+++ b/security/selinux/measure.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Measure SELinux state using IMA subsystem.
+ */
+#include <linux/vmalloc.h>
+#include <linux/ktime.h>
+#include <linux/ima.h>
+#include "security.h"
+
+/*
+ * This function creates a unique name by appending the timestamp to
+ * the given string. This string is passed as "event_name" to the IMA
+ * hook to measure the given SELinux data.
+ *
+ * The data provided by SELinux to the IMA subsystem for measuring may have
+ * already been measured (for instance the same state existed earlier).
+ * But for SELinux the current data represents a state change and hence
+ * needs to be measured again. To enable this, pass a unique "event_name"
+ * to the IMA hook so that IMA subsystem will always measure the given data.
+ *
+ * For example,
+ * At time T0 SELinux data to be measured is "foo". IMA measures it.
+ * At time T1 the data is changed to "bar". IMA measures it.
+ * At time T2 the data is changed to "foo" again. IMA will not measure it
+ * (since it was already measured) unless the event_name, for instance,
+ * is different in this call.
+ */
+static char *selinux_event_name(const char *name_prefix)
+{
+	char *event_name = NULL;
+	struct timespec64 cur_time;
+
+	ktime_get_real_ts64(&cur_time);
+	event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
+			       cur_time.tv_sec, cur_time.tv_nsec);
+	return event_name;
+}
+
+/*
+ * selinux_measure_state - Measure hash of the SELinux policy
+ *
+ * @state: selinux state struct
+ *
+ * NOTE: This function must be called with policy_mutex held.
+ */
+void selinux_measure_state(struct selinux_state *state)
+{
+	void *policy = NULL;
+	char *policy_event_name = NULL;
+	size_t policy_len;
+	int rc = 0;
+	bool initialized = selinux_initialized(state);
+
+	/*
+	 * Measure SELinux policy only after initialization is completed.
+	 */
+	if (!initialized)
+		goto out;
+
+	policy_event_name = selinux_event_name("selinux-policy-hash");
+	if (!policy_event_name) {
+		pr_err("SELinux: %s: event name for policy not allocated.\n",
+		       __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = security_read_policy_kernel(state, &policy, &policy_len);
+	if (rc) {
+		pr_err("SELinux: %s: failed to read policy %d.\n", __func__, rc);
+		goto out;
+	}
+
+	ima_measure_critical_data("selinux", policy_event_name,
+				  policy, policy_len, true);
+
+	vfree(policy);
+
+out:
+	kfree(policy_event_name);
+}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9704c8a32303..dfa2e00894ae 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2180,6 +2180,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
+	selinux_measure_state(state);
 }
 
 void selinux_policy_commit(struct selinux_state *state,
@@ -3875,8 +3876,33 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 }
 #endif /* CONFIG_NETLABEL */
 
+/**
+ * security_read_selinux_policy - read the policy.
+ * @policy: SELinux policy
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ */
+static int security_read_selinux_policy(struct selinux_policy *policy,
+					void *data, size_t *len)
+{
+	int rc;
+	struct policy_file fp;
+
+	fp.data = data;
+	fp.len = *len;
+
+	rc = policydb_write(&policy->policydb, &fp);
+	if (rc)
+		return rc;
+
+	*len = (unsigned long)fp.data - (unsigned long)data;
+	return 0;
+}
+
 /**
  * security_read_policy - read the policy.
+ * @state: selinux_state
  * @data: binary policy data
  * @len: length of data in bytes
  *
@@ -3885,8 +3911,6 @@ int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
 	struct selinux_policy *policy;
-	int rc;
-	struct policy_file fp;
 
 	policy = rcu_dereference_protected(
 			state->policy, lockdep_is_held(&state->policy_mutex));
@@ -3898,14 +3922,43 @@ int security_read_policy(struct selinux_state *state,
 	if (!*data)
 		return -ENOMEM;
 
-	fp.data = *data;
-	fp.len = *len;
+	return security_read_selinux_policy(policy, *data, len);
+}
 
-	rc = policydb_write(&policy->policydb, &fp);
-	if (rc)
-		return rc;
+/**
+ * security_read_policy_kernel - read the policy.
+ * @state: selinux_state
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ * Allocates kernel memory for reading SELinux policy.
+ * This function is for internal use only and should not
+ * be used for returning data to user space.
+ *
+ * This function must be called with policy_mutex held.
+ */
+int security_read_policy_kernel(struct selinux_state *state,
+				void **data, size_t *len)
+{
+	struct selinux_policy *policy;
+	int rc = 0;
 
-	*len = (unsigned long)fp.data - (unsigned long)*data;
-	return 0;
+	policy = rcu_dereference_protected(
+			state->policy, lockdep_is_held(&state->policy_mutex));
+	if (!policy) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	*len = policy->policydb.len;
+	*data = vmalloc(*len);
+	if (!*data) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
+	rc = security_read_selinux_policy(policy, *data, len);
+
+out:
+	return rc;
 }
-- 
2.17.1

