Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806EC327F33
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhCANON (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 08:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhCANNq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 08:13:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECFDC06121F
        for <linux-integrity@vger.kernel.org>; Mon,  1 Mar 2021 05:12:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i10so2300124pfk.4
        for <linux-integrity@vger.kernel.org>; Mon, 01 Mar 2021 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8nrtAJMyk7plUj6y75LO2Wyk419UMQTXmfvdE0RsOQ=;
        b=PfyU0s0epGTJaFJ91R+e0FYmQLIx4yfW2GCdqa9scNvvSujceg7+oPJwXoy5EK9ZVq
         cdMNoRY5ntDUBJ53z5Bc/qHLYNrwGKoFfiVMCV3azsfh5wk6Y1TrE5IOKjYAXH7bxK+D
         CuE1Lo2kCkQSBr09fK0s1B1yWzc8yufJwsK/TXWCAOJ9WUib+iRgA3OI1xJcoPkYjC3g
         +rSB2kVFKP469V+bwO5cGXxq2gZYZX1pVurOb5pgtmxATYFxBEsVpt1LhewDGKfiGDML
         eSVr0MF217Jidg780t1/Y9ZgNGlTLDqAZxGoqLBMA/kicxhYGqixgeyl5vSj0e6aqONS
         7SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8nrtAJMyk7plUj6y75LO2Wyk419UMQTXmfvdE0RsOQ=;
        b=OkRYnv0XgroSiJrcKcH/TKTbKSZkhVQ3zelZ4qUz9jjUnlxmqkP1Tlki2XLrDBsP9p
         4Tlj2ZFQmIMZMigvPakoSHQOEVDNLRA7C3wD9XnU655iF707TE0Mq5ZnfV1VZ18hMbyK
         cgQlRJ2ySgsWvIaviJ1NonoNG7Ppjs542UZN5jp4BirhWL8oPRCzgg80dpDiE6X1pSFt
         LILGS+KCsFR/DnNJqMw7r4wvHcrlhPqYmworhmetP4/BVot9NRPMFQJG2dk8wVn0fIDh
         w7yAm+xVLCjv+CANe5EwUPHIEF+3C922n8Y5x10ePBXKd1FT0JomXD1IbuFX2RwsAx5o
         OW5w==
X-Gm-Message-State: AOAM5304AJ3u/Q17/lqljNlp3IvNW8KAJX3xpWrBThA+MozUD3jHlKHF
        ZjTZx8CQu9YOWcwUbhUCvawDwA==
X-Google-Smtp-Source: ABdhPJzahuGJdrOSXA7Lj+cIOjFBi47JyErPCy1s00lkp9aeesk6G6Zl2f5mMu0lBiYdIyjEhT+SNA==
X-Received: by 2002:a63:f91b:: with SMTP id h27mr14038067pgi.133.1614604343528;
        Mon, 01 Mar 2021 05:12:23 -0800 (PST)
Received: from localhost.localdomain ([110.226.35.200])
        by smtp.gmail.com with ESMTPSA id b3sm13964523pjg.41.2021.03.01.05.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:12:22 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        erpalmer@us.ibm.com, a.fatoum@pengutronix.de,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v9 3/4] doc: trusted-encrypted: updates with TEE as a new trust source
Date:   Mon,  1 Mar 2021 18:41:26 +0530
Message-Id: <20210301131127.793707-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301131127.793707-1-sumit.garg@linaro.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update documentation for Trusted and Encrypted Keys with TEE as a new
trust source. Following is brief description of updates:

- Add a section to demonstrate a list of supported devices along with
  their security properties/guarantees.
- Add a key generation section.
- Updates for usage section including differences specific to a trust
  source.

Co-developed-by: Elaine Palmer <erpalmer@us.ibm.com>
Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .../security/keys/trusted-encrypted.rst       | 171 ++++++++++++++----
 1 file changed, 138 insertions(+), 33 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 1da879a68640..5369403837ae 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -6,30 +6,127 @@ Trusted and Encrypted Keys are two new key types added to the existing kernel
 key ring service.  Both of these new types are variable length symmetric keys,
 and in both cases all keys are created in the kernel, and user space sees,
 stores, and loads only encrypted blobs.  Trusted Keys require the availability
