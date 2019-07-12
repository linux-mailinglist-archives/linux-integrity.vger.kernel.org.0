Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27966BC8
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfGLLuD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 07:50:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfGLLuD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 07:50:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MxE1Q-1iexWi2oo4-00xaTo; Fri, 12 Jul 2019 13:49:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fTPM: fix PTR_ERR() usage
Date:   Fri, 12 Jul 2019 13:49:35 +0200
Message-Id: <20190712114951.912328-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y4aWHaGBUu1LQNUgr6qeqziguqIEOIocdFZ3G+ST42Un1whZss6
 su3C9oznzzFoKCV8L855WlFnPznQGg0abqUSozCYu8Am63w7UDzZ1FEWvsznjsgf5V5mbQF
 OEw38h46frWJgcFGMWLg7X4vDGr2LLfyxXX4H4i9ywKDwaJC0+PrjX+4S1LMp1U5FCHsif7
 NQSY01QKSdacAh/X7KthA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BB8YylfyT6Q=:Zu3NO3Skka7Pns4dz+s4wG
 ORssiD4YiwI0erYpLlnQMekwLTiTFd9BZlydBb3hkhLKAJg0sGCK6WooqivPJfEMT2I7UNp1w
 cXNMgTHwNhL7qbJGei+2kI1P+zyYgpkl4uZ3K8eGXxnK+1oZyvZVXcHuyDP+KuyhapUnpPOyf
 I6f5P3zBtra1B0tkWyhK1a4wzYkHu0d1wVIGaZu0dovys0BKqUmzne4Dnc3aY3+loaxX3t3Ca
 JhwRxMOg0ay7LQopSSsXYMJpNUI3b6F1MkNtGy/abPeoqyxZUm7qENBSzA5PFzDHlYKi4hgc6
 KivVdsWF/O9ATEHFQk5SgIXW2VlnakvsRseaZT8rpXhTNv14Kg6AUFhCZ7qBlC7/H07JihbW0
 i7vESoOfeBWdOLSShDuW7+WkJW3u7/JqabHC/Hwf0G4W09EYLNs+i5tX1GHI51OAR0dg8mK18
 Degc139V/xHuxGhTbWHT5+3sgXIpChv7QZARgcXel0TbbisTL4AVka/4CK7k6Tsuj2m+dRf6J
 6BXSYjJRAlE8t9pu5l9+V9YV9C7e7hRZVaKRQFsxNG0xcorSuBcVcvy/BxBwXYKRW4NU8dDoL
 M3xv7tl8ye17E0IOpD+AWfVbPxyr2Xai8N0kLB4V/Q/VBSLkZUbDWUkEu7f165/9bvABUpvfi
 XgjkMlabbPUK1DvEYJzHgD7gDd/vi6u41WFMhEsdRyfidYTdIFwaQgHpkpDb5iPFHLeBPxT/V
 sSQ3dOa7AO7hNeIAMwqk4vZG6v2ksrRmz3URCA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A last minute change must have confused PTR_ERR() and ERR_PTR():

drivers/char/tpm/tpm_ftpm_tee.c:236:15: error: incompatible pointer to integer conversion passing 'struct tee_context *' to parameter of type 'long' [-Werror,-Wint-conversion]
                if (ERR_PTR(pvt_data->ctx) == -ENOENT)
drivers/char/tpm/tpm_ftpm_tee.c:239:18: error: incompatible pointer to integer conversion passing 'struct tee_context *' to parameter of type 'long' [-Werror,-Wint-conversion]
                return ERR_PTR(pvt_data->ctx);

Fixes: c975c3911cc2 ("fTPM: firmware TPM running in TEE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 74766a4d3280..5679a5af9a96 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -233,10 +233,10 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
 						NULL);
 	if (IS_ERR(pvt_data->ctx)) {
-		if (ERR_PTR(pvt_data->ctx) == -ENOENT)
+		if (PTR_ERR(pvt_data->ctx) == -ENOENT)
 			return -EPROBE_DEFER;
 		dev_err(dev, "%s: tee_client_open_context failed\n", __func__);
-		return ERR_PTR(pvt_data->ctx);
+		return PTR_ERR(pvt_data->ctx);
 	}
 
 	/* Open a session with fTPM TA */
-- 
2.20.0

