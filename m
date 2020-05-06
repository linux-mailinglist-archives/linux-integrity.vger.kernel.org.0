Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF21C6D48
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEFJlX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729183AbgEFJlX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 05:41:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F048C0610D6
        for <linux-integrity@vger.kernel.org>; Wed,  6 May 2020 02:41:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so268734plt.2
        for <linux-integrity@vger.kernel.org>; Wed, 06 May 2020 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SlXuatNEebWvbmP7CKvAyoHRGK5SXnJzIr6kq4voDlQ=;
        b=Tqs/yGb/eL0VSifFGk/ngdQDPkJpIA8MkpRoLRtgxuAIFNN87JAiEBFhk033MO0ieu
         fN2HkGG/rwSqeF7HAFkuyhb5LxrsSaOsQ7PPqN+ZmJlqvf9PxPozaob3NZ8RmFdgDFbP
         NGfAZqcSVeXz+MCGw/AJdzl0/9pW6olPEh1zQoeDwu8/tG51an0qOQTkBPGrQ0cwOihW
         a0ZxZj1WVqKramj1XaTmwNbgR3WPEPK4SqFt/PUrh6HLpkEDva+MRkzNGUi1i/u2135J
         SVqSoVMHRqmEb/xmJ3rSDNY9aFM2/tp9P3if50Au3hH0t0MmHMUsaPX3ALmOupHVd7/a
         r2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlXuatNEebWvbmP7CKvAyoHRGK5SXnJzIr6kq4voDlQ=;
        b=VDgsMCHCsICgdUqE195Nsra2MekBedugT39jik6YUkh5eESbbNkozsGEkGRPiEs/Do
         BxmdxfpDVRFwpyTk385EWvUYAemSpAjgsfK5NND1lJ4eMDOZCSQwCj0I7Geg7z0gH2AW
         l/Y8cX0KrzEGdi3WisPZYfZqwAGxpCr/xbq7YTq34I6zGuzH+U/mLNtJNCU63rMOlYxT
         ruuibSW0+DYG0Ocj/QM3UzuKOMSjH7PCcWtvxmtnj7bKBCHpzDLYqf4ydnjGbRmReEzf
         VX7Yr7SptJLo06Yhjc0hVPlzCIu8V3345iEMn/iJqxZRn4Ik7CX1UhaKFNjG56m3JwHn
         zqRg==
X-Gm-Message-State: AGi0PuYnL/Hn6HuMU94R05/UTy53b61f3MOcW9lX5Z/Z1gftuT+IoLuD
        /nZi61tD/Iawz+pNDlkSBNpPEQ==
X-Google-Smtp-Source: APiQypIGUY9ehi5r6OOjFpQ4c6AIKsFBEyc2pS42FuTYpDDF0UGGkcxjiiaUJtAiAjyMKrUGRuQXBQ==
X-Received: by 2002:a17:902:56c:: with SMTP id 99mr7095466plf.124.1588758082507;
        Wed, 06 May 2020 02:41:22 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.141])
        by smtp.gmail.com with ESMTPSA id a2sm1337360pfg.106.2020.05.06.02.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 02:41:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 3/4] doc: trusted-encrypted: updates with TEE as a new trust source
Date:   Wed,  6 May 2020 15:10:16 +0530
Message-Id: <1588758017-30426-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update documentation for Trusted and Encrypted Keys with TEE as a new
trust source. Following is brief description of updates:

- Add a section to demostrate a list of supported devices along with
  their security properties/guarantees.
- Add a key generation section.
- Updates for usage section including differences specific to a trust
  source.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++++++++++----
 1 file changed, 171 insertions(+), 32 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 50ac8bc..4764a6d 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types added to the existing kernel
 key ring service.  Both of these new types are variable length symmetric keys,
 and in both cases all keys are created in the kernel, and user space sees,
 stores, and loads only encrypted blobs.  Trusted Keys require the availability
