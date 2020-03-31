Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B556719959C
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgCaLqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 07:46:45 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:40892 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgCaLqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 07:46:23 -0400
Received: from NTHCCAS01.nuvoton.com (nthccas01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 4EB451C80E2C;
        Tue, 31 Mar 2020 19:34:53 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar 2020
 19:34:52 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar
 2020 14:34:50 +0300
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Tue, 31 Mar 2020 14:34:50 +0300
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id 3F480250;
        Tue, 31 Mar 2020 14:34:50 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 2FE8B639AF; Tue, 31 Mar 2020 14:34:20 +0300 (IDT)
From:   <amirmizi6@gmail.com>
To:     <Eyal.Cohen@nuvoton.com>, <jarkko.sakkinen@linux.intel.com>,
        <oshrialkoby85@gmail.com>, <alexander.steffen@infineon.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <oshri.alkoby@nuvoton.com>,
        <tmaimon77@gmail.com>, <gcwilson@us.ibm.com>,
        <kgoldman@us.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>, <shmulik.hager@nuvoton.com>,
        <amir.mizinski@nuvoton.com>, Amir Mizinski <amirmizi6@gmail.com>,
        Christophe Richard <hristophe-h.ricard@st.com>
Subject: [PATCH v4 2/7] tpm: tpm_tis: Add check_data handle to tpm_tis_phy_ops in order to check data integrity
Date:   Tue, 31 Mar 2020 14:32:02 +0300
Message-ID: <20200331113207.107080-3-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200331113207.107080-1-amirmizi6@gmail.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

In order to compute the crc over the data sent in lower layer
 (I2C for instance), tpm_tis_check_data() calls an operation (if available)
 to check data integrity. If data integrity cannot be verified, a retry
 attempt to save the sent/received data is implemented.

The current steps are done when sending a command:
    1. Host writes to TPM_STS.commandReady.
    2. Host writes command.
    3. Host checks that TPM received data is valid.
    4. If data is currupted go to step 1.

When receiving data:
    1. Host checks that TPM_STS.dataAvail is set.
    2. Host saves received data.
    3. Host checks that received data is correct.
    4. If data is currupted Host writes to TPM_STS.responseRetry and go to
        step 1.

Co-developed-by: Christophe Richard <hristophe-h.ricard@st.com>
Signed-off-by: Christophe Richard <hristophe-h.ricard@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 102 +++++++++++++++++++++++++---------------
 drivers/char/tpm/tpm_tis_core.h |   3 ++
 2 files changed, 67 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 27c6ca0..6c4f232 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -242,6 +242,15 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
        return status;
 }

+static bool tpm_tis_check_data(struct tpm_chip *chip, const u8 *buf, size_t len)
+{
+       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+
+       if (priv->phy_ops->check_data)
+               return priv->phy_ops->check_data(priv, buf, len);
+       return true;
+}
+
 static void tpm_tis_ready(struct tpm_chip *chip)
 {
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
@@ -308,47 +317,59 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
        int size = 0;
-       int status;
+       int status, i;
        u32 expected;
+       bool check_data = false;

-       if (count < TPM_HEADER_SIZE) {
-               size = -EIO;
-               goto out;
-       }
+       for (i = 0; i < TPM_RETRY; i++) {
+               if (count < TPM_HEADER_SIZE) {
+                       size = -EIO;
+                       goto out;
+               }

-       size = recv_data(chip, buf, TPM_HEADER_SIZE);
-       /* read first 10 bytes, including tag, paramsize, and result */
-       if (size < TPM_HEADER_SIZE) {
-               dev_err(&chip->dev, "Unable to read header\n");
-               goto out;
-       }
+               size = recv_data(chip, buf, TPM_HEADER_SIZE);
+               /* read first 10 bytes, including tag, paramsize, and result */
+               if (size < TPM_HEADER_SIZE) {
+                       dev_err(&chip->dev, "Unable to read header\n");
+                       goto out;
+               }

-       expected = be32_to_cpu(*(__be32 *) (buf + 2));
-       if (expected > count || expected < TPM_HEADER_SIZE) {
-               size = -EIO;
-               goto out;
-       }
+               expected = be32_to_cpu(*(__be32 *) (buf + 2));
+               if (expected > count || expected < TPM_HEADER_SIZE) {
+                       size = -EIO;
+                       goto out;
+               }

-       size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-                         expected - TPM_HEADER_SIZE);
-       if (size < expected) {
-               dev_err(&chip->dev, "Unable to read remainder of result\n");
-               size = -ETIME;
-               goto out;
-       }
+               size += recv_data(chip, &buf[TPM_HEADER_SIZE],
+                                 expected - TPM_HEADER_SIZE);
+               if (size < expected) {
+                       dev_err(&chip->dev, "Unable to read remainder of result\n");
+                       size = -ETIME;
+                       goto out;
+               }

-       if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-                               &priv->int_queue, false) < 0) {
-               size = -ETIME;
-               goto out;
+               if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+                                     &priv->int_queue, false) < 0) {
+                       size = -ETIME;
+                       goto out;
+               }
+
+               status = tpm_tis_status(chip);
+               if (status & TPM_STS_DATA_AVAIL) {      /* retry? */
+                       dev_err(&chip->dev, "Error left over data\n");
+                       size = -EIO;
+                       goto out;
+               }
+
+               check_data = tpm_tis_check_data(chip, buf, size);
+               if (!check_data)
+                       tpm_tis_write8(priv, TPM_STS(priv->locality),
+                                      TPM_STS_RESPONSE_RETRY);
+               else
+                       break;
        }
-       status = tpm_tis_status(chip);
-       if (status & TPM_STS_DATA_AVAIL) {      /* retry? */
-               dev_err(&chip->dev, "Error left over data\n");
+       if (!check_data)
                size = -EIO;
-               goto out;
-       }
-
 out:
        tpm_tis_ready(chip);
        return size;
@@ -453,14 +474,19 @@ static void disable_interrupts(struct tpm_chip *chip)
 static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
        struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-       int rc;
+       int rc, i;
        u32 ordinal;
        unsigned long dur;
+       bool data_valid = false;

-       rc = tpm_tis_send_data(chip, buf, len);
-       if (rc < 0)
-               return rc;
-
+       for (i = 0; i < TPM_RETRY && !data_valid; i++) {
+               rc = tpm_tis_send_data(chip, buf, len);
+               if (rc < 0)
+                       return rc;
+               data_valid = tpm_tis_check_data(chip, buf, len);
+       }
+       if (!data_valid)
+               return -EIO;
        /* go and do it */
        rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
        if (rc < 0)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index d06c65b..486c2e9 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -34,6 +34,7 @@ enum tis_status {
        TPM_STS_GO = 0x20,
        TPM_STS_DATA_AVAIL = 0x10,
        TPM_STS_DATA_EXPECT = 0x08,
+       TPM_STS_RESPONSE_RETRY = 0x02,
 };

 enum tis_int_flags {
@@ -106,6 +107,8 @@ struct tpm_tis_phy_ops {
        int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
        int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
        int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+       bool (*check_data)(struct tpm_tis_data *data, const u8 *buf,
+                          size_t len);
 };

 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
--
2.7.4



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
