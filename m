Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AF61EE5A8
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgFDNsZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 09:48:25 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:50224 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728680AbgFDNsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 09:48:24 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 054DluOu011526;
        Thu, 4 Jun 2020 16:47:56 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 7490E639BF; Thu,  4 Jun 2020 16:47:56 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org,
        "benoit.houyere@st.com--to=mark.rutland"@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>,
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: [PATCH v10 3/8] tpm: tpm_tis: Add retry in case of protocol failure or data integrity (on I2C only) failure.
Date:   Thu,  4 Jun 2020 16:47:08 +0300
Message-Id: <20200604134713.157951-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200604134713.157951-1-amirmizi6@gmail.com>
References: <20200604134713.157951-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

The FIFO protocol described in the TCG PC Client Device Driver Design
Principles for TPM 2.0 advises retrying sending a command or receiving
a response using the FIFO protocol in case of any error in the protocol.

Add a retry mechanism on any protocol error. In addition, in case of a data
integrity issue in the I2C bus protocol, check after sending a command
completion or receiving a response from the TPM.

Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 106 ++++++++++++++++++++++++----------------
 drivers/char/tpm/tpm_tis_core.h |   3 ++
 2 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6ea70ea..202714d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -308,7 +308,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
-	int status;
+	int status, i;
 	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
@@ -316,39 +316,53 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size = recv_data(chip, buf, TPM_HEADER_SIZE);
-	/* read first 10 bytes, including tag, paramsize, and result */
-	if (size < TPM_HEADER_SIZE) {
-		dev_err(&chip->dev, "Unable to read header\n");
-		goto out;
-	}
+	for (i = 0; i < TPM_RETRY; i++) {
+		size = recv_data(chip, buf, TPM_HEADER_SIZE);
+		/* read first 10 bytes, including tag, paramsize, and result */
+		if (size < TPM_HEADER_SIZE) {
+			dev_err(&chip->dev, "Unable to read header\n");
+			goto retry;
+		}
 
-	expected = be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count || expected < TPM_HEADER_SIZE) {
-		size = -EIO;
-		goto out;
-	}
+		expected = be32_to_cpu(*(__be32 *) (buf + 2));
+		if (expected > count || expected < TPM_HEADER_SIZE) {
+			size = -EIO;
+			goto retry;
+		}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
-	if (size < expected) {
-		dev_err(&chip->dev, "Unable to read remainder of result\n");
-		size = -ETIME;
-		goto out;
-	}
+		size += recv_data(chip, &buf[TPM_HEADER_SIZE],
+				  expected - TPM_HEADER_SIZE);
+		if (size < expected) {
+			dev_err(&chip->dev, "Unable to read remainder of result\n");
+			size = -ETIME;
+			goto retry;
+		}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
-			      chip->timeout_c, &priv->int_queue, false) < 0) {
-		size = -ETIME;
-		goto out;
-	}
-	status = tpm_tis_status(chip);
-	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
-		dev_err(&chip->dev, "Error left over data\n");
-		size = -EIO;
-		goto out;
-	}
+		if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
+				      chip->timeout_c, &priv->int_queue,
+				      false) < 0) {
+			size = -ETIME;
+			goto retry;
+		}
+
+		status = tpm_tis_status(chip);
+		if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
+			dev_err(&chip->dev, "Error left over data\n");
+			size = -EIO;
+			goto retry;
+		}
 
+		if (priv->phy_ops->verify_data_integrity)
+			if (!priv->phy_ops->verify_data_integrity(priv, buf,
+								  size))
+				size = -EIO;
+retry:
+		if (size <= 0)
+			tpm_tis_write8(priv, TPM_STS(priv->locality),
+				       TPM_STS_RESPONSE_RETRY);
+		else
+			goto out;
+	}
 out:
 	tpm_tis_ready(chip);
 	return size;
@@ -372,7 +386,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 				      TPM_STS_COMMAND_READY, chip->timeout_b,
 				      &priv->int_queue, false) < 0) {
 			rc = -ETIME;
-			goto out_err;
+			return rc;
 		}
 	}
 
@@ -381,13 +395,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (burstcnt < 0) {
 			dev_err(&chip->dev, "Unable to read burstcount\n");
 			rc = burstcnt;
-			goto out_err;
+			return rc;
 		}
 		burstcnt = min_t(int, burstcnt, len - count);
 		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
-			goto out_err;
+			return rc;
 
 		count += burstcnt;
 	}
@@ -395,14 +409,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 			      TPM_STS_VALID, chip->timeout_a, &priv->int_queue,
 			      false) < 0) {
 		rc = -ETIME;
-		goto out_err;
+		return rc;
 	}
 
 	return 0;
-
-out_err:
-	tpm_tis_ready(chip);
-	return rc;
 }
 
 static void disable_interrupts(struct tpm_chip *chip)
@@ -431,13 +441,25 @@ static void disable_interrupts(struct tpm_chip *chip)
 static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int rc;
+	int rc, i;
 	u32 ordinal;
 	unsigned long dur;
 
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	for (i = 0; i < TPM_RETRY; i++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc < 0)
+			continue;
+		if (priv->phy_ops->verify_data_integrity) {
+			if (!priv->phy_ops->verify_data_integrity(priv, buf,
+								  len)){
+				rc = -EIO;
+				continue;
+			}
+		}
+		break;
+	}
+	if (i == TPM_RETRY)
+		goto out_err;
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index d06c65b..cd97c01 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -34,6 +34,7 @@ enum tis_status {
 	TPM_STS_GO = 0x20,
 	TPM_STS_DATA_AVAIL = 0x10,
 	TPM_STS_DATA_EXPECT = 0x08,
+	TPM_STS_RESPONSE_RETRY = 0x02,
 };
 
 enum tis_int_flags {
@@ -106,6 +107,8 @@ struct tpm_tis_phy_ops {
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+	bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
+				      size_t len);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
-- 
2.7.4

