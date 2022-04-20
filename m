Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E2508BB2
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379928AbiDTPNQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380095AbiDTPMs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 11:12:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7E1BEB8;
        Wed, 20 Apr 2022 08:10:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 326F31F752;
        Wed, 20 Apr 2022 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650467401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CI5eCbbUh0HTvUxNvVm6rOMW68v7G6W10HjxAtg/ngA=;
        b=gjZEMURyKhH+ffoe/cJZIs+1qR6NiuC5LbjUsc6HQbUiY2YzhMqa9gcWbW4J8W52XRcuUB
        bxVKmzgppOt2rXgXD9zG+IZ7iT7xfDjw0J35R694tg4TxR9zrp0FyFGkwbXBgSna0vfc7P
        /KVWK5ggl/fmh28DGQ7IZcMIgPfHAnU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0350D13AD5;
        Wed, 20 Apr 2022 15:10:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJc1O0giYGJILQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 20 Apr 2022 15:10:00 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 12/18] xen/tpmfront: use xenbus_setup_ring() and xenbus_teardown_ring()
Date:   Wed, 20 Apr 2022 17:09:36 +0200
Message-Id: <20220420150942.31235-13-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420150942.31235-1-jgross@suse.com>
References: <20220420150942.31235-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify tpmfront's ring creation and removal via xenbus_setup_ring()
and xenbus_teardown_ring().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/char/tpm/xen-tpmfront.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 69df04ae2401..379291826261 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -253,20 +253,12 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
 	struct xenbus_transaction xbt;
 	const char *message = NULL;
 	int rv;
-	grant_ref_t gref;
 
-	priv->shr = (void *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (!priv->shr) {
-		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
-		return -ENOMEM;
-	}
-
-	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
+	rv = xenbus_setup_ring(dev, GFP_KERNEL, (void **)&priv->shr, 1,
+			       &priv->ring_ref);
 	if (rv < 0)
 		return rv;
 
-	priv->ring_ref = gref;
-
 	rv = xenbus_alloc_evtchn(dev, &priv->evtchn);
 	if (rv)
 		return rv;
@@ -331,11 +323,7 @@ static void ring_free(struct tpm_private *priv)
 	if (!priv)
 		return;
 
-	if (priv->ring_ref)
-		gnttab_end_foreign_access(priv->ring_ref,
-				(unsigned long)priv->shr);
-	else
-		free_page((unsigned long)priv->shr);
+	xenbus_teardown_ring((void **)&priv->shr, 1, &priv->ring_ref);
 
 	if (priv->irq)
 		unbind_from_irqhandler(priv->irq, priv);
-- 
2.34.1

