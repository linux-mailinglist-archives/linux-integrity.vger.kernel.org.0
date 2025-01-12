Return-Path: <linux-integrity+bounces-4533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE501A0A76C
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jan 2025 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE723A85D4
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jan 2025 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DE2148FF2;
	Sun, 12 Jan 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLvI87kw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492760DCF;
	Sun, 12 Jan 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736667055; cv=none; b=QYXDRt2gQUajnkbaAmQEV1OmYJU4z2AhgUrZ9bgBIksisA8zZRcKgZ3OXcfnaVFof3CftLtSyugy9+W5kRD0icPkYNivhBmWWbEhmFpK2NATRzQ95sxCn0725XSTaim0LzY44gcgk7XKYowez+VcA5TsLpv5uPpOvEandz9J+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736667055; c=relaxed/simple;
	bh=ZTYM3OnM/7unQ2MSp2P9kzBsr9cRYJIv4TlO/6Atspg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFrheZF4rnXSz6D4Ldv4KsFFvZaJcmch352VYipKHvDVBa3aNEmm+EfV1sT+Ah8TIgkV9ORaSgywyfgw01NjNoU+q8f6rFg+b+ZbcaNy/zKJbtuB+fk18OA4MM6k81gcmJjRgbqLhUc5fqilke+/A5pARYhqEtSuAgWTPfcQR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLvI87kw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso56060485ad.3;
        Sat, 11 Jan 2025 23:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736667052; x=1737271852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7+KZIabYjHMCcMYLzm434ffxpK30mZmGo2A00HT3KY=;
        b=LLvI87kwsyLNfVH1LBObd2UTSOpM4huhHW2eGfJTkpjzjAxsd/7sEyoNQIv3ZT9z0i
         22aLSOK3jDYa88DoVnF0xAlq2g09V/HelRQCTIqT7R7HB1Du1oAoYts533BL1jBdWkVt
         IKXZ7dKzo9H7WvGZ7GpGmo4zfJoY7K9PUoIthGT51fNcEeIYADeuFAoEQevFaHBIy4X6
         FkDesEBLkSiZ5N60J4r+vZNzxuZGWlEGn4bUP1nN7xpXaUtfUsGRhYiEsdltNo/bqCHl
         LwjO+U0zVnAPHJRGuqX3OrrNx9HAXqtvhOdFhHYV4dnn3MT3lDxPssLRj1Y93Tu62HrS
         9C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736667052; x=1737271852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7+KZIabYjHMCcMYLzm434ffxpK30mZmGo2A00HT3KY=;
        b=Cj7PSKqhjWvLjFqqnAblNREnDjrQzi6K6VeRR1D27mLaainhypx4VodcGAa89kO64x
         6m/BcmhGW6RaE4ip594JfSYUaYWWTfPPSsIomPbaXhNJ3B2nH2HukWrTQl0intMHmsXk
         ViCA9TI0VsYN6/99xJurMowXbuZefRUKmhF1FgoTT7feF+vF6lsOFZDViE19ukzB0Cr6
         MniMK4EsWO5kq1fikZu8wX0AigGKyP1fTa6LBU5vLgrpNEr8Xu/+6YLI/ABJbz18Lq8p
         0va/kimvScdfWP/WydHtX+3qtAlF8nlsmrM9sy4JNADAVuGsK+bRYrxMJQLVto7/6QeF
         jZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36EltV4OoKWDy2lheyk564vRAkWXU0jzoYBx2aCPhZaRvFIl8ZktIosVbggp14SNTWwdC6aUj8FO/b9KR@vger.kernel.org, AJvYcCVfW/w1W5i8KrHj33QEuNi43SMWehOvyP82t8DSfpKZWF6zf74be7tROY5qJboQzho2wAlrFShCchteKEK6PquZfKI652q/@vger.kernel.org, AJvYcCWG14TJ8AxZ8bk58avHQ1HRzx75qU5nSsFX2SE7kMXpnpipg2L1GCOp5xNTXFgOZwh83BntqsLyoxF9shkct9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUQ3U+kD663F4HnQGF7Jz6SuPGMCF8rOgWwX1IhaJkzT+h9Pz
	3+vUNgy1dZnesOsCMsLz3RPN3Kvy2jy1li2xAL+SdE6lItVLIIGy
