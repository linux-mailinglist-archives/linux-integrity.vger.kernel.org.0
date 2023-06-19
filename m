Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86013735FC5
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFSWLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 18:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFSWLJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 18:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2F134;
        Mon, 19 Jun 2023 15:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C135560F02;
        Mon, 19 Jun 2023 22:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E37C433C0;
        Mon, 19 Jun 2023 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687212666;
        bh=V0p7OOOJsgnxMhRDePbjy5nyyiy1ziO8bCcD9o4MOYI=;
        h=From:To:Cc:Subject:Date:From;
        b=r5LR4QJ83XzVNGrY0aCKeKPkNuWaqTUVGeA6ji+/haNebAWFId65YvQuyC4pBZmzD
         NWF1r3pWAo4iQxKUXQt6z4T8Ugc7jqjtZZbHFm5VMd086J4oc+QDH+cTTdwO/YVnco
         zn3Bvc321COSw+nhMriKQ4KyUMgl5k4FmfI2tH73pNg1345qaxBLg3Gmy2sfjyflpY
         e/W/mn0U0Mkyw7lUktC5I1umrd7H8xreLMkzFVmpSfbq9AyPmIadxJKUhgV2O0fxEw
         MTh0hs6kofouGQCgjCTlWCrWWimCbj3dHhFSmanLsYWjoZaVdDwp1TQ7bANcVifEfH
         oJg1oopbj1vmg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Luca Boccassi <bluca@debian.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH v2] fsverity: improve documentation for builtin signature support
Date:   Mon, 19 Jun 2023 15:10:48 -0700
Message-ID: <20230619221048.10335-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fsverity builtin signatures (CONFIG_FS_VERITY_BUILTIN_SIGNATURES) aren't
the only way to do signatures with fsverity, and they have some major
limitations.  Yet, more users have tried to use them, e.g. recently by
https://github.com/ostreedev/ostree/pull/2640.  In most cases this seems
to be because users aren't sufficiently familiar with the limitations of
this feature and what the alternatives are.

Therefore, make some updates to the documentation to try to clarify the
properties of this feature and nudge users in the right direction.