-of a Trusted Platform Module (TPM) chip for greater security, while Encrypted
-Keys can be used on any system.  All user level blobs, are displayed and loaded
-in hex ascii for convenience, and are integrity verified.
+of a Trust Source for greater security, while Encrypted Keys can be used on any
+system. All user level blobs, are displayed and loaded in hex ASCII for
+convenience, and are integrity verified.
 
-Trusted Keys use a TPM both to generate and to seal the keys.  Keys are sealed
-under a 2048 bit RSA key in the TPM, and optionally sealed to specified PCR
-(integrity measurement) values, and only unsealed by the TPM, if PCRs and blob
-integrity verifications match.  A loaded Trusted Key can be updated with new
-(future) PCR values, so keys are easily migrated to new pcr values, such as
-when the kernel and initramfs are updated.  The same key can have many saved
-blobs under different PCR values, so multiple boots are easily supported.
 
-TPM 1.2
--------
+Trust Source
+============
 
-By default, trusted keys are sealed under the SRK, which has the default
-authorization value (20 zeros).  This can be set at takeownership time with the
-trouser's utility: "tpm_takeownership -u -z".
+A trust source provides the source of security for Trusted Keys.  This
+section lists currently supported trust sources, along with their security
+considerations.  Whether or not a trust source is sufficiently safe depends
+on the strength and correctness of its implementation, as well as the threat
+environment for a specific use case.  Since the kernel doesn't know what the
+environment is, and there is no metric of trust, it is dependent on the
+consumer of the Trusted Keys to determine if the trust source is sufficiently
+safe.
 
-TPM 2.0
--------
+  *  Root of trust for storage
 
-The user must first create a storage key and make it persistent, so the key is
-available after reboot. This can be done using the following commands.
+     (1) TPM (Trusted Platform Module: hardware device)
+
+         Rooted to Storage Root Key (SRK) which never leaves the TPM that
+         provides crypto operation to establish root of trust for storage.
+
+     (2) TEE (Trusted Execution Environment: OP-TEE based on Arm TrustZone)
+
+         Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
+         fuses and is accessible to TEE only.
+
+  *  Execution isolation
+
+     (1) TPM
+
+         Fixed set of operations running in isolated execution environment.
+
+     (2) TEE
+
+         Customizable set of operations running in isolated execution
+         environment verified via Secure/Trusted boot process.
+
+  * Optional binding to platform integrity state
+
+     (1) TPM
+
+         Keys can be optionally sealed to specified PCR (integrity measurement)
+         values, and only unsealed by the TPM, if PCRs and blob integrity
+         verifications match. A loaded Trusted Key can be updated with new
+         (future) PCR values, so keys are easily migrated to new PCR values,
+         such as when the kernel and initramfs are updated. The same key can
+         have many saved blobs under different PCR values, so multiple boots are
+         easily supported.
+
+     (2) TEE
+
+         Relies on Secure/Trusted boot process for platform integrity. It can
+         be extended with TEE based measured boot process.
+
+  *  Interfaces and APIs
+
+     (1) TPM
+
+         TPMs have well-documented, standardized interfaces and APIs.
+
+     (2) TEE
+
+         TEEs have well-documented, standardized client interface and APIs. For
+         more details refer to ``Documentation/staging/tee.rst``.
+
+
+  *  Threat model
+
+     The strength and appropriateness of a particular TPM or TEE for a given
+     purpose must be assessed when using them to protect security-relevant data.
+
+
+Key Generation
+==============
+
+Trusted Keys
+------------
+
+New keys are created from random numbers generated in the trust source. They
+are encrypted/decrypted using a child key in the storage key hierarchy.
+Encryption and decryption of the child key must be protected by a strong
+access control policy within the trust source.
+
+  *  TPM (hardware device) based RNG
+
+     Strength of random numbers may vary from one device manufacturer to
+     another.
+
+  *  TEE (OP-TEE based on Arm TrustZone) based RNG
+
+     RNG is customizable as per platform needs. It can either be direct output
+     from platform specific hardware RNG or a software based Fortuna CSPRNG
+     which can be seeded via multiple entropy sources.
+
+Encrypted Keys
+--------------
+
+Encrypted keys do not depend on a trust source, and are faster, as they use AES
+for encryption/decryption. New keys are created from kernel-generated random
+numbers, and are encrypted/decrypted using a specified ‘master’ key. The
+‘master’ key can either be a trusted-key or user-key type. The main disadvantage
+of encrypted keys is that if they are not rooted in a trusted key, they are only
+as secure as the user key encrypting them. The master user key should therefore
+be loaded in as secure a way as possible, preferably early in boot.
+
+
+Usage
+=====
+
+Trusted Keys usage: TPM
+-----------------------
+
+TPM 1.2: By default, trusted keys are sealed under the SRK, which has the
+default authorization value (20 bytes of 0s).  This can be set at takeownership
+time with the TrouSerS utility: "tpm_takeownership -u -z".
+
+TPM 2.0: The user must first create a storage key and make it persistent, so the
+key is available after reboot. This can be done using the following commands.
 
 With the IBM TSS 2 stack::
 
