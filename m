Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33616C0BBB
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 09:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCTIGb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCTIG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 04:06:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED0149BA
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 01:06:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-00068d-PN; Mon, 20 Mar 2023 09:06:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX2-005PK2-Ik; Mon, 20 Mar 2023 09:06:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX1-006OCm-Ib; Mon, 20 Mar 2023 09:06:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/3] tpm: Convert to platform remove callback returning void
Date:   Mon, 20 Mar 2023 09:06:04 +0100
Message-Id: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RXVsrQ50O6Eb9+hW0DA/De0kWuV6Ne68t5TSRbXJqNU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGBPYHi8HilsGTfajA41Dzo3b9SauK19wOLrNM NzkZWklnDSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBgT2AAKCRCPgPtYfRL+ Tlb4CACuZT9CThvJKg/3K/HIWMAhmUqW9jC6uvkSmhO1XMy9shCT3YfuLMGH/MI6onF9/DOTHJv OEN5LzA4Nw1ArNBxL9IkU3SD58yaVxE/zAHQDVDUzclNxOK4ccB2o1fAgJJ8+G0WuhZNNTuIAt7 kcF53MFVqmfBkSkCjy1NsE134tC4yFPbcQ9MSvElSy7mwQdFW7o2/FAbwD9AZCiVDoB6Dv2G8IM 91A8rcjceOonnxfJwqzxSrjlddzpjzcySFs+BF53W6LO7UDo59JS8iRPJmQm5Ee31helQiz3USj 67CkpqYDBOfhsXz6ehJHZWyyNZ4jsZ+1PwyQU0pjSNna48Bl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

this series adapts the platform drivers below drivers/char/tpm to use the
.remove_new() callback. Compared to the traditional .remove() callback
.remove_new() returns no value. This is a good thing because the driver core
doesn't (and cannot) cope for errors during remove. The only effect of a
non-zero return value in .remove() is that the driver core emits a warning. The
device is removed anyhow and an early return from .remove() usually yields a
resource leak.

The drivers converted here returned zero in their remove callback, to the
transformation was easy.

Best regards
Uwe

Uwe Kleine-König (3):
  tpm/tpm_ftpm_tee: Convert to platform remove callback returning void
  tpm/tpm_tis: Convert to platform remove callback returning void
  tpm/tpm_tis_synquacer: Convert to platform remove callback returning
    void

 drivers/char/tpm/tpm_ftpm_tee.c      | 6 +++---
 drivers/char/tpm/tpm_tis.c           | 6 ++----
 drivers/char/tpm/tpm_tis_synquacer.c | 6 ++----
 3 files changed, 7 insertions(+), 11 deletions(-)

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

