Return-Path: <linux-integrity+bounces-3930-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E79B9B3ED1
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 01:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438161F21C8A
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929F624;
	Tue, 29 Oct 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP7Oelne"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB04621;
	Tue, 29 Oct 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160368; cv=none; b=nszE/HvEK27dbSXkG2PbAW/RMHHsnJyL5NO//Z2trR/+bxCOYnTVvjOB3mXaPNHXEkVUntXKQX4/PQ2BNTF6sfWgn3w8rKAHy6xgr1ENfT8L139zdTezw/YFJ5jn12YRbiNUOcozuUQ5ERB1izpxtBo/PjI2AzGy63d7h8vO1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160368; c=relaxed/simple;
	bh=5ErTGv0+DuZd39+uN4cny7CaDy/hZ8zMZpANSPaGf5U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=TDhXjix14LKPCDe8WHzqadgEq6CZU5vBmCQgNxLusM26+d62akr2oZ8j/argRmuM7xtFKYSLyFxVpO0qjkMxifs2uSFjgWQYZ2p1RvTSjXFOO9YCiNgChijDOTpnYU3tkjGo4y6HcPfCzs9eQzCagatjsp816gtRr8njFck2ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP7Oelne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9CC4CEC3;
	Tue, 29 Oct 2024 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160367;
	bh=5ErTGv0+DuZd39+uN4cny7CaDy/hZ8zMZpANSPaGf5U=;
	h=Date:Cc:Subject:From:To:From;
	b=qP7OelneO+aAm36IOjRSIi47O2t2Ma8ADai9ppd+5KSUey0DcWzYCI6H+iatbwIQ3
	 aSttWVbiKaXpTVvwN9lmRgYv+v3RZ904KsERtzrrrzx13Dvi47qbAt8rm2CQe62F+R
	 Bgow/yXs5nXWZukP8ti7JH0ZRBmwVyRM7jrB1SRdxtbr6u6y6v2hToJD55AjhaGKXR
	 rB7LlrvwWXaC2pYgFCc4KjUEqRAqN2EzGgF2gI2IsgxT0M4mmpDKkgPQOQhaL5pS+i
	 f60XWqUD+LaK23n7IkeF37m90rmG7oALyJ8aZpKfqIMJxT+i79G7xtXovtZ8XLSJoM
	 UHb8xdwTsrQbg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Oct 2024 02:06:02 +0200
Message-Id: <D57UNU1ZUXJS.E2RDQDB8XFKI@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc6
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e=
:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.12-rc6

for you to fetch changes up to df745e25098dcb2f706399c0d06dd8d1bab6b6ec:

  tpm: Lazily flush the auth session (2024-10-29 00:46:20 +0200)

----------------------------------------------------------------
Hi

Addresses a significant boot-time delay issue:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219229

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (3):
      tpm: Return tpm2_sessions_init() when null key creation fails
      tpm: Rollback tpm2_load_null()
      tpm: Lazily flush the auth session

 drivers/char/tpm/tpm-chip.c       |  10 ++++
 drivers/char/tpm/tpm-dev-common.c |   3 ++
 drivers/char/tpm/tpm-interface.c  |   6 ++-
 drivers/char/tpm/tpm2-sessions.c  | 100 +++++++++++++++++++++++-----------=
----
 4 files changed, 77 insertions(+), 42 deletions(-)

