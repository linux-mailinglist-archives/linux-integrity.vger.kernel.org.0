Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3330D308AA5
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 17:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA2QwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 11:52:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57588 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhA2QuM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 11:50:12 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3E0F120B7192;
        Fri, 29 Jan 2021 08:49:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E0F120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611938970;
        bh=HeUFBKPErvpm417Eu/jxjrlR487fuUEJs073J4JmtAg=;
        h=From:To:Cc:Subject:Date:From;
        b=qA1AzhDbIFOAj34HcN5E1NVwTivAzH0AgGFXVFe1YqXdUIYVQlzGvv3JOtm0fnoxr
         9PJPCZe1EEx0d2u0LY/ogkr4ZMxvQlI7C1oACm5qHxBm5Kv3tWmiFk7XMfPFAAzOvt
         oXFUYqIM7YpDC/LeOsQ12COpCjLIBr2cPtx0UWlg=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com
Cc:     tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: measure state and policy capabilities
Date:   Fri, 29 Jan 2021 08:49:26 -0800
Message-Id: <20210129164926.3939-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SELinux stores the configuration state and the policy capabilities
in kernel memory.  Changes to this data at runtime would have an impact
on the security guarantees provided by SELinux.  Measuring this data
through IMA subsystem provides a tamper-resistant way for
an attestation service to remotely validate it at runtime.

Measure the configuration state and policy capabilities by calling
the IMA hook ima_measure_critical_data().

To enable SELinux data measurement, the following steps are required:

 1, Add "ima_policy=critical_data" to the kernel command line arguments
    to enable measuring SELinux data at boot time.
    For example,
      BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data

 2, Add the following rule to /etc/ima/ima-policy
       measure func=CRITICAL_DATA label=selinux

Sample measurement of SELinux state and policy capabilities:

10 2122...65d8 ima-buf sha256:13c2...1292 selinux-state 696e...303b

Execute the following command to extract the measured data
from the IMA's runtime measurements list:

  grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p

The output should be a list of key-value pairs. For example,
 initialized=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;

To verify the measurement is consistent with the current SELinux state
reported on the system, compare the integer values in the following
files with those set in the IMA measurement (using the following commands):

 - cat /sys/fs/selinux/enforce
 - cat /sys/fs/selinux/checkreqprot
 - cat /sys/fs/selinux/policy_capabilities/[capability_file]

Note that the actual verification would be against an expected state
and done on a separate system (likely an attestation server) requiring
"initialized=1;enforcing=1;checkreqprot=0;"
for a secure state and then whatever policy capabilities are actually
set in the expected policy (which can be extracted from the policy
itself via seinfo, for example).

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ima.c         | 77 ++++++++++++++++++++++++++++++++--
 security/selinux/include/ima.h |  6 +++
 security/selinux/selinuxfs.c   |  6 +++
 security/selinux/ss/services.c |  2 +-
 4 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 03715893ff97..5c7f73cd1117 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -13,18 +13,73 @@
 #include "ima.h"
 
 /*
- * selinux_ima_measure_state - Measure hash of the SELinux policy
+ * selinux_ima_collect_state - Read selinux configuration settings
  *
- * @state: selinux state struct
+ * @state: selinux_state
  *
- * NOTE: This function must be called with policy_mutex held.
+ * On success returns the configuration settings string.
+ * On error, returns NULL.
  */
-void selinux_ima_measure_state(struct selinux_state *state)
+static char *selinux_ima_collect_state(struct selinux_state *state)
+{
+	const char *on = "=1;", *off = "=0;";
+	char *buf;
+	int buf_len, i;
+
+	/*
+	 * Size of the following string including the terminating NULL char
+	 *    initialized=0;enforcing=0;checkreqprot=0;
+	 */
+	buf_len = 42;
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++)
+		buf_len += strlen(selinux_policycap_names[i]) + 3;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	strscpy(buf, "initialized", buf_len);
+	strlcat(buf, selinux_initialized(state) ? on : off, buf_len);
+
+	strlcat(buf, "enforcing", buf_len);
+	strlcat(buf, enforcing_enabled(state) ? on : off, buf_len);
+
+	strlcat(buf, "checkreqprot", buf_len);
+	strlcat(buf, checkreqprot_get(state) ? on : off, buf_len);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		strlcat(buf, selinux_policycap_names[i], buf_len);
+		strlcat(buf, state->policycap[i] ? on : off, buf_len);
+	}
+
+	return buf;
+}
+
+/*
+ * selinux_ima_measure_state_locked - Measure SELinux state and hash of policy
+ *
+ * @state: selinux state struct
+ */
+void selinux_ima_measure_state_locked(struct selinux_state *state)
 {
+	char *state_str = NULL;
 	void *policy = NULL;
 	size_t policy_len;
 	int rc = 0;
 
+	WARN_ON(!mutex_is_locked(&state->policy_mutex));
+
+	state_str = selinux_ima_collect_state(state);
+	if (!state_str) {
+		pr_err("SELinux: %s: failed to read state.\n", __func__);
+		return;
+	}
+
+	ima_measure_critical_data("selinux", "selinux-state",
+				  state_str, strlen(state_str), false);
+
+	kfree(state_str);
+
 	/*
 	 * Measure SELinux policy only after initialization is completed.
 	 */
@@ -42,3 +97,17 @@ void selinux_ima_measure_state(struct selinux_state *state)
 
 	vfree(policy);
 }
+
+/*
+ * selinux_ima_measure_state - Measure SELinux state and hash of policy
+ *
+ * @state: selinux state struct
+ */
+void selinux_ima_measure_state(struct selinux_state *state)
+{
+	WARN_ON(mutex_is_locked(&state->policy_mutex));
+
+	mutex_lock(&state->policy_mutex);
+	selinux_ima_measure_state_locked(state);
+	mutex_unlock(&state->policy_mutex);
+}
diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
index d69c36611423..75ca92b4a462 100644
--- a/security/selinux/include/ima.h
+++ b/security/selinux/include/ima.h
@@ -15,10 +15,16 @@
 
 #ifdef CONFIG_IMA
 extern void selinux_ima_measure_state(struct selinux_state *selinux_state);
+extern void selinux_ima_measure_state_locked(
+			struct selinux_state *selinux_state);
 #else
 static inline void selinux_ima_measure_state(struct selinux_state *selinux_state)
 {
 }
+static inline void selinux_ima_measure_state_locked(
+			struct selinux_state *selinux_state)
+{
+}
 #endif
 
 #endif	/* _SELINUX_IMA_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4bde570d56a2..26ec58593ba1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -41,6 +41,7 @@
 #include "security.h"
 #include "objsec.h"
 #include "conditional.h"
+#include "ima.h"
 
 enum sel_inos {
 	SEL_ROOT_INO = 2,
@@ -182,6 +183,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
 			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+
+		selinux_ima_measure_state(state);
 	}
 	length = count;
 out:
@@ -762,6 +765,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	length = count;
+
+	selinux_ima_measure_state(fsi->state);
+
 out:
 	kfree(page);
 	return length;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2106b5d383e7..cb2866489363 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2179,7 +2179,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
-	selinux_ima_measure_state(state);
+	selinux_ima_measure_state_locked(state);
 }
 
 void selinux_policy_commit(struct selinux_state *state,
-- 
2.30.0

