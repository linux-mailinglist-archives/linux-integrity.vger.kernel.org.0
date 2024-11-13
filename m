Return-Path: <linux-integrity+bounces-4111-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8279C7C22
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C022851F6
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FB204F66;
	Wed, 13 Nov 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+qj/xc0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13939204095;
	Wed, 13 Nov 2024 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526161; cv=none; b=Z8XOeoc+4QU5LL/coE+b/ublJcHaOCL3EeXzdJSRGEJ0XjmQVlm6gWtJRKR4TWxRkbcmaGdfNlzjmCjoWqCU3gxToqrv6KcP3Ky6udGe++P6/WaiCUoOoj3MUTHj5J3mIE26XmtdmQOJw5E2FWOtn+KPLmdzeessxZmEIPbLEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526161; c=relaxed/simple;
	bh=9I/sPxC4ETBYsax4tZn4x1+AhNAjIBeUlAR5o9CMu3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=SKq8LjptWcK79TWHuU+qHtXE1rwu6m3+35qQLXHwcbywUyqYAhwQPi7JcU3730v+nNepVsN6eCULaGstimFSvSDduI3HD3jgkD6LDt/MzCGgu6LRcTGLLpINAPdvcM26Jm1AtP6sZm54hv+RqhclT+Doopaat5mpTLNfGQCDSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+qj/xc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F8AC4CEC3;
	Wed, 13 Nov 2024 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731526160;
	bh=9I/sPxC4ETBYsax4tZn4x1+AhNAjIBeUlAR5o9CMu3I=;
	h=Date:To:Cc:Subject:From:From;
	b=N+qj/xc0sDj/7GxhVnVglZ23Cn3lIyNHMEx9CYswgL8EKsADdftx+MmnsXD27YR5x
	 E+jQCyOpcUkXmory+QNz3ek8zWnNpAW4WRwFtIVL/JE31ukpw2o/COLcqMEI5f73fI
	 qbgWBU+0G5gTL5TEKw+uNdOch2gcw3Fv9gny3SykEip77EMFuvDOKKNfBBRahI/loD
	 MCwNZbKb/3Xnj/nTGkhuu40YE+bzt7oOilqNnMg9UpADUdzkykykap4uSeMWa3ZADv
	 0yQEZZ5BaJWR2xuB29y7d9brRPjMLCaFb3H3DujxWDcRGYGpGqCji7GImU1eVOkr6y
	 gD/pzMgmWRRTA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 21:29:16 +0200
Message-Id: <D5LASMVLQDYH.2EDC5DH6YIDTG@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc8
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2


The following changes since commit 14b6320953a3f856a3f93bf9a0e423395baa593d=
:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2024-=
11-12 13:35:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.12-rc8

for you to fetch changes up to 423893fcbe7e9adc875bce4e55b9b25fc1424977:

  tpm: Disable TPM on tpm2_create_primary() failure (2024-11-13 21:10:45 +0=
200)

----------------------------------------------------------------
Hi,

Two bug fixes for TPM bus encryption (the remaining reported issues in
the feature).

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (2):
      tpm: Opt-in in disable PCR integrity protection
      tpm: Disable TPM on tpm2_create_primary() failure

 Documentation/admin-guide/kernel-parameters.txt |  9 ++++
 drivers/char/tpm/tpm-buf.c                      | 20 +++++++++
 drivers/char/tpm/tpm2-cmd.c                     | 30 +++++++++----
 drivers/char/tpm/tpm2-sessions.c                | 58 ++++++++++++++-------=
----
 include/linux/tpm.h                             |  3 ++
 5 files changed, 87 insertions(+), 33 deletions(-)