X-Gm-Gg: ASbGncveLLi0h2J3gxqbbBHO2p+fC3FUZ44kp7F66gXIR3WPlaH6qj2EP8fxZ8ZrowP
	0fk5HWf2eWvKbnaKWcJWOrE3D77LlaznTcA0kp7K3IXFz/cq1Yhv+cY1WaNg4cSI0yQ4QXuuK5y
	OgsdbIvnNgjcu/3UYcdULVtvKHttTa+XLulUblhjNQ7HSjSdsJRxwTtEreXGyW6xrfBFOgLbfzk
	fJQmsnp4otPUUaUlXg7WhBDYK29pzuMsy5n1WZGXle9QgQ3UQKgyBs=
X-Google-Smtp-Source: AGHT+IFpPpCi+VL6IvLEKJLym8igC+MjdCG+S8OPf5QDLuroN8Bn+bdaYXqt9L6bvSUJYp5M11UJ5w==
X-Received: by 2002:a17:902:c951:b0:216:2b14:b625 with SMTP id d9443c01a7336-21a83f765c4mr239952305ad.31.1736667052218;
        Sat, 11 Jan 2025 23:30:52 -0800 (PST)
Received: from localhost.localdomain ([122.174.69.103])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21a9f22d293sm35074905ad.185.2025.01.11.23.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 23:30:50 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: casey@schaufler-ca.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	mic@digikod.net,
	gnoack@google.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH V2] security: fix typos and spelling errors
Date: Sun, 12 Jan 2025 12:59:27 +0530
Message-Id: <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250111.22fc32ae0729@gnoack.org>
References: <20250111.22fc32ae0729@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix typos and spelling errors in security module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
Thanks Günther, for catching this error.
The irony of having a spelling mistake in a patch that fixes spelling
mistakes is not lost on me :) 

I've fixed it in V2 of the patch. Thank you for the careful review!

V2: fix spelling mistake - s/beeen/been/ 

 security/apparmor/apparmorfs.c      | 6 +++---
 security/apparmor/domain.c          | 4 ++--
 security/apparmor/label.c           | 2 +-
 security/apparmor/lsm.c             | 2 +-
 security/apparmor/policy.c          | 4 ++--
 security/integrity/evm/evm_crypto.c | 2 +-
 security/integrity/evm/evm_main.c   | 2 +-
 security/integrity/ima/ima_main.c   | 6 +++---
 security/landlock/ruleset.c         | 2 +-
 security/selinux/avc.c              | 2 +-
 security/smack/smack.h              | 2 +-
 security/smack/smack_access.c       | 4 ++--
 security/smack/smack_lsm.c          | 6 +++---
 security/smack/smackfs.c            | 2 +-
 security/tomoyo/domain.c            | 2 +-
 15 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2c0185ebc900..0c2f248d31bf 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -43,7 +43,7 @@
  * The interface is split into two main components based on their function
  * a securityfs component:
  *   used for static files that are always available, and which allows
- *   userspace to specificy the location of the security filesystem.
+ *   userspace to specify the location of the security filesystem.
  *
  *   fns and data are prefixed with
  *      aa_sfs_
