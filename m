Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118064F2067
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiDDXqO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiDDXqN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 19:46:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F15B3E8
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 16:44:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d3so6019744wrb.7
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ztaQ1ESX3eg+grHUE/lLkWKyWNOSEHPxB2f7GUJ16bI=;
        b=Ix9sjBTdT+WbHjR0xleKYd65EDk/2s3vdBElZuwy/fNM1BRHLcuPyBNHzoeAQ3/hCM
         ZaOoY8+bXR70Tg0nPIcI53d6rBmWt2O08FY9E3B+sMepZY1/ucJaYzdxr6MI9MI4fGF4
         KcT6Lmw6L5RY5WerN/vKajLsWh7l0LHmZX0hZGSgFkIYqkxiKikLuBpoHenU6PllvMOF
         wjgagidMxrA1jVgNqV8xcvAmejP7F4nuPeY+kmAYcEmzH+8oIWJQ+BnQY6KgwzX29Dm5
         C6ru1HmG/r1iSBvW87/cN6oERf/ceqTdizk/FvUjTfrDlGC4hMcFd1BY+TRiooC5M0ZT
         VPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ztaQ1ESX3eg+grHUE/lLkWKyWNOSEHPxB2f7GUJ16bI=;
        b=rRLI86X/QWOsYVLRGYWV2/QmWSamzZd5MUjXhEWArHThCnAAjzOAofviiWWD0YcUtY
         embarFlR4i1nAeiyzcCR0Xcjg1SY3gZkeEkJOcOv1AX8CeC6pvs+3WY/k64EkIGLMgvC
         EhQHpR95SxXNP6/bUWycU4evl+mGa3QGVBExHlQD8K4DSKkE8qWIHcHwaCgPKqVZVRlO
         LGxJHQowpCYE9jwL2pOCSzM0NZFjdsbD7ZOflTpLxuUjTXxtu8B1CXdBRS/ZAukD6EgO
         iWkEwqMZZBUj4zVRPhxO2Hpl5gFlVkz8/ixU6eg9eDBTBMgUQt/Ry/rj8E9OynrszrmZ
         HwIw==
X-Gm-Message-State: AOAM5317Ugu/5M1L/sFsgUFICw2uehZi/1oSZndZUlNN0m4+6TJAZuVC
        8cPetoShu+ry3U83133ysOUAl1A61gl92KVKqQjOVNS8VBldAg==
X-Google-Smtp-Source: ABdhPJzAvFzJ5KTWCvdRRB3Q0H07W6wPWHUSx4SjeyXDjL9MKOf22e3aoKXfxHZ0wHYzm6UfhMooUq98tBVFE6Ae0gw=
X-Received: by 2002:a5d:410c:0:b0:206:b5c:65c7 with SMTP id
 l12-20020a5d410c000000b002060b5c65c7mr450774wrp.94.1649115765815; Mon, 04 Apr
 2022 16:42:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jes Klinke <jbk@google.com>
Date:   Mon, 4 Apr 2022 16:42:34 -0700
Message-ID: <CANMTAZTAnGDxJri4_rogsW2Ev9tpFTSTBZaEvSNpgmjEUAgwBA@mail.gmail.com>
Subject: [PATCH] drivers/char/tpm: Google TPM, additional DID:VID
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Accept one additional numerical value of DID:VID for Google TPM.

Signed-off-by: Jes B. Klinke <jbk@google.com>

---
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c
b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f6c0affbb4567..e5fb1ecc8fa2e 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,6 +31,7 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS 2 /* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS 20 /* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID 0x00281ae0L /* Device and vendor ID reg value */
+#define TPM_TI50_I2C_DID_VID 0x504a6666L
 #define TPM_CR50_I2C_MAX_RETRIES 3 /* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO 55 /* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI 65 /* Max usecs between retries on I2C */
@@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
  }

  vendor = le32_to_cpup((__le32 *)buf);
- if (vendor != TPM_CR50_I2C_DID_VID) {
- dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
- tpm_cr50_release_locality(chip, true);
- return -ENODEV;
+ if (vendor == TPM_CR50_I2C_DID_VID) {
+ dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+ client->addr, client->irq, vendor >> 16);
+ return tpm_chip_register(chip);
+ }
+ if (vendor == TPM_TI50_I2C_DID_VID) {
+ dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+ client->addr, client->irq, vendor >> 16);
+ return tpm_chip_register(chip);
  }

- dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
- client->addr, client->irq, vendor >> 16);
-
- return tpm_chip_register(chip);
+ dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
+ tpm_cr50_release_locality(chip, true);
+ return -ENODEV;
 }

 /**
