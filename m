Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3C0282DA7
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Oct 2020 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgJDVBg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Oct 2020 17:01:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:40469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgJDVBg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Oct 2020 17:01:36 -0400
IronPort-SDR: O4NvoD9Mhb5Zj5ujvAomVtehLvjc/MEGiEFKOtGCP0wzPzDhjb7MP+250zM6a9T9/uNuLej2UA
 y7vY4wVAEmIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="142697805"
X-IronPort-AV: E=Sophos;i="5.77,336,1596524400"; 
   d="scan'208";a="142697805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 14:01:35 -0700
IronPort-SDR: CFvEEeeGtnZ6oRKkCtqhjYQ+35Vsup4GS4VdOb4h3AG2hB0PlL+LyCF4euB/VV+lR5N3qLbSEI
 7ooqFK5si84Q==
X-IronPort-AV: E=Sophos;i="5.77,336,1596524400"; 
   d="scan'208";a="516502933"
Received: from dletiche-desk.ccr.corp.intel.com (HELO localhost) ([10.252.48.19])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 14:01:33 -0700
Date:   Mon, 5 Oct 2020 00:01:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] tpmdd updates for v5.10
Message-ID: <20201004210121.GA41675@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

Here's updates for v5.10 containing support for a new TPM device and
fixes and Git URL change (infraded -> korg). Some bug fixes for tpm_tis
and trusted keys might be coming up in subsequent PR's for rc's.

/Jarkko

The following changes since commit fcadab740480e0e0e9fa9bd272acd409884d431a:

  Merge tag 'drm-fixes-2020-10-01-1' of git://anongit.freedesktop.org/drm/drm (2020-10-01 09:45:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.10

for you to fetch changes up to 7b9be800756f60bf5bb7baf39c7d221ecb877863:

  MAINTAINERS: TPM DEVICE DRIVER: Update GIT (2020-10-04 23:16:48 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.10

----------------------------------------------------------------
Andy Shevchenko (1):
      tpm: use %*ph to print small buffer

James Bottomley (1):
      tpm_tis: Add a check for invalid status

Jarkko Sakkinen (1):
      MAINTAINERS: TPM DEVICE DRIVER: Update GIT

Masahisa Kojima (2):
      tpm: tis: add support for MMIO TPM on SynQuacer
      dt-bindings: Add SynQucer TPM MMIO as a trivial device

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |   2 +-
 drivers/char/tpm/Kconfig                           |  12 ++
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm-sysfs.c                       |  31 +--
 drivers/char/tpm/tpm_tis_core.c                    |  11 ++
 drivers/char/tpm/tpm_tis_core.h                    |   1 +
 drivers/char/tpm/tpm_tis_synquacer.c               | 208 +++++++++++++++++++++
 8 files changed, 246 insertions(+), 22 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
