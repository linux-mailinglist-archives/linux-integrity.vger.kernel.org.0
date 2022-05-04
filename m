Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152C51B411
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359032AbiEEABg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382440AbiEDXYy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:24:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047434DF4A
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so6486373pju.2
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0BxOsiS7N+HTfWR68wbuI5GyHjxWUqAQAvHwIwW+yE=;
        b=R5D0DOFVkQco+OK496uEyWM8qRT/qEDa61ADRf8s0rAJeF034c8CBOcJkI9DhSK99P
         T9KGcuzycnvXcJPNISrJKPRM0NBDojZJdo/30qDInqLY8l2tGI62dZHO/kSe2d29NFi9
         K7Vu8cNCpHGLqj5AbbquXriJVZ5gqG2e3HHcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0BxOsiS7N+HTfWR68wbuI5GyHjxWUqAQAvHwIwW+yE=;
        b=TIvUgWGUZr7QqY26VpaGYoBxEVZMvDM/MTUXQDZLCyreK9XOE/cH2LsE+1XFz/U+oV
         20bNm4il6oKwfDhwCw7bhXDhalmYDgJl1drOTIDyNvHMGWuomJ0pS3DOgxKnW40nrs3I
         Qj4v5ouTgpOwE6XAeyA/tgWTO6dvoxLp760+2r5/Kt91H+yi2f+2GjUIbrEXs12KOpBn
         ZaTttQvKO043OXZ0OUa+E/sfKB2nqz2nCpwtOftJtfMrrp5LmTJeObgeASlhtGhRwmsa
         ZRpxqFx1cVpWtDO5D2J4ooM/auVPhokFkTyvYFlkm/ErOgXIih2ngDrCtWoWL0ZWmsAI
         9p/Q==
X-Gm-Message-State: AOAM530Z/pAdoxoW7iz8ZaNZuyOLp1uTMNGOkqUtMnjgwW7I4jwXX5o4
        3cbfx/Q5T651NPtUkpR8O7Ed8A==
X-Google-Smtp-Source: ABdhPJz4iqQo29US5gcPdIjO5OrbAwRmVDtwaNJJOfTh1rXJxFOpVW3YvogErA3bWiWXuRJJXotSlg==
X-Received: by 2002:a17:90b:4b83:b0:1dc:5073:b704 with SMTP id lr3-20020a17090b4b8300b001dc5073b704mr2397627pjb.94.1651706474455;
        Wed, 04 May 2022 16:21:14 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:14 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Pavel Machek <pavel@ucw.cz>, Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 00/10] Encrypted Hibernation
Date:   Wed,  4 May 2022 16:20:52 -0700
Message-Id: <20220504232102.469959-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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


Evan Green (6):
  security: keys: trusted: Verify creation data
  PM: hibernate: Add kernel-based encryption
  PM: hibernate: Use TPM-backed keys to encrypt image
  PM: hibernate: Mix user key in encrypted hibernate
  PM: hibernate: Verify the digest encryption key
  PM: hibernate: seal the encryption key with a PCR policy

Matthew Garrett (4):
  tpm: Add support for in-kernel resetting of PCRs
  tpm: Allow PCR 23 to be restricted to kernel-only use
  security: keys: trusted: Parse out individual components of the key
    blob
  security: keys: trusted: Allow storage of PCR values in creation data

 Documentation/power/userland-swsusp.rst       |    8 +
 .../security/keys/trusted-encrypted.rst       |    4 +
 drivers/char/tpm/Kconfig                      |   10 +
 drivers/char/tpm/tpm-dev-common.c             |    8 +
 drivers/char/tpm/tpm-interface.c              |   28 +
 drivers/char/tpm/tpm.h                        |   23 +
 drivers/char/tpm/tpm1-cmd.c                   |   69 ++
 drivers/char/tpm/tpm2-cmd.c                   |   58 +
 drivers/char/tpm/tpm2-space.c                 |    2 +-
 include/keys/trusted-type.h                   |    9 +
 include/linux/tpm.h                           |   12 +
 include/uapi/linux/suspend_ioctls.h           |   28 +-
 kernel/power/Kconfig                          |   15 +
 kernel/power/Makefile                         |    1 +
 kernel/power/power.h                          |    1 +
 kernel/power/snapenc.c                        | 1076 +++++++++++++++++
 kernel/power/snapshot.c                       |    5 +
 kernel/power/user.c                           |   44 +-
 kernel/power/user.h                           |  114 ++
 security/keys/trusted-keys/trusted_tpm1.c     |    9 +
 security/keys/trusted-keys/trusted_tpm2.c     |  164 ++-
 21 files changed, 1670 insertions(+), 18 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

-- 
2.31.0