-of a Trusted Platform Module (TPM) chip for greater security, while Encrypted
-Keys can be used on any system.  All user level blobs, are displayed and loaded
-in hex ascii for convenience, and are integrity verified.
+of a Trust Source for greater security, while Encrypted Keys can be used on any
+system. All user level blobs, are displayed and loaded in hex ascii for
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
+Trust Source provides the source of security for the Trusted Keys, on which
+basis Trusted Keys establishes a Trust model with its user. A Trust Source could
+differ from one system to another depending on its security requirements. It
+could be either an off-chip device or an on-chip device. Following section
+demostrates a list of supported devices along with their security properties/
+guarantees:
 
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
+  *  On-chip versus off-chip
+
+     (1) TPM
+
+         Off-chip device connected via serial bus (like I2C, SPI etc.) exposing
+         physical access which represents an attack surface that can be
+         mitigated via tamper detection.
+
+     (2) TEE
+
+         On-chip functionality, immune to this attack surface.
+
+  *  Memory attacks (DRAM based like attaching a bus monitor etc.)
+
+     (1) TPM
+
+         Immune to these attacks as it doesn’t make use of system DRAM.
+
+     (2) TEE
+
+         An implementation based on TrustZone protected DRAM is susceptible to
+         such attacks. In order to mitigate these attacks one needs to rely on
+         on-chip secure RAM to store secrets or have the entire TEE
+         implementation based on on-chip secure RAM. An alternative mitigation
+         would be to use encrypted DRAM.
+
+  *  Side-channel attacks (cache, memory, CPU or time based)
+
+     (1) TPM
+
+         Immune to side-channel attacks as its resources are isolated from the
+         main OS.
+
+     (2) TEE
+
+         A careful implementation is required to mitigate against these attacks
+         for resources which are shared (eg. shared memory) with the main OS.
+         Cache and CPU based side-channel attacks can be mitigated via
+         invalidating caches and CPU registers during context switch to and from
+         the secure world.
+         To mitigate against time based attacks, one needs to have time
+         invariant implementations (like crypto algorithms etc.).
+
+  *  Resistance to physical attacks (power analysis, electromagnetic emanation,
+     probes etc.)
+
+     (1) TPM
+
+         Provides limited protection utilizing tamper resistance.
+
+     (2) TEE
+
+         Provides no protection by itself, relies on the underlying platform for
+         features such as tamper resistance.
+
+
+Key Generation
+==============
+
+Trusted Keys
+------------
+
+New keys are created from trust source generated random numbers, and are
+encrypted/decrypted using trust source storage root key.
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
+for encryption/decryption. New keys are created from kernel generated random
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
+default authorization value (20 zeros).  This can be set at takeownership time
+with the TrouSerS utility: "tpm_takeownership -u -z".
+
+TPM 2.0: The user must first create a storage key and make it persistent, so the
+key is available after reboot. This can be done using the following commands.
 
 With the IBM TSS 2 stack::
 
@@ -79,14 +210,21 @@ TPM_STORED_DATA format.  The key length for new keys are always in bytes.
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
+"keyctl print" returns an ascii hex copy of the sealed key, which is in format
+specific to TEE device implementation.  The key length for new keys are always
+in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
+Encrypted Keys usage
+--------------------
 
 The decrypted portion of encrypted keys can contain either a simple symmetric
 key or a more complex structure. The format of the more complex structure is
@@ -104,8 +242,8 @@ Where::
 	format:= 'default | ecryptfs | enc32'
 	key-type:= 'trusted' | 'user'
 
-
 Examples of trusted and encrypted key usage:
+--------------------------------------------
 
 Create and save a trusted key named "kmk" of length 32 bytes.
 
@@ -151,7 +289,7 @@ Load a trusted key from the saved blob::
     f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
     e4a8aea2b607ec96931e6f4d4fe563ba
 
-Reseal a trusted key under new pcr values::
+Reseal (TPM specific) a trusted key under new PCR values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
     $ keyctl print 268728824
@@ -165,11 +303,12 @@ Reseal a trusted key under new pcr values::
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
2.7.4

