Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA43E49EF
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhHIQcI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62920 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233135AbhHIQbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:55 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCXsv017710;
        Mon, 9 Aug 2021 16:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=we5x6i6or0UtI+IFyCZJ4GEZz7awYd5LaE4KffUi3kA=;
 b=I8KrYICcLAVW1AOts1h1RtAZjWKd0VXgQfr1COhll9qxWlypC0se51u5nSTr5ZRdMHUj
 wwQ2EDhiU96PqzRkJmsIAYgefaqjfim6ygZ+fjcc5EVi+TVBQRr0JMQ7e6YV/N6yJMsX
 SG342Ey/MxOIQYg9ByzhKvoBrFEGc2WZZtRfCcT3VmAUMtssT7XsXBZsfLMrHA8XnWHL
 yVmi/wWltNZVOol08hUZW7/uyZgBN71PGL+Yum2Yc6njJWz9wvgVsWAnL18RgILZWIJb
 V0wNe4m1zUWezezXfISXBaaHowZQSmUjF5MArb8eUPmSg9Biqu+E2JIvA0DP/BUvfvvu /A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=we5x6i6or0UtI+IFyCZJ4GEZz7awYd5LaE4KffUi3kA=;
 b=Sbv6rPfl5YIXNKfjKODDdm60R50ZrTDKiID+jHmO8yE5JCOsyqNl5U2/qIX8Vfms21xn
 T6RqMTIUsH/osEn6CZrBrlzbCrA+v4uRxTbsg4hHt7xdd4dlPyP+UwZEmfpwhlBhUuF3
 +0966x/VSj8W9ArrPNdCyGn6o4VRoZgk23m1EhfNTb9q0cKGOhfPxYP/UAlMpMnqZQGb
 5wjYCkcLGS4C756ya/BbGkah2+YJUXDADAiDskZp9ntBUj63Ib68WGf/bIeJqRLw1JPk
 3D2Afrx1kC3n5GYlkweX4/cbQ/eOeuMwcizcy1YW5nEmAsvVZhOcJRLRP63uc52V6kMf 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01r98mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUeFD066407;
        Mon, 9 Aug 2021 16:31:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv3860c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl5DPUTx/fY25SATmX3w2eO7DUmQJRsmbspZfiy+xgC1zCCl/f01iUWAoY3UjUFjifO0TBF9m2ytEBhKdaTEPoKb+x6sKMD9WDXAV2/gCIZF+H3jyCVxeDcRRFIiALyJ/L9gaxJ4O5n5T7EdSGGCYkkxiKDSyLIlF+w5eTRQ2eObZ9y3xPoUVPMWHe01gbn/sg1NmablZubFlnaPwHnOf/DyqpokIrkGl2IY/hDHXMjqMKuUEdPWI/pOQVX+xntuQywPkiepCJ/bKbJgvAHJYHcHFpyVCxBGtZb6coC9MWNPpYtsamE7nVniv62c510ysAJoEa+X8yP2/Tfsbl7D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we5x6i6or0UtI+IFyCZJ4GEZz7awYd5LaE4KffUi3kA=;
 b=eFeOQZaqerT7bHvLvSioM1AHkA9rawrz57Ei0jZjcdsmwOXlfW8eppW+Dj0WG5Mtf7GtGF8Jz0hC1Tg5HTCt1Zr/DBmPSXCmyqciDCBqJUC+K5AG+J+q/A3KPVsS64bhKfC4fhAeZZeqm7nza8MwsQXzbrs0ynsYW6DC8ogaQX9dNpYq1v0OVxAXpND5yG4Rzw7GYZP08fKOxNm8Ph0QwuOqzRZsk6doSVnS+ADE7xPofs2ef+lARelbd2ShYSl0FFs4Ys8wq0JCX0Eh3mzTCGKtN8gljQAyimIqh4tb0GycDMxgnq9mmR0O/zl1PbqKLxsUkvSzKySDE4z++NTfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we5x6i6or0UtI+IFyCZJ4GEZz7awYd5LaE4KffUi3kA=;
 b=vs2uBkbsllro9i1JSnh+yECFqmouen/Zcht8tR5VJsNPXVdyDUVEiePQW4D7jQDGuijzrvPRpDQvcukKP8B5HTfyS2mZsqulAnXjMhlOxzOdSDEaNd3L3EpwFtdgQQud6x2AVA05fVKcxoQayWcIp2LFjNOonTUpArZPaFl7NkA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3939.namprd10.prod.outlook.com (2603:10b6:a03:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 16:31:05 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:31:05 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 14/14] tpm: Allow locality 2 to be set when initializing the TPM for Secure Launch
