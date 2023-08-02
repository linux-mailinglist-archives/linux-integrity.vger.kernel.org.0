Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588176CC9D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Aug 2023 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHBMZ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Aug 2023 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjHBMZ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Aug 2023 08:25:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122722D65;
        Wed,  2 Aug 2023 05:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRBIf57fHGumAXTOeD/YEE5x94foPAx8A64M0DWTzKO51M7gpycitS72fWjAb3MDPuyMEDOgvVQEALrRVPRIpoJ5L4DWsUVBEFR71QUZ7KclIwBqpLuorMPDK1sjPo8xBYBPJ65LpyJuENC54qSvbxVK3nH1K67DploijLuY7mLkJWvwqdroX0BU0U2+QY5jVwTFa3CEUMSM5ZNGuF+X4jcDXFkKvvrPfnkCSOWQpzso++uXlk0/RfUiCPHlsvH5cKaMYFpzGsLhUYfso7Ua6WU4Z+za1VICkTGrzXrYAptKMI8qdpg/lTYNA3h8PPD/HcePCGtvcTh00wxE3Inylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxh4f7C4ZE2mXFtjzE7h+lMKIgHqxhCemg69PHfcESQ=;
 b=M92RXNS2Lsu4kUYL/pmET7GAzPkZPCcvH/yXWFz5tJRQZBVbQNra8lxqhQWid+wbIAEAiNtlrcPC/zQtRn5enzvVRltcLoBvSM2mxHBdzZdSh2J6YH5bVk5CULKT1mUIrLsr3ZHsS83LHd0Lndt7wfr7To9+zuLpHQx7tPyanevYPA3WSnRryWLBhHDx95CD4RQbFs5rHqbayo/Kbo/7cGxZJjrv99Fb1HqktIfC/5cSChq2D48t0dVpDWnkIZ/KBJMfSsTx3IAzZjjNDb3TaiIT3tXWoZJjbDhH1d1POBxJ55mhh9H3BKNwvtzww8HD2shF2k4K2pfH90IfURoy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxh4f7C4ZE2mXFtjzE7h+lMKIgHqxhCemg69PHfcESQ=;
 b=V6YkmqsDK62QJg9F6/WgHny2BQIrpzUvHcny4vpahjTCiuXbYW0E3KNp4EnJkMaa5xFERVjtM4Oh5fDlDwq0C09xk05VMX8z5obicENLcUyC0VFpG96Sbi1zaiPOeURK/qGuZUWNMRpuA7ogIozIDlkY+gkk/ZyKH8FBHRAE6k8=
Received: from CY8PR10CA0036.namprd10.prod.outlook.com (2603:10b6:930:4b::27)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:25:46 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::27) by CY8PR10CA0036.outlook.office365.com
 (2603:10b6:930:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 12:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 12:25:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 07:25:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <bitlord0xff@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] tpm: Disable RNG for all AMD fTPMs
Date:   Wed, 2 Aug 2023 07:25:33 -0500
Message-ID: <20230802122533.19508-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 536764fd-f2c3-4ba5-a6e1-08db935398e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJmU6rlnDu7YQRA8Pm4pLWCMF2ydx3syMJQTmEXiT8fyD0iolRQ8na/FBiu0vcX+UjcuFvyM8U+10z2ojQJvV9BWmkuCk+sf73C262R/GFN7w7/Uy4s+rTAde0s4NZ0co8F4weIOzvFQF31MI87sKjDu5mbW4mx+o5U1lGegcI+Y3zmGWIbAq+4ByteI0/ztqSW3rQuBFUROvs1wZYQt7r/uqq/ccga4b7YaX5qKVJP9H/dr8i03Vyu0rK04SC6gWHE0hQrl0wgmqPB4oBXnAMkuKQn16EEGrGlo5m4TMPZpARDRVVmGSrzld3EwiQEAYF5XwCWJQGvZ6idPJAJ/lMGvim0yWQG3IxZF0sx1Pnt+gOVlewWU3MayD9dBe/00LxOhx6FElcbVUuO441mt1L0x6mUd+maMUJgNuPhvIq241sfgtNPLPP11BsKmNB0zn9VRIr1ddVZ1AaVZeCV0qJ698juuYo+lxKH5M7bc3YDxw7GrWmUv4FG0G9gwKC8Yfyb0Q4wifkfC454GT79jzWnFokIt0UUqH9+UiFYGrrrzYnFRk/kj0zmfAyTg5uAPA2nZ0Q/3epVOaKUJNnil3XLMzXqRdApuBbCsnfunvVWsdmh/pqnPepxSEdZrLAfjbAmIdRPDuPQDT9I7Nq8ilnB995wEoE2qzLNb+uFeHRXkPAA/3QSvWwssZri4Jh0Z2hIGbKc80Sjxv6bTzAy/vAQlmM1J3STclIeiI7fnRoG6JEJGHZ9cKgLPnE780v/al2GngjTRjjZ6h2PrzXuoSWfqTKOY20IX6irzaMKaKWkv2Ut6AffpQJQIqi0gOU1mR5/Fs5mo/ltwbvQjQYNTSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(5660300002)(426003)(26005)(41300700001)(36860700001)(2906002)(83380400001)(44832011)(1076003)(47076005)(36756003)(40460700003)(336012)(16526019)(2616005)(40480700001)(478600001)(54906003)(81166007)(110136005)(316002)(86362001)(82740400003)(7696005)(356005)(70586007)(70206006)(6666004)(4326008)(186003)(966005)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:25:45.8784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536764fd-f2c3-4ba5-a6e1-08db935398e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM RNG functionality is not necessary for entropy when the CPU
already supports the RDRAND instruction. The TPM RNG functionality
was previously disabled on a subset of AMD fTPM series, but reports
continue to show problems on some systems causing stutter root caused
to TPM RNG functionality.

Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
that claim to have fixed or not. To accomplish this, move the detection
into part of the TPM CRB registration and add a flag indicating that
the TPM should opt-out of registration to hwrng.

