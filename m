Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF11123FE
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 08:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLDH7x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 02:59:53 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbfLDH7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 02:59:53 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB47xgXj006913;
        Wed, 4 Dec 2019 02:59:45 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkp76jkqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 02:59:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTokhyBaXTzfcijCCcc/aCFmfkpNM7vgXA+YGAqr/+0+Go0TwIGwjGzOi+kM8WgXUBusAviGj6fodw3Y/5u2M0Es+73X6gcvxKT5eTNeAUNgekc8dC1DruW47pNAgIwV63b5+Zyafdg/K0HZM5gJNeNr8qG+OmeoClHNBnKqMmpqZt48ANfsLyoryW2mDq9mkRl/2gijpbnuQWaxniXaTk+BPIwDDXBO5TBg39pZvqHgZBT/vLj1bHZNX7762RIVzH6+9Yu0e7o717jMi9FYq+S+yaaRkWHsICqijTjcjyoOkhuf7AzdR9BSqpiixA4WoKNRsxSGoUsxZ5CnFwSuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toob3OX5/OlJqul4x5WXd+ISn28GGz0UHhJn4xkvWmo=;
 b=FhfSIixRI4QnhxYBpoF5RVCBeN5Tu+J3eht2LdCCy/WBDLxP1EK8oF4tuikZ22N6T1PuVZsp0y9Vf2ZbWrqVxAaoWeAD6TxOWDQbgHDPmOaDoQeasJ3Qedj8dQFHiK+vEKlvrlFf24TrU+BxAIn6mZqYc8TdLMY0nboU6LZOPOfHB8Am+Xd/bxQ9UcDJtvefd7KlpxdXmWSMNwKwIYF6EIJ0a+uZ3hUU2duaumS50ONf2tyyT+GKBaE68wiCRl+E4ZKzpaer+8QKbCRnLwVSd7RJK/4jbmL/oJ/m0Yt+bQaiqF93826OtJVeDI/Q1HDAKJkfPWzB9V4Q/DySd26/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toob3OX5/OlJqul4x5WXd+ISn28GGz0UHhJn4xkvWmo=;
 b=aC1slvFazvITktSPQh9oNbMI8i2BhYUn2mlej/QRA0PXNXETH+Ysp+Bh508M+me2cv5pXfzYcpYJNIU3JeV/mo00KDjStudiLSSSSzfQRLH1GsKVUbiTuws1xm9p0UwZ/EcS6z8SbqS5xnf8ouOIcPp34Lmuf4v+T7RrYNaBwsc=
Received: from BN6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:404:23::20)
 by DM6PR03MB5291.namprd03.prod.outlook.com (2603:10b6:5:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Wed, 4 Dec
 2019 07:59:43 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN6PR03CA0010.outlook.office365.com
 (2603:10b6:404:23::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 4 Dec 2019 07:59:43 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 4 Dec 2019 07:59:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xB47xgCY018394
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Dec 2019 23:59:42 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 4 Dec 2019 02:59:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>, <arnd@arndb.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] tpm_tis_spi: use new `delay` structure for SPI transfer delays
Date:   Wed, 4 Dec 2019 10:00:49 +0200
Message-ID: <20191204080049.32701-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(1076003)(5660300002)(26005)(186003)(70206006)(70586007)(426003)(356004)(316002)(14444005)(86362001)(336012)(51416003)(7696005)(7636002)(305945005)(50466002)(2906002)(106002)(48376002)(478600001)(4326008)(50226002)(246002)(110136005)(54906003)(2616005)(2870700001)(8676002)(8936002)(44832011)(107886003)(36756003)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5291;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95888c4-df36-4320-feda-08d7788febf3
X-MS-TrafficTypeDiagnostic: DM6PR03MB5291:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5291640D30E506F6279B4888F95D0@DM6PR03MB5291.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0241D5F98C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bg9NJMpWiKqq34TXt5XQGDrK6uL+7zdh9Es52scARanQXSEGQUhaAqj+jREXHBE51yBB10VCCv6mt3zTQifXLt8VFeIZQttcStAHhd2FBepD9tol3pq1VPmIqwgjsVAvKxiU4l0eMIEylO9byMCP0bdVKX4ZvFxOXJbj08F280gmVS2tqZp/aFvgy9pKJo2Qo9b4D9MOI/dmiON5y2PKZj4YAffgVfIrXT2NsjEns/j7P/fq755KosB3UfPHo3bXwm/Tv8MAOP7QP4dcnpXb1tGx1STIgzMngFU1cw8NLJ6+ELC5V/c14lK43tF3y1UN8LoKlX3rF70zZp8vRk3fOyZmbelHVTFGBmea/cbdd91w9ETsrLWBmRboYs3xQfkuX4R17fOQ4VntmpQ8ZF35Zl3sRpnoKRUK1uS5Ju9BWrkuqsmiVz+QfnhP8nbozK3lixaNc+QjygDxHj4jlTLCtVsVU9vyCDdR74G1CJu30Qsdnde36w+nitqczwIugpwf
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 07:59:42.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95888c4-df36-4320-feda-08d7788febf3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5291
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912040058
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current `delay_secs`
with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6485 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
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