@@ -78,14 +175,21 @@ TPM_STORED_DATA format.  The key length for new keys are always in bytes.
 Trusted Keys can be 32 - 128 bytes (256 - 1024 bits), the upper limit is to fit
 within the 2048 bit SRK (RSA) keylength, with all necessary structure/padding.
 
-Encrypted keys do not depend on a TPM, and are faster, as they use AES for
-encryption/decryption.  New keys are created from kernel generated random
-numbers, and are encrypted/decrypted using a specified 'master' key.  The
-'master' key can either be a trusted-key or user-key type.  The main
-disadvantage of encrypted keys is that if they are not rooted in a trusted key,
-they are only as secure as the user key encrypting them.  The master user key
-should therefore be loaded in as secure a way as possible, preferably early in
-boot.
+Trusted Keys usage: TEE
+-----------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
+specific to TEE device implementation.  The key length for new keys is always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
+Encrypted Keys usage
+--------------------
 
 The decrypted portion of encrypted keys can contain either a simple symmetric
 key or a more complex structure. The format of the more complex structure is
@@ -103,8 +207,8 @@ Where::
 	format:= 'default | ecryptfs | enc32'
 	key-type:= 'trusted' | 'user'
 
-
-Examples of trusted and encrypted key usage:
+Examples of trusted and encrypted key usage
+-------------------------------------------
 
 Create and save a trusted key named "kmk" of length 32 bytes.
 
@@ -150,7 +254,7 @@ Load a trusted key from the saved blob::
     f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
     e4a8aea2b607ec96931e6f4d4fe563ba
 
-Reseal a trusted key under new pcr values::
+Reseal (TPM specific) a trusted key under new PCR values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
     $ keyctl print 268728824
@@ -164,11 +268,12 @@ Reseal a trusted key under new pcr values::
     7ef6a24defe4846104209bf0c3eced7fa1a672ed5b125fc9d8cd88b476a658a4434644ef
     df8ae9a178e9f83ba9f08d10fa47e4226b98b0702f06b3b8
 
+
 The initial consumer of trusted keys is EVM, which at boot time needs a high
-quality symmetric key for HMAC protection of file metadata.  The use of a
+quality symmetric key for HMAC protection of file metadata. The use of a
 trusted key provides strong guarantees that the EVM key has not been
-compromised by a user level problem, and when sealed to specific boot PCR
-values, protects against boot and offline attacks.  Create and save an
+compromised by a user level problem, and when sealed to a platform integrity
+state, protects against boot and offline attacks. Create and save an
 encrypted key "evm" using the above trusted key "kmk":
 
 option 1: omitting 'format'::
-- 
2.25.1

