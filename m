Return-Path: <linux-integrity+bounces-4592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AEBA17A4D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6828016A45E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2025 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F271C07D9;
	Tue, 21 Jan 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh5TXMsp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7B1C07D5;
	Tue, 21 Jan 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452219; cv=none; b=hggXO7HM6OYauUY0gsTsILJULBbntm5Itbua8oedrMXG7AWtz9qA1qmPE1E/TuDvvd3TGxsRogJIUXzaROs+4ItxU+zAsnY8ivVX8/dG39mVp9wqU8mHh0KRe9kWibhC/Mx2LpOtkRpZbOv74i/wlCP3NmltOjSF7f4AhaA8+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452219; c=relaxed/simple;
	bh=EI5S/iz514lfNCax9LcEZSG+EjLfBy6b6gXnwQmwfYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=ubcLpoCchUJW27C73TutytCT8CJ5fYzmTkShs5fDDvPnUX7IKXW0Q++2x0BDyLAf1FBlVJRZiUc/G2aKI0p8MpxgVVvSC+jZU4YBTKFt4nS5JqFdhISJxyB6CdlL9Vu8w/CYUDxC9CU5IwWD4BCYzqP5OZ03vzwLHBd6js5LtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh5TXMsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB596C4CEDF;
	Tue, 21 Jan 2025 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452219;
	bh=EI5S/iz514lfNCax9LcEZSG+EjLfBy6b6gXnwQmwfYQ=;
	h=Date:Cc:Subject:From:To:From;
	b=Kh5TXMsp2nvyto3/qR/1cbr72JKcHhsy+OAQ3oKk/MVZ2vj7uH42+f4CyggFabR26
	 5vDwhvVP9+j/duna3OaW5LYgoFRfmynLkTrI9j1P2iYt33i8gQm5uppV/NZDZC4y9H
	 hhKWL5199WYIm8VQ53bUzunUxIe3zOmNvO93INBqAwlbMTwTX4RA6aP2X/c51oUaQq
	 6YptiFbDk53dueZSXvXDZLnoNpKwrpeVGmopF1g/Bn+WR4RWoqdXu3GEr0IK0+KR25
	 WLoYvEIaJ/RGFhI9Fc63/DvxovImGt6tL2ZSdETiqJrb5chSqaHmegcbRo28YBCzo2
	 cfb5ECZJ+ltRw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 11:36:55 +0200
Message-Id: <D77NEOPLOQ14.36MY4H1HJCG6J@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.13-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 95ec54a420b8f445e04a7ca0ea8deb72c51fe1d3=
:

  Merge tag 'powerpc-6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/powerpc/linux (2025-01-20 21:40:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.13-rc1

for you to fetch changes up to e8d9fab39d1f87b52932646b2f1e7877aa3fc0f4:

  KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=3Dy (2025-=
01-21 11:25:23 +0200)

----------------------------------------------------------------
Hi,

Here's the changes for 6.13-rc1.

BR, Jarkko

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
      keys: drop shadowing dead prototype

David Gstir (1):
      KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=3Dy

 include/keys/system_keyring.h            |  2 +-
 security/keys/trusted-keys/trusted_dcp.c | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

