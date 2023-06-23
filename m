Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949DD73AEE4
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 05:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFWDEy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jun 2023 23:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFWDEx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jun 2023 23:04:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC88170C;
        Thu, 22 Jun 2023 20:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URlWOCFOKJGhh0iBYc9EyvrHnl8qzn22GygMkUD6Dq92OLSOxkhDAV1lfybEshTf/q+rD2HJ5Q3uyqZAzT5VH/YgaKQQE3UUpDxKCiRo2qRHseMvI4xGu3AyOJzs2VbT6dOoIJVjmevh7eu6m0LTFwYpHMTkR9x5iFFc4hKS3U8J233Edh4mpzavxTM2oW0EGQT3oz4nxvYjkvPbMv0g/Ljz/bbWsC3W/jnN4/v4hGKE3C0gpb1xwzeSybvS626WttUq2zEBjCWbAF2vfQRnKZxHYJHlitR/MCJQOWuFrhx8Z4iSki17g4gzSl0pFG3ye6/jQZax70Hbqv2Es2jiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOlp0pICPmel750zJ2b+dD+6IxLi3WTjCA4eBV3OBGs=;
 b=MBooidQwaxnzLCknjtR89rNfzZe3pqMOBMyVla9iazM0eMxkzvSZxHrar42d3MH1kbgRDddMVZk4D/fmi9kxPzhI1cQWvlhf+uE/MXn8GHlkiiYgCVNBub6Jbu+krRcFlo1cxqI9p1uA1kM4Em9dj/baTtiwfc/nca7ankitR1lqHmMtxukoELtmnr9lAGukEfVzm0MPksYhCY91u7sDUKxhn5dbfV2GJHkIvAEgskK42tGFNJy1yhjcyn5PH8uB3wsC/9msPA63+l4TLJEbqyIn2LYyYXeVy1g2lmN/g4xfXfoD4/o0mdKL1VqKEKWpuVfJrEufMFx++ElhA86PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOlp0pICPmel750zJ2b+dD+6IxLi3WTjCA4eBV3OBGs=;
 b=UiLbqBxZ1sCp3tYI4qcyltJqmfz/7gJwV0DYbNxsft1X5IVzba0KetiGPEGx4+DRFuwRl/RqI8JFaCQEO9rZZ8ia0/Pojf2DrGUS/YzRMM0lO5KSN2pdGbOdPecoO4K7BV4rAbd5UFKU5BBOvZ0ON8EF2dJBw0GE9W6hlb40hKY=
Received: from CYZPR05CA0006.namprd05.prod.outlook.com (2603:10b6:930:89::10)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 03:04:43 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::88) by CYZPR05CA0006.outlook.office365.com
 (2603:10b6:930:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.10 via Frontend
 Transport; Fri, 23 Jun 2023 03:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.20 via Frontend Transport; Fri, 23 Jun 2023 03:04:43 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 22:04:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] tpm: Ensure that tpm chip has ops to check if it's defective
Date:   Thu, 22 Jun 2023 22:04:27 -0500
Message-ID: <20230623030427.908-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: e19b7543-0c1e-4054-d5e8-08db73969819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GxlCaZlDufG4/RsKlSWueZ8gH2j0MErZJdDQpJfDnRq2R/O6MBqkWODaBJjzAJMcFQALTsLaR6TTPRbXWKgwVIfBbuamsZyfJedaCFvHukJl8aiDNRRGbK1Z1XTAfST8p15gZyIY27qZWq/XPmt+JSCP54vBcVDN2Efut38UhblrW0YY0Ej+NeUdoH4oamfCW+SR5Dd1aXDd2SNNaBY/VwTXCYHsidXHI8ava7q9jWbitTtbeKYi41Rwje+qYa6NUuhupYqcmpe+74Qwsa0dNuxmlR3LrbylcgS3oXeCPttqK44W7n3MrEi2OnNAm38uG8jREeqar/OQJUzV6ClzMjLu3TQctWPOCPm9aycP+YEgaAsbDpbAgXAeNQNBNxsJpRb455Vq/guGNoL6BVBssTuc1w4mmlQcmaRCdTpcr4ofNCTZ1fNinwHmEkk15ZT1vo/9oB8Gk7HshEspbjO+RQ1aPx1xzyiNsPCWmz+CulqROgWXAxyslAObq9ThUZ/V9HFPVzcKyaUbwYD0wwDB8ttzQEViJrKoS/MzE9YdXoSGLVrxKqgi3QG28qsV4UXlfYwA104xUZa+u6O9j1dNYgufkOBBAhwah3u9H4ffyBdgMtd8VSICUIB47aNdsQOoQra3hvpTeM99jrt4+ppLYffrb0fGGqzpQpbGngh8E2+ElDYP5OIJbjBHTD1Gx5ulUUIZGUSa4dQ3C+IvynSnOrJXudJEijTGpUIf1wFD/qxtA6b6dZH/lW1dyvXjexcbJ+cDYPaQsOnvcQbvEK2+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(44832011)(36756003)(8936002)(5660300002)(8676002)(356005)(81166007)(82740400003)(2906002)(478600001)(40480700001)(16526019)(186003)(7696005)(6666004)(110136005)(54906003)(86362001)(2616005)(82310400005)(26005)(70586007)(70206006)(1076003)(336012)(426003)(316002)(41300700001)(4326008)(47076005)(966005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 03:04:43.5925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b7543-0c1e-4054-d5e8-08db73969819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ibmvtpm doesn't have `chip->ops` set, and so trying to check
if it's a defective AMD fTPM doesn't work.

Add an extra check to tpm_amd_is_rng_defective() to ensure the
TPM being checked has `chip->ops`.

Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Fixes: bd8621ca1510 ("tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site")
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm-chip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cd48033b804a..9ba433761e9a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -524,6 +524,9 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 	u64 version;
 	int ret;
 
+	if (!chip->ops)
+		return false;
+
 	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return false;
 
-- 
2.34.1

