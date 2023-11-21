Return-Path: <linux-integrity+bounces-165-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02277F392E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08271C20ED0
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BE355787;
	Tue, 21 Nov 2023 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2d4gmlD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E647799
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6246C433C8;
	Tue, 21 Nov 2023 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605897;
	bh=FoihPeiHwIoTNNUSVeXjOwQRGmpg7gdsuVMG2luO7/4=;
	h=From:To:Cc:Subject:Date:From;
	b=a2d4gmlDNfzRw4QFwZ9E2OKRmnM8oeBvBzuGhHz5e20UbjH/0euqz2w4MZQ7W7qc5
	 r0q+yMuwnxERKV1TwB1kxCSWK4UBwXKwkhUB/rqxq3udpW7Far7gXrMtzS6ZxTZDwN
	 Gd9LOtJeTrvpVIIwRmdlfuF16leRTrCjd5nlZwVgUeDbaXpG81ZfWc4YGMofazKP92
	 4Pde8j5hqu7S96omj2JI4sCdcfTCtzU0EBiVC8O/LtMGcWxoh3AIZbSkWQuIYcqLyp
	 9QV5+fjENw24OAbxTbu7ZseFGyfbeai4IhhZV2eSOP2CxUdQ6TLErdS4HAFeiEp9dq
	 Wfiwp01sjwpjg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v5 0/8] Extend struct tpm_buf to support sized buffers (TPM2B)
Date: Wed, 22 Nov 2023 00:31:12 +0200
Message-ID: <20231121223130.30824-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set extends struct tpm_buf to support TPM2 sized buffers, and
adds reader functions for parsing more complex response data.  It is
implemented to support smooth landing of [2]. Sealing of the TPM2 trusted
keys is updated to utilize the new functionality, and thus provides a
legit test case for it.

TPM2 sized buffer, i.e. the buffers in TPM2 format, are defined in the
section 10.4 of the TPM2 Structures [1] specification.

Here's the smoke test that I've run for TPM2:

/usr/lib/kselftests/run_kselftest.sh
tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
tpm2_evictcontrol -c key.ctxt 0x81000001
keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk 64" @u

[1] https://trustedcomputinggroup.org/resource/tpm-library-specification/
[2] https://lore.kernel.org/linux-integrity/20230403214003.32093-1-James.Bottomley@HansenPartnership.com/

v5:
- Fixed glitch in tpm_buf_read() reported by James Bottomley to the v4.
  Was forgotten from v4.
- Remove a spurious memset() call introduced in v4.
- Allow command buffer tag to be initially set to zero (caused spurious
  warnings).
v4:
- Cleaned up the bit too spread code changes based on the v3 review.
- For testing instructions see the previous cover letter, and use
  linux-v6.6.y branch:
  https://lore.kernel.org/linux-integrity/20231024011531.442587-1-jarkko@kernel.org/
v3:
- Resend with rebase to the latest upstream.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: William Roberts <bill.c.roberts@gmail.com> 
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>

James Bottomley (1):
  tpm: Move buffer handling from static inlines to real functions

Jarkko Sakkinen (7):
  tpm: Remove unused tpm_buf_tag()
  tpm: Remove tpm_send()
  tpm: Update &tpm_buf documentation
  tpm: Store the length of the tpm_buf data separately.
  tpm: TPM2B formatted buffers
  tpm: Add tpm_buf_read_{u8,u16,u32}
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 drivers/char/tpm/Makefile                 |   1 +
 drivers/char/tpm/tpm-buf.c                | 222 ++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c          |  26 +--
 include/keys/trusted_tpm.h                |   2 -
 include/linux/tpm.h                       | 112 +++--------
 security/keys/trusted-keys/trusted_tpm1.c |  23 ++-
 security/keys/trusted-keys/trusted_tpm2.c |  54 +++---
 7 files changed, 295 insertions(+), 145 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

-- 
2.42.1


