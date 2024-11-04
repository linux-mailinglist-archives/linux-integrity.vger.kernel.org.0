Return-Path: <linux-integrity+bounces-4004-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26C9BA9AF
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 01:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E8E1F216BE
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D80800;
	Mon,  4 Nov 2024 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdwRVVbN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90617C;
	Mon,  4 Nov 2024 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678919; cv=none; b=YctLlnnE31rK7mJ1I5R08qSOZMecCLjoOtZiQr5h8gf/K7mJPTWT9HFf5oMO8hQ4Rzm3+K7KVdzaTR3JdrvW/O1D1Ho08EwtGDOuuXMsLZQ53zn881IamWk+ft7shlbz4QSmvcQxojddDU0Unj4Cdjm0WKjSoWkZSjawFO5EAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678919; c=relaxed/simple;
	bh=CXcuQOiUiATkoADXBmgKDVrSp/xTc0KVAz/6LenqVkU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=hyzJNocZC8En2yt7yp07sGCKSMbxJrFM9iTCRn/4Ul22Bm2kkcf2H9XMqiOGYY948lC0+xVcAI0CPND37bJTmJFAJkbFGeFtB3At5/0nSXk8gyjpBh0wUDTGyNRRcMtQwApgsaFCcxBgE9WOzqm9JhijobfU+4Wm8SZmIoUVNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdwRVVbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C790C4CECD;
	Mon,  4 Nov 2024 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730678918;
	bh=CXcuQOiUiATkoADXBmgKDVrSp/xTc0KVAz/6LenqVkU=;
	h=Date:Cc:Subject:From:To:From;
	b=SdwRVVbN26L4jyTl7xQZWPxBQopk0QJBFkbvFXU/Qnp/9JTemX4vW6YfOxaeXHcBH
	 fuKi6hKAaViMp+xQ8RRnNfZf0a4qcM9LaiemCuXTittaL+NgnSZUZzLVSDgCoK3nWp
	 VyCJ0OQc3l947g5YtNswfHDHshS3Jz1jtHtvUARliSZ61e/cIZzV8LKjTQp9VtYszr
	 udH+dysxTEWeT9pS2CSjvOu+ZphMkdlHAMyW0i7EUBjozG7psJU8EjvtbxM6R/XVbI
	 eE1pCRTva64Q7tEzzD3eNeV/8Gr15tMALNzweAkkSaiF9+RrgOSP4sCV6xM3IepYMI
	 QiSVlr44gVZ9A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 02:08:32 +0200
Message-Id: <D5CYH0IJXX72.35A25M1YICZRP@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc7
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 11066801dd4b7c4d75fce65c812723a80c1481ae=
:

  Merge tag 'linux_kselftest-fixes-6.12-rc6' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/shuah/linux-kselftest (2024-11-01 16:05:50 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.12-rc7

for you to fetch changes up to 9265fed6db601ee2ec47577815387458ef4f047a:

  tpm: Lock TPM chip in tpm_pm_suspend() first (2024-11-04 01:59:08 +0200)

----------------------------------------------------------------
Hi,

This pull request fixes a race condition between tpm_pm_suspend() and
tpm_hwrng_read() (I think for good now):

https://bugzilla.kernel.org/show_bug.cgi?id=3D219383

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Lock TPM chip in tpm_pm_suspend() first

 drivers/char/tpm/tpm-chip.c      |  4 ----
 drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 14 deletions(-)

