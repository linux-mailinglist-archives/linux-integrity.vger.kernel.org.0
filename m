Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605652B9E4A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 00:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKSX0i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 18:26:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:32948 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgKSX00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 18:26:26 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F33020B8007;
        Thu, 19 Nov 2020 15:26:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F33020B8007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605828385;
        bh=HQPjCXbmCWoNxq+crvgSRCDuSmapzAI99vhPLiG291M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh0J0BWtS8OEKfZFU22fAm2WREPLsbvN+DQS8POGO9JYEe7Ex4W5fv2nHM2MzLkS9
         BcuYCYBT1YUfiA3t9pMv/XxKdXtTw/mzCEKJe9Bn3IUBQzNR0eScu4IMR0IgWl/GEB
         lswP8P9NqOEhbT36Zg4BKLQtyq392BoObRivaExw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v6 8/8] selinux: measure state and hash of the policy using IMA
Date:   Thu, 19 Nov 2020 15:26:11 -0800
Message-Id: <20201119232611.30114-9-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

IMA measures files and buffer data such as keys, command line arguments
passed to the kernel on kexec system call, etc. While these measurements
enable monitoring and validating the integrity of the system, it is not
sufficient. In-memory data structures maintained by various kernel
components store the current state and policies configured for
the components. Updates to these data structures would have an impact on
the functionalities. For example, the in-memory data structures
maintained by SELinux store the configuration and policies for this
security module and thereby determine the security functionalities
provided by this module. Changes to these data at runtime would have
an impact on the security guarantees provided by SELinux. Measuring
such in-memory data structures through IMA subsystem provides a secure
way for a remote attestation service to know the state of the system
and also the runtime changes in the state of the system.

SELinux configuration and policy are some of the critical data for this
security module that need to be measured. This measurement can be used
by an attestation service, for instance, to verify if the configurations
and policies have been setup correctly and that they haven't been
tampered at run-time.

Measure SELinux configurations, policy capabilities settings, and
the hash of the loaded policy by calling the IMA hook
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
   measure func=CRITICAL_DATA data_sources=selinux template=ima-buf

Sample measurement of SELinux state and hash of the policy:

10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:462051628 8d1d...1834

To verify the measurement check the following:

Execute the following command to extract the measured data
from the IMA log for SELinux configuration (selinux-state).

  grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p

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

Note that the actual verification would be against an expected state
and done on a system other than the measured system, typically
requiring "initialized=1; enabled=1;enforcing=1;checkreqprot=0;" for
a secure state and then whatever policy capabilities are actually set
in the expected policy (which can be extracted from the policy itself
via seinfo, for example).

For selinux-policy-hash, the hash of SELinux policy is included
in the IMA log entry.

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
 Documentation/ABI/testing/ima_policy |   6 +-
 security/selinux/Makefile            |   2 +
 security/selinux/hooks.c             |   3 +
 security/selinux/include/security.h  |  11 +-
 security/selinux/measure.c           | 157 +++++++++++++++++++++++++++
 security/selinux/selinuxfs.c         |   8 ++
 security/selinux/ss/services.c       |  71 ++++++++++--
 7 files changed, 247 insertions(+), 11 deletions(-)
 create mode 100644 security/selinux/measure.c

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index ee60442a41cd..db1ee7bcdba7 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -52,7 +52,7 @@ Description:
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
-			data_sources:= list of kernel subsystems that contain
+			data_sources:= list of kernel subsystems (eg, SeLinux) that contain
 			kernel in-memory data critical to the integrity of the kernel.
 			Only valid when action is "measure" and func is
 			CRITICAL_DATA.
@@ -135,3 +135,7 @@ Description:
 		keys added to .builtin_trusted_keys or .ima keyring:
 
 			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
+
+		Example of measure rule using CRITICAL_DATA to measure critical data
+
+			measure func=CRITICAL_DATA data_sources=selinux
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
index 6b1826fc3658..8b9fde47ae28 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7398,6 +7398,9 @@ int selinux_disable(struct selinux_state *state)
 	}
 
 	selinux_mark_disabled(state);
+	mutex_lock(&state->policy_mutex);
+	selinux_measure_state(state);
+	mutex_unlock(&state->policy_mutex);
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
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
index 000000000000..65d42059f588
--- /dev/null
+++ b/security/selinux/measure.c
@@ -0,0 +1,157 @@
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
+	bool checkreqprot = checkreqprot_get(state);
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
+	curr = scnprintf(buf, buf_len, str_fmt,
+			 "initialized", initialized);
+	curr += scnprintf((buf + curr), (buf_len - curr), str_fmt,
+			  "enabled", enabled);
+	curr += scnprintf((buf + curr), (buf_len - curr), str_fmt,
+			  "enforcing", enforcing);
+	curr += scnprintf((buf + curr), (buf_len - curr), str_fmt,
+			  "checkreqprot", checkreqprot);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		curr += scnprintf((buf + curr), (buf_len - curr), str_fmt,
+				  selinux_policycap_names[i],
+				  state->policycap[i]);
+	}
+
+	*state_str = buf;
+	*state_str_len = curr;
+
+	return 0;
+}
+
+/*
+ * selinux_measure_state - Measure SELinux state configuration and hash of
+ *			   the SELinux policy.
+ * @state: selinux state struct
+ *
+ * NOTE: This function must be called with policy_mutex held.
+ */
+void selinux_measure_state(struct selinux_state *state)
+{
+	void *policy = NULL;
+	char *state_event_name = NULL;
+	char *policy_event_name = NULL;
+	char *state_str = NULL;
+	size_t policy_len;
+	int state_str_len, rc = 0;
+	bool initialized = selinux_initialized(state);
+
+	/*
+	 * Get a unique string for measuring the current SELinux state.
+	 */
+	state_event_name = selinux_event_name("selinux-state");
+	if (!state_event_name) {
+		pr_err("%s: Event name for state not allocated.\n",
+		       __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = read_selinux_state(&state_str, &state_str_len, state);
+	if (rc) {
+		pr_err("%s: Failed to read state %d.\n", __func__, rc);
+		goto out;
+	}
+
+	ima_measure_critical_data("selinux", state_event_name,
+				  state_str, state_str_len, false);
+
+	/*
+	 * Measure SELinux policy only after initialization is completed.
+	 */
+	if (!initialized)
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
+	rc = security_read_policy_kernel(state, &policy, &policy_len);
+	if (rc) {
+		pr_err("%s: Failed to read policy %d.\n", __func__, rc);
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
+	kfree(state_str);
+	kfree(state_event_name);
+}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4bde570d56a2..015650220cb2 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -182,6 +182,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
 			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+
+		mutex_lock(&state->policy_mutex);
+		selinux_measure_state(state);
+		mutex_unlock(&state->policy_mutex);
 	}
 	length = count;
 out:
@@ -762,6 +766,10 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	length = count;
+
+	mutex_lock(&fsi->state->policy_mutex);
+	selinux_measure_state(fsi->state);
+	mutex_unlock(&fsi->state->policy_mutex);
 out:
 	kfree(page);
 	return length;
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

