Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713F61F8066
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jun 2020 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFMClp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 22:41:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgFMCli (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 22:41:38 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B5AA20B4783;
        Fri, 12 Jun 2020 19:41:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B5AA20B4783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592016097;
        bh=9/oXutbjuzQ/I6R6w3F6z0lqsxijqgXEqgpbX21P2Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SI8Fof/01+jriFe6mbCZvsCy7DRxgq0daX7KNERJA0B7gG8NkhFxziMU1CQDJs8L+
         Nwt+Vxz+YqUrlJcAOj9IE8pmD5AsR1FpNPHiGBuXBukB3rKJRMPc9sjh5krlzp7Z0i
         dPzpW8tS88pVhO90ZbSLIDX0WQnJfrGKHqzFsy1w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] LSM: Define SELinux function to measure security state
Date:   Fri, 12 Jun 2020 19:41:29 -0700
Message-Id: <20200613024130.3356-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613024130.3356-1-nramas@linux.microsoft.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SELinux needs to implement the interface function, security_state(), for
the LSM to gather SELinux data for measuring. Define the security_state()
function in SELinux.

The security modules should be able to notify the LSM when there is
a change in the module's data. Define a function namely 
security_state_change() in the LSM that the security modules
can call to provide the updated data for measurement.

Call security_state_change() function from SELinux to report data
when SELinux's state is updated.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/lsm_hooks.h           |  3 ++
 security/security.c                 |  5 ++++
 security/selinux/hooks.c            | 43 +++++++++++++++++++++++++++++
 security/selinux/include/security.h |  2 ++
 security/selinux/selinuxfs.c        |  1 +
 5 files changed, 54 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index da248c3fd4ac..a63de046139e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1572,6 +1572,9 @@ struct lsm_info {
 			      int *state_len); /*Optional */
 };
 
+/* Called by LSMs to notify security state change */
+extern void security_state_change(char *lsm_name, void *state, int state_len);
+
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
diff --git a/security/security.c b/security/security.c
index a6e2d1cd95af..e7175db5a093 100644
--- a/security/security.c
+++ b/security/security.c
@@ -238,6 +238,11 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+void security_state_change(char *lsm_name, void *state, int state_len)
+{
+	ima_lsm_state(lsm_name, state, state_len);
+}
+
 static int measure_security_state(struct lsm_info *lsm)
 {
 	char *lsm_name = NULL;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7e954b555be6..bbc908a1fcd1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7225,6 +7225,47 @@ static __init int selinux_init(void)
 	return 0;
 }
 
+static int selinux_security_state(char **lsm_name, void **state,
+				  int *state_len)
+{
+	int rc = 0;
+	char *new_state;
+	static char *security_state_string = "enabled=%d;enforcing=%d";
+
+	*lsm_name = kstrdup("selinux", GFP_KERNEL);
+	if (!*lsm_name)
+		return -ENOMEM;
+
+	new_state = kzalloc(strlen(security_state_string) + 1, GFP_KERNEL);
+	if (!new_state) {
+		kfree(*lsm_name);
+		*lsm_name = NULL;
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	*state_len = sprintf(new_state, security_state_string,
+			     !selinux_disabled(&selinux_state),
+			     enforcing_enabled(&selinux_state));
+	*state = new_state;
+
+out:
+	return rc;
+}
+
+void notify_security_state_change(void)
+{
+	char *lsm_name = NULL;
+	void *state = NULL;
+	int state_len = 0;
+
+	if (!selinux_security_state(&lsm_name, &state, &state_len)) {
+		security_state_change(lsm_name, state, state_len);
+		kfree(state);
+		kfree(lsm_name);
+	}
+}
+
 static void delayed_superblock_init(struct super_block *sb, void *unused)
 {
 	selinux_set_mnt_opts(sb, NULL, 0, NULL);
@@ -7247,6 +7288,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.security_state = selinux_security_state,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7357,6 +7399,7 @@ int selinux_disable(struct selinux_state *state)
 	}
 
 	selinux_mark_disabled(state);
+	notify_security_state_change();
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b0e02cfe3ce1..83c6ada45c7c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -232,6 +232,8 @@ size_t security_policydb_len(struct selinux_state *state);
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
+void notify_security_state_change(void);
+
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c2510..8a5ba32a7775 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -173,6 +173,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
+		notify_security_state_change();
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
 		selnl_notify_setenforce(new_value);
-- 
2.27.0

