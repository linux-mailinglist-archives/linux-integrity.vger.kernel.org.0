Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0F32C3BC
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 01:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhCCX7j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Mar 2021 18:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhCCPxm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Mar 2021 10:53:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D605064EDB;
        Wed,  3 Mar 2021 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786780;
        bh=Qir6h85tLUNfIn6uJz8Y84MHbyM/X4B4pLrnZucP8gU=;
        h=Date:From:To:Cc:Subject:From;
        b=khjcIyCotfWfzxI9bMEDhiLsdxUCLpaTUGCExZSZA2JgUxc4RyOoBGpV9jZ63TxgF
         GuTHbad7alv97mC7ZEOrSX10ZVWRDE+GiXjAFcfq9+j9bvQi9aRR/lURr1dUNUoNoh
         Sbpqr+P3fIEtUX5tkK5zyuupToCZZ59IfBxWJTkPxnxmqDuCMLZJJo1WBrXX+7phG2
         lMnLMT0slzrjl9Ahd/m/m0IIxAMydpCXcw9lXKb632IDj47QDzH0Iy7E2llRrZAINa
         mU3d1LxPEgIhNbdgHoFC2mJmQptcj641i0jQA+o56Nq6KN64RlYj4GmMwA8om28kqw
         ahb0AZVCOgKLA==
Date:   Wed, 3 Mar 2021 17:52:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.12-rc2
Message-ID: <YD+wyJzpguBWP33i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Three urgent fixes for rc2.

/Jarkko

The following changes since commit c03c21ba6f4e95e406a1a7b4c34ef334b977c194:

  Merge tag 'keys-misc-20210126' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2021-02-23 16:09:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc2

for you to fetch changes up to 232a37ea3aee9cb37bbc154fb1440a66ae4743f4:

  tpm: Remove unintentional dump_stack() call (2021-03-03 17:43:52 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.12-rc2

----------------------------------------------------------------
Jarkko Sakkinen (2):
      tpm, tpm_tis: Decorate tpm_get_timeouts() with request_locality()
      tpm: Remove unintentional dump_stack() call

Lukasz Majczak (1):
      tpm, tpm_tis: Decorate tpm_tis_gen_interrupt() with request_locality()

 drivers/char/tpm/tpm-chip.c     |  2 --
 drivers/char/tpm/tpm_tis_core.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)
