Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3176883F4
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBBQSV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBBQST (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:18:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1F16318;
        Thu,  2 Feb 2023 08:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IspPsW8zecWqagA5aDG2PFy4JRkhZKa71vlhC42eobEWpoJYBipLnfLylfSuLlYQEYfXrbeRQuLj1PE1tA7ohnQd5C9SFBF1Ua+R4VOH0fkAVG6JQfEJZ406mCoBJKVS/cUkZW5Qe8UrbTMXRenM2u8ubN4DKss4Gg/TcOwE6Yw5FTDtH2dKGzjZXWRWugBtNX1cp2eYPnKKFm5zmqIJR40Vhyh05I+z35LRjZFdFc00nTjSXiOyIWkp6vJVeMZpmimYuEOdCU2uVeEj/HlzYWTyGR4f2fNOdcMvq8S/Vw6t1jXj8U19PVfpAoHg8s2ka+Tt1Q0D1LqlED2rFBzVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6U+AhQqnDhqA+ojkMDOccEjmEVNwDXzANt0T7Ecoi4=;
 b=TG1uetN+IHV32xuXvVP19QcfXjxsRiTmYxRJVVm2iinHccEHmPiJkzfe6NNatMNGQ5+sX3v3+kZ8pBvBaz2tMd/XIbRzKPV4vbFeP5ctJv0ZoLxU5aHr/a4qwEy6IIK+pXWE6wwz1hcDf9wc8/TW+6Q3HElM1fHHVNdokXL9LQ4Am29aJWNPSMqIqvWU9bdbBP7cXjmh6VOOTnH2ubGazT6OpJ5TnJW1c0xM2G6wYsl3voWeAzysYMIIPE/ccnCvHp3FGy9vXbPM3Rb0oxDFzIMWO+am1U0IFNKbLo3eNZqbINE9K34qJae1qN18qDUOE4KbV/XHGl2jaT+g/gNHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6U+AhQqnDhqA+ojkMDOccEjmEVNwDXzANt0T7Ecoi4=;
 b=JIJ/7FeISDb6CvSyWEEs+Ghn0hUpFB5DG2WmZQYK987NPnXZDODA56huM6Wtr61XibcBbrh2SKJ5aE6WqqKxcdFxjHNS+itts4QwDbafBm8/V1RAeg4r8CtWOMwuNSe1z/7lLf6NfEjMWHh1Lq6dx2pvF4NINVickAIKPYr0RX7RLKgzh1Fgc6R20KL9MzQzVrCNZkhCowQ60OCT6sA3LlB2+t1PATgA+IIL4OkXy4O4uXjdbePpr1+KZBz1RgHSjjGcUbb6iJ/BgdqMB5LLhXYF0p+M0G4zH4amTU1QJ76uzZWWMleIwPbIJwGnsX28b5qu4vOa3p9A8+oZeqkWow==
Received: from MW4PR03CA0244.namprd03.prod.outlook.com (2603:10b6:303:b4::9)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 16:18:15 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::46) by MW4PR03CA0244.outlook.office365.com
 (2603:10b6:303:b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25 via Frontend Transport; Thu, 2 Feb 2023 16:18:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:18:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:18:04 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 08:17:59 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/4] dt-bindings: tpm: Add compatible for Tegra TPM
Date:   Thu, 2 Feb 2023 21:47:47 +0530
Message-ID: <20230202161750.21210-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202161750.21210-1-kyarlagadda@nvidia.com>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f0115-d7d4-4e13-a488-08db053915ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6951xP9g0k7C+BT5RLm7bFd+3ZAd7/SjFk2jX/AsBYZMS05MzXOxode2CwSdopUfnSDy0qfoG6eOY3aXdJX0EgTfLzWV52yvzJMpVEoTaHz3A0CD5ixuTbp3mk6zR597HDH5p+WxMWIqz1wmyLXQrj365S9W7bhMxpI18MOgU+InSMieyYhHuJoB1NCK0yhyoZ7IxHVsx09boS5etn9cCO8cBeThXgKVHIOut2xxhPRnXEbKcAdF+F90qJi69oOGoag7YZ7UJmtLzfVb6fHVvM5dqvJKxoUUsK+ryRUG21P/0+RNvwzO6vrnTeVOu1RgyXm+Fu2EfJplY/Pb8DD233jUehNuL464kqX6E6Q2lHI3GzOPqAUCPfSEs4vIu1BOQwVbfQa8DoKu5u9XsGPenkUX4cdyi2a5XS/aKkjIfLgG8K68EiJQ509Y6ILeKNd3ZZ/johTsCK2krq2PK3MKuawgdX5ZLUMpSTkK1jzLgBEyUdsv9K0uga9y0kddwTmOmXuq9dsiO0K0cWukdYbLNKuqKPqGtwH4FKBqdfo7ddUwN/rwTtGUE7yap7tu2SHF2kZq6QjTtiwKWCkJkqvWsTunNbhiFBWjwZSSKaZ5l9yETB2+Bb69sRic+p8d8nRZFdgqtsq3rc4ofEyu7CLDh6RgHygvuJhUdQTDu01pKo4FA6DVN1yx9uPDR1SvyvL4mf2xXuvT4+Pu59hXALmmMOgMSEc7vF9HoG7iP/roMubeO08J6huHLW4fxAOBV8K5faZalblnDpcQJM4jLEtnQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(8676002)(70206006)(40480700001)(4326008)(70586007)(41300700001)(36860700001)(7416002)(8936002)(5660300002)(2906002)(40460700003)(7636003)(82740400003)(86362001)(82310400005)(7696005)(2616005)(1076003)(186003)(26005)(6666004)(478600001)(107886003)(316002)(110136005)(426003)(36756003)(54906003)(47076005)(921005)(336012)(356005)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:18:14.1043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f0115-d7d4-4e13-a488-08db053915ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra234 and Tegra241 devices have QSPI controller that supports TPM
devices. Since the controller only supports half duplex, sw wait polling
method implemented in tpm_tis_spi does not suffice. Wait polling as per
protocol is a hardware feature.

Add compatible for Tegra TPM driver with hardware flow control.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 .../bindings/security/tpm/nvidia,tegra-tpm-spi.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt
new file mode 100644
index 000000000000..a2017945c7c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt
@@ -0,0 +1,14 @@
+* Device Tree Bindings for TPM device connected to TEGRA QSPI controller
+
+Required Properties:
+
+- compatible: Should be "nvidia,tegra-tpm-spi".
+
+Example:
+
+&qspi0 {
+	tpm@0 {
+		compatible = "nvidia,tegra-tpm-spi";
+		reg = <0>;
+	};
+};
-- 
2.17.1

