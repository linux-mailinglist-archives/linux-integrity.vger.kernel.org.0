Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E466280642
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgJASJb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:09:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50746 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbgJASJb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:09:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 861898EE26A;
        Thu,  1 Oct 2020 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601575770;
        bh=Cxo8pDrBuT1BXqbgmfxMxDNZi2s5aRLXk2mZPvplgCs=;
        h=From:To:Cc:Subject:Date:From;
        b=bajjumyI5/F7X24CDO+YFcLwULEzJUQQbn4T9BLqt/F5Sc3BK6xFNunWGT0CW1ipZ
         kAUNb4KzJhzvozaP+rBkylSZ84bvWo9VkJxp7ONodpT9WvjFH9zdchLFacIAKTXlop
         /I0BvSLtz2Np2TRuGBePIYkGNftNgCVZEfYN+CJk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0bKe7-e5eFFf; Thu,  1 Oct 2020 11:09:30 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB8F68EE17F;
        Thu,  1 Oct 2020 11:09:29 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Date:   Thu,  1 Oct 2020 11:09:20 -0700
Message-Id: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current state of the TIS TPM is that interrupts have been globally
disabled by various changes.  The problems we got reported the last
time they were enabled was interrupt storms.  With my own TIS TPM,
I've found that this is caused because my TPM doesn't do legacy
cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
requires any TIS TPM without legacy cycles not to act on any write to
an interrupt register unless the locality is enabled.  This means if
an interrupt fires after we relinquish the locality, the TPM_EOI in
the interrupt routine is ineffective meaning the same interrupt
triggers over and over again.  This problem also means we can have
trouble setting up interrupts on TIS TPMs because the current init
code does the setup before the locality is claimed for the first time.

James

---

James Bottomley (5):
  tpm_tis: Fix check_locality for correct locality acquisition
  tpm_tis: Clean up locality release
  tpm_tis: Fix interrupts for TIS TPMs without legacy cycles
  tpm_tis: fix IRQ probing
  Revert "tpm: Revert "tpm_tis_core: Turn on the TPM before probing
    IRQ's""

 drivers/char/tpm/tpm_tis_core.c | 185 ++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 68 deletions(-)

-- 
2.28.0

