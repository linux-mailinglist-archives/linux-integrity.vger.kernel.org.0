Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC96186DF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKCSEK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCSD4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:03:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12FA22BDC
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:01:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gw22so2394692pjb.3
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=we5sGRgeZfmiFwJlXRzMaUU1kYxW1X5nCMITmEl34Rs=;
        b=Kq6Bj/FL8nuh60ks1BQiKahd6V4pWny3fxV6iEgxy2pFv78eAfevsv4OJyz5VsL+ht
         rm3NW/7+kbgnxI4es0cLSJvuSAte0IIlpsjaygXTHiwMOMjBXV3o4DpY7nh/rjv5+9zK
         hLF3Azra8sUrIvaGsQ0ceLKhAQIYeDsvvKFGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=we5sGRgeZfmiFwJlXRzMaUU1kYxW1X5nCMITmEl34Rs=;
        b=hfKzj6LIIPOqFok43A5NsbaMzjb6KyzrGKvnEY+gc3Yh16zCNhax2Kk0aTMLKuzeyR
         5KS2nOVUQaCyhC/cjKmsnF7vMVPNP8MzGyypRpKqxbAUOvQon8ulFo4nIJCsZKP0cwxf
         WIJNfeW7gWb+92+r8sVjQrz5lHwAmJrJzdLkwkaV3wSp0pjS77akmpJvEWDw8vsULuCF
         pNt7jauXuTVKRAHpJn1Fxto/cEjh/gZLFjLUaHmkFJPVCYDbRFygw0a5uKzJRRhiXH6i
         TjNWJwZAkWRYLle/H+6GTFxZNwiqxVPLAmyatP29L/uBbdpGCx/C2X89dvAJp5/Gl/N6
         3rUQ==
X-Gm-Message-State: ACrzQf3ZbRjaXjQ2xjMy/NN71n5lewr6MaPy1629OFrOrdXgyQHEtWJc
        l2tHVl2IXeFurseNgfNltH830w==
X-Google-Smtp-Source: AMsMyM6pJ+WHoxy7JrmybugEwNm3RYa+8+Uvc7wfkCiQEh8cdwxjvdHYYa4Krbf8KHv6hakd6k78Fw==
X-Received: by 2002:a17:90a:4a0f:b0:213:f398:ed20 with SMTP id e15-20020a17090a4a0f00b00213f398ed20mr20866017pjh.110.1667498496170;
        Thu, 03 Nov 2022 11:01:36 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b00177fb862a87sm1000277plb.20.2022.11.03.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:01:35 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        gwendal@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 00/11] Encrypted Hibernation
Date:   Thu,  3 Nov 2022 11:01:08 -0700
Message-Id: <20221103180120.752659-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v4:
 - Open code tpm2_pcr_reset implementation in tpm-interface.c (Jarkko)
 - Rename interface symbol to tpm2_pcr_reset, fix kerneldocs (Jarkko)
 - Augment the commit message (Jarkko)
 - Local ordering and whitespace changes (Jarkko)
 - s/tpm_pcr_reset/tpm2_pcr_reset/ due to change in other patch
 - Variable ordering and whitespace fixes (Jarkko)
 - Add NULL check explanation in teardown (Jarkko)
 - Change strlen+1 to sizeof for static buffer (Jarkko)
 - Fix nr_allocated_banks loop overflow (found via KASAN)
 - Local variable reordering (Jarkko)
 - Local variable ordering (Jarkko)

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
 drivers/char/tpm/tpm-interface.c              |   47 +
 drivers/char/tpm/tpm.h                        |   22 +
 drivers/char/tpm/tpm1-cmd.c                   |   13 +
 drivers/char/tpm/tpm2-cmd.c                   |   29 +-
 drivers/char/tpm/tpm2-space.c                 |    8 +-
 include/keys/trusted-type.h                   |    9 +
 include/linux/tpm.h                           |   19 +
 include/uapi/linux/suspend_ioctls.h           |   28 +-
 kernel/power/Kconfig                          |   15 +
 kernel/power/Makefile                         |    1 +
 kernel/power/power.h                          |    1 +
 kernel/power/snapenc.c                        | 1043 +++++++++++++++++
 kernel/power/snapshot.c                       |    5 +
 kernel/power/user.c                           |   44 +-
 kernel/power/user.h                           |  116 ++
 security/keys/trusted-keys/tpm2key.asn1       |   15 +-
 security/keys/trusted-keys/trusted_tpm1.c     |    9 +
 security/keys/trusted-keys/trusted_tpm2.c     |  318 ++++-
 22 files changed, 1724 insertions(+), 52 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

-- 
2.38.1.431.g37b22c650d-goog

