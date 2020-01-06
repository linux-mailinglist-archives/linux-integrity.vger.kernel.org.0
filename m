Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81EE1316F7
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFRne (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 12:43:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:7315 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRnd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 12:43:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 09:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="253427274"
Received: from emilywhi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.21.216])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2020 09:43:29 -0800
Date:   Mon, 6 Jan 2020 19:43:28 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [GIT PULL] tpmdd fixes for Linux v5.5-rc6
Message-ID: <20200106174328.GA16364@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There has been a bunch of reports (e.g. [*]) reporting that when this
commit is applied it causes on some machines boot freezes.

Unfortunately hardware where this commit causes a failure is not widely
available (only one I'm aware is Lenovo T490), which means we cannot
predict yet how long it will take to properly fix tpm_tis interrupt
probing.

Thus, the least worst short term action is to revert the code to the
state before this commit. In long term we need fix the tpm_tis probing
code to work on machines that Stefan's patches were supposed to fix.

With these patches reverted nothing fatal happens, TPM is fallbacked
to be used in polling mode (which is not in the end too bad because
there are no high throughput workloads for TPM).

[*] https://bugzilla.kernel.org/show_bug.cgi?id=205935

/Jarkko

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200106

for you to fetch changes up to aa4a63dd981682b1742baa01237036e48bc11923:

  tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's" (2020-01-06 19:36:09 +0200)

----------------------------------------------------------------
tpmdd fixes for Linux v5.5-rc6

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"

Stefan Berger (2):
      tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts"
      tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"

 drivers/char/tpm/tpm_tis_core.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)
