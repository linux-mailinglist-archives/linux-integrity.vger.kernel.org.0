Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3706F2FF55E
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbhAUUFo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 15:05:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48386 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAUUDf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 15:03:35 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id ACB1020B7192;
        Thu, 21 Jan 2021 12:02:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACB1020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611259373;
        bh=84PuZ9THBM7C7BDS14/NZVcdEbnd3n4d/+WYQmnI1Zs=;
        h=From:To:Cc:Subject:Date:From;
        b=qWKNVGNflSXeaqnZItzC9Kf+2PWvra2B0D9jjxUV752yTPtKq/Sq9ecrhgSy3VEY/
         UTYZ7teXoiuOZg1YiJppGvVM+GClnb7hrs8am/dMv3hVl9eJzenu4++VncOKJe+R0a
         YioPeElPfJz32laPhxjbamqRmrIpWwMsVVst5dIw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, tusharsu@linux.microsoft.com
Cc:     tyhicks@linux.microsoft.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: measure state and policy capabilities
Date:   Thu, 21 Jan 2021 12:01:50 -0800
Message-Id: <20210121200150.2448-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SELinux stores the configuration state and the policy capabilities
in kernel memory.  Changes to this data at runtime would have an impact
on the security guarantees provided by SELinux.  Measuring SELinux
configuration state and policy capabilities through IMA subsystem
provides a tamper-resistant way for an attestation service to remotely
validate the runtime state.

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

To verify the measurement check the following:

Execute the following command to extract the measured data
from the IMA log for SELinux configuration (selinux-state).

  grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p

The output should be a list of key-value pairs. For example,
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

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This patch is based on
commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
in "next-integrity-testing" branch

 security/selinux/hooks.c     |  5 +++
 security/selinux/ima.c       | 68 ++++++++++++++++++++++++++++++++++++
 security/selinux/selinuxfs.c | 10 ++++++
 3 files changed, 83 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17ec9e63..879a0d90615d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -103,6 +103,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "ima.h"
 
 struct selinux_state selinux_state;
 
@@ -7407,6 +7408,10 @@ int selinux_disable(struct selinux_state *state)
 
 	selinux_mark_disabled(state);
 
+	mutex_lock(&state->policy_mutex);
+	selinux_ima_measure_state(state);
+	mutex_unlock(&state->policy_mutex);
+
 	pr_info("SELinux:  Disabled at runtime.\n");
 
 	/*
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 03715893ff97..e65d462d2d30 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -12,6 +12,60 @@
 #include "security.h"
 #include "ima.h"
 
+/*
+ * read_selinux_state - Read selinux configuration settings
+ *
+ * @state_str: Return the configuration settings.
+ * @state_str_len: Size of the configuration settings string
+ * @state: selinux_state
+ *
+ * Return 0 on success, error code on failure
+ */
+static int read_selinux_state(char **state_str, int *state_str_len,
+			      struct selinux_state *state)
+{
+	char *buf;
+	int i, buf_len, curr;
+	bool initialized = selinux_initialized(state);
+	bool enabled = !selinux_disabled(state);
+	bool enforcing = enforcing_enabled(state);
+	bool checkreqprot = checkreqprot_get(state);
+
+	buf_len = snprintf(NULL, 0, "%s=%d;%s=%d;%s=%d;%s=%d;",
+			   "initialized", initialized,
+			   "enabled", enabled,
+			   "enforcing", enforcing,
+			   "checkreqprot", checkreqprot);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		buf_len += snprintf(NULL, 0, "%s=%d;",
+				    selinux_policycap_names[i],
+				    state->policycap[i]);
+	}
+	++buf_len;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	curr = scnprintf(buf, buf_len, "%s=%d;%s=%d;%s=%d;%s=%d;",
+			 "initialized", initialized,
+			 "enabled", enabled,
+			 "enforcing", enforcing,
+			 "checkreqprot", checkreqprot);
+
+	for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
+		curr += scnprintf((buf + curr), (buf_len - curr), "%s=%d;",
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
 /*
  * selinux_ima_measure_state - Measure hash of the SELinux policy
  *
@@ -21,10 +75,24 @@
  */
 void selinux_ima_measure_state(struct selinux_state *state)
 {
+	char *state_str = NULL;
+	int state_str_len;
 	void *policy = NULL;
 	size_t policy_len;
 	int rc = 0;
 
+	rc = read_selinux_state(&state_str, &state_str_len, state);
+	if (rc) {
+		pr_err("SELinux: %s: failed to read state %d.\n",
+			__func__, rc);
+		return;
+	}
+
+	ima_measure_critical_data("selinux", "selinux-state",
+				  state_str, state_str_len, false);
+
+	kfree(state_str);
+
 	/*
 	 * Measure SELinux policy only after initialization is completed.
 	 */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4bde570d56a2..8b561e1c2caa 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -41,6 +41,7 @@
 #include "security.h"
 #include "objsec.h"
 #include "conditional.h"
+#include "ima.h"
 
 enum sel_inos {
 	SEL_ROOT_INO = 2,
@@ -182,6 +183,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
 			call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+
+		mutex_lock(&state->policy_mutex);
+		selinux_ima_measure_state(state);
+		mutex_unlock(&state->policy_mutex);
 	}
 	length = count;
 out:
@@ -762,6 +767,11 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	length = count;
+
+	mutex_lock(&fsi->state->policy_mutex);
+	selinux_ima_measure_state(fsi->state);
+	mutex_unlock(&fsi->state->policy_mutex);
+
 out:
 	kfree(page);
 	return length;
-- 
2.30.0

