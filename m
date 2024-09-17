Return-Path: <linux-integrity+bounces-3628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB897B2CD
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD35B2B31D
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD32A17DFF3;
	Tue, 17 Sep 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTQs+x52"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80917BB25;
	Tue, 17 Sep 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589732; cv=none; b=djzRumPBfMtLhxdxs+mHmnUpnMApfAypqjp6viBR9llji0Z8Z1OIUIRUZ+l5M5nqbOVL0NAjixUY7I8SSaOeRQepPJDsn3cFr+M6POCQY3b7xYJWk0mValem/N42H7G2mPhcEj0V7vYR3qJq9ledSzQEqKgKeZVTGfBV5zWh4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589732; c=relaxed/simple;
	bh=7PxsDcOZpqvjurJmHu4WIGKRM9mq5riqgC5lquetokI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From; b=PYfG9jzzMJhwxCIHOQdkqHl2B4/dBRhCUbZ7lGu7PQqCCW8AXMalz58J9AftpMVcyUTcag28nzzsCrF5/KRc97V+U/9lavwSHOWXrLk7LxKAe9UftENhl8iuNFUpuD0A0uGktVPjsSJ/mv21b6ae6+rY3hyRjzC1Eo4XLSYCIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTQs+x52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1706C4CEC5;
	Tue, 17 Sep 2024 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589732;
	bh=7PxsDcOZpqvjurJmHu4WIGKRM9mq5riqgC5lquetokI=;
	h=Date:To:Cc:Subject:From:From;
	b=oTQs+x52XwAVv1EaMzn3V9BzIjitNKUEukpMnUAvxorNNj/BWrAIedD7EdVFGs9Um
	 g5ehhW9O350uBlHzfbzZCdIV7T5h8mHGT22pxN0GjcZE6UEt827NMvJMAvL7tULdzY
	 WbI7fowRDIeC9Kn7m1WHlxqsemy9hcogBfxo6S+D5xcrxfxhVQMJNmRITqdX12RB2A
	 6CiVefTtY6H/PQ7y8uoJFHmvXXxkBW0oe0I83gSd5rjrwElIB+IFwQdTXTWDiF3a3+
	 sEiUIF6kz26KA88oHJuBjnVOXs0t5Bu6M6bikWf7NgEmkvzf5kCaX/Wge9CGwDseYq
	 oCrNah9fmQc/Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Sep 2024 19:15:28 +0300
Message-Id: <D48OZ7EPSJB7.2YEWVMTAYHQXH@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2

The following changes since commit 2f27fce67173bbb05d5a0ee03dae5c021202c912=
:

  Merge tag 'sound-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/tiwai/sound (2024-09-17 17:03:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.12-rc1

for you to fetch changes up to f168c000d27f8134160d4a52dfc474a948a3d7e9:

  tpm: export tpm2_sessions_init() to fix ibmvtpm building (2024-09-17 18:5=
6:37 +0300)

----------------------------------------------------------------
Hi,

Just updates and fixes, no major changes.

I might send a PR during the release cycle addressing a performance issue i=
n the
bus encryption:

1. https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
2. https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@k=
ernel.org/

The first version of the patch set cut out already five seconds and I
expect similar figures from the current version but I really need some
more feedback. However, this week is not exactly optimal for getting
it, given the Vienna conference.

BR, Jarkko

----------------------------------------------------------------
Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Kexy Biscuit (1):
      tpm: export tpm2_sessions_init() to fix ibmvtpm building

Michal Suchanek (2):
      MAINTAINERS: Add selftest files to TPM section
      selftests: tpm2: test_smoke: Run only when TPM2 is avaialable.

Uwe Kleine-K=C3=B6nig (1):
      tpm: Drop explicit initialization of struct i2c_device_id::driver_dat=
a to 0

 MAINTAINERS                                | 1 +
 drivers/char/tpm/st33zp24/i2c.c            | 2 +-
 drivers/char/tpm/tpm-dev-common.c          | 2 ++
 drivers/char/tpm/tpm2-sessions.c           | 1 +
 drivers/char/tpm/tpm2-space.c              | 3 +++
 drivers/char/tpm/tpm_i2c_atmel.c           | 2 +-
 drivers/char/tpm/tpm_tis_i2c.c             | 2 +-
 tools/testing/selftests/tpm2/test_smoke.sh | 2 ++
 8 files changed, 12 insertions(+), 3 deletions(-)

