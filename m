Return-Path: <linux-integrity+bounces-3164-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B8933D62
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C81C225A6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650401802A3;
	Wed, 17 Jul 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTwPw6in"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3F1CAB1;
	Wed, 17 Jul 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221868; cv=none; b=WOpWzDGKSuR2/X8iVBoTLBWC+p/QpzqBg/PQUgIyjLtHshhnTs4uu2eGsm2b0M6D1haJOCHF2rI2dTuPsajl5bGAZ8MwbWhvLpWo6+k67DyKE711+GloP+Xu0zfc8xij9UQ9ud8f8T059ddYPgAFCJ3gMGErUzXG6vIm56Z3V04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221868; c=relaxed/simple;
	bh=aUFygkpBQcR68U5hCYFpZ5bQGow9JtcWM+4VP+kgBYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=V+ycnHwp4qW5mXW1gGkv5xdpD/0TmLDcv4NQU9PBFCgTmTg5N+B6vPk20praKJA6VhGPgLPl7V8p/5Pou5AwIypZt11GYSJJqy2hOjCqWPZPvGCDmJcYTBL7aMUdrxUZIm5sjTS4nlqssNquX/erJf6Uj9HiusNr80M8qdebfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTwPw6in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2153EC32782;
	Wed, 17 Jul 2024 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221867;
	bh=aUFygkpBQcR68U5hCYFpZ5bQGow9JtcWM+4VP+kgBYY=;
	h=Date:Cc:Subject:From:To:From;
	b=bTwPw6inPP+yqBpTG/PP73tk2VXrmmbOsDDoXkys1XSy2JJ9X23/tKSUwLCFedzyN
	 nCcFKJf0wkvNOY1PPywB7PBxg478W338heC24N2W6oGJq3U3TxZSJ9FnUQuDqNcr8Q
	 w9Yjuc3l/q4ZTpb5mXQbm9WihsKJu0YNMf+mE1uzrKd9M7PozcKEvniPC/cPiYjTA+
	 ycYQmjhxzHueRh+Ntk2O1P/kUdd1o4EHoEuQxAADBM3oryFxfgT/NEfDZ808Nv0/u9
	 NDfGT3hoVybu+rt4FQJfZuzhwNukbmgxbUFDgZhDnIw7Q/ojs8C7I5Cg4cQ6/0du3+
	 VVRG8cy6MFMyA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 16:11:04 +0300
Message-Id: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao Ge"
 <gehao@kylinos.cn>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1-roundtwo
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit d67978318827d06f1c0fa4c31343a279e9df6fde=
:

  Merge tag 'x86_cpu_for_v6.11_rc1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/tip/tip (2024-07-15 20:25:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.11-rc1-roundtwo

for you to fetch changes up to 7dc357d343f134bf59815ff6098b93503ec8a23b:

  tpm: Use auth only after NULL check in tpm_buf_check_hmac_response() (202=
4-07-16 13:55:58 +0300)

----------------------------------------------------------------
Hi

This is additional fix that supplements my earlier fixes for handling
auth, which I unfortunately missed last time.

BR, Jarkko

----------------------------------------------------------------
Hao Ge (1):
      tpm: Use auth only after NULL check in tpm_buf_check_hmac_response()

 drivers/char/tpm/tpm2-sessions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

