Return-Path: <linux-integrity+bounces-2955-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22091E4A9
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A4280CFD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409A16D32E;
	Mon,  1 Jul 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcnr/rRE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DE126F1E;
	Mon,  1 Jul 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849112; cv=none; b=RdquQ+v0hhEsSShHGIW5jJE4nb6IxOT4E5PoopaLRsN2iNzTitaKQ3MNxIrfsRMdNIyA+zYWYPJYncfsHNS6Ctry84h5NXan1ieSUSU22W7ciRpHU5uDJMKD1g+ykGRk5DNtJKgGVBOifJVl7WmZqvM23nRbOWxRTio4Q4dRV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849112; c=relaxed/simple;
	bh=go7y+/7R+ef/tBI71iLrWGpZRU+uIzdwgbbTeOixqMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=EfRhIm8j7Es4O6jS7TOgL2dz+7FeLDZSdiPpMPdnJvH9NYLhOzNMgPfpJK/aabWoVzb8BXFplkOBsjfRjfalKTvWzdQMOXJevDyJ9FrXdtoI2/2NKUoXUDp56KvgWrre3XIxHdL+XSsgOG4wTjVcccBs0kGjEhVYcGeU/0vz0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcnr/rRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD3AC116B1;
	Mon,  1 Jul 2024 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719849111;
	bh=go7y+/7R+ef/tBI71iLrWGpZRU+uIzdwgbbTeOixqMY=;
	h=Date:Cc:Subject:From:To:From;
	b=Mcnr/rRE5iNWKLLYUOSxXwc+iraO85pqjmO3jUSGnZIJw7zJEZ4qMeN078ofhzXN/
	 9Rv6HziSrMs7NJjdQfhwfdsa9YA4rlxK37To0Dk9dmYs6RWPtY1ZXqtBmka7p6LtEn
	 conB3EnmZ71aJtdBylbzc+dHsiqPq/YtBYVX+Jgk2n/pYR5fQlkC9ro7zcgkz9Xx6z
	 Q8NYH9aRpJt+6h9Urfd90Ug9NJyvhtwIysy2+5vOP5Kqb3/Q5hwCV2+PFPnTqh7lC+
	 hDjmJ099O1ap5hrH70Vezeu6HJwZoctJ9plX9yBFvHMLFkhtuvcdA/PDZiDCEN+Csd
	 C66sl4NbdffLQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 15:51:48 +0000
Message-Id: <D2EBML829ZJI.1XZZVLVGUXRBH@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826=
:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.11-rc1

for you to fetch changes up to 0543f29408a151c1c4a12e5da07ec45c2779b9b8:

  tpm_tis_spi: add missing attpm20p SPI device ID entry (2024-07-01 15:50:0=
2 +0000)

----------------------------------------------------------------
Hi,

Contains couuple of bug fixes.

BR, Jarkko

----------------------------------------------------------------
Joe Hattori (1):
      char: tpm: Fix possible memory leak in tpm_bios_measurements_open()

Vitor Soares (1):
      tpm_tis_spi: add missing attpm20p SPI device ID entry

 drivers/char/tpm/eventlog/common.c  | 2 ++
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 2 files changed, 3 insertions(+)

