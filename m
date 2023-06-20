Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C952736AF0
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 13:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFTLaH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 07:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTLaG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 07:30:06 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 04:30:03 PDT
Received: from mx1.bezdeka.de (mx1.bezdeka.de [IPv6:2a03:4000:3f:1f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EAAFE;
        Tue, 20 Jun 2023 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bezdeka.de;
        s=mail201812; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
        :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/HI0tDVAbkWJsDatF0WxkEQiTSqiG5w9ZKyO7AztVww=; b=bP8UsipdpSmRTTOyy+/IwfsR5x
        O/B1q+XtVRhNzI3XnxOZUJPhss91PJ1YKww66Bw4KSUmBMXu2Cmhgv+B8+Km4GvmcSEV+OHYJ/nbF
        043eH0p9vLJbLa6saJwVQdL4GNpSJhhWls+TYgqeqfjPdd7nlFJpMQW53+IV6z8bghdt4zcamI6Px
        osj3rn5o/oozA64Cm8hXnFlXZOsBDG8e+H9rLnfHkcphB/uOaasJJlHGRKDdK0X5FbBEO8onYw51s
        vwrKt7P8CjdVkBHpwLTI3mymoVbpBFx536Ozd+a0aShNgL7Oz/p6nWNAGjcR5Q044L6CmlRjR/dl5
        e4Yl33Dg==;
Received: from [2a02:810d:8780:7fc:9af2:491:cdda:af5f] (helo=localhost)
        by smtp.bezdeka.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <florian@bezdeka.de>)
        id 1qBZGY-00GpvU-16;
        Tue, 20 Jun 2023 13:11:18 +0200
From:   Florian Bezdeka <florian@bezdeka.de>
Date:   Tue, 20 Jun 2023 13:11:01 +0200
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo L590 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-flo-lenovo-l590-tpm-fix-v1-1-16032a8b5a1d@bezdeka.de>
X-B4-Tracking: v=1; b=H4sIAESJkWQC/x2NwQqDMBBEf0X23IWY1kj9ldLDxq66kG4ksVIQ/
 71LT8Mb5jEHVC7CFYbmgMK7VMlq0F4aGBfSmVFexuCdv7rgHU4pY2LNu0V3d7itb5zkizfiGIh
 8F0IPZkeqjLGQjov5+knJyrWwbf93j+d5/gDJ/eg7fgAAAA==
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Bezdeka <florian@bezdeka.de>
X-Mailer: b4 0.12.2
X-Authenticated-User: florian@bezdeka.de
X-Authenticator: plain
X-Invalid-HELO: HELO is no FQDN (contains no dot) (See RFC2821 4.1.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Lenovo L590 suffers from an irq storm issue like the T490, T490s
and P360 Tiny, so add an entry for it to tpm_tis_dmi_table and force
polling.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2214069#c0
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Florian Bezdeka <florian@bezdeka.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..2771abb5628f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -138,6 +138,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad L590",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "UPX-TGL",

---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230620-flo-lenovo-l590-tpm-fix-4aeb6aa25667

Best regards,
-- 
Florian Bezdeka <florian@bezdeka.de>

