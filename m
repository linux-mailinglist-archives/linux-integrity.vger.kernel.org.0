Return-Path: <linux-integrity+bounces-2358-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7CF8C1739
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 22:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A01C20AF4
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894E14C58A;
	Thu,  9 May 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZGSXJzU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01463129A68;
	Thu,  9 May 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285048; cv=none; b=uSGKwvn6S9imxKizH773tmgI7wspkriEzWTdJM8zG8ZLIKTjgT+GY0zCJrshOyMe+8wj2jUkVFkAn6+YU8bTYK45Ap/eO8v1dvslJs/1hSLqlpTRuQPf4FZ6WpP3EGl2h4wxORzuAggNrxrm6t2I1PQGnJb0FSOddJNMXUfWDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285048; c=relaxed/simple;
	bh=LTGAalsVHpHpS5kUBwPeinahoR1Fg29UOnSYLyQsWm8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=SOULK/eL/ey/A0KnWeYanYLp78y7mSQnpUhWbEwNFoPdiY+LrbWXhOcbw0cmlSicCtblYB+I1U/3bK0Tt3tswFfosMXtAa2UbUgaclEJTy1FQxR1eV7ELD1AShrZmyOFXXqxjoguHQDPpfMPIlEOc0V4AD/iEAemcN5RiTH1tRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZGSXJzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D2C3277B;
	Thu,  9 May 2024 20:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715285047;
	bh=LTGAalsVHpHpS5kUBwPeinahoR1Fg29UOnSYLyQsWm8=;
	h=Date:Cc:Subject:From:To:From;
	b=DZGSXJzUlXWtqZ08KEc16seehl3da9D7WSUTOFxgddVb2emt334emFMc546tW77KV
	 oF8RBgTkJ4wDQHiLvoIYMUBFuhnew1BjTqNRWDNlzBj18vT5uQxAi+WQfEavMz1DBz
	 jXO68LqxOx5IsKZ8qlru4xzcpEt4hsquDZtutRm3gXJaO+RocvzARPyAchuzqR/4FB
	 eWfGYdwMeW3v99Fs5JAoIGUsbZlg3eaG8UJX8c6+mpT1jtrdHhfAr9zml4QM6UJyoo
	 oAo2VfHOqATgmLRn2xL76lSK1GP5ELBmx/NefeWWeWzenXaOnTAXYXDMUaU2ZU7BHf
	 6WBc1vNaVjkuw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 23:04:04 +0300
Message-Id: <D15DSV117DQZ.3GJOTXCTGZHE9@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 45db3ab70092637967967bfd8e6144017638563c=
:

  Merge tag '6.9-rc7-ksmbd-fixes' of git://git.samba.org/ksmbd (2024-05-08 =
10:39:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.10-rc1

for you to fetch changes up to 1d479e3cd6520085832a6b432d521eeead2691ba:

  Documentation: tpm: Add TPM security docs toctree entry (2024-05-09 22:30=
:52 +0300)

----------------------------------------------------------------
Hi,

These are the changes for the TPM driver with a single major new
feature: TPM bus encryption and integrity protection. The key pair
on TPM side is generated from so called null random seed per power
on of the machine [1]. This supports the TPM encryption of the hard
drive by adding layer of protection against bus interposer attacks.

Other than the pull request a few minor fixes and documentation for
tpm_tis to clarify basics of TPM localities for future patch review
discussions (will be extended and refined over times, just a seed).

[1] https://lore.kernel.org/linux-integrity/20240429202811.13643-1-James.Bo=
ttomley@HansenPartnership.com/

BR, Jarkko

----------------------------------------------------------------
Ard Biesheuvel (1):
      crypto: lib - implement library version of AES in CFB mode

Bagas Sanjaya (1):
      Documentation: tpm: Add TPM security docs toctree entry

Colin Ian King (1):
      tpm/eventlog: remove redundant assignment to variabel ret

James Bottomley (14):
      tpm: Move buffer handling from static inlines to real functions
      tpm: add buffer function to point to returned parameters
      tpm: export the context save and load commands
      tpm: Add NULL primary creation
      tpm: Add TCG mandated Key Derivation Functions (KDFs)
      tpm: Add HMAC session start and end functions
      tpm: Add HMAC session name/handle append
      tpm: Add the rest of the session HMAC API
      tpm: add hmac checks to tpm2_pcr_extend()
      tpm: add session encryption protection to tpm2_get_random()
      KEYS: trusted: Add session encryption protection to the seal/unseal p=
ath
      tpm: add the null key name as a sysfs export
      Documentation: add tpm-security.rst
      tpm: disable the TPM if NULL name changes

Jarkko Sakkinen (8):
      Documentation: tpm_tis
      tpm: Remove unused tpm_buf_tag()
      tpm: Remove tpm_send()
      tpm: Update struct tpm_buf documentation comments
      tpm: Store the length of the tpm_buf data separately.
      tpm: TPM2B formatted buffers
      tpm: Add tpm_buf_read_{u8,u16,u32}
      KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

Michael Haener (1):
      dt-bindings: tpm: Add st,st33ktpm2xi2c

Niklas Schnelle (2):
      char: tpm: handle HAS_IOPORT dependencies
      char: tpm: Keep TPM_INF_IO_PORT define for HAS_IOPORT=3Dn

 .../devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml   |    1 +
 Documentation/security/tpm/index.rst               |    2 +
 Documentation/security/tpm/tpm-security.rst        |  216 ++++
 Documentation/security/tpm/tpm_tis.rst             |   46 +
 drivers/char/tpm/Kconfig                           |   17 +-
 drivers/char/tpm/Makefile                          |    2 +
 drivers/char/tpm/eventlog/acpi.c                   |    1 -
 drivers/char/tpm/tpm-buf.c                         |  252 ++++
 drivers/char/tpm/tpm-chip.c                        |    6 +
 drivers/char/tpm/tpm-interface.c                   |   26 +-
 drivers/char/tpm/tpm-sysfs.c                       |   18 +
 drivers/char/tpm/tpm.h                             |   14 +
 drivers/char/tpm/tpm2-cmd.c                        |   53 +-
 drivers/char/tpm/tpm2-sessions.c                   | 1286 ++++++++++++++++=
++++
 drivers/char/tpm/tpm2-space.c                      |   11 +-
 drivers/char/tpm/tpm_infineon.c                    |   14 +-
 drivers/char/tpm/tpm_tis_core.c                    |   19 +-
 include/crypto/aes.h                               |    5 +
 include/keys/trusted_tpm.h                         |    2 -
 include/linux/tpm.h                                |  316 +++--
 lib/crypto/Kconfig                                 |    5 +
 lib/crypto/Makefile                                |    3 +
 lib/crypto/aescfb.c                                |  257 ++++
 security/keys/trusted-keys/trusted_tpm1.c          |   23 +-
 security/keys/trusted-keys/trusted_tpm2.c          |  136 ++-
 25 files changed, 2519 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm-security.rst
 create mode 100644 Documentation/security/tpm/tpm_tis.rst
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 lib/crypto/aescfb.c

