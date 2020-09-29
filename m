Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0ED27DC1B
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgI2Wc0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 18:32:26 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51196 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbgI2Wc0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 18:32:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 16B178EE17F;
        Tue, 29 Sep 2020 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601418745;
        bh=f9n6Dt908fRVcDdVjl+kxvulCiYlZIX7B8Q2h5IbmGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MbVYlzD9NvHi0buynpmmUYsG3Ja1RU5MAD3hBiccnZjoVA9eY3kUsL44UVPFRLw8A
         5qWrypJPEzmcJQUz+hcRSBpAjvCRBgFoZ6ApuNHNRJvrVjCtz3oahQrKAwFtyTOAGq
         ifbxjt8vU3PXln869a9piQm2JUYgrLqvpSnAWPLI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0O3nEYX4xgJZ; Tue, 29 Sep 2020 15:32:24 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 711998EE119;
        Tue, 29 Sep 2020 15:32:24 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 0/4] tpm_tis: fix interrupts (again)
Date:   Tue, 29 Sep 2020 15:32:12 -0700
Message-Id: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
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

James Bottomley (4):
  tpm_tis: Clean up locality release
  tpm_tis: Fix interrupts for TIS TPMs without legacy cycles
  tpm_tis: fix IRQ probing
  Revert "tpm: Revert "tpm_tis_core: Turn on the TPM before probing
    IRQ's""

 drivers/char/tpm/tpm_tis_core.c | 182 ++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 67 deletions(-)

-- 
2.28.0

