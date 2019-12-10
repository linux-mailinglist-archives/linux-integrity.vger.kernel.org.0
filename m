Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFB1180EC
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfLJG4k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 01:56:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65088 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbfLJG4k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 01:56:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA6rH6d003154;
        Tue, 10 Dec 2019 01:56:31 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wrb1s83v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:56:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wwkz/EQ0TOZF1jP50PiosrZOXd9EEZpA36dZWhiNx0wtppVqFgN43lH/f1s4nm388dx3OZcF6MSmNCV3j9LIyQ0n72kCzK6kIIXim8TBAeS0RAwnMH7oyU6dXgoO1/TJj/+tcweDzEn+oHi2uY7bTMgWNNVVAZGCtAPqciOhLBHDt7lwCzzcKD3iYRmIzIY74naF14XRaoQel5grbsah4UP2vbRzo3TAfgMgLGlz9QGvdWDBx/vvlmW9Ai64FU/o9MNn30pPdSzAaonnwSCSMys39v2oxCYE05cBRaZNuoAaYjis6BNb97Z6Sl1f0RkLxo9rx+793CBRYE2JILtumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga/SDbL4y9VJszCxq3G0sJo8U3USmDWRsFHvxybOPmE=;
 b=Z20ocBuhhE5XrHkW73gZ3QH6I4iTAIuSM2xs15fyfws/UX1qyu9YfWZClbDJb5ZrLXNv17ECozh9wm7LzT+h9/tvTXc3BsP5WKtj9XqZahyemjFRCPeUTuRbWSW40/g/snCG+xUcCZTYUTzOYFk5cJ4v4bk2okxvORdrjO3QqjfmbvpjFhkkoeMhhvjsgcGHquVkYd+e2t83mAC0kxGAK+v/2s4o7zN6bQfq/F2R3T3JIdQuoe5rra0/M8VIXz2rd8sfPBTbkZnSDVL5VJglNS3SJse8PpXY4+Q992atAZI1WsG/f87JxOlhHPDSomcFMxf6kn7XTWSV3UJuMJcN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga/SDbL4y9VJszCxq3G0sJo8U3USmDWRsFHvxybOPmE=;
 b=QViiWSS/lUITsgzOe8GcK1f3HX/QxTE26ocTmEcElm4DkQ9fagMe2vrb2NOY6iaoaaK2VFLTmetm4W4zFVa98uaTAwaSdzRZmlLmQz+faa4QPcRP2oDcCsyNazJpXCCRPd9f6wQ0oOqIyQbYAZXayehGguZxWVOVfoEtdQfFgSQ=
Received: from DM3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:0:50::11) by
 BN3PR03MB2193.namprd03.prod.outlook.com (2a01:111:e400:7bb6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Tue, 10 Dec
 2019 06:56:27 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM3PR03CA0001.outlook.office365.com
 (2603:10b6:0:50::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14 via Frontend
 Transport; Tue, 10 Dec 2019 06:56:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Tue, 10 Dec 2019 06:56:26 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBA6uP2i012670
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 9 Dec 2019 22:56:25 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 10 Dec
 2019 01:56:25 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 10 Dec 2019 01:56:25 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBA6uL5o021168;
        Tue, 10 Dec 2019 01:56:22 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI transfer delays
Date:   Tue, 10 Dec 2019 08:56:19 +0200
Message-ID: <20191210065619.7395-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204080049.32701-1-alexandru.ardelean@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(199004)(189003)(54534003)(186003)(70206006)(305945005)(8936002)(8676002)(107886003)(336012)(70586007)(36756003)(44832011)(5660300002)(4326008)(246002)(86362001)(7636002)(426003)(2906002)(2616005)(498600001)(356004)(2870700001)(6666004)(7696005)(54906003)(1076003)(26005)(110136005)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2193;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a634ba-432c-479a-d1d6-08d77d3e139e
X-MS-TrafficTypeDiagnostic: BN3PR03MB2193:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2193F7D79FA77C31BC89ED91F95B0@BN3PR03MB2193.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 02475B2A01
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2jKMGkgvGZA6IMDIVelgVh9PN2rSUXcUGYJYJ5oquRFWT/24ViCjqB0d5BJGOUdOce2tC9zxTNyXzBcibHoUbOPWetpdMP3PFsGRBp3B29i36HZ7Ko/upXmpzEcewoyqmUz1KEpZNQmU4PvTmNwlBZ+zF/t5MGahmVy2yQBfJkBSvaGPLKhQOo2A+v1WEHp2YxuPaqhv71LJw85la3v/5G9U+3FhB+qye1G5S7W0J3eBBnkNe1Wa/NLuWQed+mv5mdgFbMlj3NBaA9mXkHaP/+hfMyGSbQxXE4i3A+VszBzSt/06Fd9nZu0QGeMYlbEqDPPbudBzp06h1InZ2H0suNWik1zI4nYeKiRqHyDDj4V5FtEt4RqES79dPrQOPxn0I+DufjnuQ1j35UIFbsf7anaWn0WgIG3td6C2yQQC7N/FFsao5cIacWZCuEUpU5t5jv5J8l7QniEV1dY8UGFDnPWcvejs5ui8nFNRkejbVVRqszZGzCDmJjBZelCr22QL6HyFSMdieQqxlHrX7cUgQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 06:56:26.5703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a634ba-432c-479a-d1d6-08d77d3e139e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2193
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100060
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current `delay_usecs`
with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6485 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* fixed typo `delay_secs` -> `delay_usecs`

 drivers/char/tpm/tpm_tis_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..1990e79afaed 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -105,7 +105,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
-		spi_xfer.delay_usecs = 5;
+		spi_xfer.delay.value = 5;
+		spi_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
 
 		if (in) {
 			spi_xfer.tx_buf = NULL;
-- 
2.20.1

