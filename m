Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C126065B
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIGVjF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 17:39:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49728 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgIGVjD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 17:39:03 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9FDF22074C6B;
        Mon,  7 Sep 2020 14:39:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FDF22074C6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599514740;
        bh=JBk2RF3yajR8amtWpDPQO5C0Nm0kVGRy+F/2j/JmRoc=;
        h=From:To:Cc:Subject:Date:From;
        b=aujuQ7jqHsWOuqVdSRwU59dJeXkpzGPsjw/whwc5j7AxZ52zSX14fJis1dpq8hs+l
         kqyPbmBuIx0YHbF6niWzBeKkWaQAziDSooOIrG7E+ZJW+ky8CJ9dMBfKGilFZinPY/
         fK965GCnPXkiLuFPGr8qXmD9DwZAqYB2ZJchdkrk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, omosnace@redhat.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SELinux: Measure state and hash of policy using IMA
Date:   Mon,  7 Sep 2020 14:38:55 -0700
Message-Id: <20200907213855.3572-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Critical data structures of security modules are currently not measured.
Therefore an attestation service, for instance, would not be able to
attest whether the security modules are always operating with the policies
and configuration that the system administrator had setup. The policies
and configuration for the security modules could be tampered with by
rogue user mode agents or modified through some inadvertent actions on
the system. Measuring such critical data would enable an attestation
service to reliably assess the security configuration of the system.

SELinux configuration and policy are some of the critical data for this
security module that needs to be measured. This measurement can be used
by an attestation service, for instance, to verify if the configuration
and policies have been setup correctly and that they haven't been tampered
with at runtime.

Measure SELinux configuration, policy capabilities settings, and the hash
of the loaded policy by calling the IMA hook ima_measure_critical_data().
Since the size of the loaded policy can be quite large, hash of the policy
is measured instead of the entire policy to avoid bloating the IMA log.

Enable early boot measurement for SELinux in IMA since SELinux
initializes its state and policy before custom IMA policy is loaded.

Sample measurement of SELinux state and hash of the policy:

10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:462051628 8d1d...1834

To verify the measurement check the following:

Execute the following command to extract the measured data
from the IMA log for SELinux configuration (selinux-state).

  grep -m 1 "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6 | xxd -r -p

The output should be the list of key-value pairs. For example,
 initialized=1;enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;

To verify the measured data with the current SELinux state:

 => enabled should be set to 1 if /sys/fs/selinux folder exists,
    0 otherwise

For other entries, compare the integer value in the files
 => /sys/fs/selinux/enforce
 => /sys/fs/selinux/checkreqprot
And, each of the policy capabilities files under
 => /sys/fs/selinux/policy_capabilities

For selinux-policy-hash, the hash of SELinux policy is included
in the IMA log entry.

To verify the measured data with the current SELinux policy run
the following commands and verify the output hash values match.

  sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1

  grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6

This patch is based on commit 66ccd2560aff ("selinux: simplify away security_policydb_len()")
in "next" branch in https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

This patch is dependent on the following patch series and must be
applied in the given order:
	https://patchwork.kernel.org/patch/11709527/
	https://patchwork.kernel.org/patch/11730193/
	https://patchwork.kernel.org/patch/11730757/

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?
---
 security/integrity/ima/Kconfig      |   3 +-
 security/integrity/ima/ima.h        |   1 +
 security/selinux/Makefile           |   2 +
 security/selinux/hooks.c            |   1 +
 security/selinux/include/security.h |  18 +++-
 security/selinux/measure.c          | 156 ++++++++++++++++++++++++++++
 security/selinux/selinuxfs.c        |   3 +
 security/selinux/ss/services.c      |  70 +++++++++++--
 8 files changed, 242 insertions(+), 12 deletions(-)
 create mode 100644 security/selinux/measure.c

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 953314d145bb..9bf0f65d720b 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
 
 config IMA_QUEUE_EARLY_BOOT_DATA
 	bool
