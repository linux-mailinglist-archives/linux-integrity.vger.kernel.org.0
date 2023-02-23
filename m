Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07626A0DF7
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjBWQ1V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 11:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjBWQ1T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 11:27:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2247.outbound.protection.outlook.com [52.100.172.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F159E69;
        Thu, 23 Feb 2023 08:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZzwtWpTCQto1jJf22skSuZIfvMmnLfJku0wofIfYWeEcjYTG2oR3X+KarYJUqEWcLREkmTfgaiivzmkCR7qJKL1iUSqWF/5alZqhe/mrqSjaYBnmlbWZ51rUdqUeSV0/fZZS5zMrgY3ndvnHccGM4CdQ7mEqwg4nKUTXyOgX+Y/XIKGRR+lNAJc7Na1z45kr5PfvCLKS6pPyxF0haEK/c5vowxqHUBl6244OMfQeYDeOKpWbPgdt3Yux+vJO0yTUl8zQ1fui6/nEJ4DYMl0TRxh4kaGb6LcvVLuPXVafDosf0BFOVAy5WvfmgK45lAhNf2sRGCSIKaufWhJXlRLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsfhtNGIMTSq3iU4jmP/wfyqRfUEXCLyWBK8qBendlA=;
 b=ECEOAqRbaBj6xCH8aC9hnJrYWudv6l+9UpByWKoFyzFqVAiL2aDOJg4j29RN9fRYWfHeIxrHaZ96bKjTakqAav0oB7qJC8YsBpxJSWR26Umoq58VAHebNJtcdVvkjqynoZyPpoRbwBHTkBqNUIm/jzTuluuaa/zpfmd8foX+OcVwCrPwxWb9z2LdFyP6hBSxDlqocVAhDuwUbFrt1sY91CboGZeHZJkwjzSb1YFpINDracfuMRPzxjl8KX1zZ4PUYarf3NJ+67dgYqfhpdzOwAOds27UxdUGYrGqIUrU4UE3Zyc9MXFf5L6ykgi4+X+IxeT2NTAbOZtI6CJcmJPCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsfhtNGIMTSq3iU4jmP/wfyqRfUEXCLyWBK8qBendlA=;
 b=X71LeY3r6LJbWktXCU+i9a86W6TYQ5cYW/2PfPOmI78UmBD/4C2ORPK5GmkXpFzL3d8rqKf6L4GNn5yVSBljE8w55zbiakQoo68UphI/nV24tPW5wXGokcVs+4I8xym6nsQmD5Iv2tQIDKTVYz1YmBHb7zulDnTV5xH1TWWhUvjZhQ4X00dxtjWRKrpWO/0zkP6vtMckFIrnoo/ED/4GGc1r6mFrQjtSw2752+iJ27IjfBcRw8/9IzmYZgFKvFClG5I3gbW7YFZGsjBPS5vo/gebTnoVKt+vIOy7lb2Dpu5YuDROq39TTDzXyekeM8otPtRVAzsqhtPHRrsFUFQz1Q==
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 16:27:13 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::28) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 16:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 16:27:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 08:27:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Feb 2023 08:27:01 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 23 Feb 2023 08:26:57 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V3 2/3] spi: tegra210-quad: set half duplex flag
Date:   Thu, 23 Feb 2023 21:56:34 +0530
Message-ID: <20230223162635.19747-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223162635.19747-1-kyarlagadda@nvidia.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bdbb92-7e9f-4840-21fb-08db15bad1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fgk6S4g0Z+TIj2G5f/Bs53YdA0jUIyZ5rzZgkpd+JtdykgCNmkdSqSvT4LG08PZjTYD/TYNFKtk5vYHTJ/txQ0GK7MOcodAd9uWjPs6mU3OgtlaR6426ggc/bOdsL+nPuyeewH3oKHIJtK83MwhSsttPkZm7UTnJvs9CahdUO+AVmUvn+FUuxhD8GwFpTz99RsPqUWdwcCaq5iryOBMhQogvDVZVUvF1xvanpEUUj8bssaelv8ErEEQi+NLlDNPQiq/V+rA/iCC2Egnu7ScNYGj0pw7GMnb8i1Vuwu7NoE3dw4C6f/FscD8KEaP+VV+Yo1miK2hyWi86D5hZhwOq5rh2F5YlPPItBflz3nFuF4pCm9BUZduYBVxtm5xRO6/HnqH4gPKeuxqVZqDMEuouPBSfyjIiOhDxGVxcznTkzSdhL5dGLeJB23/gjFJlcVaX5/Fyt+Av8p2fRciy0n665GP+vugLWIHUJzbK3mJuUFkcyRyjvvlG5Mcwkg90hdEFeVndP7WyTdYtked7+oTULt+gfQJMBtlMEj+X5nWNzq7W+9+JOaUwNS4mCPWAhnTS2lKbOUBS5oZj1UcNh/oBPQbrq6a/NFvpYw1Ps9L/XonRGeknSascTamQyGmjMsYYYOO9C9/UA9NSwgp/ORPYn9piLGgl/aF7Dg8Nm0lTOMu7ta/UPANN2vj9D1owkvO230fC45Qz0+5Dq5l3WttglQqJxZc9ZFenQT8y9zLl9hH32hdrVVH753sTT259vg9gtCBmBElS+td+AwwVF49s4WgeDnmtqCjpIAwGT+1JfeCIi0vB++qYsyFi3T4LH3AvrPdNQU3l2GzrRSzoMkvmA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(5400799012)(36840700001)(46966006)(40470700004)(2906002)(36756003)(82740400003)(316002)(336012)(107886003)(6666004)(7696005)(34020700004)(36860700001)(41300700001)(2616005)(426003)(7636003)(70206006)(1076003)(47076005)(40480700001)(70586007)(40460700003)(921005)(82310400005)(5660300002)(478600001)(83380400001)(54906003)(8676002)(110136005)(4326008)(4744005)(356005)(8936002)(26005)(186003)(7416002)(86362001)(83996005)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:27:12.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bdbb92-7e9f-4840-21fb-08db15bad1dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra QSPI controller only supports half duplex transfers.
Set half duplex constrain flag.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 9ddb02fc6f1b..b967576b6c96 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1532,6 +1532,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = tegra_qspi_setup;
 	master->transfer_one_message = tegra_qspi_transfer_one_message;
 	master->num_chipselect = 1;
-- 
2.17.1

