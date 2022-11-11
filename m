Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F6626550
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 00:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKXTm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 18:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKKXTk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 18:19:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E982C46
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p12so5382634plq.4
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIpB8rVITnQiLV75Iez0MoucLLsKoDwgwgSNeYFDxFo=;
        b=nzk9QqkNZX6pz5oA5R++fU/7JJn/1lgiJKup4h+DQwJ2d+UJ/iUfN4nEe+UxgtPrh0
         0eLwsuSIesIh7+nq66CIeRuJ/z5EBlEFrcEZ9FA4C7hKF7HJ6iLQL1Y0iCXNA66p+++E
         Nfr0JeWf20MCEDbV1f6F3zZlxQsX/IgQDTWSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIpB8rVITnQiLV75Iez0MoucLLsKoDwgwgSNeYFDxFo=;
        b=WyHDQEOTi+Bt0EPrtgCOZjOlF+crLAXBJzvJowyPv0TWHkQhayMVkBDCLzbQ64wEfN
         QBopfGydsObuhyo1Ky7oJynYzHq9ID86/J/LrY1fFF6ZeDV0K20HQHQR1BqZii6GRUaw
         ixqQjWawijLrIACQaSB0imlmq+7O8JYlZI0+/4Ocz8b9R2XtsnsaJHacQx4FmB+5RH86
         /yCvPBETrYAv4Tx1K/kB6uyKiytbLkrPfYW4o+aCCo55VvMDED0VcBGNXoVlkWlElydl
         JyINt3pYJADwO1sNz4LxDKkAABIdBMUpMFzmbGZGivPx8CsX+tKG170Z9WvCgghMVQfB
         IVmA==
X-Gm-Message-State: ANoB5pn7XBdBf5gCWmCdEgM32gvrmtE1//sEdcaI0eOZbCtvhBuLdH7s
        Dmk+6oU14PWppAmKHI7yFVaqaQ==
X-Google-Smtp-Source: AA0mqf6T1tTau3QB8qtxBh7OFdBlmkbKx4ENAq7cmsEFPewbtal5FGCTC12Ni1swMo1dVhLLLjGy3w==
X-Received: by 2002:a17:902:8f89:b0:187:a98:7ee5 with SMTP id z9-20020a1709028f8900b001870a987ee5mr4588805plo.142.1668208777361;
        Fri, 11 Nov 2022 15:19:37 -0800 (PST)
Received: from evgreen-glaptop.lan ([98.45.28.95])
        by smtp.gmail.com with ESMTPSA id x128-20020a623186000000b0056da2ad6503sm2106900pfx.39.2022.11.11.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:19:37 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 00/11] Encrypted Hibernation
Date:   Fri, 11 Nov 2022 15:16:25 -0800
Message-Id: <20221111231636.3748636-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v5:
 - Change to co-developed by Matthew (Kees)
 - Change tags on RESTRICT_PCR patch (Kees)
 - Rename to TCG_TPM2_RESTRICT_PCR
 - Do nothing on TPM1.2 devices (Jarkko, Doug)
 - Factored some math out to a helper function (Kees)
 - Constified src in tpm2_key_encode().
 - Make Matthew's tag match author
 - Removed default n in Kconfig (Kees)
 - Expanded commit message (Jarkko)
 - Use Suggested-by tag instead of made up Sourced-from (Kees)
 - ENCRYPTED_HIBERNATION should depend on TCG_TPM2_RESTRCT_PCR
 - Remove pad struct member (Kees)
 - Use a struct to access creation data (Kees)
 - Build PCR bitmask programmatically in creation data (Kees)

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

Evan Green (10):
  tpm: Add support for in-kernel resetting of PCRs
  tpm: Export and rename tpm2_find_and_validate_cc()
  tpm: Allow PCR 23 to be restricted to kernel-only use
  security: keys: trusted: Include TPM2 creation data
  security: keys: trusted: Verify creation data
  PM: hibernate: Add kernel-based encryption
  PM: hibernate: Use TPM-backed keys to encrypt image
  PM: hibernate: Mix user key in encrypted hibernate
  PM: hibernate: Verify the digest encryption key
  PM: hibernate: seal the encryption key with a PCR policy

Matthew Garrett (1):
  security: keys: trusted: Allow storage of PCR values in creation data

 Documentation/power/userland-swsusp.rst       |    8 +
 .../security/keys/trusted-encrypted.rst       |    6 +
 drivers/char/tpm/Kconfig                      |   12 +
 drivers/char/tpm/tpm-dev-common.c             |    6 +
 drivers/char/tpm/tpm-interface.c              |   47 +
 drivers/char/tpm/tpm.h                        |   15 +
 drivers/char/tpm/tpm2-cmd.c                   |   29 +-
 drivers/char/tpm/tpm2-space.c                 |    8 +-
 include/keys/trusted-type.h                   |    9 +
 include/linux/tpm.h                           |   19 +
 include/uapi/linux/suspend_ioctls.h           |   28 +-
 kernel/power/Kconfig                          |   15 +
 kernel/power/Makefile                         |    1 +
 kernel/power/power.h                          |    1 +
 kernel/power/snapenc.c                        | 1105 +++++++++++++++++
 kernel/power/snapshot.c                       |    5 +
 kernel/power/user.c                           |   44 +-
 kernel/power/user.h                           |  117 ++
 security/keys/trusted-keys/tpm2key.asn1       |   15 +-
 security/keys/trusted-keys/trusted_tpm1.c     |    9 +
 security/keys/trusted-keys/trusted_tpm2.c     |  355 +++++-
 21 files changed, 1797 insertions(+), 57 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

-- 
2.38.1.431.g37b22c650d-goog

