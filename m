Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1039B161B07
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2020 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgBQSur (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Feb 2020 13:50:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:64776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgBQSur (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Feb 2020 13:50:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 10:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,453,1574150400"; 
   d="scan'208";a="258347540"
Received: from aottaski-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.113])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2020 10:50:44 -0800
Date:   Mon, 17 Feb 2020 20:50:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org
Subject: [GIT PULL] tpmdd updates for Linux v5.6-rc3
Message-ID: <20200217185044.GA7180@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Two bug fixes.

/Jarkko

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200217

for you to fetch changes up to dc10e4181c05a2315ddc375e963b7c763b5ee0df:

  tpm: Initialize crypto_id of allocated_banks to HASH_ALGO__LAST (2020-02-17 20:47:06 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.6-rc3

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Revert tpm_tis_spi_mod.ko to tpm_tis_spi.ko.

Roberto Sassu (1):
      tpm: Initialize crypto_id of allocated_banks to HASH_ALGO__LAST

 drivers/char/tpm/Makefile                              | 8 +++++---
 drivers/char/tpm/tpm2-cmd.c                            | 2 ++
 drivers/char/tpm/{tpm_tis_spi.c => tpm_tis_spi_main.c} | 0
 3 files changed, 7 insertions(+), 3 deletions(-)
 rename drivers/char/tpm/{tpm_tis_spi.c => tpm_tis_spi_main.c} (100%)
