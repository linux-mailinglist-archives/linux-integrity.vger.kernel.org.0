Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437E480CDF
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHDWPC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Aug 2019 18:15:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:32644 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfHDWPC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Aug 2019 18:15:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 15:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,347,1559545200"; 
   d="scan'208";a="181514616"
Received: from chenghao-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.2])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2019 15:14:56 -0700
Date:   Mon, 5 Aug 2019 01:14:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, gmazyland@gmail.com, nayna@linux.ibm.com
Subject: [GIT PULL] tpmdd fixes for Linux v5.3-rc2
Message-ID: <20190804221450.n62l3fwehjt3nyit@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

Contains two bug fixes that did not make into my first PR for Linux v5.3.

/Jarkko

The following changes since commit 4b6f23161b4e888e72671e377c32eabe9a8e62fc:

  Merge tag 'powerpc-5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2019-08-04 10:30:47 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190805

for you to fetch changes up to fa4f99c05320eb28bf6ba52a9adf64d888da1f9e:

  tpm: tpm_ibm_vtpm: Fix unallocated banks (2019-08-05 00:55:00 +0300)

----------------------------------------------------------------
tpmdd fixes for Linux v5.3-rc2

----------------------------------------------------------------
Milan Broz (1):
      tpm: Fix null pointer dereference on chip register error path

Nayna Jain (1):
      tpm: tpm_ibm_vtpm: Fix unallocated banks

 drivers/char/tpm/tpm-chip.c | 43 ++++++++++++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm1-cmd.c | 36 ++++++++++++++++++++++++------------
 drivers/char/tpm/tpm2-cmd.c |  6 +-----
 4 files changed, 63 insertions(+), 24 deletions(-)
