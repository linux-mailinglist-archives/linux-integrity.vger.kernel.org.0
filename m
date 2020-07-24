Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0422BE28
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXGmc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 02:42:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:54704 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXGmc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 02:42:32 -0400
IronPort-SDR: Y04g67wnquGx3UqCxY3paer6Myvfj1MYzGa9cMeC9b2bxlYap7PZse5jNwJRi6W9pQCjatpPEM
 sypLqg8PoM5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="215255351"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="215255351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 23:42:30 -0700
IronPort-SDR: fH0hTdvFCAgznlFS7V7JPiU3m7tVVzApphHtpZ/KEDzUbJQXES6WUdBXPLtnYX0/DzcNRUx9tg
 TTjIp/tPIykQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="393227472"
Received: from cbuerkle-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.184])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2020 23:42:28 -0700
Date:   Fri, 24 Jul 2020 09:42:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] tpmdd update for Linux v5.9
Message-ID: <20200724064212.GA1871046@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

An issue was fixed with the TPM space buffer size. The buffer is used to
store in-TPM objects while swapped out of the TPM for a /dev/tpmrm0
session. The code incorrectly used PAGE_SIZE, which obviously can vary.
With v5.9 changes the buffer has a fixed size of 16 kB.

In addition, the PR contains support for acquiring TPM even log from
TPM2 ACPI table. This method is used by QEMU in particular.

/Jarkko

The following changes since commit f37e99aca03f63aa3f2bd13ceaf769455d12c4b0:

  Merge tag 's390-5.8-6' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux into master (2020-07-23 13:42:46 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-v5.9

for you to fetch changes up to 85467f63a05c43364ba0b90d0c05bb89191543fa:

  tpm: Add support for event log pointer found in TPM2 ACPI table (2020-07-24 09:29:21 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.9

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Unify the mismatching TPM space buffer sizes

Stefan Berger (2):
      acpi: Extend TPM2 ACPI table with missing log fields
      tpm: Add support for event log pointer found in TPM2 ACPI table

Tyler Hicks (1):
      tpm: Require that all digests are present in TCG_PCR_EVENT2 structures

 drivers/char/tpm/eventlog/acpi.c | 63 ++++++++++++++++++++++++++--------------
 drivers/char/tpm/tpm-chip.c      |  9 ++----
 drivers/char/tpm/tpm.h           |  5 +++-
 drivers/char/tpm/tpm2-space.c    | 26 ++++++++++-------
 drivers/char/tpm/tpmrm-dev.c     |  2 +-
 include/acpi/actbl3.h            |  7 +++++
 include/linux/tpm.h              |  1 +
 include/linux/tpm_eventlog.h     | 11 +++++--
 8 files changed, 82 insertions(+), 42 deletions(-)
