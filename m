Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419235EC9F2
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiI0Qtv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiI0Qtk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:49:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4454DE90
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:49:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so10659063pjl.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CshlNIOejbfiYc9tiWv058BC6HJpHyki8VAbybm61uA=;
        b=MucmUzS2nCcF+AhT93QZQrmD3Psbz+Enr8Z1TI7Cl88vuGDyx6aGFblYhF7ZvzNJ9P
         oHqeDAjNu2VqHESkGQZT9EmNsJXCAY9WpWP5mBw31Vo3QbUQMzyXGuWxp9cHqOk5VguX
         gOhSrowuXG+DHdSY0V2Tnnmr+AGJ8P6bdZRLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CshlNIOejbfiYc9tiWv058BC6HJpHyki8VAbybm61uA=;
        b=SIN8MZY9GyYxsklyaQzrHAdpuyWUtJVvFpPkZxizA14P97FQbZbsMmhozgIZtgPkTb
         Ny6ZzrINRNxgKlSKhBpctYfWWoN+D2sCjvVP0CC5oPqEpONeELX/bhVzBFnAgCBPdGeM
         bejp4QFCeGv8tI2DZOBTRDppTieEKoP89IjOtBBtAyegkTw4feAH9SRm1yp1GXU21a6L
         xu2oZn5UZKL/tlhonaZdzkain28Gw2pzlhG6CRI91AFxX5GwOToegNSz+ZMkP7DMYyRn
         mEU7XMaT/rpvuVrNftA1io7E+2XZi1weAPA4L+4OODG87IYgC0G0v/rnJcoAKvJ6Y33y
         vZ4Q==
X-Gm-Message-State: ACrzQf1ef7h/AAcj7NkoVYA2BP3059AQJqfXlsIITHxVtnr7WllN2oqY
        P7VL7m4l/s+ga685ECZYvJM8Ng==
X-Google-Smtp-Source: AMsMyM5nHrnaxrzhddnmL2v6Bi3s6QZogqG6G/cZkv7Zy3cQbem1uUeyfaGRak4dMeabdo6+o2ZdLQ==
X-Received: by 2002:a17:90b:3ec1:b0:203:5eef:fe1e with SMTP id rm1-20020a17090b3ec100b002035eeffe1emr5441458pjb.143.1664297373237;
        Tue, 27 Sep 2022 09:49:33 -0700 (PDT)
Received: from evgreen-glaptop.lan ([73.231.74.141])
        by smtp.gmail.com with ESMTPSA id p13-20020a63950d000000b00434272fe870sm1753509pgd.88.2022.09.27.09.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:49:32 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dlunev@google.com, jarkko@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Ben Boeckel <me@benboeckel.net>, rjw@rjwysocki.net,
        corbet@lwn.net, linux-pm@vger.kernel.org, zohar@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 00/11] Encrypted Hibernation
Date:   Tue, 27 Sep 2022 09:49:11 -0700
Message-Id: <20220927164922.3383711-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We are exploring enabling hibernation in some new scenarios. However,
our security team has a few requirements, listed below:
1. The hibernate image must be encrypted with protection derived from
   both the platform (eg TPM) and user authentication data (eg
   password).
2. Hibernation must not be a vector by which a malicious userspace can
   escalate to the kernel.

Requirement #1 can be achieved solely with uswsusp, however requirement
2 necessitates mechanisms in the kernel to guarantee integrity of the
hibernate image. The kernel needs a way to authenticate that it generated
the hibernate image being loaded, and that the image has not been tampered
with. Adding support for in-kernel AEAD encryption with a TPM-sealed key
allows us to achieve both requirements with a single computation pass.

Matthew Garrett published a series [1] that aligns closely with this
goal. His series utilized the fact that PCR23 is a resettable PCR that
can be blocked from access by usermode. The TPM can create a sealed key
tied to PCR23 in two ways. First, the TPM can attest to the value of
PCR23 when the key was created, which the kernel can use on resume to
verify that the kernel must have created the key (since it is the only
one capable of modifying PCR23). It can also create a policy that enforces
PCR23 be set to a specific value as a condition of unsealing the key,
preventing usermode from unsealing the key by talking directly to the
TPM.

This series adopts that primitive as a foundation, tweaking and building
on it a bit. Where Matthew's series used the TPM-backed key to encrypt a
hash of the image, this series uses the key directly as a gcm(aes)
encryption key, which the kernel uses to encrypt and decrypt the
hibernate image in chunks of 16 pages. This provides both encryption and
integrity, which turns out to be a noticeable performance improvement over
separate passes for encryption and hashing.

The series also introduces the concept of mixing user key material into
the encryption key. This allows usermode to introduce key material
based on unspecified external authentication data (in our case derived
from something like the user password or PIN), without requiring
usermode to do a separate encryption pass.

Matthew also documented issues his series had [2] related to generating
fake images by booting alternate kernels without the PCR23 limiting.
With access to PCR23 on the same machine, usermode can create fake
hibernate images that are indistinguishable to the new kernel from
genuine ones. His post outlines a solution that involves adding more
PCRs into the creation data and policy, with some gyrations to make this
work well on a standard PC.

Our approach would be similar: on our machines PCR 0 indicates whether
the system is booted in secure/verified mode or developer mode. By
adding PCR0 to the policy, we can reject hibernate images made in
developer mode while in verified mode (or vice versa).

