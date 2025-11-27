Return-Path: <linux-integrity+bounces-7721-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0FC904AD
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 23:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED17934DE59
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9231D38C;
	Thu, 27 Nov 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3wZPyNj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256D31B800;
	Thu, 27 Nov 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282370; cv=none; b=iRf3DlX56ZXYP2uUaxm11jHEeyWiSN+f30fFt/berImPhbGHbl+V6RQ5VTDMEZhzKYBZltv6KLva3b+0NK7LllKzDnFUci0665bZn64/flrjUSppnpKMo0tOb/IbYPx4QaVZ1LUWQitim2F/ZywkaiUY5KRrqg23jJoDxLKzHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282370; c=relaxed/simple;
	bh=kFt5kKJGpgV98RokJrNZPd0zbBQKnUSlPuE7gJ4/bBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pff8ESslhxYMEecLtKimdtCdxt1lJswUBN6AYFewZpqKrZovRDX62m/rjY2z4Bf+DB8i3yQYFMTwuYGzwjuX7+R1Qq1A5fmxzODWeC51zjfQeqUj5qNGHT4UhMLIZdrUV8rCxcdkPuPxddgE30TXbK2GXLB/oRpUoKA6/vHhycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3wZPyNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B54C4CEF8;
	Thu, 27 Nov 2025 22:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764282369;
	bh=kFt5kKJGpgV98RokJrNZPd0zbBQKnUSlPuE7gJ4/bBY=;
	h=Date:From:To:Cc:Subject:From;
	b=r3wZPyNjjwXev2PpBxO/G5rhfphCfcbHY943Vpzi3k5nE4oLeLic04k6eu8N7XDiO
	 QiQNJT29Rc6eOqaUszgEEcQcR0yaoHrP8OWuCYE3g89TBB0pdxvUJHP/pZrBgUcAIs
	 iPUPeoiuMZcGNaxTQim1+OECjf/F9BdJnaqKGveBGD818dzDok1eRaNLP+I4QC62gn
	 Y80qemZn1NCo5lSfEnpJ5Uv7WPUZaqlQ418vYdvdFZiTiZoRV0rCuus/81wH8EzsoL
	 +rHeaxNENnmY/R7sdico0kxLAJ6p4JF5Lci8SCmLBne6KnS/G0g/hBpY60BBln96V5
	 n6QOvUwriNjcQ==
Date: Fri, 28 Nov 2025 00:26:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.19-rc1
Message-ID: <aSjP_BsakvhxSDYR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e1afacb68573c3cd0a3785c6b0508876cd3423bc:

  Merge tag 'ceph-for-6.18-rc8' of https://github.com/ceph/ceph-client (2025-11-27 11:11:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.19-rc1

for you to fetch changes up to 35ef1e24392ff0f3b28654b452f9720f07e9533f:

  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2 (2025-11-28 00:17:26 +0200)

----------------------------------------------------------------
Hi

The first pull request for TPM driver contains changes to unify TPM return
code translation between trusted_tpm2 and TPM driver itself. Other than
that the changes are either bug fixes or small adjustments.

BR, Jarkko

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: tpm-security.rst: change title to section heading

Chu Guangqing (1):
      tpm_crb: Fix a spelling mistake

David Laight (1):
      drivers/char/tpm: use min() instead of min_t()

Jarkko Sakkinen (3):
      tpm: Cap the number of PCR banks
      tpm: Use -EPERM as fallback error code in tpm_ret_to_err
      KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2

Jonathan McDowell (1):
      tpm: Remove tpm_find_get_ops

Marco Crivellari (1):
      tpm: add WQ_PERCPU to alloc_workqueue users

Maurice Hieronymus (1):
      selftests: tpm2: Fix ill defined assertions

Stuart Yoder (1):
      tpm_crb: add missing loc parameter to kerneldoc

 Documentation/security/tpm/tpm-security.rst |  2 +-
 drivers/char/tpm/tpm-chip.c                 | 36 -----------------------------
 drivers/char/tpm/tpm-dev-common.c           |  3 ++-
 drivers/char/tpm/tpm-interface.c            | 20 ++++++++++++----
 drivers/char/tpm/tpm.h                      |  1 -
 drivers/char/tpm/tpm1-cmd.c                 |  7 +-----
 drivers/char/tpm/tpm2-cmd.c                 |  8 +++----
 drivers/char/tpm/tpm_crb.c                  |  4 +++-
 drivers/char/tpm/tpm_tis_core.c             |  7 +++---
 include/linux/tpm.h                         | 12 ++++++----
 security/keys/trusted-keys/trusted_tpm2.c   | 26 ++++++---------------
 tools/testing/selftests/tpm2/tpm2.py        |  4 ++--
 12 files changed, 46 insertions(+), 84 deletions(-)

