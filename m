Return-Path: <linux-integrity+bounces-5484-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C4A735C8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FFC3AE5ED
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580018FC67;
	Thu, 27 Mar 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSOBXBZi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675412C7FD;
	Thu, 27 Mar 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089907; cv=none; b=sKAmCUzLbo4+XKDlNyRzkpp3ReXkzZPb9NwNYOyRcx8dc7YUzM1tlWZiNSx+8HD5I4ofjcRU6u8J8TH4AeAQpbaNaYPw5ZaGr3V7Ap/HStSSfiH5yB5112BARG3VFIN4Yctv9HUT0tl56mTtCfn2+1FQfjsVsGBIKT8P4nVHjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089907; c=relaxed/simple;
	bh=2lPC7oxBDrMFBDdkgZJfZHAesgaYsbLAsWow2pzJtmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=YoX3RHyKBtgZXyBOX84Z8ZUoGVC+GWAdTnhktsK6izmzG2OhlB3XMdFOFN3mdJB8A1+VLi3SGMNqWz7OB15iMMhuX36L/Klg7/AOdh872keqW7KarrZK+0VYHumaiCf+nuM+mpXcCqVx+CQl1lsYIifRzg0Via1p1I4TznPZezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSOBXBZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32035C4CEDD;
	Thu, 27 Mar 2025 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743089906;
	bh=2lPC7oxBDrMFBDdkgZJfZHAesgaYsbLAsWow2pzJtmU=;
	h=Date:To:Cc:Subject:From:From;
	b=rSOBXBZiLQW596sT/QjemQ4L4KkSoiiI0y1klLgJCcDmoIRvZhVJc8vkNQPv5ejkI
	 DtR9m/4U+GlkKEXP4ebT65PoIFRAOjYf47hbOmLgZzIxlzjQlfpmhWPhOYPaVNVWF1
	 TDt+A6+4Afwk3pMTPgDNB0mqtRmunmRY2mhAV766Wk5jhIVc9PbMJLK49V4FIn1ww/
	 r/4OTokK38cvgjFm0XJpkvEeF/VFdqKBbWP+myZgk1OagkjmB5Gvq6hwCJYFi8Gmlv
	 Sz7pqdmNLBJsOWwBZtB8DIqI4dH9rOxdxZ7O41sbWjf+coRhDTzp4zoA+9AD3V7V/9
	 z6TGKavoPPNOQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 17:38:22 +0200
Message-Id: <D8R5SUN9YYXG.1RL5OEAJPN0GO@jarkko-kan-01>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.15-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0

The following changes since commit 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95=
:

  Merge tag 'net-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net-next (2025-03-26 21:48:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.15-rc1

for you to fetch changes up to 980a573621ea4b5032123937df0115bdbec6b2de:

  tpm: Make chip->{status,cancel,req_canceled} opt (2025-03-27 17:10:43 +02=
00)

----------------------------------------------------------------
Hi,

This PR contains a new driver: TPM FF-A driver. FF comes from Firmware
Framework, and A comes from Arm's A-profile [1]. FF-A is essentially
a standard mechanism to communicate with TrustZone apps such as TPM.

Other than that, the PR includes a pile of fixes and small improvments.

BR, Jarkko

----------------------------------------------------------------
Arnd Bergmann (1):
      tpm: ftpm_tee: remove incorrect of_match_ptr annotation

Jarkko Sakkinen (1):
      tpm: Make chip->{status,cancel,req_canceled} opt

Jonathan McDowell (5):
      tpm: Lazily flush auth session when getting random data
      tpm: Convert warn to dbg in tpm2_start_auth_session()
      tpm, tpm_tis: Fix timeout handling when waiting for TPM status
      tpm, tpm_tis: Workaround failed command reception on Infineon devices
      tpm: End any active auth session before shutdown

Stefano Garzarella (1):
      tpm/tpm_ftpm_tee: fix struct ftpm_tee_private documentation

Stuart Yoder (5):
      tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A
      tpm_crb: Clean-up and refactor check for idle support
      ACPICA: Add start method for ARM FF-A
      tpm_crb: Add support for the ARM FF-A start method
      Documentation: tpm: Add documentation for the CRB FF-A interface

Thadeu Lima de Souza Cascardo (1):
      tpm: do not start chip while suspended

WangYuli (1):
      MAINTAINERS: TPM DEVICE DRIVER: add missing includes

 Documentation/security/tpm/index.rst       |   1 +
 Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++++
 MAINTAINERS                                |   2 +
 drivers/char/tpm/Kconfig                   |   9 +
 drivers/char/tpm/Makefile                  |   1 +
 drivers/char/tpm/tpm-chip.c                |   6 +
 drivers/char/tpm/tpm-interface.c           |  37 ++-
 drivers/char/tpm/tpm2-cmd.c                |   1 -
 drivers/char/tpm/tpm2-sessions.c           |   2 +-
 drivers/char/tpm/tpm_crb.c                 | 105 +++++++--
 drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++++++=
++++
 drivers/char/tpm/tpm_crb_ffa.h             |  25 +++
 drivers/char/tpm/tpm_ftpm_tee.c            |  22 +-
 drivers/char/tpm/tpm_ftpm_tee.h            |   1 -
 drivers/char/tpm/tpm_tis_core.c            |  20 +-
 drivers/char/tpm/tpm_tis_core.h            |   1 +
 include/acpi/actbl3.h                      |   1 +
 include/linux/tpm.h                        |   1 +
 18 files changed, 590 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.h

