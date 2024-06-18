Return-Path: <linux-integrity+bounces-2867-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AEE90D328
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070A01C24509
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D00F156C5B;
	Tue, 18 Jun 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyETr0v+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1212DD92;
	Tue, 18 Jun 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717763; cv=none; b=kTNPUK3q1BdoCzsz2ADYHaVE9D91IxbPhIpoUtrJxh753wHtFTvB4jcZaUl9gL7QxMlM8JrugqkZma/kfes86bgd0vFhdlijj9pGLDeMDs3QtQUe34gPZWaRqptMWOHopu0fT5G9DknNo72N4rjVtl54MlL8CwcHJFE4JPYIEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717763; c=relaxed/simple;
	bh=18wvR2VgD6SuCinm13A5EGVFInqKVMlwI+0FKFOQny8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Meig04PFuD8PNxEuq+17nAyxYJdXYDDeR5vpqCD5Xnls/+T+prf62bx4Wh3r1B7c31x8HQkVRjyGpJogRQy5VzOjAebPdnjdQ2g4xdAXmj1yJKWprXmBCO8ovEAzfXMUCDqQYGiDKtraIrf3M+b5LTDWO2z6K3+KynAJGoPt7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyETr0v+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC18C3277B;
	Tue, 18 Jun 2024 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718717762;
	bh=18wvR2VgD6SuCinm13A5EGVFInqKVMlwI+0FKFOQny8=;
	h=From:To:Cc:Subject:Date:From;
	b=RyETr0v+jwdiT2mqIrFgW2uaNIzMjZdZV3tvLwRHC/YA827r0toGorNxynIT5s5Br
	 GhQhmK93Dfn1Da5kqNsHCLBMDOLdE6bShxE4gmqGyQHz84hPk9gltyALoI/rFMfQ79
	 s+YuVItDUDB01lSvr8itkVZl7Bs8GNq4Q9kbcONMg2OG1beuLZCAYT0aXhcA29hDx+
	 VjyapUSjAqeYErAVfcOgiBNLyCcC/zlmn5+JQVMari+d+1yDpg6wadlcqSahhfbdBt
	 nsmGMt6S1kFNu1S03CCINzqoZ2JzteZHAhdjg7L8LY3hE6FoR2Gm210IN30MKS6A8u
	 eqce8b3e/B4kQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: Update the W-tag
Date: Tue, 18 Jun 2024 16:35:56 +0300
Message-ID: <20240618133556.105604-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git hosting for the test suite has been migrated from Gitlab to Codeberg,
given the "less hostile environment".

Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://codeberg.org/jarkko/linux-tpmdd-test
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..022aac78a000 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22746,7 +22746,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
-W:	https://gitlab.com/jarkkojs/linux-tpmdd-test
+W:	https://codeberg.org/jarkko/linux-tpmdd-test
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	Documentation/devicetree/bindings/tpm/
-- 
2.45.2


