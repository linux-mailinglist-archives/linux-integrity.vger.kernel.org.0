Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF220A145
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405543AbgFYOwh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 10:52:37 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51475 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405525AbgFYOwh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 10:52:37 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 05PElmIh015285;
        Thu, 25 Jun 2020 17:47:49 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id F26EC639BE; Thu, 25 Jun 2020 17:47:48 +0300 (IDT)
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
Subject: [PATCH v12 4/9] tpm: tpm_tis: Add verify_data_integrity handle to tpm_tis_phy_ops
Date:   Thu, 25 Jun 2020 17:46:44 +0300
Message-Id: <20200625144650.269719-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200625144650.269719-1-amirmizi6@gmail.com>
References: <20200625144650.269719-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

When using I2C bus protocol, the TPM has the ability to report data
integrity on incoming or outgoing command parameter bytes.
According to the TCG specs, if this data validation functionality is
enabled via the TPM_DATA_CSUM_ENABLE register, the TPM will update the
TPM_DATA_CSUM register after reception of the last command byte and after
the last response byte has been read.

Data integrity is checked if a "verify_data_integrity" handle is defined in
"tpm_tis_phy_ops".

Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
 drivers/char/tpm/tpm_tis_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e136467..347c020 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -347,6 +347,13 @@ static int __tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return size;
 	}
 
+	if (priv->phy_ops->verify_data_integrity)
+		if (!priv->phy_ops->verify_data_integrity(priv, buf,
+							  size)) {
+			size = -EIO;
+			return size;
+		}
+
 	return size;
 }
 
@@ -419,6 +426,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		return rc;
 	}
 
+	if (priv->phy_ops->verify_data_integrity) {
+		if (!priv->phy_ops->verify_data_integrity(priv, buf, len)) {
+			rc = -EIO;
+			return rc;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6cc6b76..cd97c01 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -107,6 +107,8 @@ struct tpm_tis_phy_ops {
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+	bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
+				      size_t len);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
-- 
2.7.4

