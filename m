Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4D308221
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 00:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA1X5H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 18:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA1X5G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 18:57:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC6F64DFD;
        Thu, 28 Jan 2021 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611878186;
        bh=EhGuBnDKNaxrHgKNWWQpNT8NTFDnQMtXzm1iAYTmQJs=;
        h=From:To:Cc:Subject:Date:From;
        b=B19c9N+nl1f34HZNJwLBPXwxAD/fmpHIKLEb3Sw+p4zwsVBqi7tKokcI1j+w3+b0v
         62pgdgaR9ASX3bkz4CmgU6PJXQwXSjsa/7YySXtyoWuWPJLggEqpmYS2k82YXRRauo
         g+CivWbFDFl9p0fYP+wObTcw0PsaMA25Vv5ZMRvk0x8Magjh2QhPFLy5yJUOkGFy+L
         kbaMrq4pvi6fMzMG4umo11l4bCJwphWi3r7k8M3n0h2debdTgxIwylHhxq/q1bntPg
         BLFPTTisHmToUiRdRBlUSEilXKzgwbaky2RAWq2UpBvYISDzDsQL3XngI9GNXLezzf
         4qBTLwekEVWFg==
From:   jarkko@kernel.org
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v5 0/3] KEYS, trusted: a bunch of bug fixes
Date:   Fri, 29 Jan 2021 01:56:18 +0200
Message-Id: <20210128235621.127925-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

This patch set contains a bunch of disjoint bug fixes.

v5:
* Call tpm_try_get_ops() and tpm_put_ops() inside tpm2_seal_trusted()
  and tpm2_unseal_trusted().
  https://lore.kernel.org/linux-integrity/CAFA6WYO4HJThYHhBxbx0Tr97sF_JFvTBur9uTGSQTtyQaOKpig@mail.gmail.com/

v4:
* Do not create stubs for tpm_transmit_cmd(), tpm_try_get_ops() and
  tpm_put_ops().
  https://lore.kernel.org/linux-integrity/20201013023927.GA71954@linux.intel.com/

v3:
* Reordered patches a bit, i.e. trivial fixes in the head and the least
  trivial in the tail.
  <no xref>
* Added the missing "return -ENODEV;" to tpm_transmit_cmd(), when the
  kernel is compiled without TPM support.
  https://lore.kernel.org/linux-integrity/202010110927.zsxMpek2-lkp@intel.com/

v2:
* Fix a kernel test bot warning.
  https://lore.kernel.org/linux-integrity/202010051152.9kxy43LO-lkp@intel.com/

Jarkko Sakkinen (3):
  KEYS: trusted: Fix incorrect handling of tpm_get_random()
  KEYS: trusted: Fix migratable=1 failing
  KEYS: trusted: Reserve TPM for seal and unseal operations

 drivers/char/tpm/tpm.h                    |  4 ----
 include/linux/tpm.h                       |  5 ++++-
 security/keys/trusted-keys/trusted_tpm1.c | 22 +++++++++++++++++----
 security/keys/trusted-keys/trusted_tpm2.c | 24 ++++++++++++++++++-----
 4 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.30.0

