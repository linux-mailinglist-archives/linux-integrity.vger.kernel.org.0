Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815774F5D9B
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiDFMEH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiDFMCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A325B435BD3;
        Tue,  5 Apr 2022 18:54:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KQqpW012558;
        Wed, 6 Apr 2022 01:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=dGiisuzzx/uZydxF1lRej1A4fpAGvoVWi2s92L0Gv8YG1EepOZwJ3Gn6BJzSGSr63QGm
 FPs+QMLMv6mP3yUC+D9uXTGTmBuhjenPZ2cyUFf8GpR89GqSx0E1mp6BpSJIqY1oibFw
 ziguzhvja7+FrZ9iRPifxZE/MmYatGpLqB6vGYcGUKRBJWVr1VgLNO2DGRRN6fZS3nKQ
 6vIyZZRtW1DpLoGn/sO0Tgjcd1hweYxyU6kYaz3IXxcb7BsuHwfv2ltrKHCbZd7mLMDk
 y8nwW7HquheuB1pnAz8HudwVkcsfT3GN6/nPzcO/LbUbl473J99hrd13U7/tLolUcb4H Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361pbJd040778;
        Wed, 6 Apr 2022 01:53:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3yesp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APUU7O52+3OCCjpMSe6qc18gPf6X+f7S5JhT//79xj/0NwLL6M5sCcNskT0iyDewVJPaRopqANDRbrNhWpoIlpc4Wr9fhR9Ws6m296+DfBHvQjxE0gojrKMe+iwk7zfwsed6fLo1I7vkZdLizNQcsZ/CrlVaB5LA+I9TLz/mXMbeIvOh1+OgZcvcnpZvEaLx4K4REXQb3pWj/dKQAgaOT6xAsTt5q9WIs/p39KkBQxnOVxU/H3c1bFhGcQQRqHAvXdiDvsWN+AEe5UqdjeD65pX76NaExzpWzJm3cn4maYk0lSWf3S4rrdFu5XjGSf7tV5Sk1yd35eMcxW2Wd/XPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=KC/3yHNr+tbJLuZ8EF/fJCkmzp/ti5vh0HUyQYeBgmgfy/EtGpw5KEd3qjzyrclTaznpm9IObygJSIitWxEb3vQDR/SnBzte8TwoMb/BIAe4FZf8w+IhCCmQKHvINNInLKZgNQiaZdNK9wYxBbDy3qkvA2FD/oGb3mTz/6GCmNbdlTtNgMtUPQ5mtMA890CaH9t0X+YyWeaFttjWn4jBowYyRd49d/OZzVajnmdm/sKdQ/QRRcFS+G5s5JzIW6hV8eZjtxhpR0hWvYx8iaZZ7TCX3BATuGAyi56NzHtA4Tc95tXKMlsZBwPGyzZv6opcyNTFxIrHgaBHMP+n+5cC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILxKA2RKy2S7lmmEzPyc10vgrmbkb8/rXFl/vfMPZRs=;
 b=Ae9XUJFGuhH8vNnGLsGjD0/i6tz+ZgUNtM/SiFEHd0trpEJdM22CdSusxCtl5N5aVomAOmFYS+fWTgTnCM8xzU1YxCMrz7kl2e5v7XqhRrsI1V3Sagi0+3jo7iVLZNN6W5PHuQzZZDtYAVjdeJy1r5amQIMh49KEFAqvUCHSG5I=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:53:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:53:51 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 1/7] KEYS: Create static version of public_key_verify_signature
