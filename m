Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29788329399
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 22:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhCAV2y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 16:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244711AbhCAVZU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 16:25:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EFA3600CC;
        Mon,  1 Mar 2021 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614633879;
        bh=IgG13ZIsyOmXOaKZjEr30Gu7JPyOgI1kvu1wqvxD0KM=;
        h=From:To:Cc:Subject:Date:From;
        b=Zh6T9kuiJc1kSpaBaWjmXey0awjhxa7vfvun8yLO5hZLIB6A7K/hwjhCaJHD7WFwF
         I8fvUvMWfSQfxXtSnk175+F9I/hCDb26EjPa1naQvPorZ5xCuDtrjmQZaudF8+dgkn
         BBaHy2FkYjYYjaaWJFqPcCx9xLoWojBdc1RVTMxhths7eXmirmdXqV8XTIaJkRwfcx
         Mgp5E5NeeJg3QZwoUH1imW1hl6maVgpVzsrMoHN7v08zBRLFpZoqcI3m3EmVVEqEXd
         43+84zyqzM83vFVQsVuInzlZwuevTIQQFTBWryHKWt6w79vVxbZmkp+p7decZ5IE5E
         s6HkR0uh+bFlg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: Remove unintentional dump_stack() call
Date:   Mon,  1 Mar 2021 23:24:16 +0200
Message-Id: <20210301212417.48774-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

