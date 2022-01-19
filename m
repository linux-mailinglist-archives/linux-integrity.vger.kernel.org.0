Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE94943E1
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jan 2022 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbiASXbd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 18:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiASXbc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 18:31:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D31C061574;
        Wed, 19 Jan 2022 15:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FFB3B81C34;
        Wed, 19 Jan 2022 23:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425AC004E1;
        Wed, 19 Jan 2022 23:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642635089;
        bh=wpaaWCiYZyAnyuuz1kY2kggtn4GBEDvuWq+07dNMQFk=;
        h=Date:From:To:Cc:Subject:From;
        b=io84APfNHqLHI5kNhwUZT5KvdPqWANNRAbPOvSh61dNTzPetytlYU00E1zQE/cWTD
         GUdBTOkcTVNXtdT1qWKdd59Yb8+PGAWbq1FG/ehBWJPAydk4k784MxWwMFyS8OCiSf
         qR75YfkvTTJ8jBSOtYClNRIrQt3Et4UF2MKkpzSbN/hY8XcJWwLu98o2F33BE9y8zT
         5aDGPKY/g4U+jhWacZ8wAU7xQrisL3IZ6gdDgKn3JkYhuXlz18EZrobRPdbSk8JMJ8
         qUuWPsPP0wQClq67t1lxzH0pt/b+aIqUks8NBm6ERdf8TQhs6mSe/WHbfBkwe9LHTM
         bf3fSvEio+49w==
Date:   Wed, 19 Jan 2022 17:38:03 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] tpm: xen-tpmfront: Use struct_size() helper
Message-ID: <20220119233803.GA66829@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worse scenario, could lead to heap overflows.

Also, address the following sparse warning:
drivers/char/tpm/xen-tpmfront.c:131:16: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/char/tpm/xen-tpmfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index da5b30771418..f53e0cf1ec7e 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -126,16 +126,16 @@ static void vtpm_cancel(struct tpm_chip *chip)
 	notify_remote_via_evtchn(priv->evtchn);
 }
 
-static unsigned int shr_data_offset(struct vtpm_shared_page *shr)
+static size_t shr_data_offset(struct vtpm_shared_page *shr)
 {
-	return sizeof(*shr) + sizeof(u32) * shr->nr_extra_pages;
+	return struct_size(shr, extra_pages, shr->nr_extra_pages);
 }
 
 static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
 	struct vtpm_shared_page *shr = priv->shr;
-	unsigned int offset = shr_data_offset(shr);
+	size_t offset = shr_data_offset(shr);
 
 	u32 ordinal;
 	unsigned long duration;
@@ -177,7 +177,7 @@ static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
 	struct vtpm_shared_page *shr = priv->shr;
-	unsigned int offset = shr_data_offset(shr);
+	size_t offset = shr_data_offset(shr);
 	size_t length = shr->length;
 
 	if (shr->state == VTPM_STATE_IDLE)
-- 
2.27.0