Date:   Mon,  9 Aug 2021 12:38:56 -0400
Message-Id: <1628527136-2478-15-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:31:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15fb2233-0beb-4164-e3cc-08d95b5315a2
X-MS-TrafficTypeDiagnostic: BY5PR10MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB393904F4159855FFD6D20E48E6F69@BY5PR10MB3939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abIS8D69GACayTravVKA7Khf+BguIpxUMSnReELgzl6AIYM7e9xv2zKpWVfohW6dwy0zUxrzLF+lJvnb3PT5x2f1X+WG4zqpRTepgFLWhYhYv89iuYk5RbdZXcoFqtVp6lwt2XpmyYluSK33OQKp3J0EWN/lPSb9RpZ0AA9Nt6xhk/v+1IguSzf6Gf1eS73F/Io+FIo2LQkvTQPy0mFrOP1ka+9u3SyHRl/0zmdE3mtnWzeZRRihtYIFM00C0cycjqUXJ+q/vhWXRwm7ubeBEvro8jXsfhf2fCbI3emPW/rxXo7JHr+V1fhlbMVcPZkEmntp8VYcPCK++FJUnrz8kmKDoeG7NE/I85gX3FbuiGWF8WKEpolGSjDfIy6w8oqe01O4qDxxJb3GaUaEBcJ7Hjzjoo+6jqDjLj9Ew1IExcMvWznx13pmmpVotPf9eVN4WXGPLcNF5+UmmUgKxXEtqy3NC1AR/kELcF1DyihlveBRXJTs0FNSAwq6WpDw+jPR9nTJ4pTra3KnN3RHju3frbx6o3z/+iSYHpDICmeI4UZqgXtWvO1hynj0//wSzcD+tQ+9jsfOZg5J1EvMOhbx/28mS8qOKnGd9tA3ljlB/IwoQDmJQJivKesIEIpMS6qZZz9xsbraCg2WblT+x1dZBqCw85qG4j1m97ZX2IExgWv2N8tOw+BifCx6zBwH9O5rT8wZno9SoyWPxFSqHLodFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(38350700002)(478600001)(86362001)(316002)(38100700002)(52116002)(4326008)(7696005)(7416002)(2906002)(6666004)(8936002)(83380400001)(6486002)(186003)(5660300002)(8676002)(26005)(44832011)(2616005)(66946007)(66476007)(66556008)(956004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnZgU14P1Tfsd+ILKDObz04fho56Xsopi3/mzT6qFt2blIjHtuV2T2CHJ8qm?=
 =?us-ascii?Q?sbFulBMlKvNjAlUspBLww8QFGjKNjeNAdvPjkovR3lIEsKdcSr1406jKhQ9T?=
 =?us-ascii?Q?Ay8GWlFUIuWxQOgjXboKUfCPS9x19QcCbQ8jQUDsxY8kbx+LRlMQUj/iYgQR?=
 =?us-ascii?Q?Pj1nQwADVWHbJpEMXNUJVjX/fHMewINh8JKMFUJ/gcUvVw3MFHiaF/YrUIbD?=
 =?us-ascii?Q?+k4cHSQe00BZnjmmQe3ayaPn12ZnwhsXDNXbCE/62OX/LtnFqvsC08YaKEMX?=
 =?us-ascii?Q?oKBKhhTQ0uMuEBTPqaaOvApD5SBZNgteZHTOyLqNfPEPFIDvdquOlSJ39IKm?=
 =?us-ascii?Q?nvnPjvqJz94EMmZBfLyHCQJE78W0ufGnAJ2QX+HUupM5SGzEM42Wqd3FfhrW?=
 =?us-ascii?Q?WoTMF2TNSShhzRqi23kxb6UgNO/37PqvAhvjR3Rn5NEU+WSLLmDQmPdDLoz7?=
 =?us-ascii?Q?GKFoAgpyZ0jcAJx4qSNB5kVU+U//UmZA8dh3uvXUasJS2DeVGYB5XJaZjjaI?=
 =?us-ascii?Q?GE7PKfIqM+pxnrubIAmSwDtuEQBGNJkBC9HpvLUP4ebjWZc9qb6Tgu/XbWDi?=
 =?us-ascii?Q?bHvRv7woF04sbv5U2ZAV4jqgTKyjkxbRYzVgL3NruLNQm+5gror4EDN37Hlk?=
 =?us-ascii?Q?Ea6B6JtA/Q355O7AlqtW6IlljScvdWwMSDCvgGHF/nwkE+E+megQ1k1jW8xb?=
 =?us-ascii?Q?UaexBG6WUWsqYEiK2AFQbR5SSOv/T3bPKRULHSOwLtk/doVvzgYf2lA6C6gP?=
 =?us-ascii?Q?EF7pLYc/8LyF25U/pqX5jOZlnwGAR21u1GLVL2A3ZXtgzqChLjdPcTpylbeC?=
 =?us-ascii?Q?wvZsfNJFcXudpgTeB1HPK2BN3wFneexTE4iBJArspsIUPhuob6H74iMt4EeX?=
 =?us-ascii?Q?UgwtPSAg+fH3GFGFPHz2tx3zPWqA0eSgDLU65RxBuvOHTnpM+6Crkl4FC6um?=
 =?us-ascii?Q?BNm6Zfp089tbdoybyLc55IVNpGpq9bP3ej4cYiLX8GR1yrXgLRxKtbfta9iP?=
 =?us-ascii?Q?UYP38QNDB/Esp3nEFpOkUR798JyXHKqB+3eFD/rdMn6Ygj1X9K0P8ht1d8Bd?=
 =?us-ascii?Q?8GGBO2tfG6Obw9Y2aSWJiNdOnEViPj3HxPueOd1hIXqtPEg5fK96qb2o7wUY?=
 =?us-ascii?Q?xGQXBUckOey4173mNJsoAva5Kpy/Eb7odpsZ1zEpjAyAfVUDBlbWWoTdcYBX?=
 =?us-ascii?Q?2oIGJ2xh/VganF7OMX5NMKizuFIH4X4jvtR9l2HPrk+jozYgZgB2LAwojsG2?=
 =?us-ascii?Q?I69M4Rh1u7D7rS7xP+1iBvRT1QztdQjTD/om8v3vABR2tV2sF/D40o6vRrHV?=
 =?us-ascii?Q?GtIl/F2ncemSRWk58dyBoh5/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fb2233-0beb-4164-e3cc-08d95b5315a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:31:05.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pmr5Bg/PM3wsi+1yoWbN8+CDUnYYExdnLtpxDjJYsOY1KW2EBSixrm9eX0XAhzuBfgZ3q/YVCNhO7tjWMJ6EQkOaoCH5GAjyZkTC/bhYe8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: gY9d-duv_WGI9cVaQFbLZKxBhGrVs0QX
X-Proofpoint-GUID: gY9d-duv_WGI9cVaQFbLZKxBhGrVs0QX
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb..48b9351 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,20 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
-	int rc;
+	int rc, locality;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE) {
+		dev_dbg(&chip->dev, "setting TPM locality to 2 for MLE\n");
+		locality = 2;
+	} else {
+		dev_dbg(&chip->dev, "setting TPM locality to 0\n");
+		locality = 0;
+	}
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

