Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FD6883F6
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBBQSU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBBQST (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:18:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5506A212B3;
        Thu,  2 Feb 2023 08:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFpNW+M9zTyjYVQIVpZQVTu+7yrBPyjBe+vU1fMRk646tqmAvhyUrw1/Vb5gHU30NwZ6mAY1JuzO6vL5iQ3ae42fT9OrBcm+aeidl+27tRGdJhslIXVIrCAZ1yz204DjGXMmeWXMF0ZhjP1w0NkmdrwQGZezNpVzVx06xtAvs2MwrRcxAm2/ATve9Xr4Tj2unOnC/22yHDhTO/gVz1M3OZTG4qrCjUVeZ0CM1nURSOLINJcWsrWCLjhygJM+JOYeo2q+Kfcr7GgXBIVmF6BBH62l9Oo0YQ2jrvSO31CKvoHBt7hwYwRZtRpC46TB5gPwv8amf6L3VUNXBLnPlSrTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkiGvIpGnfI4C1w+gojgg+XU7WO0Xt+bk/w+Sqr/k5k=;
 b=Ch20AfMJMrLh+ro+utBxa99fus6SzmttY0BQxhduMp7ZS5wB6gCFqBJ4LMWP8HrYEk4tT5vcB+RlM/+cFdXonUfG5Cic0kuRDJCeuZgK7ymlfY8BknqqnaNx8pU7k6geDAoJXh8VAayvr0P3ozFPLUcykycKcWpoBNwu4OSsxTRDyMBuJnJ5tHWZS7qD14pgyxVTdpdEfEuVb+jn4ygsUlCALspG7PgeL+th1EEP+iuNTif/qvP+UMiC2i1Cr5XH3FwWHY5DbBToLiXhn1NNhOM4I9xt82JMFbzQJVubiAzslLMECjH7S2oI0pz9EpxAsJoaC9n/JVXISXxIU0FWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkiGvIpGnfI4C1w+gojgg+XU7WO0Xt+bk/w+Sqr/k5k=;
 b=lhQC9JK9mILJO52mkXai8v2X1vHe0w/kMNzOPk29TETjXI1InnsJNJdmcYLJDnsYXj4pFsJgSgvGp224rUl0eECPfDglWb9ossJJs0Q7ppffGzlSn8BlWIG2aynnTdvJ07BmJYqFSEXUJ2i/iKmBE+A411HkmIKO5GdfDavuYkMULxKSgRObgqIShqdTf5tcUYtPUjsju3EYJXW2n9G4Gb6KlUcTffFkbeoSXCsw69cEo3HWztOoK2kW66pk5TBR8a1F4ple2ClXdFj3+5bj7rBtyZKrHHybFdtMhPKk9SHTMgiVmIr6Fo7Qn1kUzOSbHQ/vKShpmshtR+xk8Cs2tQ==
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 16:18:10 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::dd) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25 via Frontend Transport; Thu, 2 Feb 2023 16:18:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:17:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:17:59 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 08:17:55 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 0/4] Tegra TPM driver with hw flow control
Date:   Thu, 2 Feb 2023 21:47:46 +0530
Message-ID: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|BL1PR12MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: f12b4569-cfa7-4860-62a4-08db053913dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZW6KTEMLzzpJxXwedHOHIWA9cJAhCYiHeck7sqkdIGnM/2CxOF3ih0TvHWoGGE8Idqtqvs0rL77Z6W5ctwa/7SHExX8HET8tiq3RXjD9Qu08YnulWq1IuZH6rGJuQ4Hi5aV23rw/mbO6I/bNOrYA2bktOf9VRi0/+EAj3NoxLFHO6LezCSbxNRmA8UhhhaoC5GXniEGgWSu6Q/kzYr8MRi2sFjR1KUtL/ObfG0WwVhMk4josweAqTFBbnwBzyFNiQ881WLztKhwaqR+UWIoTUv+YeBXFxbgad+tT/2XUf30zsKmJlG5BLQlTXCFYdZonZRVfPrUzHSRPOzxBRrWL3Y1FE67p/IOVnyX2HAG2FnSoCmP3QrSrR0scF+er/JXfNDtRK23F0uDlgAdrCDBApeU4xO6udtEphVSBt8uFlR8QMswCz6L4O6MS0ZCw6+SQf7KJrqAJ96BCLHPLNhg5HKgefWF1Q7oBQJcHubemyrzVZG0JVRTyjcBrKmpMKiAHpCA7UgQwur/zNMFCxzjN9bNaZwtLe6iLsR4PjWEjjvdj+FCDxNC55u/w1qWRS/Cg1stRX3CeMlgXqTfvIAHvZQohu4ge2WT1DdXb7nliE1k2QsHt9vZbd9JZ/vEehcBdP1Wg/kCy8A1ROXaolqQ8imNc1NqtJeACF501pE2y+Um1iqjpVqgMmSfd4BBfvKrAm8QWnIHSgD4EOEeBfm4+AGy2paJo2IV4dYE9xCyLtyFzCkezdiRcCR6KpqsmT91XFyhNYQOyFZ7beWddpSte2Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(7696005)(40460700003)(36756003)(356005)(86362001)(40480700001)(7636003)(82740400003)(36860700001)(82310400005)(2616005)(26005)(186003)(426003)(83380400001)(336012)(921005)(478600001)(1076003)(7416002)(110136005)(316002)(54906003)(8676002)(6666004)(107886003)(70586007)(4326008)(8936002)(70206006)(41300700001)(5660300002)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:18:10.6670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12b4569-cfa7-4860-62a4-08db053913dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra234 and Tegra241 chips have QSPI controller that supports TCG
PC Client Specific TPM Interface Specification (TIS) flow control.
Since the controller only supports half duplex, sw wait polling
(flow control using full duplex transfers) method implemented in
tpm_tis_spi_main.c does not suffice.
Added extended driver to disable sw flow control and send
all transfers in single message. Flow control is handled by hardware.

Krishna Yarlagadda (4):
  dt-bindings: tpm: Add compatible for Tegra TPM
  tpm: tegra: Support SPI tpm wait state detect
  spi: dt-bindings: Add Tegra TPM wait polling flag
  spi: tegra210-quad: Enable TPM wait polling

 .../security/tpm/nvidia,tegra-tpm-spi.txt     |  14 ++
 ...nvidia,tegra210-quad-peripheral-props.yaml |   6 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_spi.h                |   1 +
 drivers/char/tpm/tpm_tis_spi_main.c           |   4 +-
 drivers/char/tpm/tpm_tis_spi_tegra.c          | 123 ++++++++++++++++++
 drivers/spi/spi-tegra210-quad.c               |  16 +++
 7 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.txt
 create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c

-- 
2.17.1

