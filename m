Return-Path: <linux-integrity+bounces-6701-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D3B0E786
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jul 2025 02:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DEA17B70C
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jul 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7C111AD;
	Wed, 23 Jul 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK/tmZme"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1FCA6B;
	Wed, 23 Jul 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229923; cv=none; b=j3O1kIgDNQ8n3lmkf9tE9Li8OTrL9b04QuEkrBpI6NiYrZSdlvMKqqynIjMzPjSw6ohuafCWsfpRkEOdN9TJQnKhzW82Imd6cXv2KM0E6O3f/pBVq6o+neWITyD4Y/R++djuTngr38pciY6nG3A3lm0xJP6Qnz5Xy27633cglLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229923; c=relaxed/simple;
	bh=rUIHAK6R3Mb+47KhSDQxNS0rxC1YMuLaNzFUfX0huRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TJFlnX5x7SRv38R6hSEJgDGr9kZQ6+9qxeEZt8X7Rw7AnwZBgq4KgDYHYQP4jcOOmr6HVf66L1OLi2lSX3KYVQCMHrvsWoqMJnURsBQ4Q97HnN2sBvKVkLkneBifbWI3v1cY5q3a1kEtKjGVgeVWuudnSGQ9wYrvyiZVN/pOvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK/tmZme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F7EC4CEEB;
	Wed, 23 Jul 2025 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753229923;
	bh=rUIHAK6R3Mb+47KhSDQxNS0rxC1YMuLaNzFUfX0huRM=;
	h=Date:From:To:Cc:Subject:From;
	b=fK/tmZmehLb2qr4shPhJrxftCEPjokE9IyPz5RcbyGDJMO4exC9/ba504CKGweW3R
	 NMn/Tm1szT6okf4vuT+aEp1TIC/wh8iGoA52R86FPFCjScWTYdzAouEXbClmfN9wGc
	 IXbbkjt7XWM+t+iWkCgjX62d39FBuJZ+dYo8LYCyS/GWFVyaNCVvxWlECWK4yjq9tk
	 +vPgQpsyXvbYWt5vGLc+Y36WA6q/nkGl0zdtQMJhzRqKAwRlkYwytHdsybmcJuqeHN
	 E2275sIkGuqTAY0lGH3ibGzbltjG59KlCcpVLHNZ6WUt6EudmhdbBMKdMbpafIxM+b
	 EaqrGOj4yWNjA==
Date: Wed, 23 Jul 2025 03:18:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.17-rc1
Message-ID: <aIAqX1qFnxUzayTR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-6.17-rc1

for you to fetch changes up to 7f0c6675b3194461ad7bb8db1d822445121fb029:

  tpm_crb_ffa: handle tpm busy return code (2025-07-23 02:32:00 +0300)

----------------------------------------------------------------
Hi,

This PR has quite a few commits but nothing really that would be worth of
spending too much time for, or would want to emphasize in particular.

BR, Jarkko

----------------------------------------------------------------
Chelsy Ratnawat (1):
      tpm: Replace scnprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show functions

Jarkko Sakkinen (2):
      tpm_crb_ffa: Remove unused export
      tpm: Check for completion after timeout

Prachotan Bathi (3):
      tpm_crb_ffa: Fix typos in function name
      tpm_crb_ffa: Remove memset usage
      tpm_crb_ffa: handle tpm busy return code

Rob Herring (1):
      tpm: Use of_reserved_mem_region_to_resource() for "memory-region"

Stefano Garzarella (4):
      tpm: add bufsiz parameter in the .send callback
      tpm: support devices with synchronous send()
      tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
      tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC

Yeoreum Yun (2):
      firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall
      tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in

 Documentation/admin-guide/kernel-parameters.txt |  8 +++
 drivers/char/tpm/eventlog/of.c                  |  8 +--
 drivers/char/tpm/st33zp24/st33zp24.c            |  2 +-
 drivers/char/tpm/tpm-interface.c                | 39 ++++++++--
 drivers/char/tpm/tpm_atmel.c                    |  3 +-
 drivers/char/tpm/tpm_crb.c                      |  2 +-
 drivers/char/tpm/tpm_crb_ffa.c                  | 94 +++++++++++++++++--------
 drivers/char/tpm/tpm_crb_ffa.h                  |  2 -
 drivers/char/tpm/tpm_ftpm_tee.c                 | 66 ++++++-----------
 drivers/char/tpm/tpm_ftpm_tee.h                 |  4 --
 drivers/char/tpm/tpm_i2c_atmel.c                |  3 +-
 drivers/char/tpm/tpm_i2c_infineon.c             |  3 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c              |  3 +-
 drivers/char/tpm/tpm_ibmvtpm.c                  |  6 +-
 drivers/char/tpm/tpm_infineon.c                 |  3 +-
 drivers/char/tpm/tpm_nsc.c                      |  3 +-
 drivers/char/tpm/tpm_ppi.c                      | 52 +++++++-------
 drivers/char/tpm/tpm_svsm.c                     | 28 ++++----
 drivers/char/tpm/tpm_tis_core.c                 |  3 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c             |  6 +-
 drivers/char/tpm/tpm_vtpm_proxy.c               |  4 +-
 drivers/char/tpm/xen-tpmfront.c                 |  3 +-
 drivers/firmware/arm_ffa/driver.c               |  2 +-
 include/linux/tpm.h                             |  4 +-
 24 files changed, 199 insertions(+), 152 deletions(-)

