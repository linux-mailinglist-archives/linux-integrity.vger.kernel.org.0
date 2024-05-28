Return-Path: <linux-integrity+bounces-2679-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD88D189A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F4B1F221BB
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583B16B729;
	Tue, 28 May 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmZAJ0vr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAB13CABD;
	Tue, 28 May 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892140; cv=none; b=Pz4wc+FKkpAAImUAtmudljcCeKYDNX321MAoLGQNxli8NfXPZl7HVdRPT0nuLO4vkXa62ozlVHhZDKb8vTCo9EPvTDm8BK21kiMjEYWSRMAWZxaFLOvrMAzLwGDDLmTRepUiM2vLb0T+OgpGA23CxeXUWUJuKU9/d5B5jCwq7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892140; c=relaxed/simple;
	bh=2tllxKCFXVlZmMchKrFmmyFaiwTKz5SDQsRsrUjsJUQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=fuZ6TsRy3LDqHQA3dP/5GH+B1kvcqD7NIJCvbUwW/3n6XCza5ieXb/6bUHbxPQWB/Q2EMXAUC8eLMI8akwv5awZizQRmDtkE314URuk4uW77Ea0sPrT94CgguNuBtjs7N6AgLbSIbhqrQVjqfMUmw2H2p3RwzETfVXbKfV+7jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmZAJ0vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D332C3277B;
	Tue, 28 May 2024 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716892140;
	bh=2tllxKCFXVlZmMchKrFmmyFaiwTKz5SDQsRsrUjsJUQ=;
	h=Date:Cc:Subject:From:To:From;
	b=cmZAJ0vrr4PVHYgEixnoGK86FFq5NzMMyUA+uvIlXb2LbmFg2ob0NfUT96DYIvD/8
	 a55kaNvah8aBiqs9pMlKSDBFBwA/SL5Si5NX9f29e46DKxmR6fiM66mpELbU2Rw3Z6
	 xr29ISTvsz3hs7AejahI82DWK7rGG750/ANXOJM+3EfDZRnLq6NmrfO3TkdTC7jHF2
	 wK+iuhdOJPDG7Kiuq8HHREHNXf9jPfYGQSawFb0Xrs6vmrXmA1PSgQVdLga3KEQM3M
	 jjhh5VYs90ltkWpQjqq7AJ2it+eqgb/AgVVvSxA2OYMbFD0Vp3FuDiVZbGgxsuhLeA
	 JY72UrxJQyHJA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 13:28:57 +0300
Message-Id: <D1L7GV7M5K0E.2OPVM82VLFT10@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.10-rc2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 2bfcfd584ff5ccc8bb7acde19b42570414bf880b=
:

  Merge tag 'pmdomain-v6.10-rc1' of git://git.kernel.org/pub/scm/linux/kern=
el/git/ulfh/linux-pm (2024-05-27 08:18:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.10-rc2

for you to fetch changes up to d3e43a8fa43effdbb62c7edc206df7ac67772205:

  tpm: Enable TCG_TPM2_HMAC by default only for X86_64 (2024-05-28 13:14:29=
 +0300)

----------------------------------------------------------------
Hi,

This PR fixes two unaddressed review comments for the HMAC encryption
patch set. They are cosmetic but we are better off, if such unnecessary
glitches do not exist in the release.

The priority part of this PR is enabling the HMAC encryption by default
only on x86-64 because that is the only sufficiently tested arch.

Finally, there is a bug fix for SPI transfer buffer allocation, which
did not take into account the SPI header size.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (3):
      tpm: Open code tpm_buf_parameters()
      tpm: Rename TPM2_OA_TMPL to TPM2_OA_NULL_KEY and make it local
      tpm: Enable TCG_TPM2_HMAC by default only for X86_64

Matthew R. Ochs (1):
      tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buff=
er

 drivers/char/tpm/Kconfig            |  2 +-
 drivers/char/tpm/tpm-buf.c          | 26 --------------------------
 drivers/char/tpm/tpm2-cmd.c         | 10 +++++++++-
 drivers/char/tpm/tpm2-sessions.c    | 21 +++++++++++++++++++--
 drivers/char/tpm/tpm_tis_spi_main.c |  3 ++-
 include/linux/tpm.h                 | 17 -----------------
 6 files changed, 31 insertions(+), 48 deletions(-)

