Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419085B6A5E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIMJKt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiIMJKs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 05:10:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9CB57890;
        Tue, 13 Sep 2022 02:10:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so14946184pja.5;
        Tue, 13 Sep 2022 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fmTTNMO6nsNe3wwRALCsW2vgWT26jAViSTGEkQkN2xQ=;
        b=EssyJK6fB0axPke6T/p2C87jv/sbiRJHoG4x/dQN6+jfPRmKpLaEVPmPJi+unkfh6k
         wsetk8D4aeMRuFu9sPhjw0hQaWPficm+2owXUmNXAQgqT6ZuwKat94c8MFK54xy8Rt9u
         Z33pfb6IO4diwG/nA4yVOkeorrRC9ogoYXIStxpS2Mr/weWRysl0Fn7ZgUZMgqKUIpV3
         EV1Gv5B89rEP7oul9rG14R/Prndtw/svOyfwVUrg1+3JdVXgEtNcCvJOYH1zed0lxs52
         ljUYZlz0sHAKTiDBCsFV93BapwlxhDvMbRBTdjsBNNuC7vVRl+A9SKaa6ybUELgfz5gn
         +qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fmTTNMO6nsNe3wwRALCsW2vgWT26jAViSTGEkQkN2xQ=;
        b=mr+0yL9go5fow8/pAgdzBbh0tLqdLKHswrw10Eyg4J0FiPhTXbOLr8O4qVfXp9Dgzn
         88FiqyEV1+WnJ99yd44yNk8oRWxESzdu3su+4TCRi0r9k2XhRhMMpC+/VhAJ/6rNelAK
         66dSGG6YMOBWC87EtZ2IEzMovj40wnUqM7i/wuq7mRwa95D+1yTWUUGelud6KMQvJv6m
         yuTQvlqT7lEVBM2cmtgSYBarL533O/mUFWt19zRqAYw5JEdNlGGJim/YHgPwSMMshflb
         SUYbOzeohHnP1CHP6SGNa65gk0U/rPzpUvo9Ab8RFC0AFbPqyNJIvSLjiDyoCg5BcL9L
         7ADA==
X-Gm-Message-State: ACgBeo3cebE6hJ8CU5VXh4Xcv4SiYIoFR3Ytzlxn548KEz3TGbG8Lql4
        DJwf+EyfpTAejwA+sJQrh0c=
X-Google-Smtp-Source: AA6agR43iKPyWbCNjo8QDkPPZS91dQUTqq08M32ENbNk1z73i0He52m8DNdf1aE0cIL/jbK5VYyJMQ==
X-Received: by 2002:a17:90b:4c4e:b0:202:fd53:7acd with SMTP id np14-20020a17090b4c4e00b00202fd537acdmr1413111pjb.98.1663060246366;
        Tue, 13 Sep 2022 02:10:46 -0700 (PDT)
Received: from voyager.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm6801668pju.19.2022.09.13.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:10:45 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: [PATCH 2/2] tpm: tis-i2c: Add more compatible strings
Date:   Tue, 13 Sep 2022 18:40:24 +0930
Message-Id: <20220913091025.1768882-3-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913091025.1768882-1-joel@jms.id.au>
References: <20220913091025.1768882-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.

https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/

Add a compatible string for it, and the generic compatible.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/char/tpm/tpm_tis_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 0692510dfcab..4af27b7ec5b1 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
-- 
2.35.1

