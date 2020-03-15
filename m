Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BB186051
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Mar 2020 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgCOWyt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Mar 2020 18:54:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:17724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgCOWyt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Mar 2020 18:54:49 -0400
IronPort-SDR: msDA0z2FmERdC0az68Nz6WpGd5J0xNiNXwB7WtiKtl6K/h8fxIG3ZyyDVxwfJWleoOxS7Nh7Mh
 FCCkIrWzOtUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 15:54:48 -0700
IronPort-SDR: q2EG/JiCttc6d/8TXdcFTU0FuxuXu0mvEotBumngkuu10QZUpzjeF5b/bxQVvPy1kw8vM3hHHZ
 gC/MxoxvsYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,558,1574150400"; 
   d="scan'208";a="278840400"
Received: from babayass-mobl.ger.corp.intel.com (HELO localhost) ([10.249.90.210])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2020 15:54:44 -0700
Date:   Mon, 16 Mar 2020 00:54:43 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.7
Message-ID: <20200315225443.GA1413900@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Just a bunch of local fixes here and there.

/Jarkko

The following changes since commit 0d81a3f29c0afb18ba2b1275dcccf21e0dd4da38:

  Merge tag 'drm-fixes-2020-03-13' of git://anongit.freedesktop.org/drm/drm (2020-03-12 18:05:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200316

for you to fetch changes up to 2e356101e72ab1361821b3af024d64877d9a798d:

  KEYS: reaching the keys quotas correctly (2020-03-15 20:59:50 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.7

----------------------------------------------------------------
Alexandru Ardelean (1):
      tpm_tis_spi: use new 'delay' structure for SPI transfer delays

Lukas Bulwahn (1):
      MAINTAINERS: adjust to trusted keys subsystem creation

Matthew Garrett (1):
      tpm: Don't make log failures fatal

Sergiu Cuciurean (1):
      tpm: tpm_tis_spi_cr50: use new structure for SPI transfer delays

Stefan Berger (3):
      tpm: of: Handle IBM,vtpm20 case when getting log parameters
      tpm: ibmvtpm: Wait for buffer to be set before proceeding
      tpm: ibmvtpm: Add support for TPM2

Vasily Averin (2):
      tpm: tpm1_bios_measurements_next should increase position index
      tpm: tpm2_bios_measurements_next should increase position index

Yang Xu (1):
      KEYS: reaching the keys quotas correctly

 MAINTAINERS                         |  4 ++--
 drivers/char/tpm/eventlog/common.c  | 12 ++++--------
 drivers/char/tpm/eventlog/of.c      |  3 ++-
 drivers/char/tpm/eventlog/tpm1.c    |  2 +-
 drivers/char/tpm/eventlog/tpm2.c    |  2 +-
 drivers/char/tpm/tpm-chip.c         |  4 +---
 drivers/char/tpm/tpm.h              |  3 ++-
 drivers/char/tpm/tpm2-cmd.c         |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c      | 17 +++++++++++++++++
 drivers/char/tpm/tpm_ibmvtpm.h      |  1 +
 drivers/char/tpm/tpm_tis_spi_cr50.c |  7 ++++++-
 drivers/char/tpm/tpm_tis_spi_main.c |  3 ++-
 security/keys/key.c                 |  2 +-
 security/keys/keyctl.c              |  4 ++--
 14 files changed, 43 insertions(+), 23 deletions(-)
