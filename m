Return-Path: <linux-integrity+bounces-4615-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8FA1A05D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D027F3AD390
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856220C47E;
	Thu, 23 Jan 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="kOQbPpN2";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="d3cyL035"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973E15AF6;
	Thu, 23 Jan 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623462; cv=pass; b=fVDqCa+F1ISrIh8VddzpikJ7gxIHl/9MVFuWn+TI0OPDM/YGIBWGLarK6olx4OITfZyWny8W4OLnYLzV2jELEB34KpMCObhQc0YoJatt+IuVCeWJiz+JNzwaJ5CevbtYx/k6x361sAI7lornz4TxTvvyJbKImfVBHp8q5FMC3Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623462; c=relaxed/simple;
	bh=453mGJSiEBFZGocGwp0P5IRdHE1i8ijNKOBTzgMR37I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=bsqoiYyfvgBRiqCLiVREtByyFkAcqX6yk39ELHJjVrpcP/Gyhi/shlVtgswfhtlwZGT6VROzqh3dqni6Au0tZeHiQ23xFIoemEcsAIumww4etPSMVV5RD68VXYrJaozclevf517wMdGNpD1jeS0pbCaQ3xuuh+fzSUDc5hpm2kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=kOQbPpN2; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=d3cyL035; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Ydw4P0nsWz49QCV;
	Thu, 23 Jan 2025 11:04:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1737623077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=alxMwYMlnKX5yNBW7H9cRGqpPuHPbbzNiS/4++NiEec=;
	b=kOQbPpN2foL57fgx0gQo1gx6IhN5udPwFzRRDPcCKHY37XGs0SFVgxD7yKf6ybzS85ycBP
	CkQtXKVZWMT5A54Bc5Q3UGmCeXHjPoEugIDJreAhR0KZZKqXGwJn9AqRLZw0cbSsdVB+YU
	gpKzn5T6yKiSOq+pq0Ev+8gWUbhBva/NF3NcYogC8aPxTjidw/Dtgq3/4W9jr2JDWEmCcH
	ChFYE7vsMM8mmVyRO/1AWJ2Le9v1WSUXa40uhfiXopzaXknCVsg/MhmNW463LNdyXeUTCG
	gRYg6K0NAVpY+c7Z2Z59H+3+L0/ylXmjbc1fmPNjcsEI15b1dqoEuwO7AItmLQ==
Received: from localhost (83-245-197-208.elisa-laajakaista.fi [83.245.197.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Ydw4C5djxzyVf;
	Thu, 23 Jan 2025 11:04:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1737623068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=alxMwYMlnKX5yNBW7H9cRGqpPuHPbbzNiS/4++NiEec=;
	b=d3cyL035Q0gXy1zti7II4Gi0lVf1aZ81f7z7hvqrfTGKgV5nnVATQB5aQzikcmE4yeOPld
	eKqD5svOssb+mvuS7wFcDeKfUKhzky2JK4T79PQxtPI89L7CD9+/u2pAXkwjokEpygszWZ
	Bnd3R7mYNkAut0t+TWYn+K+EpZeLVZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1737623068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=alxMwYMlnKX5yNBW7H9cRGqpPuHPbbzNiS/4++NiEec=;
	b=iBt0kBmQW9hUGBOgozNghFDEKH9H5PpQkuP/bTdSyoQ45ltMZCYTSWPSRV8rFbw0Ynvyua
	HNZGh7olk6ECvZ3FSUdFMuEWU9ANNyhkJoS+d35hWX7YF4X8mKe87KZT+sBGaL1Am/TEIv
	A2OAGJTI+BmNyBhX2f0zSZurlpbqd7M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1737623068; a=rsa-sha256; cv=none;
	b=BzB5fIE9T5qTTg7bK9KRC7GLGDqlHbHrWtfcy6dxhKuFXRpLNsNX8m1aq2aLYC50uGFz4+
	z6SnkB5ZrMW2qFz/8t2EkIFqlbrO7H2ZwUTowjg0zq3nvST8lNuGYU3qCEHRIw8VfBToTL
	/ACvBZrmwqwoxgtieaS/r92EVdyLKq0=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 11:04:25 +0200
Message-Id: <D79BYW5LF81P.3S7NLCWK7RAL9@iki.fi>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.14-rc1
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.18.2

The following changes since commit 21266b8df5224c4f677acf9f353eecc9094731f0=
:

  Merge tag 'AT_EXECVE_CHECK-v6.14-rc1' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/kees/linux (2025-01-22 20:34:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.14-rc1

for you to fetch changes up to a3a860bc0fd6c07332e4911cf9a238d20de90173:

  tpm: Change to kvalloc() in eventlog/acpi.c (2025-01-23 10:52:23 +0200)

----------------------------------------------------------------
Hi,

Updates for the TPM driver (yep, only one patch).

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Change to kvalloc() in eventlog/acpi.c

 drivers/char/tpm/eventlog/acpi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

