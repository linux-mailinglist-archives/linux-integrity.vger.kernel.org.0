Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E315776F1CA
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHCSY5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHCSYw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 14:24:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817AF1BFD
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 11:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrBnTU266ncJdo111iLeVXz+TK7nxbxpoAuaQNulvI9suYcxzYlRxGxWzqWOyb3igP685UNoSHa7I9WgngaUH9yn5vCCxw5olmT1AtKuxWF2nBf+iv6gda2gl7qnCFolrdFyQF7n071SU2MCaBiJ8gFl+KSgcF8i1rTefasiutXLanGRz/sPzVURSqVtJs6c26XD5BFgPK+rMuBYP9jVM8aAXFkDoFt44QTR9AXJ5FElf+Uyu7lo4SltbovMvUXIsbjyhyjgc5NScQeHp+ou8SRlxSrzfSs1XuySU4J92DX2w/D7VS0OHsinsbB80Z+dMzVPeKdEkiqbnYinPRJkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bTaRBcR1/zhm1B5aAMVltsFniq3Jq77Ej/nNKwhnLE=;
 b=UCDc/1rik5z/Zbp1Q0qyhNwXILyzSaY5pfeStTwySNEBjguBEE32cSy5DIAtQUIVPmJptvd//9rLaepCFxkQhwKhiaZzq9y+X2PylvMCuNt8vLwhmsdNi7H5910HKkW569HzS3QC3zqSpU+9JoPZOaajC09jSDXrtvBcstFlzWwXvLXQ0n0BCqHKSYeN8jg9EP8qQJfYIVbtFOQZajS/SfRn7unBi9AJFyTKfqdk4/+hbx7gv2UggKcbYrQk8Q5tYufo+zmmtw/2VxBZrpb9F8HxFcqM+zdIEmCvu9smrnvU3YKhGa/JZOLp68A9ONfi153IGZ8FyEnODK1JS2kPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bTaRBcR1/zhm1B5aAMVltsFniq3Jq77Ej/nNKwhnLE=;
 b=ztfgCaUgV4SDj27qoSSPo6SlwBFwIj829CtZWoFvIK+jJYlUB/9GfaOmLqE2wu8ifQgztL64T19I4sbcX9rELD0kcGeDRizNoJSiO1qYeV/u+f7QZ4d0aU9/ImuUjEdFAUid8UA2OWsDohJN2VpbHFp7FMyywgFGMbuCd4zEFwQ=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 18:24:47 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::fb) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 18:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Thu, 3 Aug 2023 18:24:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 13:24:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "Jason A . Donenfeld" <Jason@zx2c4.com>, <jgg@ziepe.ca>,
        <linux@dominikbrodowski.net>, <linux-integrity@vger.kernel.org>,
        <daniil.stas@posteo.net>, <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Date:   Thu, 3 Aug 2023 13:24:28 -0500
Message-ID: <20230803182428.25753-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 178db8a7-24a3-4719-da04-08db944eead2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNEudxKtEJF8LNU71KBpT7IqaRQfdQRbTd8UvJY67Vw+Z1NXbtJWpafyTZrs1vWfeHvssaT7seHzsfNEa/obCTvTlWap3cCBV0CLoyrQynh2JYjFyceNcz++eWxwCho5CQ+F0q0h19miDs8Vd8P5iIEAgRlHVlxrIDhp4qih00ia0xzWX1hDbJ21v9eZ8W8o4DIFPvMilX021/JJJp3VNKAmtpraCdqxjPIssipr/QW4HQauOnE4iiYLEOO4Iz0Gm/RCjaMkYJENeKMXxM1ecfTw4rcGhrNihYqByM2SL4uAo7IkxQOABURpDfB+01xhfKoAg307IGk9C+0eYmhO7YLxYgKC7KMOLSB/BqcDX3YNpFwxwx+/ZLXdQhIMFktxiNUvVYN1rARA6v5q3x6wCL/ghaZHa9am81m2wQ5wHvtR9AIEu+GyoWpVpyZYQHW+xFnajICmc1YSh/ByCcaBgh4ytEEo46RlgjWJbSLGPU53wkbwlHfQgGzRUPfJXZMQPVpt99auv64A80vU3UV8LG0zzntIg51krFQeHeZqG5rfq3sG14i7flX9OWNeRv4+8nAzGsekpvxz413zsQUR+Uq8qIVf3M5gsXhYblRNQ5LPyl38HAEHh8cJZS6qrpv8u14ocC9DiStQ2g3/H/FQnE2ku/hEwvE+fPiReC3maUhZ3FAjktv3dy+V06FzMrOvDcPXdAUiIb/qPSkM72GdfRbfWPlF2CNJdAkXVV84/XRmwHGLcm35U9rCOlyemvaAmFsIxLUKlZxDX5O9twxMzmtJq8ky9qBQXwx6xY0AehOU3gK3oQ77xTCNiNXaq+2lHZNSdEYlqa6CfK7LJINFIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(8936002)(8676002)(83380400001)(47076005)(36860700001)(336012)(186003)(26005)(1076003)(16526019)(2616005)(426003)(86362001)(81166007)(356005)(82740400003)(316002)(6666004)(478600001)(40480700001)(966005)(7696005)(54906003)(36756003)(6916009)(4326008)(70586007)(70206006)(2906002)(5660300002)(44832011)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:24:46.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 178db8a7-24a3-4719-da04-08db944eead2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org # 5.5+
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
Reported-by: daniil.stas@posteo.net
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
Reported-by: bitlord0xff@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up a R-b tag
 * Add another Fixes for when fTPM support enabled on AMD
 * Adjust stable tag further back to 5.5 (when fTPM enabled)
 * Fix an error handling case that would have introduced a NULL pointer dereference
v1->v2:
 * switch from callback to everything in tpm_crb
 * switch to open coded flags check instead of new inline
---
 drivers/char/tpm/tpm-chip.c | 71 +++----------------------------------
 drivers/char/tpm/tpm_crb.c  | 30 ++++++++++++++++
 include/linux/tpm.h         |  1 +
 3 files changed, 35 insertions(+), 67 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cf5499e51999b..8f61b784810d6 100644
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
@@ -693,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
+	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -719,7 +656,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
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

