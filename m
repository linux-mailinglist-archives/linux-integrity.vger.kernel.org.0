Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3985122775
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 10:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLQJQk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 04:16:40 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:15788 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfLQJQk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 04:16:40 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH9F18q025947;
        Tue, 17 Dec 2019 04:16:30 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wxf1msjvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 04:16:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWbNAQUj/l8qjYCc576TUTZQWIZ/74GwL24KN1KmpTdyIrVcnvFimnT5s77SIEy+L+jfkU0DErJ/NWUJbuUh9o/90Tw8SsannhcBHPsJcXOYuSnDFgp7xNdhPvnBSB3cISQJ9YYTWwQEsj8+Wn6rskomli3CX4HO5NZYZJd3yUM8Uxzx27YpLCPVVfJIcco0Bt5HLq9J6BNHpDgjDtkILL3XLJLw9qKNMkuXyqfVnxUwxY9tcnX8jhMROXrozz+3ZlhcwZrXGq2rMC9KO+Y1YlHkb0wCe8XL3ZW1HFc/G/kDwR/qvs11gzie67zV1ObnWWFEIIJbXjt5inVpAHHX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4EDPQGvqtAh2MZR79VceHLjyLBXcLiY/Wb2uIqDhBM=;
 b=BPxnb6hz44IvJeGCWKXGfhSSaG9lCH9FSfzbVAdwrn/cx4Y+E5vIcMjM+roiuH/8eBMw/R9+yxVHCt8Ae8ZVtTH2bp4dqybxhMFzQAO/Y9F49Sf2sASYmP8zMYv7o5qLCr43LH60m4m9eTrequNcgnp7TOZr9cC1HT5fvBQNbb6C8e9v9qYZfECvXGTIO9BCX0zbnIwmatwW1YKGwB+6nb8Gwa09BQKRD45BGmVwuXGRYJ2hCvvsltt05fkNSNefygZvK6cN6wM+SsmXzFYmSW+ayDfALHHknQ5FsvuIGuFYHwPTAzm7mFPS+085gQ4jyzGU4dOU2G/NnwgNfcLehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4EDPQGvqtAh2MZR79VceHLjyLBXcLiY/Wb2uIqDhBM=;
 b=AqJbXtcMIEx2bvAwifDYAAFdgU9CIv+r7UHHowu6FQE6Qf0g1f2CJmxEAZGsF5B3Y6mHrh3h3klhjrlIdIQVxmwfJKMv46K/Zyn7NjjKHnkZ7GcCG0JmT5N2E9AShcrguQoiNqlrhHlEZZqNJAFtom/ERs+hwTgciD7d/5sVx3M=
Received: from SN6PR04CA0095.namprd04.prod.outlook.com (2603:10b6:805:f2::36)
 by DM6PR03MB5306.namprd03.prod.outlook.com (2603:10b6:5:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Tue, 17 Dec
 2019 09:16:29 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::4b) by SN6PR04CA0095.outlook.office365.com
 (2603:10b6:805:f2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Tue, 17 Dec 2019 09:16:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Tue, 17 Dec 2019 09:16:28 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBH9GQeM019258
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 17 Dec 2019 01:16:27 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Dec
 2019 01:16:25 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Dec 2019 04:16:25 -0500
Received: from saturn.ad.analog.com ([10.48.65.123])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBH9GMb8025878;
        Tue, 17 Dec 2019 04:16:22 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI transfer delays
Date:   Tue, 17 Dec 2019 11:16:15 +0200
Message-ID: <20191217091615.12764-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204080049.32701-1-alexandru.ardelean@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(54534003)(199004)(189003)(4326008)(107886003)(478600001)(7696005)(8936002)(5660300002)(426003)(336012)(7636002)(8676002)(86362001)(2616005)(186003)(6666004)(356004)(2906002)(70206006)(70586007)(54906003)(110136005)(44832011)(246002)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5306;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0691f0-4646-4bcd-d4b1-08d782d1cc50
X-MS-TrafficTypeDiagnostic: DM6PR03MB5306:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5306E592135F81B890A6C6B3F9500@DM6PR03MB5306.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeUcg+K+hkqniABFuOBZUMidTLIIXidRdWEGhryA9HDMXRqkvd5FoZ7SQp/e3gvQLnr9YRv1QAun0GeCJraOAvaWiwB02f/RxouzaJ+y5DvDnTgAQnmSNUT6Xb5Hix0gN258TaisIwFe+i3RUypw6+TDZ8j5Crg3LhdFiqbmjnweeRUo/3QOeBekTAkDHRtb4NaxmSnLl92Ft9pkSl+0MoWT+Rg27yEHSQZA1RmDHoZ5IxSqZSOdUd9GJROvzCM6WXNcz7HYiGzL/jnNf2GpQXb333bjyrif51pNev9qRLKJfRyQW7u58/jMtO05cwbAYkfGf57IJfDmVXuJAuf29OBbd0GN7w80KwoNBezIomLRXhiibsabto96kek6rlkw7YQ7kZLcXeSx+U3Jld1ZpS45IeCFGMFLelS1eboTsThgNREj7oFRadWBfZDOzDNz/fv4dkNTbRx4Z50YMmxfqGeauUVMOuu3i/RHOS4KVHs0VqTTMkG3QOfGse2BurKY
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 09:16:28.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0691f0-4646-4bcd-d4b1-08d782d1cc50
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5306
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170081
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In a recent change to the SPI subsystem [1], a new 'delay' struct was added
to replace the 'delay_usecs'. This change replaces the current
'delay_usecs' with 'delay' for this driver.

The 'spi_transfer_delay_exec()' function [in the SPI framework] makes sure
that both 'delay_usecs' & 'delay' are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6485 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v2 -> v3:
* replaced symbol ` with ' ; did not change it for title of
  commit bebcfd272df6485 , since that one has been commited with
  symbol ` in the commit title

 drivers/char/tpm/tpm_tis_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd6c573..d96755935529 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -110,7 +110,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
-		spi_xfer.delay_usecs = 5;
+		spi_xfer.delay.value = 5;
+		spi_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
 
 		if (in) {
 			spi_xfer.tx_buf = NULL;
-- 
2.20.1

