Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2E4D03FA
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Mar 2022 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiCGQXa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Mar 2022 11:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiCGQX3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 11:23:29 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD4BF66;
        Mon,  7 Mar 2022 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646670149;
        bh=ptRoAb8mg6/U7TkOzs/YecjHNLhRU4WkHJrUaIumxVs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JseSE/lSZFukslI2nJr8C5heEK+iyAPk2P4gAKHROrZlmr34i7jdH4qwPHAFQf+wj
         xkXDESYVEe+/EigfyuGtyfp4YD8Aug7+h1Yi3+M5Wx/5cEuoa7/GbZPYj1hvUlLs5h
         iTWneSMRjINEh1yNluaUymo1DhN/AjEH/7pQCFSw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D74111280BC9;
        Mon,  7 Mar 2022 11:22:29 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KMOW5Aw_jOo3; Mon,  7 Mar 2022 11:22:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646670149;
        bh=ptRoAb8mg6/U7TkOzs/YecjHNLhRU4WkHJrUaIumxVs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=JseSE/lSZFukslI2nJr8C5heEK+iyAPk2P4gAKHROrZlmr34i7jdH4qwPHAFQf+wj
         xkXDESYVEe+/EigfyuGtyfp4YD8Aug7+h1Yi3+M5Wx/5cEuoa7/GbZPYj1hvUlLs5h
         iTWneSMRjINEh1yNluaUymo1DhN/AjEH/7pQCFSw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 13CFC1280BC6;
        Mon,  7 Mar 2022 11:22:29 -0500 (EST)
Message-ID: <120839d2925750e278810b2ad211f5465638f7b0.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 11:22:27 -0500
In-Reply-To: <YiYnpsryEDlrryzU@iki.fi>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
         <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
         <YiYnpsryEDlrryzU@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-03-07 at 17:41 +0200, Jarkko Sakkinen wrote:
[...]
> James, would it possible for you to construct a proper patch from
> this and send it so we could include it to the next PR (use my tree
> as baseline)?

Sure,  There's not really any identifiable patch for a fixes tag, since
the race really always existed.

How about the below.

James

-------------------8>8>8><8<8<8------------------

From 3e0e640e47e5728b68693c5d45bf3cdd0bff48ca Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 7 Mar 2022 11:16:55 -0500
Subject: [PATCH] tpm: use try_get_ops() in tpm-space.c

As part of the series conversion to remove nested TPM operations:

https://lore.kernel.org/all/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/

exposure of the chip->tpm_mutex was removed from much of the upper
level code.  In this conversion, tpm2_del_space() was missed.  This
didn't matter much because it's usually called closely after a
converted operation, so there's only a very tiny race window where the
chip can be removed before the space flushing is done which causes a
NULL deref on the mutex.  However, there are reports of this window
being hit in practice, so fix this by converting tpm2_del_space() to
use tpm_try_get_ops(), which performs all the teardown checks before
acquring the mutex.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 265ec72b1d81..ffb35f0154c1 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip)) {
+
+	if (tpm_try_get_ops(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
-	mutex_unlock(&chip->tpm_mutex);
+
 	kfree(space->context_buf);
 	kfree(space->session_buf);
 }
-- 
2.34.1


