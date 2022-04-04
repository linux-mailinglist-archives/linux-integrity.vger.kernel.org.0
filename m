Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD14F2012
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 01:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiDDXPm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 19:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243570AbiDDXPg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 19:15:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C8D9
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 16:00:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso505190wml.5
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5Ofcs9Zs/jnnaqkLbH027xhrrtdyvQ/RD7B+639ROK8=;
        b=rODoxbl7Ndt3ifD2BBvrCiQyG+R1J5MS4zdRatlR+4YDO48A4PkHmib6mCSJ7R8TIi
         q7QEStdSIg9IiyewySyFSCzc3j4l9vL1UcMwMac4cdpHGDRBhv7tl+NdjXvjNzy28dXi
         PuUI5biGHGcjphXP65CxPkOP2GhIM5QoXPwk6AFixY+xYYPY1ruODM7TipNf6jOgt3wH
         BaMHQXSnNhH/gvcsD2atDAlStNPs651+lp/LdI1bJwoUs9drb1qpnC0FiDRzdubhJbTb
         8+IALEJxS5lqC+XgvS4Z9FAXFfxkQ6llyOtE8raeOLTTgYr08PsfMgpgssQw5JY86uFH
         68GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5Ofcs9Zs/jnnaqkLbH027xhrrtdyvQ/RD7B+639ROK8=;
        b=M4/x/m1L0s8zWs612lusiPmUi9eucFkZXfrH/0yCpMtGbA5P7sC3+UljxJ6d3A5z9j
         bzDS3GX59erTuI33EjnEzcX7SGvxL4xOgsL+0KCfU4LbZfUtTBWrymkYa7sU+zUhszJm
         pg+ghY1nD/ye+cHy3/r/cebINlnRVsT+z88Vh+HHO9xnQmXu9RCs3EkJSgS2vbTFq9PA
         dLdui6c9uKXndl+F0DpYSNVcXfQNjX3V9Gr0AQnEnquy1OYvXmqnOxZst9seUBibRsxF
         qLsbThCxfk+Bejozq3RSXGEztVd0tuMxqLdCGSlOmRMDuiM6g5aDVF4H2APVHIU/NU9A
         SU6Q==
X-Gm-Message-State: AOAM533Mb0WR/372AYhTYSRJBLzM8j7o3FDkfijv24yCD/b2lifpY+Dj
        BHvU24k9lihW3QEUO8odgYmV4Hg+wd3NsPX1xnHGz9vxhIHQAw==
X-Google-Smtp-Source: ABdhPJzAkwW7twHnv0FHSWULoUbb4vqYwvnVHVY5l98NrkFg5YLW8uN/krWZkiK04NPWHrMzQSyXlC9Dt7k8zrEAcLg=
X-Received: by 2002:a05:600c:1797:b0:38e:70fa:4e4f with SMTP id
 x23-20020a05600c179700b0038e70fa4e4fmr361123wmo.30.1649113243046; Mon, 04 Apr
 2022 16:00:43 -0700 (PDT)
MIME-Version: 1.0
From:   Jes Klinke <jbk@google.com>
Date:   Mon, 4 Apr 2022 16:00:31 -0700
Message-ID: <CANMTAZSQgokaG7ZaqipcR56yzOK7iDq50P0_GKd-H7nxUX3TzQ@mail.gmail.com>
Subject: PATCH: Google security chip, additional DID:VID
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     linux-integrity@vger.kernel.org
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

Hello Peter,

I am a firmware engineer working on the TPM chip in Chromebooks (known
as cr50).  As we plan to deploy a new codebase on our TPM chips, we
will have them present a new DID:VID value, but otherwise follow the
same protocol as the existing implementations.

The below patch has the effect of accepting one additional numerical
value, and logging one of two messages, depending on the value.
Unfortunately, I had to reverse the indentation, so the diff appears
to touch more lines than it needed to do.

I am unsure which procedure to follow, as this is my first kernel
patch.  Let me know if posting the patch inline like this is not the
way to go.

Regards
Jes Bodi Klinke

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c
b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f6c0affbb4567..e5fb1ecc8fa2e 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,6 +31,7 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS 2 /* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS 20 /* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID 0x00281ae0L /* Device and vendor ID reg value */
+#define TPM_TI50_I2C_DID_VID 0x504a6666L /* Device and vendor ID reg value */
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
