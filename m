Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF88120016
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 09:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLPIne (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 03:43:34 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfLPIne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 03:43:34 -0500
Received: from orion.localdomain ([77.2.44.177]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2jO8-1hiOOQ3fYa-0137DZ; Mon, 16 Dec 2019 09:43:02 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] drivers: char: tpm: remove unneeded MODULE_VERSION() usage
Date:   Mon, 16 Dec 2019 09:42:30 +0100
Message-Id: <20191216084230.31412-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:ZRMRCvGtq21lbtgskvbS5prFUgst+5RwJZEQW66QiN+qjkuMlBc
 uGZLISeYLgQ9heOIGqmejXQW6EJ1Yj9dlSn4uQwVBS1GCATDsnRMdpuN2L0Y/QUQihyF0/5
 Py17FBwzilsZjijPn/vtG8iHe13gTG4QALNK+LcHtpbLNoRNZbWECYtzyjqi0Lcjg6loX+I
 NHKQcxcT7bFsh1zJN5JKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vjz3eEF+RtM=:F0xI2+yKDrF/uAcYVylI+4
 ahqQZRJcfO3yYU1eNu6//nO3A6Ja3NgWdT9Nc0GvRRrlI4wnqJCBw5wuAPKMKaGzyld0IL5St
 J9D92bkdON63U8qjqD1sZkeLSj8Qmc9EhmWtstpsHfeOrVDb7D0V19qwrQNJTwIMlwzfMLe3I
 cJaYKAmHjbNyjk6Q64WnKRg5GFFVlVwZmMyVOckx3/sD2MyJLgBrbqPvEBROBDJJgNDw8nnUe
 kEFF05o6SpkkOjCuZUYVZOL+aD4SaAbmeyn/ZuNesS4j30Qj3XMU89WnQC6r/PT+IZf7wX4iX
 m46zrRlJ1bx49wb/yBxbWbn6JK0F1zK9VZXpJpDLzccyjsVmvGCl9vWVZXEduyj94+mjCzT31
 jYOzPuGa8V5aOcBXAb0zpReZwFAt2IC4tB3byXiP7g7wUWhVuRTpVEBiUl4patVJzzpwRy0hk
 c5wllrnS1XY9Nq04xi6kK/2Qw/XzoKPKpydCQ8jW8ej2lhJCxpZEHtkTGxbQl5VW3LqPtnuZv
 VZqUp/x+JicXB9T8BVb9Nzf2Oj3NONihS5xbJI0CCbXIgdB/BQSE1D1nVZOy2WZgWcwY2yFno
 VQscnZT3NyJo4ev9PifZVok1856aobhigBtC0lyS1au2onN2P0dvdCdz+Z6hVY0hD0jir/F21
 /9q3/Oao7UyStGt3D4DJz3oDlX/pf0In9Iasp4HBcLtEUkqgqR6U754W+XX+Tf/cyG2JjB9qA
 KRvyBWA7jdZAyv6MJdsjja897fr69VHC02t1JPSbZUQO+kkOAVdWg3ZaM/uAXmXMxUvMa8Szn
 msY6NWOyGD9r64v0G6KPQeiLMug3ZEqarR12hTPzvc7w306zwmigf+dX8vM4f9re/a8GbP5UN
 gFgHs04gu0r0wfJ2MTnA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove MODULE_VERSION(), as it isn't needed at all: the only version
making sense is the kernel version.

See also: https://lkml.org/lkml/2017/11/22/480

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/char/tpm/st33zp24/i2c.c      | 1 -
 drivers/char/tpm/st33zp24/spi.c      | 1 -
 drivers/char/tpm/st33zp24/st33zp24.c | 1 -
 drivers/char/tpm/tpm-interface.c     | 1 -
 drivers/char/tpm/tpm_atmel.c         | 1 -
 drivers/char/tpm/tpm_crb.c           | 1 -
 drivers/char/tpm/tpm_i2c_infineon.c  | 1 -
 drivers/char/tpm/tpm_ibmvtpm.c       | 1 -
 drivers/char/tpm/tpm_infineon.c      | 1 -
 drivers/char/tpm/tpm_nsc.c           | 1 -
 drivers/char/tpm/tpm_tis.c           | 1 -
 drivers/char/tpm/tpm_tis_core.c      | 1 -
 drivers/char/tpm/tpm_vtpm_proxy.c    | 1 -
 13 files changed, 13 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 35333b65acd1..71df056f14c9 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -313,5 +313,4 @@ module_i2c_driver(st33zp24_i2c_driver);
 
 MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
 MODULE_DESCRIPTION("STM TPM 1.2 I2C ST33 Driver");
-MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 26e09de50f1e..94ceced4d57d 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -430,5 +430,4 @@ module_spi_driver(st33zp24_spi_driver);
 
 MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
 MODULE_DESCRIPTION("STM TPM 1.2 SPI ST33 Driver");
-MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 37bb13f516be..60269b6ac470 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -646,5 +646,4 @@ EXPORT_SYMBOL(st33zp24_pm_resume);
 
 MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
 MODULE_DESCRIPTION("ST33ZP24 TPM 1.2 driver");
-MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a438b1206fcb..91d4584f399d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -514,5 +514,4 @@ module_exit(tpm_exit);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
-MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
index 54a6750a6757..35bf249cc95a 100644
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -231,5 +231,4 @@ module_exit(cleanup_atmel);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
-MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index a9dcf31eadd2..3e72b7b99cce 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -748,5 +748,4 @@ static struct acpi_driver crb_acpi_driver = {
 module_acpi_driver(crb_acpi_driver);
 MODULE_AUTHOR("Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>");
 MODULE_DESCRIPTION("TPM2 Driver");
-MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index a19d32cb4e94..8920b7c19fcb 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -731,5 +731,4 @@ static struct i2c_driver tpm_tis_i2c_driver = {
 module_i2c_driver(tpm_tis_i2c_driver);
 MODULE_AUTHOR("Peter Huewe <peter.huewe@infineon.com>");
 MODULE_DESCRIPTION("TPM TIS I2C Infineon Driver");
-MODULE_VERSION("2.2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 78cc52690177..034d24758915 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -723,5 +723,4 @@ module_exit(ibmvtpm_module_exit);
 
 MODULE_AUTHOR("adlai@us.ibm.com");
 MODULE_DESCRIPTION("IBM vTPM Driver");
-MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 9c924a1440a9..8a58966c5c9b 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -621,5 +621,4 @@ module_pnp_driver(tpm_inf_pnp_driver);
 
 MODULE_AUTHOR("Marcel Selhorst <tpmdd@sirrix.com>");
 MODULE_DESCRIPTION("Driver for Infineon TPM SLD 9630 TT 1.1 / SLB 9635 TT 1.2");
-MODULE_VERSION("1.9.2");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 038701d48351..6ab2fe7e8782 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -412,5 +412,4 @@ module_exit(cleanup_nsc);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
-MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..713773ebff81 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -397,5 +397,4 @@ module_init(init_tis);
 module_exit(cleanup_tis);
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
-MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8af2cee1a762..1aeb11e5fd5b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1150,5 +1150,4 @@ EXPORT_SYMBOL_GPL(tpm_tis_resume);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
-MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 91c772e38bb5..18f14162d1c1 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -729,5 +729,4 @@ module_exit(vtpm_module_exit);
 
 MODULE_AUTHOR("Stefan Berger (stefanb@us.ibm.com)");
 MODULE_DESCRIPTION("vTPM Driver");
-MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
-- 
2.11.0

