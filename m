Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70935F5B3
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhDNN60 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 09:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233761AbhDNN6Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 09:58:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 980EF6113D;
        Wed, 14 Apr 2021 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618408683;
        bh=hIMGIIDnDHf7gAYZ0W2mlUdfjZOZMX6FwWZvfvSiO8U=;
        h=Date:From:To:Cc:Subject:From;
        b=vA4DQdLbkUphCcG9zNnFRtd0s0icWfziVvNBU9VxWrAlz8/a54AKW9Y2Njje9/59q
         8S90+v2LhXhO3h3vktUotPZWUmRTWCdomm1kBVOuo6IX0efGNK/LBnpPlpLz+7R19M
         80Y6ZPlPpORNogO+RVUuLd0O4JZQFbcSu3/uJeTt/aX6yqm73fddYWEPzPFIMxd5yN
         GV9QrYyEW+RMuhBdf25EFjIkwh04Q5t99UcDFK5Bp01tIjTJtsRmqLwA/EA4CYymZg
         GRc/qkaR5QbENsnL+XHu1nQAQ+sZGSRGIzgsrLXD/pz//u4QIc5LBZBrylRody6+1E
         vZ1SollammY0A==
Date:   Wed, 14 Apr 2021 16:58:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.13
Message-ID: <YHb06P4IOGV7eoiJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

New features:

1. ARM TEE backend for kernel trusted keys to complete the existing TPM
   backend.
2. ASN.1 format for TPM2 trusted keys to make them interact with the
   user space stack, such as OpenConnect VPN.

Other than that, contains bunch of bug fixes.

/Jarkko

The following changes since commit 50987beca096a7ed4f453a6da245fd6a2fadedeb:

  Merge tag 'trace-v5.12-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-04-13 18:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13

for you to fetch changes up to aec00aa04b1131e17e6744681b380779f89d77b3:

  KEYS: trusted: Fix missing null return from kzalloc call (2021-04-14 16:30:31 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.13

----------------------------------------------------------------
Colin Ian King (1):
      KEYS: trusted: Fix missing null return from kzalloc call

James Bottomley (5):
      lib: Add ASN.1 encoder
      oid_registry: Add TCG defined OIDS for TPM keys
      security: keys: trusted: fix TPM2 authorizations
      security: keys: trusted: use ASN.1 TPM2 key format for the blobs
      security: keys: trusted: Make sealed key properly interoperable

Stefan Berger (3):
      tpm: efi: Use local variable for calculating final log size
      tpm: acpi: Check eventlog signature before using it
      tpm: vtpm_proxy: Avoid reading host log when using a virtual device

Sumit Garg (4):
      KEYS: trusted: Add generic trusted keys framework
      KEYS: trusted: Introduce TEE based Trusted Keys
      doc: trusted-encrypted: updates with TEE as a new trust source
      MAINTAINERS: Add entry for TEE based Trusted Keys

Zhihao Cheng (1):
      char: tpm: fix error return code in tpm_cr50_i2c_tis_recv()

 Documentation/admin-guide/kernel-parameters.txt   |  12 +
 Documentation/security/keys/trusted-encrypted.rst | 229 +++++++++--
 MAINTAINERS                                       |   8 +
 drivers/char/tpm/eventlog/acpi.c                  |  33 +-
 drivers/char/tpm/eventlog/common.c                |   3 +
 drivers/char/tpm/eventlog/efi.c                   |  29 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c               |   1 +
 include/keys/trusted-type.h                       |  55 +++
 include/keys/trusted_tee.h                        |  16 +
 include/keys/trusted_tpm.h                        |  29 +-
 include/linux/asn1_encoder.h                      |  32 ++
 include/linux/oid_registry.h                      |   5 +
 include/linux/tpm.h                               |   2 +
 lib/Kconfig                                       |   3 +
 lib/Makefile                                      |   1 +
 lib/asn1_encoder.c                                | 454 ++++++++++++++++++++++
 security/keys/Kconfig                             |   3 +
 security/keys/trusted-keys/Makefile               |   6 +
 security/keys/trusted-keys/tpm2key.asn1           |  11 +
 security/keys/trusted-keys/trusted_core.c         | 360 +++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 318 +++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 398 +++++--------------
 security/keys/trusted-keys/trusted_tpm2.c         | 269 +++++++++++--
 23 files changed, 1887 insertions(+), 390 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c