@@ -204,7 +204,7 @@ static struct file_system_type aafs_ops = {
 /**
  * __aafs_setup_d_inode - basic inode setup for apparmorfs
  * @dir: parent directory for the dentry
- * @dentry: dentry we are seting the inode up for
+ * @dentry: dentry we are setting the inode up for
  * @mode: permissions the file should have
  * @data: data to store on inode.i_private, available in open()
  * @link: if symlink, symlink target string
@@ -2244,7 +2244,7 @@ static void *p_next(struct seq_file *f, void *p, loff_t *pos)
 /**
  * p_stop - stop depth first traversal
  * @f: seq_file we are filling
- * @p: the last profile writen
+ * @p: the last profile written
  *
  * Release all locking done by p_start/p_next on namespace tree
  */
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 5939bd9a9b9b..d959931eac28 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -755,7 +755,7 @@ static int profile_onexec(const struct cred *subj_cred,
 		/* change_profile on exec already granted */
 		/*
 		 * NOTE: Domain transitions from unconfined are allowed
-		 * even when no_new_privs is set because this aways results
+		 * even when no_new_privs is set because this always results
 		 * in a further reduction of permissions.
 		 */
 		return 0;
@@ -926,7 +926,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	 *
 	 * NOTE: Domain transitions from unconfined and to stacked
 	 * subsets are allowed even when no_new_privs is set because this
-	 * aways results in a further reduction of permissions.
+	 * always results in a further reduction of permissions.
 	 */
 	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
 	    !unconfined(label) &&
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 91483ecacc16..8bcff51becb8 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1456,7 +1456,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
 
 /*
  * cached label name is present and visible
- * @label->hname only exists if label is namespace hierachical
+ * @label->hname only exists if label is namespace hierarchical
  */
 static inline bool use_label_hname(struct aa_ns *ns, struct aa_label *label,
 				   int flags)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1edc12862a7d..04bf5d2f6e00 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2006,7 +2006,7 @@ static int __init alloc_buffers(void)
 	 * two should be enough, with more CPUs it is possible that more
 	 * buffers will be used simultaneously. The preallocated pool may grow.
 	 * This preallocation has also the side-effect that AppArmor will be
-	 * disabled early at boot if aa_g_path_max is extremly high.
+	 * disabled early at boot if aa_g_path_max is extremely high.
 	 */
 	if (num_online_cpus() > 1)
 		num = 4 + RESERVE_COUNT;
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index d0244fab0653..5cec3efc4794 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -463,7 +463,7 @@ static struct aa_policy *__lookup_parent(struct aa_ns *ns,
 }
 
 /**
- * __create_missing_ancestors - create place holders for missing ancestores
+ * __create_missing_ancestors - create place holders for missing ancestors
  * @ns: namespace to lookup profile in (NOT NULL)
  * @hname: hierarchical profile name to find parent of (NOT NULL)
  * @gfp: type of allocation.
@@ -1068,7 +1068,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 		goto out;
 
 	/* ensure that profiles are all for the same ns
-	 * TODO: update locking to remove this constaint. All profiles in
+	 * TODO: update locking to remove this constraint. All profiles in
 	 *       the load set must succeed as a set or the load will
 	 *       fail. Sort ent list and take ns locks in hierarchy order
 	 */
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 7c06ffd633d2..a5e730ffda57 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -180,7 +180,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 }
 
 /*
- * Dump large security xattr values as a continuous ascii hexademical string.
+ * Dump large security xattr values as a continuous ascii hexadecimal string.
  * (pr_debug is limited to 64 bytes.)
  */
 static void dump_security_xattr_l(const char *prefix, const void *src,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 377e57e9084f..0add782e73ba 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -169,7 +169,7 @@ static int is_unsupported_hmac_fs(struct dentry *dentry)
  * and compare it against the stored security.evm xattr.
  *
  * For performance:
- * - use the previoulsy retrieved xattr value and length to calculate the
+ * - use the previously retrieved xattr value and length to calculate the
  *   HMAC.)
  * - cache the verification result in the iint, when available.
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..cdb8c7419d7e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -983,9 +983,9 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	}
 
 	/*
-	 * Both LSM hooks and auxilary based buffer measurements are
-	 * based on policy.  To avoid code duplication, differentiate
-	 * between the LSM hooks and auxilary buffer measurements,
+	 * Both LSM hooks and auxiliary based buffer measurements are
+	 * based on policy. To avoid code duplication, differentiate
+	 * between the LSM hooks and auxiliary buffer measurements,
 	 * retrieving the policy rule information only for the LSM hook
 	 * buffer measurements.
 	 */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a93bdbf52fff..c464d1f84792 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
 		return ERR_PTR(-ENOMEM);
 	RB_CLEAR_NODE(&new_rule->node);
 	if (is_object_pointer(id.type)) {
-		/* This should be catched by insert_rule(). */
+		/* This should have been caught by insert_rule(). */
 		WARN_ON_ONCE(!id.key.object);
 		landlock_get_object(id.key.object);
 	}
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 1f2680bcc43a..4b4837a20225 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -936,7 +936,7 @@ static void avc_flush(void)
 
 		spin_lock_irqsave(lock, flag);
 		/*
-		 * With preemptable RCU, the outer spinlock does not
+		 * With preemptible RCU, the outer spinlock does not
 		 * prevent RCU grace periods from ending.
 		 */
 		rcu_read_lock();
