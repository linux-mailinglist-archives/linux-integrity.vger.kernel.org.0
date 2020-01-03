Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7612FF1B
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Jan 2020 00:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgACX3q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 18:29:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:50748 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgACX3q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 18:29:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 15:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="216899753"
Received: from hkarray-mobl.ger.corp.intel.com (HELO localhost) ([10.252.22.101])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2020 15:29:43 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list),
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH for-linus-v5.5-rc6 0/3] TPM changes for v5.5-rc6
Date:   Sat,  4 Jan 2020 01:29:31 +0200
Message-Id: <20200103232935.11314-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There has been a bunch of reports (one from kernel bugzilla linked)
reporting that when this commit is applied it causes on some machines
boot freezes.

Unfortunately hardware where this commit causes a failure is not widely
available (only one I'm aware is Lenovo T490), which means we cannot
predict yet how long it will take to properly fix tpm_tis interrupt
probing.

Thus, the least worst short term action is to revert the code to the
state before this commit. In long term we need fix the tpm_tis probing
code to work on machines that Stefan's code was supposed to fix.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205935
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>

Jarkko Sakkinen (1):
  tpm: Revert "tpm_tis: reserve chip for duration of tpm_tis_core_init"

Stefan Berger (2):
  tpm: Revert "tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for
    interrupts"
  tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"

 drivers/char/tpm/tpm_tis_core.c | 34 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

-- 
2.20.1

