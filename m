Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133DD221191
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGOPtC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 11:49:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45932 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGOPtB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 11:49:01 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 969D420B490D;
        Wed, 15 Jul 2020 08:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 969D420B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594828139;
        bh=hULiY/K/I3S3Y8jZ2YtZlqHB8cUZi9TTQWrFp45uKr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJBrixD5syOmZHvtYaW/BmyKGbYEZA+b6Dx0eSCsrfwGAM9CsU/QgpZkxIvA+d4sn
         SwSYOqfmizCOaVPSHeuUDGwLXDArqwOg26TrcoUX7SFgY2+N9NfxCiGvn/54Bs/qns
         KTcbv9/eOajyXJ8OXVx0WCuEgU9k/+dQIpPvESWs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] LSM: Define SELinux function to measure security state
Date:   Wed, 15 Jul 2020 08:48:52 -0700
Message-Id: <20200715154853.23374-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715154853.23374-1-nramas@linux.microsoft.com>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SELinux configuration and policy are some of the critical data for this
security module that needs to be measured. To enable this measurement
SELinux needs to implement the interface function, security_state(), that
the LSM can call.

Define the security_state() function in SELinux to measure SELinux
configuration and policy. Call this function to measure SELinux data
when there is a change in the security module's state.

Sample measurement of SELinux state and hash of the policy:

10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state 656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574706565723d313b6f70656e7065726d3d313b657874736f636b636c6173733d313b616c776179736e6574776f726b3d303b6367726f75707365636c6162656c3d313b6e6e706e6f737569647472616e736974696f6e3d313b67656e66737365636c6162656c73796d6c696e6b3d303b
10 f4a7...9408 ima-buf sha256:4941...68fc selinux-policy-hash 8d1d...1834

The data for selinux-state in the above measurement is:
enabled=1;enforcing=0;checkreqprot=1;netpeer=1;openperm=1;extsockclass=1;alwaysnetwork=0;cgroupseclabel=1;nnpnosuidtransition=1;genfsseclabelsymlink=0;

The data for selinux-policy-hash in the above measurement is
the SHA256 hash of the SELinux policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Makefile           |   2 +
 security/selinux/hooks.c            |   2 +
 security/selinux/include/security.h |  19 +++++
 security/selinux/measure.c          | 122 ++++++++++++++++++++++++++++
 security/selinux/selinuxfs.c        |   1 +
 security/selinux/ss/services.c      |  23 +++++-
 6 files changed, 165 insertions(+), 4 deletions(-)
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
index efa6108b1ce9..1f270206f0ee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7284,6 +7284,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.security_state = selinux_security_state,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7394,6 +7395,7 @@ int selinux_disable(struct selinux_state *state)
 	}
 
 	selinux_mark_disabled(state);
+	selinux_security_state();
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b0e02cfe3ce1..691c7e35f82a 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -222,16 +222,35 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
 }
 
+static inline bool selinux_checkreqprot(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->checkreqprot;
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
 int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len);
