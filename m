Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DACD696E62
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 21:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBNUUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBNUUS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 15:20:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA984EDD;
        Tue, 14 Feb 2023 12:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1gvVBpbYmaCcOCm7agoljCe67yfsli3RfRfPRVf90EmunP0/MOJw9OXw36L7/LcxrHCE7TVoGiT0krKWaB3B1rjuA4sQUK2liK6j7ywAw16aLTbdpaYbOLMSb2+5dyNQod9r0iAMdyLz2g98X2cIRg7emdPYhiycma5Mre6QMcSv5oQAdXNoV1PdyVKe++QcTxbiXGtyhGh8ggvBr7bfh2Ak289aF2q8wqPwj6MFnAP2E1z3rsQcuaW6ezRn5869mfdwq9e+8YF7fK9dopDM2YZgn+WzBzB1UrzXiaAZ4PXkqXgXSL1tj6WBGk1BSLzkvcy/Bk+II6DzeheVlQ6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu4lsiu2qoHKuw5Dupax5dpTHTA8319GgQRRBiIxAqw=;
 b=FjRThi+mSTE47IYQ+hAHgvtStUFu1dmEV41rFidEMb+vRu8co/q57604xW1m80zqRoMnLhAD7iB9FAM68joSFvZ+8PUZx81g7mPmn47pRzRIISMD7I2VwUxMhzMW0nFHlihs2/q0/OXxAcecTS6hZ8sY5dI0XvRhvWBOct6qhzcLedhya2vpzHD+zKwrmBRws6k4hH1ie51QVKN7Vhzyw9wFJdiIaM8qxwRrKu0VI0HfwBkkbxL067TXvEybPNeznolTCFuHCABjG3AwttXtR/S4IE8g8us0g16IexFLLBr9mbzMGj6Cd7mnXSdwnJPBm0uE8Hf2EKW7wRZzpfk9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu4lsiu2qoHKuw5Dupax5dpTHTA8319GgQRRBiIxAqw=;
 b=47dnARc5MZFtMvyW83os2jpX6A/UgLLKR/OoY6gze8gsWCSZgiuIAkoTWupT6ngWDXLI5S2UC3vbatVcVL6Q3/G77M32dN+2cYakMN49hYolmLfFXQonlqlztW9lnUtoshLJG6hsdxhB3ywYD1A3fcilD95pwAsMgXEjQhW1ZVw=
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 20:20:14 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::93) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 20:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 20:20:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 14:20:12 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <Jason@zx2c4.com>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/1] Avoid triggering an fTPM bug from kernel
Date:   Tue, 14 Feb 2023 14:19:54 -0600
Message-ID: <20230214201955.7461-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f27c262-c69f-4869-7d27-08db0ec8e156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThQiqQAUN0GMLY05++oYMsg/Zn2Mpxw7c+qPs5Plz8VHseAwrlTEBhm1hN/nxPEaalOTxNTDTuL90H2ECn/DiGLe+qW9nkcUtcc5eRYkkoxvLfTwcf1lmeJvMZ09NKVYmqFaqRtstRr5+x8ylwzmIFLHpJe4sz3jyK+SA+Mz1394OFyrkOicBNe5WyciQa2fMvWKlzqtItQ0a8PDcJmCvmpXYtEDKg0Lh8lRA2xikRsQ3HwYLKRv6yCrAURsMaLwQFsi+UEe4mhFsRQk1GkoFEZewUB7IOF5IXUpCCAIlMLPsJ71PMK9IRLonv12YOLJI0FP59ayv1TbwsD+O6Pc2/d2OZ+PPvh0IXGoehMHLxxP+0d0/Fgp8lHCSSFGrvRZxm+O/Fr5dHYME0UMprnkmOIvxT/a9Saoxm2nEHXUxJ8XCLEBSRGd7gx2jew7g7Ks11xzNJiOVDX93Sf2V9ntGdZcFF7XwvHEVQLQ5xRIuSYo0EFcazNI7jyE6LwnaZmxziBUA2ZqjzVqVtQ2gv2FyhLtuDgb8OGVBVqpVTPCyZ6PrMtmDDtKNrw8/vI3Ueu6GfIYv4aoI1d/P7G5RgNyFwebcu0vRCP/1KhSL+DVUYXMqgGsY2MPaA8ieq8MbtPWmyCd33axLdYfGpfU4uld8pLaV24TKSk12CMBsJenaXpLVem3NtHuSrPNe4z4vsOVYpHN/Ezp5Thm0Fpa62UBpzsI9XOZGdcamRObiCOkWu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(70206006)(6916009)(70586007)(8936002)(5660300002)(8676002)(41300700001)(4326008)(336012)(40480700001)(36756003)(2616005)(356005)(186003)(16526019)(1076003)(44832011)(26005)(4744005)(36860700001)(478600001)(7696005)(54906003)(6666004)(86362001)(82310400005)(40460700003)(316002)(83380400001)(47076005)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 20:20:13.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27c262-c69f-4869-7d27-08db0ec8e156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

AMD issued an advisory that having fTPM enabled and utilizing certain
functionality can cause stuttering in the OS. This was a Windows specific
problem initially, but commit b006c439d58db ("hwrng: core - start
hwrng kthread also for untrusted sources") exposed it for Linux as well.

This issue has been fixed by newer fTPM firmware, but not many system
designers have rolled out the fix, so to avoid triggering it check
AMD's fTPM implementation version to decide whether to register the fTPM
RNG.

As this regression was reported by many users and escalated by Thorsten
as tracking the regressions it's being sent directly to Linus to try to
catch 6.2 release.

Mario Limonciello (1):
  tpm: disable hwrng for fTPM on some AMD designs

 drivers/char/tpm/tpm-chip.c | 62 ++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h      | 73 +++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletion(-)

-- 
2.25.1

