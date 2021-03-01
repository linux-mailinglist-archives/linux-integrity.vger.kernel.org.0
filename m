Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63E327B06
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCAJpN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 04:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233762AbhCAJpM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 04:45:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F9E64E31;
        Mon,  1 Mar 2021 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614591870;
        bh=jMbKvssZVyvSNQWJNR1W7nK6aRXIaaX7YBLAevoZguk=;
        h=From:To:Cc:Subject:Date:From;
        b=f+R8r14IUGmmb9F7J+PLfqr2ULV09VqFUMAXbbRrJ0zKM1Ts+559JMmSN/1MVDLvy
         5lda6UUBbtJInLOr5elJlayYSgs5kerbJe7FaljW8n2c/0uVGuw/gABVf8ZQ22dnV6
         7yttnCTMjUlD7xOnJltiUn2+/jDHRCKMhkXDKPSxq+AdZcqV9qtYX/SZk9O4/dHtjs
         8Mzj6ZYexgCS86KlzRbK6dbaMazopJVc0a3KfTLiLuSerNpGQAXq1q9QFiM/NUjTr+
         La9p5BqCdtr8fkEPa0YByxl3x54Ebwj1k+TogEhpuEAvw2UzbhZCR1f4tshWBqKgsb
         i8YJ2gjAGJNAg==
From:   jarkko@kernel.org
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: Remove unintentional dump_stack() call
Date:   Mon,  1 Mar 2021 11:44:09 +0200
Message-Id: <20210301094409.14380-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Somewhere along the line, probably during a rebase, an unintentional
dump_stack() got included. Revert this change.

Reported-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Fixes: 90cba8d20f8b ("tpm/ppi: Constify static struct attribute_group")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 19e23fcc6bc8..ddaeceb7e109 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -278,8 +278,6 @@ static void tpm_devs_release(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);
 
-	dump_stack();
-
 	/* release the master device reference */
 	put_device(&chip->dev);
 }
-- 
2.30.1

