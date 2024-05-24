Return-Path: <linux-integrity+bounces-2632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA568CEB39
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642A31C2196D
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3994130E53;
	Fri, 24 May 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HTcorkoI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06F84DFD;
	Fri, 24 May 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583625; cv=none; b=s4Ba27GQfudeZW79CNAhso4hoVzH/6BzpqXwbU+hwwpn30312vB+xmLQd34hy0VgU/CiZZpI8EAwFfSk0zfMkj7JRZ45+A1ikDC3noZXyGvQR+lUtZfgMRJpBFj6c5G3efg0wspe5EDNeDESWQ7lD/+qNg9pdtt4V/4I81NksJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583625; c=relaxed/simple;
	bh=hALd62jtxfmHVvlAHqMQJIVwQq9kxLw+A81pDmAfJag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XPnfdQ8Uqd4+0WvSkbV83y/67J1pjf0ioGPnfo+LFuZwHZYyFVsKh9+bpT8IInd5m040qRzdxmM7ma+kA1BVzECVOsURh6MmXyFhhzcTfTXGzOyUuIvWzA83gPGQRc7asZqMfUP3n3Ufh6yUN3xFsfki9F4AIS/jFHhxOAC47Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HTcorkoI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id EE35F20BE595; Fri, 24 May 2024 13:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE35F20BE595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716583611;
	bh=vrJzOGuvqZ8IP0pHGyWlhX1P94tTAhnoJcQfMZyCfB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTcorkoIexYH396yioziMyDQi0DLF37upTUm8jnQgRJmZlYfB/dUCajE2t21RLqbH
	 pMUZeaDnpizhl3UQkYYhMjKrN6x105bn/GiuWBX1Z3b7ZL5EfFYX6AS+dPjMhDL05N
	 2z050H69U1Q+Ltv2QgWga9AbMmioRcmNOyj4a/v0=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: [PATCH v19 15/20] fsverity: expose verified fsverity built-in signatures to LSMs
Date: Fri, 24 May 2024 13:46:44 -0700
Message-Id: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

This patch enhances fsverity's capabilities to support both integrity and
authenticity protection by introducing the exposure of built-in
signatures through a new LSM hook. This functionality allows LSMs,
e.g. IPE, to enforce policies based on the authenticity and integrity of
files, specifically focusing on built-in fsverity signatures. It enables
a policy enforcement layer within LSMs for fsverity, offering granular
control over the usage of authenticity claims. For instance, a policy
could be established to permit the execution of all files with verified
built-in fsverity signatures while restricting kernel module loading
from specified fsverity files via fsverity digests.

The introduction of a security_inode_setintegrity() hook call within
fsverity's workflow ensures that the verified built-in signature of a file
is exposed to LSMs. This enables LSMs to recognize and label fsverity files
that contain a verified built-in fsverity signature. This hook is invoked
subsequent to the fsverity_verify_signature() process, guaranteeing the
signature's verification against fsverity's keyring. This mechanism is
crucial for maintaining system security, as it operates in kernel space,
effectively thwarting attempts by malicious binaries to bypass user space
stack interactions.

The second to last commit in this patch set will add a link to the IPE
documentation in fsverity.rst.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v6:
  + Not present

v7:
  Introduced

