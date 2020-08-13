Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AAF243DFE
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHMRHQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 13:07:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHMRHP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 13:07:15 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 029D120B490D;
        Thu, 13 Aug 2020 10:07:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 029D120B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597338433;
        bh=PUkaKZXuFpV4TMrqxzQA4qL6QNnTugUdGGZeyWKO4sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQFyi2VmackYqKZiVNaH4kuO24gW0/bdWyy9Git576LGsTc5BDJtlJ28FG2CRfgKH
         2dtqpo5rNVsip4e8N5x8IM9NNUDylj7K3T+BIPXVCmyd39HH4vylm9QfgWqwJ4+Brw
         PCgwWB4JG6nNUo1M3ZBOa5zYnCeEMqInvn1/Fhx8=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
Date:   Thu, 13 Aug 2020 10:07:07 -0700
Message-Id: <20200813170707.2659-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813170707.2659-1-nramas@linux.microsoft.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SELinux configuration and policy are some of the critical data for this
security module that needs to be measured. This measurement can be used
by an attestation service, for instance, to verify if the configuration
and policies have been setup correctly and that they haven't been tampered
with at runtime.

Measure SELinux configuration, policy capabilities settings, and the hash
of the loaded policy by calling the IMA hook ima_measure_critical_data().

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

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?
---
 security/selinux/Makefile           |   2 +
 security/selinux/hooks.c            |   1 +
 security/selinux/include/security.h |  15 ++
 security/selinux/measure.c          | 204 ++++++++++++++++++++++++++++
 security/selinux/selinuxfs.c        |   3 +
 security/selinux/ss/services.c      |  71 ++++++++--
 6 files changed, 287 insertions(+), 9 deletions(-)
 create mode 100644 security/selinux/measure.c

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
index efa6108b1ce9..5521dfc1900b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7394,6 +7394,7 @@ int selinux_disable(struct selinux_state *state)
 	}
 
 	selinux_mark_disabled(state);
+	selinux_measure_state(state);
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b0e02cfe3ce1..77f42d9b544b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -222,16 +222,31 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
 }
 
