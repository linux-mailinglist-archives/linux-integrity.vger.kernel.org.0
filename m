Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBA689959
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 14:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjBCNCK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBCNCH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 08:02:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F49D077;
        Fri,  3 Feb 2023 05:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv9DoqrEaBcgVw6saLF7vHnvMjpAjJnd7ll/2mUR7ewbdEK+KKB9yQ99Y0CnXWAV8g9NTD1qw5bGXkM5fZd8+odk7qB+Rvv4aHFG03Q5KMLomn1xZFQBhEG3FcqyqDvGdy6Awz0d/K5iimn2+GaYMYJ42TXEU0/BiGiaBq1zoI8wTXSGqJy5Mb6lxfg5fv8MeCLC5lY22uujtIEerZOl2gwJPFpw5SLqdnMXTX/QZomjSavmUPebArBET7RBgmA8mD1Q7vbAN1yfnvs6XYXjoBnmci0xH6sE7Zt+jGT4zQf31g4LDtfjBJwp+gKXLG7tXx19EIvEi+ayRw2HkY3JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYqNtURX6sgj1Il06Rub7pp9lcxmqO67nIgl0nPpEaM=;
 b=aPmnDuyVe2IhMsIgNxSryM0Y7CYHNktEp5DK+9M7d5dJYS1K2rEUgRcZolvSRr9RaJZ4AVdI5wHAzYvNEGU/m+p2Dg4Bi+HsOQevHSAxNOmh6LocH5yjB8/nwEMyDUapv6jV9CTV9TZzbuoegHQexd07tzNsz7K79ZohgvejTM5hrWAlzFtN3Q2Rw2vgtUEecAWFznuAd5xIectdvZ6tMQLhubxoMmy6X+FbHYCG86bjk025HJqtFMect/S6H1mFXdYjxnXhgHbJZIesXXSQ84WrLqHwU9BOJmTk4R3WoyRg/ii5q24Fg+9wcrfrY5FaR3JLEv474DNuGYnU7GIgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYqNtURX6sgj1Il06Rub7pp9lcxmqO67nIgl0nPpEaM=;
 b=HrmIE+7Az4hZHDE2SgTM2HzERNDIYmzJVjrEazjGQYGZBWYcqw5Bm5nSJUTeKde0PjRiJkrNexHHyWZxmwGaVOBPoS8+MbOabtBwhyqY4YP+2youDaNI3m6c57mdang0bAB2UB7RcGWD87FWfaJILooW1alvG+nZTG4F7CMka0VYExdsGRHYyAFRpGrcI2KvQDpbPKfGNMM5CxodRARzxpGHVmbHbwr1iYxEpeVkVPXaMt2rVXXW9NFgFjERJWH4NiQqt/n0xIS+L53LOcU7Usaj4rzKXrnJouwrfU4+kUxIqs9o5m6doFUIidbNyrw9UoElBcZJDbHmlHHwmtLSMA==
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 13:02:03 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::e3) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 13:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 13:02:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:51 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:50 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 05:01:46 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2 1/4] dt-bindings: tpm: Add compatible for Tegra TPM
Date:   Fri, 3 Feb 2023 18:31:30 +0530
Message-ID: <20230203130133.32901-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230203130133.32901-1-kyarlagadda@nvidia.com>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|CH0PR12MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: 73317ae1-0ecc-45b9-046f-08db05e6d898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4f6Dql+1bRN1kVfI9HgKXy1et4Zc+xm6S7MJHA/XbVVJaB/3R3uHW4AN2nByBX4EB44JfdNwDZuR2VqcsZ58U/wKLbTYUqAtxqPgE6RtxOcF80e5Sl4rhl5HDfU1L9cVTfTws2USMYtBwSUIVqTEaw0aPIt8W8EBg+dQkm2LtqyLVCg5aCGNsqoF/0qUL1X8M4zBHgEY88eAD5Pty9m+2YzSzmNG1oxRBoXUK13/NgXLhnb4YF8J4wo/xYhLEuT2IAcOH0fG6OZoA55+1t2O7iBzgY+Tnrk+NntHEDy2S2/bK9oWW6Nkts9obD3oFR78nCK8zia455Ui9YJSNAbcHUlVOMBqNqyb/2/7lZZNiczl3KkOHuz1MqmA6utHJFwvuqcScB0NN9BAtNYzPj3wYKCF7I/HoLAwR16VAP2Pw2uCNbofnCDVsZK1V4JgePzXb7QWaqO8yYX+fWsctwMbJoIp9gxyG9uLEKkLiEx6eJsS4StvOxCJneKDndzTXndrSO8EbZ+dXOiJgcDdWUcQul2tsCAeW8GObrkiIwNpC9msWqeRJbC+TbUXHWIRPIa7iz7LqXnw59MdB0udS/99qtC1s+y25Lvz1jcGqIAI/dHxTas+13fkzhId1tbbBlECRahJTYPCiwWYmXrBhXZQ+KVcwDjA+UIrWV19gwL2jmfms2aAX/PfcTS5EEH1ASDZbVm8x0dVwBVXkSkBm4wa3LzPslSoLUOb8GB6AKwSJLtWfsUETdj3lR6RPxkTYWsYZ3e3kFcsWYYtuSQ6RtbDDZpWblkd31dNabXoZGx9QrFRX8/VH8T9ylPcrNy8MfYAIrHgsX4NkADr/7vOaVxjng7evTQkH/HmuH4qLCLKH0qSKmYxnV8NfRDJ+BAqx7MiR0QvROCUxhnl6vxgC79ig==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(47076005)(966005)(82310400005)(86362001)(6666004)(107886003)(7696005)(478600001)(26005)(2616005)(186003)(336012)(40460700003)(1076003)(36860700001)(70206006)(70586007)(41300700001)(4326008)(7416002)(82740400003)(426003)(8936002)(83380400001)(40480700001)(36756003)(316002)(7636003)(8676002)(2906002)(110136005)(356005)(921005)(5660300002)(54906003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:02:03.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73317ae1-0ecc-45b9-046f-08db05e6d898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
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
 .../security/tpm/nvidia,tegra-tpm-spi.yaml    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
new file mode 100644
index 000000000000..dcb78db7355c
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/nvidia,tegra-tpm-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra QSPI TPM driver
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra-tpm-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    qspi1@3250000 {
+      tpm@0 {
+        compatible = "nvidia,tegra-tpm-spi";
+        reg = <0>;
+      };
+    };
-- 
2.17.1

