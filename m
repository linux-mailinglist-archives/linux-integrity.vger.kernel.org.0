Return-Path: <linux-integrity+bounces-5379-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B6A6CC18
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5964217E537
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B123643F;
	Sat, 22 Mar 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPNTWo82"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864123535B;
	Sat, 22 Mar 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742673704; cv=none; b=Gf+9/e+vSOmTTGlj+x51X4K03KJNVRzfq+hulO+Dz6wDGK90zksGwWtxHo47y+I3P00CPCNBdc7LPbSq109FtLd5h+ceTW7zfmobGYj1ltpElR7tRlOrKZkOUJXFJXVh98le5BOv+NJdvilIUXeACX+JmfZYDS85/bbFF5DBi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742673704; c=relaxed/simple;
	bh=J98TzFwZwixxPXlktGcaegVbeDrGguxN36zKCXAEjJA=;
	h=Content-Type:Date:From:To:Cc:Subject:Mime-Version:Message-Id; b=cgiZrrxOJe4bkkQnIb6Ijg6zbtcG4tco7a0DSfM8v38mkihLbUwlYp1CMw3bRHPOHvu0bhfdv/Aa8TGcmgOPy6HmW/nAsydjYHYFYubzNEpuOMvkg4JDY/pV1DG/6YtSkHXmLAFfmrtStx2qNUVDNzmQ5x90/yINowlH7cmc+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPNTWo82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D378C4CEEC;
	Sat, 22 Mar 2025 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742673703;
	bh=J98TzFwZwixxPXlktGcaegVbeDrGguxN36zKCXAEjJA=;
	h=Date:From:To:Cc:Subject:From;
	b=YPNTWo82hO1F2l99M6o/p/C0NCjO08OzCxwfH91MLrTEvRxuXmOGuK7Y4acA7/tsu
	 6+beanWRpKFG1Wp7XCnunf+FIzrfxyhV/dnz3JP3s1svYJ8XahsvzU1cMunwJfVGh7
	 3/fG5hHnq2Vs9sZ4dTa0KrhKMbemjNj9K8HbDa/D2A7VYa+xYybxJOJWIdiyZUBfV5
	 oR4kHqGy0VlUqaYQMgSdUAh03gpjgIsD6B3Dn9njgeCG5BMrpSoZBllqifTt0349Ju
	 65zE8iulv0OxkOJBAuD46oxnbPw6JgM9GbR0bdM3txPaWijDugfB1gXUbDSlmPfk02
	 wd9+EFLHdv+yA==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Mar 2025 22:01:40 +0200
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 <keyrings@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: [GIT PULL] KEYS: keys-next-6.14-rc8
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8N1VMZVITFY.127IEQZN0J9KZ@jarkko-kan-01>
X-Mailer: aerc 0.14.0

The following changes since commit 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15=
:

  Merge tag 'spi-fix-v6.14-rc7' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/broonie/spi (2025-03-21 14:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/keys-next-6.14-rc8

for you to fetch changes up to 75845c6c1a64483e9985302793dbf0dfa5f71e32:

  keys: Fix UAF in key_put() (2025-03-22 15:36:49 +0200)

----------------------------------------------------------------
Hi,

I presume -rc7 is the last rc for v6.14 but here is one critical fix
for the release. If possible, please include, otherwise will be
postponed to the merge window...

BR, Jarkkoa

----------------------------------------------------------------
David Howells (1):
      keys: Fix UAF in key_put()

 include/linux/key.h | 1 +
 security/keys/gc.c  | 4 +++-
 security/keys/key.c | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