+static inline bool selinux_checkreqprot(const struct selinux_state *state)
+{
+	return READ_ONCE(state->checkreqprot);
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
+int security_read_policy_kernel(struct selinux_state *state,
+				void **data, size_t *len);
 size_t security_policydb_len(struct selinux_state *state);
 
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
+#ifdef CONFIG_IMA
+extern void selinux_measure_state(struct selinux_state *selinux_state);
+#else
+static inline void selinux_measure_state(struct selinux_state *selinux_state)
+{
+}
+#endif
+
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/measure.c b/security/selinux/measure.c
new file mode 100644
index 000000000000..f21b7de4e2ae
--- /dev/null
+++ b/security/selinux/measure.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Measure SELinux state using IMA subsystem.
+ */
+#include <linux/vmalloc.h>
+#include <linux/ktime.h>
+#include <linux/crypto.h>
+#include <crypto/hash.h>
+#include <crypto/hash_info.h>
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
+	struct timespec64 curr_time;
+
+	ktime_get_real_ts64(&curr_time);
+	event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
+			       curr_time.tv_sec, curr_time.tv_nsec);
+	if (!event_name) {
+		pr_warn("%s: event name not allocated.\n", __func__);
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
+
+	buf_len = snprintf(NULL, 0, str_fmt, "initialized", 0);
+	buf_len += snprintf(NULL, 0, str_fmt, "enabled", 0);
+	buf_len += snprintf(NULL, 0, str_fmt, "enforcing", 0);
+	buf_len += snprintf(NULL, 0, str_fmt, "checkreqprot", 0);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		buf_len += snprintf(NULL, 0, str_fmt,
+				    selinux_policycap_names[i], 0);
+	}
+	++buf_len;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	curr = snprintf(buf, buf_len, str_fmt,
+			"initialized", selinux_initialized(state));
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "enabled", !selinux_disabled(state));
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "enforcing", enforcing_enabled(state));
+	curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
+			 "checkreqprot", selinux_checkreqprot(state));
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
+static int selinux_hash_buffer(void *buf, size_t buf_len,
+			       void **buf_hash, int *buf_hash_len)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc = NULL;
+	void *digest = NULL;
+	int desc_size;
+	int digest_size;
+	int ret = 0;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+	digest_size = crypto_shash_digestsize(tfm);
+
+	digest = kmalloc(digest_size, GFP_KERNEL);
+	if (!digest) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_digest(desc, buf, buf_len, digest);
+	if (ret < 0)
+		goto error;
+
+	*buf_hash_len = digest_size;
+	*buf_hash = digest;
+	digest = NULL;
+
+error:
+	kfree(desc);
+	kfree(digest);
+
+	crypto_free_shash(tfm);
+
+	return ret;
+}
+
+void selinux_measure_state(struct selinux_state *state)
+{
+	void *policy = NULL;
+	void *policy_hash = NULL;
+	char *event_name = NULL;
+	char *state_str = NULL;
+	size_t policy_len;
+	int state_str_len, policy_hash_len, rc = 0;
+	bool initialized = selinux_initialized(state);
+
+	rc = read_selinux_state(&state_str, &state_str_len, state);
+	if (rc) {
+		pr_warn("%s: Failed to read selinux state.\n", __func__);
+		return;
+	}
+
+	/*
+	 * Get an unique string for measuring the current SELinux state.
+	 */
+	event_name = selinux_event_name("selinux-state");
+	if (!event_name) {
+		pr_warn("%s: Event name for state not allocated.\n",
+			__func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = ima_measure_critical_data(event_name, "selinux",
+				       state_str, state_str_len);
+
+	kfree(event_name);
+	event_name = NULL;
+
+	if (rc)
+		goto out;
+
+	/*
+	 * Measure SELinux policy only after initialization is completed.
+	 */
+	if (!initialized)
+		goto out;
+
+	rc = security_read_policy_kernel(state, &policy, &policy_len);
+	if (rc)
+		goto out;
+
+	rc = selinux_hash_buffer(policy, policy_len,
+				 &policy_hash, &policy_hash_len);
+	if (rc)
+		goto out;
+
+	event_name = selinux_event_name("selinux-policy-hash");
+	if (!event_name) {
+		pr_warn("%s: Event name for policy not allocated.\n",
+			__func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = ima_measure_critical_data(event_name, "selinux",
+				       policy_hash, policy_hash_len);
+
+out:
+	kfree(event_name);
+	kfree(state_str);
+	kfree(policy_hash);
+	vfree(policy);
+}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c2510..6d46eaef5c92 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -173,6 +173,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
+		selinux_measure_state(state);
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
 		selnl_notify_setenforce(new_value);
@@ -678,6 +679,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	fsi->state->checkreqprot = new_value ? 1 : 0;
 	length = count;
+
+	selinux_measure_state(fsi->state);
 out:
 	kfree(page);
 	return length;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ef0afd878bfc..3978c804c361 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2182,6 +2182,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		selinux_status_update_policyload(state, seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
+		selinux_measure_state(state);
 		return 0;
 	}
 
@@ -2270,6 +2271,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
+	selinux_measure_state(state);
 
 	rc = 0;
 	goto out;
@@ -2941,6 +2943,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 		selnl_notify_policyload(seqno);
 		selinux_status_update_policyload(state, seqno);
 		selinux_xfrm_notify_policyload();
+		selinux_measure_state(state);
 	}
 	return rc;
 }
@@ -3720,14 +3723,23 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 }
 #endif /* CONFIG_NETLABEL */
 
+static int security_read_policy_len(struct selinux_state *state, size_t *len)
+{
+	if (!selinux_initialized(state))
+		return -EINVAL;
+
+	*len = security_policydb_len(state);
+	return 0;
+}
+
 /**
- * security_read_policy - read the policy.
+ * security_read_selinux_policy - read the policy.
  * @data: binary policy data
  * @len: length of data in bytes
  *
  */
-int security_read_policy(struct selinux_state *state,
-			 void **data, size_t *len)
+static int security_read_selinux_policy(struct selinux_state *state,
+					void **data, size_t *len)
 {
 	struct policydb *policydb = &state->ss->policydb;
 	int rc;
@@ -3736,12 +3748,6 @@ int security_read_policy(struct selinux_state *state,
 	if (!selinux_initialized(state))
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
-
-	*data = vmalloc_user(*len);
-	if (!*data)
-		return -ENOMEM;
-
 	fp.data = *data;
 	fp.len = *len;
 
@@ -3754,5 +3760,52 @@ int security_read_policy(struct selinux_state *state,
 
 	*len = (unsigned long)fp.data - (unsigned long)*data;
 	return 0;
+}
+
+/**
+ * security_read_policy - read the policy.
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ */
+int security_read_policy(struct selinux_state *state,
+			 void **data, size_t *len)
+{
+	int rc;
+
+	rc = security_read_policy_len(state, len);
+	if (rc)
+		return rc;
+
+	*data = vmalloc_user(*len);
+	if (!*data)
+		return -ENOMEM;
+
+	return security_read_selinux_policy(state, data, len);
+}
+
+/**
+ * security_read_policy_kernel - read the policy.
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ * Allocates kernel memory for reading SELinux policy.
+ * This function is for internal use only and should not
+ * be used for returning data to user space
+ *
+ */
+int security_read_policy_kernel(struct selinux_state *state,
+				void **data, size_t *len)
+{
+	int rc;
+
+	rc = security_read_policy_len(state, len);
+	if (rc)
+		return rc;
+
+	*data = vmalloc(*len);
+	if (!*data)
+		return -ENOMEM;
 
+	return security_read_selinux_policy(state, data, len);
 }
-- 
2.28.0

