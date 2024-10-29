Return-Path: <linux-integrity+bounces-3932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0C9B55D6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 23:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AB7B22073
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2B209F4C;
	Tue, 29 Oct 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBKol5r8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34A1DACA9;
	Tue, 29 Oct 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241417; cv=none; b=F8nT1hhWRLGcQWd+dCFYmXGTBYMftA0VmuvUJ3/JekxBdOvvWLY6wqYWiXsuo8jcLvfy6g7Ct3l1NyJ+jEzeGXqe5l/nOPPxWoJuYOgBAF1XJ/s2L9oNXuegoq3IrMUryYjktSWzZU+CEVd3NXVc9PxFBZpjhc1d0+iVVyDwwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241417; c=relaxed/simple;
	bh=CZFBXuRdzhtDhbnyWwAlURHP9/eZ+qZz8xYGRRRThKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dw+Pseovt7UupO2euEIXFVxPFpMVu0SD0k0dm+lA7VHCrW/PHzqPQ1knJcQ/b5T77oQI/0wmcT7nyGu7Ukgn/TzRKfuhGByDa/fDT+qTDqdl8Iy5ahoRaAdPbWT64gwmnYvyJ7IWs7DPHc3RFUP6L6VIIClzsgHK0wa5Oak3D3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBKol5r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFFDC4CECD;
	Tue, 29 Oct 2024 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730241416;
	bh=CZFBXuRdzhtDhbnyWwAlURHP9/eZ+qZz8xYGRRRThKM=;
	h=From:To:Cc:Subject:Date:From;
	b=FBKol5r8YMwLYCW0ZxbsxjDAKZVh+2maPy1VEyGdQrxUmuo4Kqu0KJ2K8Q9aZxoPa
	 CymiijulZKpK1YFScI9G6Ctkpc/EB+7Urx4mlqB3YgROjrkKdLBMA4X+b+6Bdz95Z+
	 +yYJ2U8vH8vutssctKFVNRBCUx/jJyvDOHkujDwJiidWV6fAoCHV4eiVWsjoITJ2pc
	 +L5ObrYaaxW24Agtws6fasTxdl2N51423P07Q1pT4yQaGgB+59LIC9Ec/W1Co18ru9
	 5iFqf2BMVnjh5goZfVdsYxIzTa6cAuLG3HoqVVeQniVfmUkSwl5DBxeff6nIbE+koD
	 BBFEd3jrv/Pzg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: stable@vger.kernel.org,
	Mike Seo <mikeseohyungjin@gmail.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Date: Wed, 30 Oct 2024 00:36:47 +0200
Message-ID: <20241029223647.35209-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
according to the bug report, as this leaves window for tpm_hwrng_read() to
be called while the operation is in progress. Move setting of the flag
into the beginning.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8134f002b121..3f96bc8b95df 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
 	}
 
 suspended:
-	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
-
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
-- 
2.47.0