diff --git a/security/smack/smack.h b/security/smack/smack.h
index dbf8d7226eb5..ca38e145f364 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -42,7 +42,7 @@
 
 /*
  * This is the repository for labels seen so that it is
- * not necessary to keep allocating tiny chuncks of memory
+ * not necessary to keep allocating tiny chunks of memory
  * and so that they can be shared.
  *
  * Labels are never modified in place. Anytime a label
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 585e5e35710b..5c17aee5dd78 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -242,7 +242,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
 	}
 
 	/*
-	 * Allow for priviliged to override policy.
+	 * Allow for privileged to override policy.
 	 */
 	if (rc != 0 && smack_privileged(CAP_MAC_OVERRIDE))
 		rc = 0;
@@ -277,7 +277,7 @@ int smk_curacc(struct smack_known *obj_known,
 
 #ifdef CONFIG_AUDIT
 /**
- * smack_str_from_perm : helper to transalate an int to a
+ * smack_str_from_perm : helper to translate an int to a
  * readable string
  * @string : the string to fill
  * @access : the int
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0c476282e279..85ec288eefe7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	 */
 	file = fown->file;
 
-	/* we don't log here as rc can be overriden */
+	/* we don't log here as rc can be overridden */
 	blob = smack_file(file);
 	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
@@ -4211,7 +4211,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		/*
 		 * Receiving a packet requires that the other end
 		 * be able to write here. Read access is not required.
-		 * This is the simplist possible security model
+		 * This is the simplest possible security model
 		 * for networking.
 		 */
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
@@ -4717,7 +4717,7 @@ static int smack_post_notification(const struct cred *w_cred,
  * @gfp: type of the memory for the allocation
  *
  * Prepare to audit cases where (@field @op @rulestr) is true.
- * The label to be audited is created if necessay.
+ * The label to be audited is created if necessary.
  */
 static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 				 gfp_t gfp)
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 1401412fd794..432e2d094e35 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -165,7 +165,7 @@ static int smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
 #define SMK_LOADLEN	(SMK_LABELLEN + SMK_LABELLEN + SMK_ACCESSLEN)
 
 /*
- * Stricly for CIPSO level manipulation.
+ * Strictly for CIPSO level manipulation.
  * Set the category bit number in a smack label sized buffer.
  */
 static inline void smack_catset_bit(unsigned int cat, char *catsetp)
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index aed9e3ef2c9e..9a1928be707d 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -913,7 +913,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 #ifdef CONFIG_MMU
 	/*
 	 * This is called at execve() time in order to dig around
-	 * in the argv/environment of the new proceess
+	 * in the argv/environment of the new process
 	 * (represented by bprm).
 	 */
 	mmap_read_lock(bprm->mm);
-- 
2.39.5