-	depends on IMA_MEASURE_ASYMMETRIC_KEYS
-	depends on SYSTEM_TRUSTED_KEYRING
+	depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING) || SECURITY_SELINUX
 	default y
 
 config IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 422fe833037d..710648eeb21b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -230,6 +230,7 @@ struct modsig;
 
 #define __ima_supported_kernel_data_sources(source)	\
 	source(MIN_SOURCE, min_source)			\
+	source(SELINUX, selinux)			\
 	source(MAX_SOURCE, max_source)
 
 #define __ima_enum_stringify(ENUM, str) (#str),
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
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6210e98219a5..222c8473e5b5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7402,6 +7402,7 @@ int selinux_disable(struct selinux_state *state)
 	}
 
 	selinux_mark_disabled(state);
+	selinux_measure_state(state, false);
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index cbdd3c7aff8b..c971ec09d855 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -209,6 +209,11 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
 }
 
+static inline bool selinux_checkreqprot(const struct selinux_state *state)
+{
+	return READ_ONCE(state->checkreqprot);
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			void *data, size_t len,
@@ -219,7 +224,8 @@ void selinux_policy_cancel(struct selinux_state *state,
 			struct selinux_policy *policy);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
-
+int security_read_policy_kernel(struct selinux_state *state,
+				void **data, size_t *len);
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
@@ -436,4 +442,14 @@ extern void ebitmap_cache_init(void);
 extern void hashtab_cache_init(void);
 extern int security_sidtab_hash_stats(struct selinux_state *state, char *page);
 
+#ifdef CONFIG_IMA
+extern void selinux_measure_state(struct selinux_state *selinux_state,
+				  bool policy_mutex_held);
+#else
+static inline void selinux_measure_state(struct selinux_state *selinux_state,
+					 bool policy_mutex_held)
+{
+}
+#endif
+
 #endif /* _SELINUX_SECURITY_H_ */
diff --git a/security/selinux/measure.c b/security/selinux/measure.c
new file mode 100644
index 000000000000..caf9107937d9
--- /dev/null
+++ b/security/selinux/measure.c
@@ -0,0 +1,156 @@
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
+ * This function creates an unique name by appending the timestamp to
+ * the given string. This string is passed as "event name" to the IMA
+ * hook to measure the given SELinux data.
+ *
+ * The data provided by SELinux to the IMA subsystem for measuring may have
+ * already been measured (for instance the same state existed earlier).
+ * But for SELinux the current data represents a state change and hence
+ * needs to be measured again. To enable this, pass an unique "Event Name"
+ * to the IMA hook so that IMA subsystem will always measure the given data.
+ *
+ * For example,
+ * At time T0 SELinux data to be measured is "foo". IMA measures it.
+ * At time T1 the data is changed to "bar". IMA measures it.
+ * At time T2 the data is changed to "foo" again. IMA will not measure it
+ * (since it was already measured) unless the event name, for instance,
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
+	if (!event_name) {
+		pr_err("%s: event name not allocated.\n", __func__);
+		return NULL;
+	}
+
+	return event_name;
+}
+
+static int read_selinux_state(char **state_str, int *state_str_len,
+			      struct selinux_state *state)
+{
+	char *buf, *str_fmt = "%s=%d;";
+	int i, buf_len, curr;
+	bool initialized = selinux_initialized(state);
+	bool enabled = !selinux_disabled(state);
+	bool enforcing = enforcing_enabled(state);
+	bool checkreqprot = selinux_checkreqprot(state);
+
+	buf_len = snprintf(NULL, 0, str_fmt, "initialized", initialized);
+	buf_len += snprintf(NULL, 0, str_fmt, "enabled", enabled);
+	buf_len += snprintf(NULL, 0, str_fmt, "enforcing", enforcing);
+	buf_len += snprintf(NULL, 0, str_fmt, "checkreqprot", checkreqprot);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		buf_len += snprintf(NULL, 0, str_fmt,
+				    selinux_policycap_names[i],
+				    state->policycap[i]);
+	}
+	++buf_len;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	curr = snprintf(buf, buf_len, str_fmt,
+			"initialized", initialized);
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "enabled", enabled);
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "enforcing", enforcing);
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "checkreqprot", checkreqprot);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+				 selinux_policycap_names[i],
+				 state->policycap[i]);
+	}
+
+	*state_str = buf;
+	*state_str_len = curr;
+
+	return 0;
+}
+
+void selinux_measure_state(struct selinux_state *state, bool policy_mutex_held)
+{
+	void *policy = NULL;
+	char *state_event_name = NULL;
+	char *policy_event_name = NULL;
+	char *state_str = NULL;
+	size_t policy_len;
+	int state_str_len, rc = 0;
+	bool initialized = selinux_initialized(state);
+
+	rc = read_selinux_state(&state_str, &state_str_len, state);
+	if (rc) {
+		pr_err("%s: Failed to read selinux state.\n", __func__);
+		return;
+	}
+
+	/*
+	 * Get an unique string for measuring the current SELinux state.
+	 */
+	state_event_name = selinux_event_name("selinux-state");
+	if (!state_event_name) {
+		pr_err("%s: Event name for state not allocated.\n",
+		       __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = ima_measure_critical_data(state_event_name, "selinux",
+				       state_str, state_str_len, false);
+	if (rc)
+		goto out;
+
+	/*
+	 * Measure SELinux policy only after initialization is completed.
+	 */
+	if (!initialized)
+		goto out;
+
+	if (!policy_mutex_held)
+		mutex_lock(&state->policy_mutex);
+
+	rc = security_read_policy_kernel(state, &policy, &policy_len);
+
+	if (!policy_mutex_held)
+		mutex_unlock(&state->policy_mutex);
+
+	if (rc)
+		goto out;
+
+	policy_event_name = selinux_event_name("selinux-policy-hash");
+	if (!policy_event_name) {
+		pr_err("%s: Event name for policy not allocated.\n",
+		       __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = ima_measure_critical_data(policy_event_name, "selinux",
+				       policy, policy_len, true);
+
+out:
+	kfree(state_event_name);
+	kfree(policy_event_name);
+	kfree(state_str);
+	vfree(policy);
+}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 45e9efa9bf5b..bb460954de03 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -176,6 +176,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
+		selinux_measure_state(state, false);
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
 		selnl_notify_setenforce(new_value);
@@ -761,6 +762,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	fsi->state->checkreqprot = new_value ? 1 : 0;
 	length = count;
+	selinux_measure_state(fsi->state, false);
+
 out:
 	kfree(page);
 	return length;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8dc111fbe23a..04a9c3d8c19b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2179,6 +2179,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
+	selinux_measure_state(state, true);
 }
 
 void selinux_policy_commit(struct selinux_state *state,
@@ -3874,6 +3875,30 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
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
+					void **data, size_t *len)
+{
+	int rc;
+	struct policy_file fp;
+
+	fp.data = *data;
+	fp.len = *len;
+
+	rc = policydb_write(&policy->policydb, &fp);
+	if (rc)
+		return rc;
+
+	*len = (unsigned long)fp.data - (unsigned long)*data;
+	return 0;
+}
+
 /**
  * security_read_policy - read the policy.
  * @data: binary policy data
@@ -3884,8 +3909,6 @@ int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
 	struct selinux_policy *policy;
-	int rc;
-	struct policy_file fp;
 
 	policy = rcu_dereference_protected(
 			state->policy, lockdep_is_held(&state->policy_mutex));
@@ -3897,14 +3920,43 @@ int security_read_policy(struct selinux_state *state,
 	if (!*data)
 		return -ENOMEM;
 
-	fp.data = *data;
-	fp.len = *len;
+	return security_read_selinux_policy(policy, data, len);
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
 
+	*len = policy->policydb.len;
+	*data = vmalloc(*len);
+	if (!*data) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = security_read_selinux_policy(policy, data, len);
+
+out:
+	return rc;
 }
-- 
2.28.0