Date:   Tue,  5 Apr 2022 21:53:31 -0400
Message-Id: <20220406015337.4000739-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613530dc-3bc0-453c-2e69-08da17704c8d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB434997A86040F903B4E4799F87E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbzU6KhKQTle/ZtiYByJRvS4rEDkZ/NXz+bzc9/BnKzNbf1ZRqU5IW1UG7Gz4H80PYKZDrnYaqoDUmYiPN/tayppwkU6+iEOLmrtNmngYITWvwAK7aX6CNsIqobvg6PGxBf6ZZVboWiigBgd+LsEXMq3Nu2swSg2dMmIjv9iUhcGJhB+lI8hrw/6PQhykoH7ayj9xM7Y6wd/h4C/A1w4ppELpGry9Aw8pslSiG6ceIyht273Ch/DL6z/4yDRxxHenH6wLzJQMBl/gKlha+xwpomWNn61dHp2caPUeGwwfqMYGzVp0LdSFy22hxhb6Vbm4FDLpwe0yylvu36TWBQP9VTFuO76K2nkPuQ0TzWfVIxegWPSrrXUVgx9f4/BusWSNX4mTlHNvEvIFD4gvQqD57DaNaujwRuSaaiBLuqW8tDIu1VKmCio3Hggpo9JkRd1gQlYDvoeIILGoYHygy2gwhzaNOn0CeLWM/3wMeRO6gRnnanjYwxYow5LMaDRMhx67JOiG+Fm69Y8yG6x+/OqX3S1JYC/HJWQhVUHbtrIhXdokAdt8Qak65p/03T+HR3YH6RLqStK7cZQQF7yibVg0kqvrzWkKZCBGctXxC/ADXMYgjwwSAhUHCqPj1uIwLKoIpi9Jkl+6RZ8JSdDTE3FpKOYraVxNoaSqZucmhJzPSTC2oU+Ryfq4JJTwfkUnXaZehetzj84L/4BW/kTF5ktzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UtCrPTYc7ydZo1oq/iqqHvxV7//E1QLAHFDTJhHeeaqhqb7SEAIVurSB5/p?=
 =?us-ascii?Q?6isNt8FXpXCI6cfsN8WjgFP3ek8fFk/l2V9k2LCLWH3zhDEwN1m3OHW4t2nu?=
 =?us-ascii?Q?8Qwr0gCPnO9Rfmf1huraJpoR60NWJ0F/sWX6VaRudvtuJA4aaNh9k6JLfw6H?=
 =?us-ascii?Q?Vzr+bCbbu5tM2W062+tfmFNMf6G/rxmZZ6mYF+MdKFKJZIcYv7488Iw1uluw?=
 =?us-ascii?Q?gL7tRSzX9eD/WvESkyO4L3rEwXaxA0hVL8H8Yh520Oqf035a/+j9eAoQdl/J?=
 =?us-ascii?Q?uVqbYbPnauN/8HvONkZw/gtnJZheCfqRQyoWtN3A+KkST4DfnFrlvUwosY3+?=
 =?us-ascii?Q?Q3nBpU0+WzNXtaZmLFxutUAJ/2a3CxxeJIBkMURIfbsEdsxaYjuwXUXqxtxi?=
 =?us-ascii?Q?n7WjgbMO8PkEqXZDuj31JqHLaBPTLtqZq8grJqXyLPZ4WnOw6YF0ubMMAnNl?=
 =?us-ascii?Q?GI0eJ1BAlGM9vcgnljPuCREDlgghCU3XvY0tZ5Kv8XQsbYDD4TiWs5l3FQr6?=
 =?us-ascii?Q?JwM5ciL+9rp5zL4A9eImbPmLNSDwSfdTbPfxjrjjz/YnbQByySzQ+KE0gAF0?=
 =?us-ascii?Q?WlXvYueOVCTtOC8kxblrc5PtR67e2rpg55lF0M79POxMMkFDsFB9RNKmKUA1?=
 =?us-ascii?Q?zAjdU0emTA5/CLTHTje30wOGzjoH5oA8eqOqt1iTWbe/k/K3OQZZySOqkWm0?=
 =?us-ascii?Q?Q/5vOp+oxXXyN/ISdQOujrBVWg1VbCQW4T1aK090suIRRcuDAVEqSQRo81pv?=
 =?us-ascii?Q?pdkvVcQjneZgIxDmj5X/j2HBwz/rYgflDkE0rStM5BoW3P9JrGMDjItzzVRM?=
 =?us-ascii?Q?ZZh16mA9vsEce77CSj9Kr0bXmAmD2frVzzKGQy2F6qClnU36fT5NVOj+Nc3X?=
 =?us-ascii?Q?IyLzSArJFru8m9rJ4APE3lvvc2FUuG18Cj1Hq6puFdy+MBpBt1xHT+zrUo6F?=
 =?us-ascii?Q?mC1+/ditjGRAlV7dmya1PELZ626AH3vl3bwo9KeUlkO6G6B/k/BUiAKF60M7?=
 =?us-ascii?Q?KlsMjGpWc/OlZyJrDyCuLU/Q+JfGhrZ2xwt3vcHy+MIN4NLiIAxLcXrEWolR?=
 =?us-ascii?Q?cDyrJK7eZ4aeuSkmzCcqeoLFMvzfKUBiov4vLXSVvQ2h9W70Bn5TRtZ3tPYT?=
 =?us-ascii?Q?rxJiH1+tj3uvy6tnBbjnui9YvYl/ockKLsq1Ov4x3xbEVpW58M7wc4h47pSn?=
 =?us-ascii?Q?XGvQGE2Y5gRW99gTeDi3n41qNjpUVLzTTIzyznX9Nftfq7Ml7tRQvDATPhTq?=
 =?us-ascii?Q?aJ+DBL7jMAaOHhgHH+YW+rVHiW4wK7B7iU/0go1fGqJarlv9OJnMJoXljoBd?=
 =?us-ascii?Q?pAHTUzcbCEAcii6Krl2iqtRihP6y1bKnQljM3TdwnxbXuId96Df2JLYO8W4b?=
 =?us-ascii?Q?MADCDIL8OH+8cP40P30BXgG87utizIvTsvVKjNx0eMAmsxId/DQe5AtsaEhv?=
 =?us-ascii?Q?/OeyNTa4dME2SKgp2bke86FzcSPPHrTfjMopwqZ1o5HYRGmLKFORBBulsjHn?=
 =?us-ascii?Q?stRXtZrkBmuYxZJ19kn6+NbQiWRil/bkcD9BmNwuidVGcHu4P+y/l9lh2RPN?=
 =?us-ascii?Q?rnXJuvGXEpB5Yt228pNvUwD2VYp+GYECOuPCOKJoTHFKav9Dq114S8UlDONw?=
 =?us-ascii?Q?vgYk2v/ElQP4b2EmcKf2YVTyV8aKS3V0JQP677tJGyEQq+G0P91Bq388jeTr?=
 =?us-ascii?Q?pWv+iTm1wcQpmj9Y+zEH9PlwXKIp3/bRMstlfsCQYymW0oKN8FFzjzoHzNje?=
 =?us-ascii?Q?I5h8lnyU1P8412/dv4KpWb9vxWcQDl4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613530dc-3bc0-453c-2e69-08da17704c8d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:53:51.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dkLeFDFJtubh4HUbGi+coYeUadkma02UA5ZcqdjSaMX3wSQzUVmGTn4HNSDlyFSYDbQP+KuM1E03Gnbg+jbbHxHMhvs7Xw32eAlEIDUwvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: EUtiOETVl0IrhhHuMZ1yqilSXzsONKeX
X-Proofpoint-GUID: EUtiOETVl0IrhhHuMZ1yqilSXzsONKeX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0

