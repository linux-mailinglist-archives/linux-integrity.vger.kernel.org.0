Return-Path: <linux-integrity+bounces-4186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9B9D5647
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2024 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B31F2393D
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDF1DE2A5;
	Thu, 21 Nov 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5xlhA5u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF41CBEB9;
	Thu, 21 Nov 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732232475; cv=none; b=Dok4FUXycKkReTM+0vqheJBxRcJKSpl4iQL2Usnd4scH9op41WduagmTypmyPHw/THjUeGxRMpNakourC2X+P4koun9ullbYvzzhOyLLyXP/qffggJczpfcvKN2uPOsMgssD18rHC3Jk2v9Xko/IS2ZJdfpo7CXLg9LXDF3NI4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732232475; c=relaxed/simple;
	bh=hZMMA00BLtAoskhvmEJq99fPpPJUiqFk9bzWhdPZVr8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=tmq8AH0SL6dXdFOGOFlezBzcB18axTK1UvdGWIzWxnuhuzCzVzAZgwstqvmdJR8A1yxCLRJp/Fbs0ot3XBgT8Gj7XRzUP07yZS1rV3GHbHom37L2jUFDETHVNrNRYYZmm2odLZzFFHYFr9xFGCSRs7xQ+eYUg2tkZRseyr1LI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5xlhA5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE7CC4CECC;
	Thu, 21 Nov 2024 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732232475;
	bh=hZMMA00BLtAoskhvmEJq99fPpPJUiqFk9bzWhdPZVr8=;
	h=Date:Cc:Subject:From:To:From;
	b=A5xlhA5uCJNUNqZqyB34pBv1KzfF0bZciA0RMSPEG561rMJUWUNGhI0mI+IvNzK+M
	 U6iFA+lKKT31MV+ZjVIORET5/MTW65KcsgY+Dbxz3ieeynmtX2+IMUGRJYUdokizTa
	 QxYid/dIG5AYkH8+7v6v1Gk6Eyn5/eFXjHbSZR3bFb+xssU1j5Fhi3nVTugR92OL+u
	 jRKa0yTNJ4HNqWBi+J0WoIbYlutjFKQDx+R4IWxUKFvyQfZ1L2u2hogvIvQQ7arhno
	 kmAjgyQXI8eGQedTJmLf1PKUilLqprh02+/NpcGqmD8WmZtz4zmmZga0GnZlmquHad
	 zF+Q9puyGoLHA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 01:41:10 +0200
Message-Id: <D5S95V90MFOZ.4LGI0I0F9QP8@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: linux-next-6.13-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 341d041daae52cd5f014f68c1c7d9039db818fca=
:

  Merge tag 'for-linus-iommufd' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/jgg/iommufd (2024-11-21 12:40:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.13-rc1

for you to fetch changes up to 5578b4347bb5d5dfc8eeb8ee2eb8248658707d9b:

  tpm: atmel: Drop PPC64 specific MMIO setup (2024-11-22 00:56:50 +0200)

----------------------------------------------------------------
Hi,

This pull request has only some minor tweaks.

BR, Jarkko

----------------------------------------------------------------
Jan Dabros (2):
      char: tpm: cr50: Use generic request/relinquish locality ops
      char: tpm: cr50: Move i2c locking to request/relinquish locality ops

Jett Rink (1):
      char: tpm: cr50: Add new device/vendor ID 0x50666666

Rob Herring (Arm) (1):
      tpm: atmel: Drop PPC64 specific MMIO setup

Stefan Berger (1):
      tpm: ibmvtpm: Set TPM_OPS_AUTO_STARTUP flag on driver

 drivers/char/tpm/Kconfig            |   2 +-
 drivers/char/tpm/tpm2-sessions.c    |   1 -
 drivers/char/tpm/tpm_atmel.c        |  63 +++++++++++++++-
 drivers/char/tpm/tpm_atmel.h        | 140 --------------------------------=
--
 drivers/char/tpm/tpm_ibmvtpm.c      |  15 +---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 146 +++++++++++++++++++++++---------=
----
 6 files changed, 156 insertions(+), 211 deletions(-)
 delete mode 100644 drivers/char/tpm/tpm_atmel.h