Additionally, mixing in the user authentication data limits both
data exfiltration attacks (eg a stolen laptop) and forged hibernation
image attacks to attackers that already know the authentication data (eg
user's password). This, combined with our relatively sealed userspace
(dm-verity on the rootfs), and some judicious clearing of the hibernate
image (such as across an OS update) further reduce the risk of an online
attack. The remaining attack space of a forgery from someone with
physical access to the device and knowledge of the authentication data
is out of scope for us, given that flipping to developer mode or
reflashing RO firmware trivially achieves the same thing.

A couple of patches still need to be written on top of this series. The
generalized functionality to OR in additional PCRs via Kconfig (like PCR
0 or 5) still needs to be added. We'll also need a patch that disallows
unencrypted forms of resume from hibernation, to fully close the door
to malicious userspace. However, I wanted to get this series out first
and get reactions from upstream before continuing to add to it.

[1] https://patchwork.kernel.org/project/linux-pm/cover/20210220013255.1083202-1-matthewgarrett@google.com/
[2] https://mjg59.dreamwidth.org/58077.html

Changes in v3:
 - Unify tpm1/2_pcr_reset prototypes (Jarkko)
 - Wait no, remove the TPM1 stuff altogether (Jarkko)
 - Remove extra From tag and blank in commit msg (Jarkko).
 - Split find_and_validate_cc() export to its own patch (Jarkko)
 - Rename tpm_find_and_validate_cc() to tpm2_find_and_validate_cc().
 - Fix up commit message (Jarkko)
 - tpm2_find_and_validate_cc() was split (Jarkko)
 - Simply fully restrict TPM1 since v2 failed to account for tunnelled
   transport sessions (Stefan and Jarkko).
 - Fix SoB and -- note ordering (Kees)
 - Add comments describing the TPM2 spec type names for the new fields
   in tpm2key.asn1 (Kees)
 - Add len buffer checks in tpm2_key_encode() (Kees)
 - Clarified creationpcrs documentation (Ben)
 - Changed funky tag to suggested-by (Kees). Matthew, holler if you want
   something different.
 - ENCRYPTED_HIBERNATION needs TRUSTED_KEYS builtin for
   key_type_trusted.
 - Remove KEYS dependency since it's covered by TRUSTED_KEYS (Kees)
 - Changed funky tag to Co-developed-by (Kees). Matthew, holler if you
   want something different.
 - Changed funky tag to Co-developed-by (Kees)

Changes in v2:
 - Fixed sparse warnings
 - Adjust hash len by 2 due to new ASN.1 storage, and add underflow
   check.
 - Rework load/create_kernel_key() to eliminate a label (Andrey)
 - Call put_device() needed from calling tpm_default_chip().
 - Add missing static on snapshot_encrypted_byte_count()
 - Fold in only the used kernel key bytes to the user key.
 - Make the user key length 32 (Eric)
 - Use CRYPTO_LIB_SHA256 for less boilerplate (Eric)
 - Fixed some sparse warnings
 - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
 - Adjusted offsets due to new ASN.1 format, and added a creation data
   length check.
 - Fix sparse warnings
 - Fix session type comment (Andrey)
 - Eliminate extra label in get/create_kernel_key() (Andrey)
 - Call tpm_try_get_ops() before calling tpm2_flush_context().

Evan Green (8):
  tpm: Export and rename tpm2_find_and_validate_cc()
  security: keys: trusted: Include TPM2 creation data
  security: keys: trusted: Verify creation data
  PM: hibernate: Add kernel-based encryption
  PM: hibernate: Use TPM-backed keys to encrypt image
  PM: hibernate: Mix user key in encrypted hibernate
  PM: hibernate: Verify the digest encryption key
  PM: hibernate: seal the encryption key with a PCR policy

Matthew Garrett (3):
  tpm: Add support for in-kernel resetting of PCRs
  tpm: Allow PCR 23 to be restricted to kernel-only use
  security: keys: trusted: Allow storage of PCR values in creation data

 Documentation/power/userland-swsusp.rst       |    8 +
 .../security/keys/trusted-encrypted.rst       |    6 +
 drivers/char/tpm/Kconfig                      |   12 +
 drivers/char/tpm/tpm-dev-common.c             |    8 +
 drivers/char/tpm/tpm-interface.c              |   25 +
 drivers/char/tpm/tpm.h                        |   23 +
 drivers/char/tpm/tpm1-cmd.c                   |   13 +
 drivers/char/tpm/tpm2-cmd.c                   |   58 +
 drivers/char/tpm/tpm2-space.c                 |    8 +-
 include/keys/trusted-type.h                   |    9 +
 include/linux/tpm.h                           |   12 +
 include/uapi/linux/suspend_ioctls.h           |   28 +-
 kernel/power/Kconfig                          |   15 +
 kernel/power/Makefile                         |    1 +
 kernel/power/power.h                          |    1 +
 kernel/power/snapenc.c                        | 1037 +++++++++++++++++
 kernel/power/snapshot.c                       |    5 +
 kernel/power/user.c                           |   44 +-
 kernel/power/user.h                           |  114 ++
 security/keys/trusted-keys/tpm2key.asn1       |   15 +-
 security/keys/trusted-keys/trusted_tpm1.c     |    9 +
 security/keys/trusted-keys/trusted_tpm2.c     |  318 ++++-
 22 files changed, 1724 insertions(+), 45 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

-- 
2.31.0