Note that the Integrity Policy Enforcement (IPE) LSM, which is not yet
upstream, is planned to use the builtin signatures.  (This differs from
IMA, which uses its own signature mechanism.)  For that reason, my
earlier patch "fsverity: mark builtin signatures as deprecated"
(https://lore.kernel.org/r/20221208033548.122704-1-ebiggers@kernel.org),
which marked builtin signatures as "deprecated", was controversial.

This patch therefore stops short of marking the feature as deprecated.
I've also revised the language to focus on better explaining the feature
and what its alternatives are.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: updated two paragraphs of fsverity.rst to address Luca's comments

 Documentation/filesystems/fsverity.rst | 190 ++++++++++++++++---------
 fs/verity/Kconfig                      |  16 +--
 fs/verity/enable.c                     |   2 +-
 fs/verity/open.c                       |   8 +-
 fs/verity/read_metadata.c              |   4 +-
 fs/verity/signature.c                  |   8 ++
 6 files changed, 147 insertions(+), 81 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index ede672dedf110..c33f783e74953 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -38,20 +38,14 @@ fail at runtime.
 Use cases
 =========
 
-By itself, the base fs-verity feature only provides integrity
-protection, i.e. detection of accidental (non-malicious) corruption.
+By itself, fs-verity only provides integrity protection, i.e.
+detection of accidental (non-malicious) corruption.
 
 However, because fs-verity makes retrieving the file hash extremely
 efficient, it's primarily meant to be used as a tool to support
 authentication (detection of malicious modifications) or auditing
 (logging file hashes before use).
 
-Trusted userspace code (e.g. operating system code running on a
-read-only partition that is itself authenticated by dm-verity) can
-authenticate the contents of an fs-verity file by using the
-`FS_IOC_MEASURE_VERITY`_ ioctl to retrieve its hash, then verifying a
-digital signature of it.
-
 A standard file hash could be used instead of fs-verity.  However,
 this is inefficient if the file is large and only a small portion may
 be accessed.  This is often the case for Android application package
@@ -69,24 +63,34 @@ still be used on read-only filesystems.  fs-verity is for files that
 must live on a read-write filesystem because they are independently
 updated and potentially user-installed, so dm-verity cannot be used.
 
-The base fs-verity feature is a hashing mechanism only; actually
-authenticating the files may be done by:
-
-* Userspace-only
-
-* Builtin signature verification + userspace policy
-
-  fs-verity optionally supports a simple signature verification
-  mechanism where users can configure the kernel to require that
-  all fs-verity files be signed by a key loaded into a keyring;
-  see `Built-in signature verification`_.
-
-* Integrity Measurement Architecture (IMA)
-
-  IMA supports including fs-verity file digests and signatures in the
-  IMA measurement list and verifying fs-verity based file signatures
-  stored as security.ima xattrs, based on policy.
-
+fs-verity does not mandate a particular scheme for authenticating its
+file hashes.  (Similarly, dm-verity does not mandate a particular
+scheme for authenticating its block device root hashes.)  Options for
+authenticating fs-verity file hashes include:
+
+- Trusted userspace code.  Often, the userspace code that accesses
+  files can be trusted to authenticate them.  Consider e.g. an
+  application that wants to authenticate data files before using them,
+  or an application loader that is part of the operating system (which
+  is already authenticated in a different way, such as by being loaded
+  from a read-only partition that uses dm-verity) and that wants to
+  authenticate applications before loading them.  In these cases, this
+  trusted userspace code can authenticate a file's contents by
+  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then
+  verifying a signature of it using any userspace cryptographic
+  library that supports digital signatures.  Consider using `libsodium
+  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
+  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
+  Other options include OpenSSL, JCA, and libgcrypt.
+
+- Integrity Measurement Architecture (IMA).  IMA supports fs-verity
+  file digests as an alternative to its traditional full file digests.
+  "IMA appraisal" enforces that files contain a valid, matching
+  signature in their "security.ima" extended attribute, as controlled
+  by the IMA policy.  For more information, see the IMA documentation.
+
+- Trusted userspace code in combination with `Built-in signature
+  verification`_.  This approach should be used only with great care.
 
 User API
 ========
@@ -111,8 +115,7 @@ follows::
     };
 
 This structure contains the parameters of the Merkle tree to build for
-the file, and optionally contains a signature.  It must be initialized
-as follows:
+the file.  It must be initialized as follows:
 
 - ``version`` must be 1.
 - ``hash_algorithm`` must be the identifier for the hash algorithm to
@@ -129,12 +132,14 @@ as follows:
   file or device.  Currently the maximum salt size is 32 bytes.
 - ``salt_ptr`` is the pointer to the salt, or NULL if no salt is
   provided.
-- ``sig_size`` is the size of the signature in bytes, or 0 if no
-  signature is provided.  Currently the signature is (somewhat
-  arbitrarily) limited to 16128 bytes.  See `Built-in signature
-  verification`_ for more information.
-- ``sig_ptr``  is the pointer to the signature, or NULL if no
-  signature is provided.
+- ``sig_size`` is the size of the builtin signature in bytes, or 0 if no
+  builtin signature is provided.  Currently the builtin signature is
+  (somewhat arbitrarily) limited to 16128 bytes.
+- ``sig_ptr``  is the pointer to the builtin signature, or NULL if no
+  builtin signature is provided.  A builtin signature is only needed
+  if the `Built-in signature verification`_ feature is being used.  It
+  is not needed for IMA appraisal, and it is not needed if the file
+  signature is being handled entirely in userspace.
 - All reserved fields must be zeroed.
 
 FS_IOC_ENABLE_VERITY causes the filesystem to build a Merkle tree for
@@ -158,7 +163,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
-- ``EBADMSG``: the signature is malformed
+- ``EBADMSG``: the builtin signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
 - ``EFAULT``: the caller provided inaccessible memory
@@ -168,10 +173,10 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
   reserved bits are set; or the file descriptor refers to neither a
   regular file nor a directory.
 - ``EISDIR``: the file descriptor refers to a directory
-- ``EKEYREJECTED``: the signature doesn't match the file
-- ``EMSGSIZE``: the salt or signature is too long
-- ``ENOKEY``: the fs-verity keyring doesn't contain the certificate
-  needed to verify the signature
+- ``EKEYREJECTED``: the builtin signature doesn't match the file
+- ``EMSGSIZE``: the salt or builtin signature is too long
+- ``ENOKEY``: the ".fs-verity" keyring doesn't contain the certificate
+  needed to verify the builtin signature
 - ``ENOPKG``: fs-verity recognizes the hash algorithm, but it's not
   available in the kernel's crypto API as currently configured (e.g.
   for SHA-512, missing CONFIG_CRYPTO_SHA512).
@@ -180,8 +185,8 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
   support; or the filesystem superblock has not had the 'verity'
   feature enabled on it; or the filesystem does not support fs-verity
   on this file.  (See `Filesystem support`_.)
-- ``EPERM``: the file is append-only; or, a signature is required and
-  one was not provided.
+- ``EPERM``: the file is append-only; or, a builtin signature is
+  required and one was not provided.
 - ``EROFS``: the filesystem is read-only
 - ``ETXTBSY``: someone has the file open for writing.  This can be the
   caller's file descriptor, another open file descriptor, or the file
@@ -270,9 +275,9 @@ This ioctl takes in a pointer to the following structure::
 - ``FS_VERITY_METADATA_TYPE_DESCRIPTOR`` reads the fs-verity
   descriptor.  See `fs-verity descriptor`_.
 
-- ``FS_VERITY_METADATA_TYPE_SIGNATURE`` reads the signature which was
-  passed to FS_IOC_ENABLE_VERITY, if any.  See `Built-in signature
-  verification`_.
+- ``FS_VERITY_METADATA_TYPE_SIGNATURE`` reads the builtin signature
+  which was passed to FS_IOC_ENABLE_VERITY, if any.  See `Built-in
+  signature verification`_.
 
 The semantics are similar to those of ``pread()``.  ``offset``
 specifies the offset in bytes into the metadata item to read from, and
@@ -299,7 +304,7 @@ FS_IOC_READ_VERITY_METADATA can fail with the following errors:
   overflowed
 - ``ENODATA``: the file is not a verity file, or
   FS_VERITY_METADATA_TYPE_SIGNATURE was requested but the file doesn't
-  have a built-in signature
+  have a builtin signature
 - ``ENOTTY``: this type of filesystem does not implement fs-verity, or
   this ioctl is not yet implemented on it
 - ``EOPNOTSUPP``: the kernel was not configured with fs-verity
@@ -347,8 +352,8 @@ non-verity one, with the following exceptions:
   with EIO (for read()) or SIGBUS (for mmap() reads).
 
 - If the sysctl "fs.verity.require_signatures" is set to 1 and the
-  file is not signed by a key in the fs-verity keyring, then opening
-  the file will fail.  See `Built-in signature verification`_.
+  file is not signed by a key in the ".fs-verity" keyring, then
+  opening the file will fail.  See `Built-in signature verification`_.
 
 Direct access to the Merkle tree is not supported.  Therefore, if a
 verity file is copied, or is backed up and restored, then it will lose
@@ -433,20 +438,25 @@ root hash as well as other fields such as the file size::
 Built-in signature verification
 ===============================
 
-With CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y, fs-verity supports putting
-a portion of an authentication policy (see `Use cases`_) in the
-kernel.  Specifically, it adds support for:
+CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y adds supports for in-kernel
+verification of fs-verity builtin signatures.
+
+**IMPORTANT**!  Please take great care before using this feature.
+It is not the only way to do signatures with fs-verity, and the
+alternatives (such as userspace signature verification, and IMA
+appraisal) can be much better.  It's also easy to fall into a trap
+of thinking this feature solves more problems than it actually does.
+
+Enabling this option adds the following:
 
-1. At fs-verity module initialization time, a keyring ".fs-verity" is
-   created.  The root user can add trusted X.509 certificates to this
-   keyring using the add_key() system call, then (when done)
-   optionally use keyctl_restrict_keyring() to prevent additional
-   certificates from being added.
+1. At boot time, the kernel creates a keyring named ".fs-verity".  The
+   root user can add trusted X.509 certificates to this keyring using
+   the add_key() system call.
 
 2. `FS_IOC_ENABLE_VERITY`_ accepts a pointer to a PKCS#7 formatted
    detached signature in DER format of the file's fs-verity digest.
-   On success, this signature is persisted alongside the Merkle tree.
-   Then, any time the file is opened, the kernel will verify the
+   On success, the ioctl persists the signature alongside the Merkle
+   tree.  Then, any time the file is opened, the kernel verifies the
    file's actual digest against this signature, using the certificates
    in the ".fs-verity" keyring.
 
@@ -454,8 +464,8 @@ kernel.  Specifically, it adds support for:
    When set to 1, the kernel requires that all verity files have a
    correctly signed digest as described in (2).
 
-fs-verity file digests must be signed in the following format, which
-is similar to the structure used by `FS_IOC_MEASURE_VERITY`_::
+The data that the signature as described in (2) must be a signature of
+is the fs-verity file digest in the following format::
 
     struct fsverity_formatted_digest {
             char magic[8];                  /* must be "FSVerity" */
@@ -464,13 +474,61 @@ is similar to the structure used by `FS_IOC_MEASURE_VERITY`_::
             __u8 digest[];
     };
 
-fs-verity's built-in signature verification support is meant as a
-relatively simple mechanism that can be used to provide some level of
-authenticity protection for verity files, as an alternative to doing
-the signature verification in userspace or using IMA-appraisal.
-However, with this mechanism, userspace programs still need to check
-that the verity bit is set, and there is no protection against verity
-files being swapped around.
+That's it.  It should be emphasized again that fs-verity builtin
+signatures are not the only way to do signatures with fs-verity.  See
+`Use cases`_ for an overview of ways in which fs-verity can be used.
+fs-verity builtin signatures have some major limitations that should
+be carefully considered before using them:
+
+- Builtin signature verification does *not* make the kernel enforce
+  that any files actually have fs-verity enabled.  Thus, it is not a
+  complete authentication policy.  Currently, if it is used, the only
+  way to complete the authentication policy is for trusted userspace
+  code to explicitly check whether files have fs-verity enabled with a
+  signature before they are accessed.  (With
+  fs.verity.require_signatures=1, just checking whether fs-verity is
+  enabled suffices.)  But, in this case the trusted userspace code
+  could just store the signature alongside the file and verify it
+  itself using a cryptographic library, instead of using this feature.
+
+- Builtin signature verification uses the same set of public keys for
+  all fs-verity enabled files on the system.  Different keys cannot be
+  trusted for different files; each key is all or nothing.
+
+- The sysctl fs.verity.require_signatures applies system-wide.
+  Setting it to 1 only works when all users of fs-verity on the system
+  agree that it should be set to 1.  This limitation can prevent
+  fs-verity from being used in cases where it would be helpful.
+
+- Builtin signature verification can only use signature algorithms
+  that are supported by the kernel.  For example, the kernel does not
+  yet support Ed25519, even though this is often the signature
+  algorithm that is recommended for new cryptographic designs.
+
+- fs-verity builtin signatures are in PKCS#7 format, and the public
+  keys are in X.509 format.  These data formats are unnecessarily
+  complex and prone to vulnerabilities.  (fs-verity builtin signatures
+  were made to use these formats because other kernel subsystems, such
+  as the module loader, unfortunately used these formats already.
+  Note, these formats should still be used when they are the only
+  option to have signatures at all.)  Userspace signature verification
+  avoids having to enable CONFIG_FS_VERITY_BUILTIN_SIGNATURES and the
+  associated kernel attack surface.  Userspace also has the
+  flexibility to choose simpler formats.  For example, consider using
+  straightforward Ed25519 keys and signatures with `libsodium
+  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
+
+  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
+  partially avoids this issue as well (though it does use X.509).
+
+  If you are considering making use of "advanced" features of X.509
+  and/or PKCS#7, please also keep in mind that these "advanced"
+  features do not always work as intended with the kernel.  For
+  example, the kernel does not check X.509 certificate validity times.
+
+- A file's builtin signature can only be set at the same time that
+  fs-verity is being enabled on the file.  Changing or deleting the
+  builtin signature later requires re-creating the file.
 
 Filesystem support
 ==================
diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
index a7ffd718f1719..e1036e5353521 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -39,14 +39,14 @@ config FS_VERITY_BUILTIN_SIGNATURES
 	depends on FS_VERITY
 	select SYSTEM_DATA_VERIFICATION
 	help
-	  Support verifying signatures of verity files against the X.509
-	  certificates that have been loaded into the ".fs-verity"
-	  kernel keyring.
+	  This option adds support for in-kernel verification of
+	  fs-verity builtin signatures.
 
-	  This is meant as a relatively simple mechanism that can be
-	  used to provide an authenticity guarantee for verity files, as
-	  an alternative to IMA appraisal.  Userspace programs still
-	  need to check that the verity bit is set in order to get an
-	  authenticity guarantee.
+	  Please take great care before using this feature.  It is not
+	  the only way to do signatures with fs-verity, and the
+	  alternatives (such as userspace signature verification, and
+	  IMA appraisal) can be much better.  For details about the
+	  limitations of this feature, see
+	  Documentation/filesystems/fsverity.rst.
 
 	  If unsure, say N.
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index bd86b25ac084b..c284f46d1b535 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -208,7 +208,7 @@ static int enable_verity(struct file *filp,
 	}
 	desc->salt_size = arg->salt_size;
 
-	/* Get the signature if the user provided one */
+	/* Get the builtin signature if the user provided one */
 	if (arg->sig_size &&
 	    copy_from_user(desc->signature, u64_to_user_ptr(arg->sig_ptr),
 			   arg->sig_size)) {
diff --git a/fs/verity/open.c b/fs/verity/open.c
index f0383bef86eaa..1db5106a9c385 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -156,7 +156,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 
 /*
  * Compute the file digest by hashing the fsverity_descriptor excluding the
- * signature and with the sig_size field set to 0.
+ * builtin signature and with the sig_size field set to 0.
  */
 static int compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 			       struct fsverity_descriptor *desc,
@@ -174,7 +174,7 @@ static int compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 
 /*
  * Create a new fsverity_info from the given fsverity_descriptor (with optional
- * appended signature), and check the signature if present.  The
+ * appended builtin signature), and check the signature if present.  The
  * fsverity_descriptor must have already undergone basic validation.
  */
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
@@ -319,8 +319,8 @@ static bool validate_fsverity_descriptor(struct inode *inode,
 }
 
 /*
- * Read the inode's fsverity_descriptor (with optional appended signature) from
- * the filesystem, and do basic validation of it.
+ * Read the inode's fsverity_descriptor (with optional appended builtin
+ * signature) from the filesystem, and do basic validation of it.
  */
 int fsverity_get_descriptor(struct inode *inode,
 			    struct fsverity_descriptor **desc_ret)
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 2aefc5565152a..f58432772d9ea 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -105,7 +105,7 @@ static int fsverity_read_descriptor(struct inode *inode,
 	if (res)
 		return res;
 
-	/* don't include the signature */
+	/* don't include the builtin signature */
 	desc_size = offsetof(struct fsverity_descriptor, signature);
 	desc->sig_size = 0;
 
@@ -131,7 +131,7 @@ static int fsverity_read_signature(struct inode *inode,
 	}
 
 	/*
-	 * Include only the signature.  Note that fsverity_get_descriptor()
+	 * Include only the builtin signature.  fsverity_get_descriptor()
 	 * already verified that sig_size is in-bounds.
 	 */
 	res = fsverity_read_buffer(buf, offset, length, desc->signature,
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index b8c51ad40d3a3..72034bc71c9d9 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -5,6 +5,14 @@
  * Copyright 2019 Google LLC
  */
 
+/*
+ * This file implements verification of fs-verity builtin signatures.  Please
+ * take great care before using this feature.  It is not the only way to do
+ * signatures with fs-verity, and the alternatives (such as userspace signature
+ * verification, and IMA appraisal) can be much better.  For details about the
+ * limitations of this feature, see Documentation/filesystems/fsverity.rst.
+ */
+
 #include "fsverity_private.h"
 
 #include <linux/cred.h>

base-commit: 74836ecbc5c7565d24a770917644e96af3e98d25
-- 
2.41.0

