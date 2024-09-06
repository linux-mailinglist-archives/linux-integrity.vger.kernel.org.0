Return-Path: <linux-integrity+bounces-3474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08E96E9C0
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFE41F22593
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74D13BC0E;
	Fri,  6 Sep 2024 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="lWt/ZQRz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE23B1A2;
	Fri,  6 Sep 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603007; cv=none; b=aRw8kKQkx8tBWTkojeqPZQB2SFdzpPE5+G/I2Y9AZJ6czKj18rErtfxWugrMGgaFz1zCohbVEXXZDYumGztI5QhB9fHzAd05+3kF3GX1UCNxk3/WfYjpIxGoNaxmg/aYbrpPrL/GPufJrXcwijm7it15yjoXqofow94mtPg3/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603007; c=relaxed/simple;
	bh=L/M6VWT0huBTc7VVB3Vitg3CYBgjtnhiy6HcqOb6g3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iURr50JCNNV3hwTAMMBtHps98gAIAeeBxPq0Cm7d9ijOKfBVY2R/XckI4sQC/EPah0xpbXFsmM57NDsZMlETCMJPgTdTxl+ubAWYRbhxCFT/4UttSZ/QogCVeRGNKUdg1q0R8Dva8h76wPXmjjHT+gau3wzqko20LK/Kr3G/uYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=lWt/ZQRz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725602995; x=1726207795; i=wahrenst@gmx.net;
	bh=KuGidECZWeZ8PGviZlVT4SoHZf65jEZKxo1C4Og2fno=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lWt/ZQRzpNWWy3+BBlDNet2tXS/QBAnoiswOnB8d4iHrrxnlg9Xj5/6PcgcPQec+
	 2Iqftn2oyyNeJS1pnRAJEhn/CdR9UlUN33hLF/rDg+BvC8qE4DYZsGeqWTTTLzBDI
	 5ePmaVcNSB3Yp92Qpdxb28r/d3rn2FkTTUgYu44V9fAUIxRPBDBMyORsLUXVAjImk
	 UqjY5ZEtcRfwcj20otWR71+3LU9bF9NAqBR13d/o0Ik0DklyJvhGFM1SV5FP9ho0E
	 r0zfdrx7c+mz2JmXOd56fBjyFYn/V+v0jI40syhitUGI1zcT2g4RfKbOWCl75w8pI
	 AVRXgoB3CTPaKTTRvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1rv2X30RxC-017zRs; Fri, 06
 Sep 2024 08:09:55 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC 0/2] tpm: Minor improvements
Date: Fri,  6 Sep 2024 08:09:45 +0200
Message-Id: <20240906060947.4844-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aASnBdfZ/MVzEme5ExVgqoinWwXUIVXtOKN4ohK93s3WbcgGgin
 EolGARfiVCMEHVhSUGhIeE7XJ8l2EeS6wmzSkEAiuih2HKdEG/Od+M4fwQC7VSPBYxQo9pI
 j+gn7Qrl3urIEvDiKb9fwhlkxDOJ1aYWoEuBFV4RS7Kqx424eXNdw4eA9R2UthThDL8uflD
 66JnjGnmUbYXBvRlXK/+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+vZOc4yaGqo=;lvuPGRmr68xbyKUJXtnxnyHrjad
 tf6gTkzHeFUT4vSCDj8msruW0jTcZAx7RgXHVSkX4ggOvMsMI2faRdjMW2Y+Or5rk9E1rBSKG
 u3D6D9EEaNtcTz+DIWj02lnrhyZfJLQSAH6mk8BG4NGdgvL16/KTVeIeDa2sf6FyAYjWx0lX/
 r1UnSJUTAluRED3a7kb20aexcVo7RmpwpO5DdbwD1jrl16t48J8mcU/p5NHpMseVvZFPBes9c
 NjPeeQwg2+Ip/NMiJqnwh3ETPnjOQzD8lnSM9pnHz26yaCyGpUXUAiyiOFbbzywXHIdtfGMBK
 u6D5rMAzTD+u0JZCLFxFQg1F0mqKyLKcBqx6OxOUOWTg5x9R8al9HemPPyd6nTZ14bS2EXT78
 JJKeyqmswz76zeUkGfMgorFb2tNkVE7U9ScdUeDu7jncqxGm6LYfPUsGL4KXetehrrM/G/bpx
 lEwUAA2qOOXBm30LBaczV1wvEdmbe3bJYeMQ/qPv0NHcLDAIBNEtvmXkSh5vh4KSBgy1fkgdn
 788F1IYhAG7mASkEhiC1U8VCQ2lehbF2avjsWi4u4XR5k+74q/IBrjfCucCH8F1c/LiS2nmjR
 NmM9FMzF3ZGlGPt9iQwLqSF7lDIa2Kq9tSWvTBTJaKYX9VSbcZy1xaOSRvnbLCLDGV6ch7cOS
 ejVcRHBRTtyonLOuM6+CK6+kEXeYzVe4Ax6v7bQ2+Zlu7irhL1myxJF9P8WZ4cj1fOXb6f/8E
 BP+yAOBu7F/jutgUhw4a2Gk2K4j2Ahqdof04i6GCKzUtfuQyEx1Gu8My2mJO605pCefE0F8av
 UCy/eIq9sRwzJZYgx43RMpCw==

These minor improvements are the results of wiring up a
Infineon SLB9670 chip on a custom board.

Stefan Wahren (2):
  tpm: tpm_tis_spi: Ensure SPI mode 0
  tpm: tpm_tis: Provide error messages in tpm_tis_core_init

 drivers/char/tpm/tpm_tis_core.c     | 15 ++++++++++++---
 drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

=2D-
2.34.1