Cc: stable@vger.kernel.org # 6.1.y+
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Reported-by: daniil.stas@posteo.net
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
Reported-by: bitlord0xff@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * switch from callback to everything in tpm_crb
 * switch to open coded flags check instead of new inline
---
 drivers/char/tpm/tpm-chip.c | 68 ++-----------------------------------
 drivers/char/tpm/tpm_crb.c  | 30 ++++++++++++++++
 include/linux/tpm.h         |  1 +
 3 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cf5499e51999b..e904aae9771be 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -510,70 +510,6 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
 	return 0;
 }
 
-/*
- * Some AMD fTPM versions may cause stutter
- * https://www.amd.com/en/support/kb/faq/pa-410
- *
- * Fixes are available in two series of fTPM firmware:
- * 6.x.y.z series: 6.0.18.6 +
- * 3.x.y.z series: 3.57.y.5 +
- */
-#ifdef CONFIG_X86
-static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	u32 val1, val2;
-	u64 version;
-	int ret;
-
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
-		return false;
-
-	ret = tpm_request_locality(chip);
-	if (ret)
-		return false;
-
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
-	if (ret)
-		goto release;
-	if (val1 != 0x414D4400U /* AMD */) {
-		ret = -ENODEV;
-		goto release;
-	}
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
-	if (ret)
-		goto release;
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
-
-release:
-	tpm_relinquish_locality(chip);
-
-	if (ret)
-		return false;
-
-	version = ((u64)val1 << 32) | val2;
-	if ((version >> 48) == 6) {
-		if (version >= 0x0006000000180006ULL)
-			return false;
-	} else if ((version >> 48) == 3) {
-		if (version >= 0x0003005700000005ULL)
-			return false;
-	} else {
-		return false;
-	}
-
-	dev_warn(&chip->dev,
-		 "AMD fTPM version 0x%llx causes system stutter; hwrng disabled\n",
-		 version);
-
-	return true;
-}
-#else
-static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
-{
-	return false;
-}
-#endif /* CONFIG_X86 */
-
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
@@ -588,7 +524,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-	    tpm_amd_is_rng_defective(chip))
+	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -719,7 +655,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
 	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !tpm_amd_is_rng_defective(chip))
+	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 1a5d09b185134..9eb1a18590123 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -463,6 +463,28 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
+static int crb_check_flags(struct tpm_chip *chip)
+{
+	u32 val;
+	int ret;
+
+	ret = crb_request_locality(chip, 0);
+	if (ret)
+		return ret;
+
+	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
+	if (ret)
+		goto release;
+
+	if (val == 0x414D4400U /* AMD */)
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+
+release:
+	crb_relinquish_locality(chip, 0);
+
+	return ret;
+}
+
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -800,6 +822,14 @@ static int crb_acpi_add(struct acpi_device *device)
 	chip->acpi_dev_handle = device->handle;
 	chip->flags = TPM_CHIP_FLAG_TPM2;
 
+	rc = tpm_chip_bootstrap(chip);
+	if (rc)
+		goto out;
+
+	rc = crb_check_flags(chip);
+	if (rc)
+		goto out;
+
 	rc = tpm_chip_register(chip);
 
 out:
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6a1e8f1572551..4ee9d13749adc 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -283,6 +283,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
+	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.34.1

