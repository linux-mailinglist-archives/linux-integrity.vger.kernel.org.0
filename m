Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D21715388
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 04:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE3CTd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 May 2023 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3CTc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 May 2023 22:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CCA0;
        Mon, 29 May 2023 19:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDEE262967;
        Tue, 30 May 2023 02:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62213C433D2;
        Tue, 30 May 2023 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685413170;
        bh=eiUFgOZSpjDQEluGf9ifJCdhlsqPYvzTO9q4+4sBJlU=;
        h=From:To:Cc:Subject:Date:From;
        b=Cyrvm4bl/Jk25Ve/wSjSikfn86dEDfPUqVYH82yZ78OgQPMXm+wzajJoPmBIlOQWw
         PC45X4EJKZnk37AiU1INl2Z0HGoA3lBArmDKYqKoLf+aNfagk65IPE/DZLLpJ6yg57
         Wj/sH6IOrvGZNZ31ITutbVlFhG323EcamjgC8z2PojjZmDr995mkIJZfCoHNn+YfAe
         RbSry4MTBAQEKeASUaoKQB/yAPn/v/YriiNAHsTdC8zVJ1ahCmuJfUcaefCDeWKGSg
         7yi/PvaJtpsOFtkcK66GtbYhEZPfYd47FTsuTOnL86LylyHKSwUqpZC6GkYAACc1Rx
         BViYSFSjbhpmw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11
Date:   Tue, 30 May 2023 05:19:09 +0300
Message-Id: <20230530021909.242012-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Further restrict with DMI_PRODUCT_VERSION.

Link: https://lore.kernel.org/linux-integrity/20230517122931.22385-1-peter.ujfalusi@linux.intel.com/
Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
I do not believe that this necessarily needs to be backported but please
shout, if I'm wrong.
 drivers/char/tpm/tpm_tis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..9cb4e81fc548 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -143,6 +143,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
 		},
 	},
 	{}
-- 
2.39.2

