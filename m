Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519C773E06
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHHQZP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjHHQXb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 12:23:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60BA5D4
        for <linux-integrity@vger.kernel.org>; Tue,  8 Aug 2023 08:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQzPxBso6SCCLEOPQDRnKHo5rt2cEtJc+x46I3bSJBBFFz6caK+sFYBkz2ZHpdnCnTUXPqFoYRgwO+hFK8DVPXJeRSY7vxYlk63PxbruBIqMMU9DK9cPiIFOq5uqrkVh/vvf3umAhTWLjSdxfx9p3eRKEWSurXgbg0EChcOUCcSyCHfV5LVjTMyr792oqqSSGWZrl1gnjTe3qvbjq3OXrodXpALFLaFwg7iTDFIIum2bQa0smaX+1hYSDFSjc0nFvqNO/N9LF13BSoYGHliqsn5PpXyQVCUYcbrEd8sOvR0gmviT5JT/IXMT1s+0oMQq6SMQh0ZqnDqiowDZkLXpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV5vc1XdxpxIcFHy7PEonpTgJFLXLNxgVzD8vp6aFOY=;
 b=dyiCFmKJL66qhuiBl0SBZjxI/tsplPysdPYtZO5lQ9LYB/ngHNeEH7p2yfJ3PkHJiHcqc93zACkYUecNUlqYiHyG+swgcauaqr3t+DzqUjCTZjZtOqDJIxQTRt1fvCiSGG4LOjeK+MzcHgJUkJdR0jQINMeWqLDmZpZ0kKZSLT8qBTyNpRehyhaSDWyBUeqoGksYEGx9TXQMAQPzKVOxyhZup4uos1hrJRkX+j9zs1BIaZpJwMgoIKZqnEeat0L4xpggFDXkLTIR7AawuGOmrPbQVBEAZTLTiP6RLPN2Z1/1RpjJLNStrpWHWNMRjzU6QgDOojPjxNPHMFCyolArrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zx2c4.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV5vc1XdxpxIcFHy7PEonpTgJFLXLNxgVzD8vp6aFOY=;
 b=OVsek7KHd220W67ye4yIrY5Bccu6KFfZvOaghqziQt+z6SgUmO2YDBXjVgYpf9pUvrGSusRwPhALOPhFWdPb55PtojDpM+f4nsgEAkt3l4xqYq3WIFHVLXfLz2rxQEAqBfjdTtmMa4CuqHyx06JdNbdvbcgIhMN7xd77cE8BNn0=
Received: from CYZPR11CA0020.namprd11.prod.outlook.com (2603:10b6:930:8d::7)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 04:13:01 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::7f) by CYZPR11CA0020.outlook.office365.com
 (2603:10b6:930:8d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 04:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 04:13:01 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 23:12:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <peterhuewe@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] tpm: Add a helper for checking hwrng enabled
Date:   Mon, 7 Aug 2023 23:12:29 -0500
Message-ID: <20230808041229.22514-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a6c25e-7ef5-49ba-3a7e-08db97c5c165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqLXV0GoChGYyNJbKsJku/8DItJxYGWGaYGG7NBw3FnS9A8Ie+jYlJNQHZUfBJto56c8cIsZV/gIWi5hva/avImMoj1HArZNxUjQ+i3GVxCLF0OEutzbHQfpX/dOEfCfphzKlX80KqIbkPU0HNJZAxE0kkZWBomGTdseJ2WeNtcaPUNzEWkgBgiAGOfVKWgRBEZsYWNZnrtbgJlPOfoIT601Uq+wT9OEgRttR/RQ+9INyOPaYjbSdSWqJjCcCPhOoZ11RfuR/zPKDb4asdwPoE/F83D+qZxKh17Yh7wxzineo1N9r9I7qF/rNq3IKzRwG9lp0XPgOnn0mKvSckJXTGSZVs1MtrxNo9lRrIq8kKw+HZLqZpCOtzZFvomXcNAu2vGTzUNji058fY1xCk2nATZG5CKOWmSFx5aaQtOWP8iGs5eMpPJbJGz1uiRhDujSlfpQgclXdf1y48rfIk9Ss1KgCzTAQoANa1LoeAFWLAZLAJRXciQkxXZFOHv2EWoenCllyFKZtEyJNzKL3GmD5f/hRk+wnvyIM9N5aVzdoFR1DA2oYQHK6J/O2UiREpkgwL8Lsl+NREq9fGpRB9wRjwwr0v248g8igFe9bGXelXItebMVET9zfvJUIkHsIQ+9JKXwjRjyyqffjf/7BFZtgm1y6/F40MCMXCPgsk58YMhXT/9Qk2E8pGIfGUlSDHIYIwwD4z3qQqKRHg+YTkPg23XfAIPkSvq0f2xUMdZdw9Qntb5M39EH/u9zMle/MfU7eXzrRolsTjf9O6zfoRkGcEuifWUQR6AaS0TLn5moeHZnS9tpbuinJjQ3IFK99qgchet/JPLQNtLM6Zou/3K3VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(186006)(1800799003)(90021799007)(451199021)(90011799007)(46966006)(36840700001)(40470700004)(426003)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(8676002)(36860700001)(47076005)(8936002)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(86362001)(316002)(82740400003)(7696005)(70206006)(110136005)(356005)(54906003)(478600001)(70586007)(6666004)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 04:13:01.0951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a6c25e-7ef5-49ba-3a7e-08db97c5c165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The same checks are repeated in 3 places to decide whether to use
hwrng.  Consolidate these into a helper.

Also this fixes a case that one of them was missing a check in the
cleanup path.

Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm-chip.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e904aae9771be..ea6b4013bc38f 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -521,10 +521,20 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 	return tpm_get_random(chip, data, max);
 }
 
+static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
+{
+	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
+		return false;
+	if (tpm_is_firmware_upgrade(chip))
+		return false;
+	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
+		return false;
+	return true;
+}
+
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
-	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
-	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
+	if (!tpm_is_hwrng_enabled(chip))
 		return 0;
 
 	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
@@ -629,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
@@ -654,8 +664,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
-	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
+	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
-- 
2.34.1