v8:
  + Split fs/verity/ changes and security/ changes into separate patches
  + Change signature of fsverity_create_info to accept non-const inode
  + Change signature of fsverity_verify_signature to accept non-const inode
  + Don't cast-away const from inode.
  + Digest functionality dropped in favor of:
    ("fs-verity: define a function to return the integrity protected
      file digest")
  + Reworded commit description and title to match changes.
  + Fix a bug wherein no LSM implements the particular fsverity @name
    (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.

v9:
  + No changes

v10:
  + Rename the signature blob key
  + Cleanup redundant code
  + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES

v11:
  + No changes

v12:
  + Add constification to the hook call

v13:
  + No changes

v14:
  + Add doc/comment to built-in signature verification

v15:
  + Add more docs related to IPE
  + Switch the hook call to security_inode_setintegrity()

v16:
  + Explicitly mention "fsverity builtin signatures" in the commit
    message
  + Amend documentation in fsverity.rst
  + Fix format issue
  + Change enum name

v17:
  + Fix various documentation issues
  + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID

v18:
  + Fix typos
  + Move the inode_setintegrity hook call into fsverity_verify_signature()

v19:
  + Cleanup code w.r.t inode_setintegrity hook refactoring
---
 Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
 fs/verity/signature.c                  | 18 +++++++++++++++++-
 include/linux/security.h               |  1 +
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..362b7a5dc300 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -86,6 +86,14 @@ authenticating fs-verity file hashes include:
   signature in their "security.ima" extended attribute, as controlled
   by the IMA policy.  For more information, see the IMA documentation.
 
+- Integrity Policy Enforcement (IPE).  IPE supports enforcing access
+  control decisions based on immutable security properties of files,
+  including those protected by fs-verity's built-in signatures.
+  "IPE policy" specifically allows for the authorization of fs-verity
+  files using properties ``fsverity_digest`` for identifying
+  files by their verity digest, and ``fsverity_signature`` to authorize
+  files with a verified fs-verity's built-in signature.
+
 - Trusted userspace code in combination with `Built-in signature
   verification`_.  This approach should be used only with great care.
 
@@ -457,7 +465,11 @@ Enabling this option adds the following:
    On success, the ioctl persists the signature alongside the Merkle
    tree.  Then, any time the file is opened, the kernel verifies the
    file's actual digest against this signature, using the certificates
-   in the ".fs-verity" keyring.
+   in the ".fs-verity" keyring. This verification happens as long as the
+   file's signature exists, regardless of the state of the sysctl variable
+   "fs.verity.require_signatures" described in the next item. The IPE LSM
+   relies on this behavior to recognize and label fsverity files
+   that contain a verified built-in fsverity signature.
 
 3. A new sysctl "fs.verity.require_signatures" is made available.
    When set to 1, the kernel requires that all verity files have a
@@ -481,7 +493,7 @@ be carefully considered before using them:
 
 - Builtin signature verification does *not* make the kernel enforce
   that any files actually have fs-verity enabled.  Thus, it is not a
-  complete authentication policy.  Currently, if it is used, the only
+  complete authentication policy.  Currently, if it is used, one
   way to complete the authentication policy is for trusted userspace
   code to explicitly check whether files have fs-verity enabled with a
   signature before they are accessed.  (With
@@ -490,6 +502,13 @@ be carefully considered before using them:
   could just store the signature alongside the file and verify it
   itself using a cryptographic library, instead of using this feature.
 
+- Another approach is to utilize fs-verity builtin signature
+  verification in conjunction with the IPE LSM, which supports defining
+  a kernel-enforced, system-wide authentication policy that allows only
+  files with a verified fs-verity builtin signature to perform certain
+  operations, such as execution. Note that IPE doesn't require
+  fs.verity.require_signatures=1.
+
 - A file's builtin signature can only be set at the same time that
   fs-verity is being enabled on the file.  Changing or deleting the
   builtin signature later requires re-creating the file.
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 90c07573dd77..a4ed91c7049f 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -17,6 +17,7 @@
 
 #include <linux/cred.h>
 #include <linux/key.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/verification.h>
 
@@ -41,7 +42,11 @@ static struct key *fsverity_keyring;
  * @sig_size: size of signature in bytes, or 0 if no signature
  *
  * If the file includes a signature of its fs-verity file digest, verify it
- * against the certificates in the fs-verity keyring.
+ * against the certificates in the fs-verity keyring. Note that signatures
+ * are verified regardless of the state of the 'fsverity_require_signatures'
+ * variable and the LSM subsystem relies on this behavior to help enforce
+ * file integrity policies. Please discuss changes with the LSM list
+ * (thank you!).
  *
  * Return: 0 on success (signature valid or not required); -errno on failure
  */
@@ -106,6 +111,17 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return err;
 	}
 
+	err = security_inode_setintegrity(inode,
+					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
+					  signature,
+					  le32_to_cpu(sig_size));
+
+	if (err) {
+		fsverity_err(inode, "Error %d exposing file signature to LSMs",
+			     err);
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index ab489fb02f06..2e87e038bc79 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -92,6 +92,7 @@ struct dm_verity_digest {
 enum lsm_integrity_type {
 	LSM_INT_DMVERITY_SIG_VALID,
 	LSM_INT_DMVERITY_ROOTHASH,
+	LSM_INT_FSVERITY_BUILTINSIG_VALID,
 };
 
 /*
-- 
2.44.0


