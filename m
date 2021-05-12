Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65137EE4C
	for <lists+linux-integrity@lfdr.de>; Thu, 13 May 2021 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbhELV1j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 17:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345903AbhELUhH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 16:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C37761408;
        Wed, 12 May 2021 20:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620851753;
        bh=xkbaEdp7qDTC/HRqIHJPDHWmiOnj/gy1VL5Y0uTIbeE=;
        h=Date:From:To:Cc:Subject:From;
        b=cjH4oVLc8ikCYiu2Uk8t7qccgCMNnxO6Nljj/82NA2HuoP5AcqPCL167e5JmhY0kX
         K1nc4gykLLVws+qxtlvwZ3Lw9O4qc0LnQztH3rwcuRbEqhMhQN69Y5s02uOOampzpy
         X3IUnWVidi3cCzQkPWB9mVHBtI3l+6yxhZIeysw+vjuapkXXLpXTdedy4hfw+1vPbV
         C0cix/8e4MmJ2ec7F6RXFnIHHjjpgbwJQYDZ3FD7fmC8j8jP9Ue27SpA+oA34rVeft
         RDyactIJz9yDYlpxa8J7VAIoBefqQQyqw+o3k3Du8GeBxj/yRGlX0l5YZI0UdZWaTE
         TWuNdTeFfi5yQ==
Date:   Wed, 12 May 2021 23:35:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de,
        zohar@linux.ibm.com, jejb@linux.ibm.com
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.13-rc2
Message-ID: <YJw8J1icU49X/Wo9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

These are bug fixes, which have came up after the first pull request.

/Jarkko

The following changes since commit dbb5afad100a828c97e012c6106566d99f041db6:

  ptrace: make ptrace() fail if the tracee changed its pid unexpectedly (2021-05-12 10:45:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.13-rc2

for you to fetch changes up to 1df83992d977355177810c2b711afc30546c81ce:

  tpm: fix error return code in tpm2_get_cc_attrs_tbl() (2021-05-12 22:36:50 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.13-rc2

----------------------------------------------------------------
Ben Boeckel (1):
      trusted-keys: match tpm_get_ops on all return paths

Colin Ian King (1):
      KEYS: trusted: Fix memory leak on object td

Jarkko Sakkinen (2):
      tpm, tpm_tis: Extend locality handling to TPM2 in tpm_tis_gen_interrupt()
      tpm, tpm_tis: Reserve locality in tpm_tis_resume()

Zhen Lei (1):
      tpm: fix error return code in tpm2_get_cc_attrs_tbl()

 drivers/char/tpm/tpm2-cmd.c               |  1 +
 drivers/char/tpm/tpm_tis_core.c           | 22 ++++++++++++++--------
 security/keys/trusted-keys/trusted_tpm1.c |  8 +++++---
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 4 files changed, 23 insertions(+), 14 deletions(-)
