Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511F8F9A0E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLTzr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 14:55:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:21354 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLTzr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 14:55:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 11:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="194434538"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2019 11:55:44 -0800
Date:   Tue, 12 Nov 2019 21:55:42 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org
Subject: [GIT PULL] tpmdd updates for Linux v5.5
Message-ID: <20191112195542.GA10619@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

1. Support for Cr50 fTPM.
2. Support for fTPM on AMD Zen+ CPUs.
3. TPM 2.0 trusted keys code relocated from drivers/char/tpm to
   security/keys.

/Jarkko

The following changes since commit eb094f06963bb0fd8134c6a9b805d4ad0002a7d4:

  Merge branch 'x86-pti-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-11-12 10:53:24 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20191112

for you to fetch changes up to 0b40dbcbba923b5379bd1d601edd6d51e23fe72c:

  KEYS: trusted: Remove set but not used variable 'keyhndl' (2019-11-12 21:45:37 +0200)

----------------------------------------------------------------
tpmdd update for Linux v5.5

----------------------------------------------------------------
Andrey Pronin (2):
      dt-bindings: tpm: document properties for cr50
      tpm: tpm_tis_spi: Support cr50 devices

Hans de Goede (1):
      tpm: Switch to platform_get_irq_optional()

Ivan Lazeev (1):
      tpm_crb: fix fTPM on AMD Zen+ CPUs

James Bottomley (1):
      tpm: use GFP_KERNEL instead of GFP_HIGHMEM for tpm_buf

Jarkko Sakkinen (1):
      tpm: Remove duplicate code from caps_show() in tpm-sysfs.c

Jerry Snitselaar (2):
      tpm: provide a way to override the chip returned durations
      tpm_tis: override durations for STM tpm with firmware 1.2.8.28

Stephen Boyd (4):
      tpm: Add a flag to indicate TPM power is managed by firmware
      tpm: tpm_tis_spi: Introduce a flow control callback
      tpm: tpm_tis_spi: Cleanup includes
      tpm: tpm_tis_spi: Drop THIS_MODULE usage from driver struct

Sumit Garg (4):
      tpm: Move tpm_buf code to include/linux/
      KEYS: Use common tpm_buf for trusted and asymmetric keys
      KEYS: trusted: Create trusted keys subsystem
      KEYS: trusted: Move TPM2 trusted keys code

Tadeusz Struk (1):
      tpm: add check after commands attribs tab allocation

zhengbin (1):
      KEYS: trusted: Remove set but not used variable 'keyhndl'

 .../bindings/security/tpm/google,cr50.txt          |  19 ++
 crypto/asymmetric_keys/asym_tpm.c                  | 101 +++----
 drivers/char/tpm/Kconfig                           |   7 +
 drivers/char/tpm/Makefile                          |   4 +-
 drivers/char/tpm/tpm-interface.c                   |  64 +---
 drivers/char/tpm/tpm-sysfs.c                       |  45 +--
 drivers/char/tpm/tpm.h                             | 248 +---------------
 drivers/char/tpm/tpm1-cmd.c                        |  15 +
 drivers/char/tpm/tpm2-cmd.c                        | 311 +-------------------
 drivers/char/tpm/tpm_crb.c                         | 123 +++++---
 drivers/char/tpm/tpm_tis.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |  79 +++++
 drivers/char/tpm/tpm_tis_spi.c                     | 143 +++++----
 drivers/char/tpm/tpm_tis_spi.h                     |  53 ++++
 drivers/char/tpm/tpm_tis_spi_cr50.c                | 322 +++++++++++++++++++++
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +---
 include/linux/tpm.h                                | 250 ++++++++++++++--
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  98 +++----
 security/keys/trusted-keys/trusted_tpm2.c          | 314 ++++++++++++++++++++
 22 files changed, 1371 insertions(+), 887 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h
 create mode 100644 drivers/char/tpm/tpm_tis_spi_cr50.c
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c
