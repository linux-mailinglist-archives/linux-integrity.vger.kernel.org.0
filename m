Return-Path: <linux-integrity+bounces-4986-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83CA44657
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4614319C1BAC
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C1195808;
	Tue, 25 Feb 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY9E/YFw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C411990D9;
	Tue, 25 Feb 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501442; cv=none; b=taUT8gCoxxZcriQIQR8tu/aLuoZj3TxeckQaowHtsYKFvwZpkjnQh9o2ZNx1apnh1YV66ZUsJ+KHk3DcdlXM42+p2a21c/wAIfNzf5zEdhlTYvlFz4G9GWFuGoL6ggegTP95H3MZalfGhjqHLwlRyX3vIfpfiWMrIoqjsHL0UGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501442; c=relaxed/simple;
	bh=PsSFz+o6QsG5C91G69pD+6CtVdAG9/eI0Tp095Rkuu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isod+shBWH3TGlc5Yf6ap3sqJbJLYvJSS/vLxe+CQp0oXy9+oGg+QRRKVz+KpeM6VS2ych+CKtgVE2Cla6k1UExl+ibAb3A7HYfJ+YR+g2RUlQOvuKhuS7PWrns8R0yCJd7kv/AcMchs+JqUes2mEGnLFVP/wVKFd87nW1qdt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY9E/YFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD6C4CEDD;
	Tue, 25 Feb 2025 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501442;
	bh=PsSFz+o6QsG5C91G69pD+6CtVdAG9/eI0Tp095Rkuu8=;
	h=From:To:Cc:Subject:Date:From;
	b=PY9E/YFwRU9iZrJaqPM6pLw+fUhjno/Kl1yJQzIMl+2PXr59yTinhjWH2K5KRAdea
	 12l2rMnSUAdk90Kv8S8QWG9N7aYVS2IpIs+R5SKjq8pofSA7i1ZULVYfjqVgujeuEz
	 MhfngJRuDHs6IuVAxRoGgwMbPICxKk20yvwHo7aRgDKFrUgEM7KXfofk994jrT1OaG
	 pIyR4sx/EV7eNznT5MvWto5rlhsP81eumuzOHrp11c6vwwIk+aaiXGDZcfZfSlKWp6
	 IX6ghAOyLXQcK0e/HD6JwP6QG/tImOGyR+0zbZ7rIo/c6v39YHx13/AtybFX9HQbpO
	 fQF63KkxR5dWQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: ftpm_tee: remove incorrect of_match_ptr annotation
Date: Tue, 25 Feb 2025 17:37:15 +0100
Message-Id: <20250225163718.4169649-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about of_ftpm_tee_ids being unused when
CONFIG_OF is disabled:

    drivers/char/tpm/tpm_ftpm_tee.c:356:34: error: unused variable 'of_ftpm_tee_ids' [-Werror,-Wunused-const-variable]

Drop the unnecessary of_match_ptr().

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
An earlier version had this combined with other changes, I made it
a separate patch now
---
 drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 139556b21cc6..8d9209dfc384 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -362,7 +362,7 @@ MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
 static struct platform_driver ftpm_tee_plat_driver = {
 	.driver = {
 		.name = "ftpm-tee",
-		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
+		.of_match_table = of_ftpm_tee_ids,
 	},
 	.shutdown = ftpm_plat_tee_shutdown,
 	.probe = ftpm_plat_tee_probe,
-- 
2.39.5


