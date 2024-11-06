Return-Path: <linux-integrity+bounces-4032-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72E9BF564
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 19:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C891F26246
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3A28EF;
	Wed,  6 Nov 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0rqJxpa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E051208220;
	Wed,  6 Nov 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918139; cv=none; b=Shos5EP+Srs9mlhG3Ue2baS/OXzK/CIFz/RLhxGf3Ks6cYdrKzk+Nd7OFOWYKds/wvtt6jJ1kdrtysP47waeMShwviD7G5qTyjFQR62ImzryUgJjVDp6+psdx/nfrHWVEGGnZXIwg6C1iKHKb45IhgN1+su2Wvgoz9K4DEtnGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918139; c=relaxed/simple;
	bh=lSepakk3yilD/WdqaDpUJpzRegdFgY39i/wXKvhEaOI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=OC42HE8t8lFZU43vbQlOoDBSRH3+MBPeQfNVi9VShSAp6w3vL28H1dUMyPcwRFgVrEZ0dlYTQXYcU94KbZNc1LnEgEbGX6iqbc6htRT1Ve5rYpC61ThN+LQORAW72DIoVMwxsNLVJw9+aG+7LA6UeWqxhqDdnMUinIyvBUlxUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0rqJxpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61752C4CEC6;
	Wed,  6 Nov 2024 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918138;
	bh=lSepakk3yilD/WdqaDpUJpzRegdFgY39i/wXKvhEaOI=;
	h=Date:Cc:Subject:From:To:From;
	b=E0rqJxpaFnNKtbu0YPAHQGfElD8r+lT+Ztp/a9rLB3h0Hsd/i1Ib+ro6YBcwXTSB0
	 Vd9xJYvvCCnjwS3Pgj8iHTgBT4pPzr0XyPLvfLL2s92DwUeh7exP+3djhAbAXo+usy
	 kFXEFYrukxsNJA4Ft5RCzZNZAh2EyYkvNa+7A+Gc3qJdRwVUMBdBdZtHHjXW/eD2PW
	 nbXM8ID1s1LjJwLre9dYMmaAHBKNqPdkyIMpoFMqFa7+d0iGWNhO1eHUDcsLYdu31G
	 gosMeg5q8JTMlIIJFgieWMtnW9qvY/ZhH4IweeUJb2k9zblBrsHH9dVCDd648xTJxQ
	 A3mmHTSaHXU0A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Nov 2024 20:35:34 +0200
Message-Id: <D5FB9PK9DD35.1B1VBVMPOZPRS@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.12-rc7
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 557329bcecc2f55e134db8974953b32b69db9d15=
:

  Merge tag 'mmc-v6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/ulfh/mmc (2024-11-04 08:07:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.12-rc7

for you to fetch changes up to 04de7589e0a95167d803ecadd115235ba2c14997:

  KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation (2024-1=
1-04 21:24:24 +0200)

----------------------------------------------------------------
Hi,

Couple of fixes for keys and trusted keys. For me it id not make
(common) sense to separate them into separate them into separate keys
and trusted keys PR's.

BR, Jarkko

----------------------------------------------------------------
Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

David Gstir (1):
      KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation

 security/keys/keyring.c                  | 7 +++++--
 security/keys/trusted-keys/trusted_dcp.c | 9 +++++----
 2 files changed, 10 insertions(+), 6 deletions(-)