+int security_read_selinux_policy(struct selinux_state *state,
+				 void **data, size_t *len,
+				 bool alloc_kernel_memory);
 size_t security_policydb_len(struct selinux_state *state);
 
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
+#ifdef CONFIG_IMA
+extern int selinux_security_state(void);
+#else
+static inline int selinux_security_state(void)
+{
+	return 0;
+}
+#endif
+
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/measure.c b/security/selinux/measure.c
new file mode 100644
index 000000000000..b909e8e61542
--- /dev/null
+++ b/security/selinux/measure.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Measure SELinux state using IMA subsystem.
+ */
+#include <linux/ima.h>
+#include "security.h"
+
+static int selinux_hash_policy(const char *hash_alg_name,
+			       void *policy, size_t policy_len,
+			       void **policy_hash, int *policy_hash_len)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc = NULL;
+	void *digest = NULL;
+	int desc_size;
+	int digest_size;
+	int ret = 0;
+
+	tfm = crypto_alloc_shash(hash_alg_name, 0, 0);
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
+	ret = crypto_shash_digest(desc, policy, policy_len, digest);
+	if (ret < 0)
+		goto error;
+
+	*policy_hash_len = digest_size;
+	*policy_hash = digest;
+	digest = NULL;
+
+error:
+	kfree(desc);
+	kfree(digest);
+
+	crypto_free_shash(tfm);
+
+	if (ret)
+		pr_err("%s: error %d\n", __func__, ret);
+
+	return ret;
+}
+
+int selinux_security_state(void)
+{
+	int rc = 0;
+	int count;
+	size_t buflen;
+	int policy_hash_len;
+	char *state = NULL;
+	void *policy = NULL;
+	void *policy_hash = NULL;
+	static char *security_state_string =
+			"enabled=%d;enforcing=%d;checkreqprot=%d;"        \
+			"netpeer=%d;openperm=%d;extsockclass=%d;"         \
+			"alwaysnetwork=%d;cgroupseclabel=%d;"             \
+			"nnpnosuidtransition=%d;genfsseclabelsymlink=%d;";
+
+	if (!selinux_initialized(&selinux_state))
+		return -EOPNOTSUPP;
+
+	buflen = strlen(security_state_string) + 1;
+	state = kzalloc(buflen, GFP_KERNEL);
+	if (!state) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	count = snprintf(state, buflen, security_state_string,
+			 !selinux_disabled(&selinux_state),
+			 enforcing_enabled(&selinux_state),
+			 selinux_checkreqprot(),
+			 selinux_policycap_netpeer(),
+			 selinux_policycap_openperm(),
+			 selinux_policycap_extsockclass(),
+			 selinux_policycap_alwaysnetwork(),
+			 selinux_policycap_cgroupseclabel(),
+			 selinux_policycap_nnp_nosuid_transition(),
+			 selinux_policycap_genfs_seclabel_symlinks());
+	if (count >= 0 && count < buflen)
+		ima_lsm_state("selinux-state", state, count);
+	else {
+		pr_err("selinux state error: %d\n", count);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = security_read_selinux_policy(&selinux_state,
+					  &policy, &buflen, true);
+	if (!rc)
+		rc = selinux_hash_policy("sha256", policy, buflen,
+					 &policy_hash, &policy_hash_len);
+	if (!rc)
+		ima_lsm_state("selinux-policy-hash", policy_hash,
+			      policy_hash_len);
+
+out:
+	kfree(state);
+	kfree(policy);
+	kfree(policy_hash);
+
+	if (rc)
+		pr_err("%s: error %d\n", __func__, rc);
+
+	return rc;
+}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c2510..8f68964e4ba8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -173,6 +173,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
+		selinux_security_state();
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
 		selnl_notify_setenforce(new_value);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ef0afd878bfc..0c289d13ef6a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3724,10 +3724,11 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
  * security_read_policy - read the policy.
  * @data: binary policy data
  * @len: length of data in bytes
- *
+ * @alloc_kernel_memory: flag to indicate memory allocation
  */
-int security_read_policy(struct selinux_state *state,
-			 void **data, size_t *len)
+int security_read_selinux_policy(struct selinux_state *state,
+				 void **data, size_t *len,
+				 bool alloc_kernel_memory)
 {
 	struct policydb *policydb = &state->ss->policydb;
 	int rc;
@@ -3738,7 +3739,10 @@ int security_read_policy(struct selinux_state *state,
 
 	*len = security_policydb_len(state);
 
-	*data = vmalloc_user(*len);
+	if (alloc_kernel_memory)
+		*data = kzalloc(*len, GFP_KERNEL);
+	else
+		*data = vmalloc_user(*len);
 	if (!*data)
 		return -ENOMEM;
 
@@ -3754,5 +3758,16 @@ int security_read_policy(struct selinux_state *state,
 
 	*len = (unsigned long)fp.data - (unsigned long)*data;
 	return 0;
+}
 
+/**
+ * security_read_policy - read the policy.
+ * @data: binary policy data
+ * @len: length of data in bytes
+ *
+ */
+int security_read_policy(struct selinux_state *state,
+			 void **data, size_t *len)
+{
+	return security_read_selinux_policy(state, data, len, false);
 }
-- 
2.27.0

