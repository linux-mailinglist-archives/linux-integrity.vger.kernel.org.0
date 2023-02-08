Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA968F879
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBHT7C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Feb 2023 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBHT7B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Feb 2023 14:59:01 -0500
Received: from mail-vs1-xe64.google.com (mail-vs1-xe64.google.com [IPv6:2607:f8b0:4864:20::e64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1B1E1F6
        for <linux-integrity@vger.kernel.org>; Wed,  8 Feb 2023 11:58:59 -0800 (PST)
Received: by mail-vs1-xe64.google.com with SMTP id k6so21182641vsk.1
        for <linux-integrity@vger.kernel.org>; Wed, 08 Feb 2023 11:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6dbcpWxEXf8dlXMOfPHjkk2bJFz15jMyyAAYkmC0KQ=;
        b=UpttiACPybvs6l9/FVwshO1wpC1HIBARzopP4EQO11pyFb+dx44pE0bcwHsG9/4sFi
         s2sQ8xgHOnAfZeaI73//XitgYJGwt7Ka4ogcZt50gm1wSUy91wHlOG/2Yufvo+svJ29U
         V10XPsredAwjpTxmDiasUXHG1xCdgre1hBPj8NhkTF6sErrCrrGpSy0zLxe7TBC5Z+k9
         YLoWxgarD65vAJ9ZwdBLmo8WOmZzh4RIAYnRDTeOSkhFDH0KFHBIYEkPnIGqzOh5oWYg
         BBNyzEev+ZsKKYa8FdnfG8sK32DMdeQAPtkee0Gz5qCrsk8kBpyra1FeXOXGIPLdWCXr
         iP/g==
X-Gm-Message-State: AO0yUKVygp1Gxps1NpEKsRb/wjocWgTTtBqkMVaCYnY4Vvd4jpcEg+ZQ
        q1wTU7D81XLH0qYfv1V7ImgjW/ZII2n4joi2cSyC52qq4OzK
X-Google-Smtp-Source: AK7set+2icUkUuaKchV6Xh8RcAHuienkj5xPVyXERliPCGJ+X9BRoFcYwQ9C9iAMpWYuLXmZu7tGM5s6gKj4
X-Received: by 2002:a67:d711:0:b0:3ef:4402:6b8b with SMTP id p17-20020a67d711000000b003ef44026b8bmr2000232vsj.14.1675886338598;
        Wed, 08 Feb 2023 11:58:58 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.10])
        by smtp-relay.gmail.com with ESMTPS id e7-20020a0561020dc700b003d3dd0b55besm1068506vst.1.2023.02.08.11.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2023 11:58:58 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us170.sjc.aristanetworks.com (us170.sjc.aristanetworks.com [10.243.120.5])
        by smtp.aristanetworks.com (Postfix) with ESMTP id A32CB4136D7;
        Wed,  8 Feb 2023 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1675886337;
        bh=Z6dbcpWxEXf8dlXMOfPHjkk2bJFz15jMyyAAYkmC0KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=M74upJJKBNl983jr86UUrc/WT0138hJycEBUrZOGXuJ+ncVqdl+G4msM5NFSEF0nF
         w3oZwWcluOnf7dE8kIzHe4jD4YXbG/dLANPisK8tB+tqEOMDKSTSxg7Hh8O/a0aB3N
         b2wWWmLtGltRhgjeRRxiq3EQ8jqziN3wyS4XKILdThtVsw6wJnPeJpga843WZ/VAsb
         v6pccQgthFtnHxLuhXUHFmpzeJyOf15QLUxRzB69iBUytqssFOsTVhimu62fL9qEcK
         eFuUMKnpJIL0LRIbSHjPB4h1hF79/tquaLdQPLCxY2kCLXWmt1UuxTjKnmlbjgDUg0
         V4OyYKBXvh8ww==
From:   Julien Gomes <julien@arista.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, jarkko@kernel.org, peterhuewe@gmx.de
Cc:     julien@arista.com
Subject: [PATCH] tpm: add vendor flag to command code validation
Date:   Wed,  8 Feb 2023 11:58:36 -0800
Message-Id: <20230208195836.30175-1-julien@arista.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some TPM 2.0 devices have support for additional commands which are not
part of the TPM 2.0 specifications.
These commands are identified with bit 29 of the 32 bits command codes.
Contrarily to other fields of the TPMA_CC spec structure used to list
available commands, the Vendor flag also has to be present in the
command code itself (TPM_CC) when called.

Add this flag to tpm_find_cc() mask to prevent blocking vendor command
codes that can actually be supported by the underlying TPM device.

Signed-off-by: Julien Gomes <julien@arista.com>
---
 drivers/char/tpm/tpm2-cmd.c | 4 +++-
 include/linux/tpm.h         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 65d03867e114..93545be190a5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -777,10 +777,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 {
+	u32 cc_mask;
 	int i;
 
+	cc_mask = 1 << TPM2_CC_ATTR_VENDOR | GENMASK(15, 0);
 	for (i = 0; i < chip->nr_commands; i++)
-		if (cc == (chip->cc_attrs_tbl[i] & GENMASK(15, 0)))
+		if (cc == (chip->cc_attrs_tbl[i] & cc_mask))
 			return i;
 
 	return -1;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dfeb25a0362d..4dc97b9f65fb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -265,6 +265,7 @@ enum tpm2_startup_types {
 enum tpm2_cc_attrs {
 	TPM2_CC_ATTR_CHANDLES	= 25,
 	TPM2_CC_ATTR_RHANDLE	= 28,
+	TPM2_CC_ATTR_VENDOR	= 29,
 };
 
 #define TPM_VID_INTEL    0x8086
-- 
2.39.1

