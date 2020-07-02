Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF7212CAF
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2020 21:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGBS6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 14:58:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:34237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgGBS6i (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 14:58:38 -0400
IronPort-SDR: MuT7qF1Z1+ZAqKitiuNUw39awLRHLTo4ULM2Uo7UsxwKxQphxO8VnROVJLaOIXxOlTXZZfRleN
 ii3+TS6jE+7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212034676"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="212034676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 11:58:38 -0700
IronPort-SDR: lpwT6pJPC5PjRflArA+/3lgxlDyec4K5HEJsvVM/paf0VakxL3G/r98Qo/e1nZ8z7PP+PdJgBq
 HgquvVKCOZOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="314226948"
Received: from mylinen-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.43.38])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2020 11:58:35 -0700
Date:   Thu, 2 Jul 2020 21:58:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Subject: [GIT PULL] tpmdd updates for Linux v5.8-rc4
Message-ID: <20200702185813.GA25571@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

These are just fixes for bugs found lately. All of them are small scale
things here and there, and all of them are for previous kernel releases
(the oldest appeared in v2.6.17).

/Jarkko

The following changes since commit cd77006e01b3198c75fb7819b3d0ff89709539bb:

  Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux (2020-07-01 12:56:05 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.8-rc4

for you to fetch changes up to e918e570415ced9898a51109000a3f39a6e03be5:

  tpm_tis: Remove the HID IFX0102 (2020-07-02 17:49:00 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.8-rc4

----------------------------------------------------------------
Binbin Zhou (1):
      tpm/st33zp24: fix spelling mistake "drescription" -> "description"

David Gibson (1):
      tpm: ibmvtpm: Wait for ready buffer before probing for TPM2 attributes

Douglas Anderson (2):
      tpm_tis_spi: Don't send anything during flow control
      tpm_tis_spi: Prefer async probe

James Bottomley (1):
      tpm: Fix TIS locality timeout problems

Jarkko Sakkinen (1):
      tpm_tis: Remove the HID IFX0102

Vasily Averin (1):
      tpm_tis: extra chip->ops check on error path in tpm_tis_core_init

 drivers/char/tpm/st33zp24/i2c.c      |  2 +-
 drivers/char/tpm/st33zp24/spi.c      |  4 ++--
 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm-dev-common.c    | 19 +++++++++----------
 drivers/char/tpm/tpm_ibmvtpm.c       | 14 +++++++-------
 drivers/char/tpm/tpm_tis.c           |  1 -
 drivers/char/tpm/tpm_tis_core.c      |  2 +-
 drivers/char/tpm/tpm_tis_spi_main.c  | 10 +++++-----
 8 files changed, 26 insertions(+), 28 deletions(-)

