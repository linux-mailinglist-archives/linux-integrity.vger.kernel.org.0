Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0813B3E9C53
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhHLCVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44152 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233645AbhHLCUb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2AgKY019120;
        Thu, 12 Aug 2021 02:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9raf28RglAZn6k1+01Tbi51tg8sLixVJzgzRviuM+T4=;
 b=fSXP8Y81bsS1bPP6SF/wEI+TconfXdh7HUeNz+DN5jV4kmy7sktM2gqWOr1lWe65DshT
 nPBWrKyjz1+A5glub1GPzq6bf+zZ7rmX0O266RlSTKvl6+xPi1qq511QFHwlXxr/Cvud
 TaAwiFDDZxqvTjYSdS3gkspmrUeq6dHKUaf6e3lqB9A8outkkmPV7kj2SDX2jwWs1YZp
 8ITMkNPVKyxJ/5r2rR+Hec8n8IzTFQIHB+LsydnNUHahVR9fNOaLHPALQmSxCJb+IZQy
 QUEf/hMqrd+xpeutYiR6CWFgU61Vu9mwMo8nT720OOBky+zWiVa5pM1yEFDVhr3WVltE 1A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9raf28RglAZn6k1+01Tbi51tg8sLixVJzgzRviuM+T4=;
 b=gtwhN6W3kA/JLtHTEM9wdGbz5PrWWdwYFdpqj4D44zwv47NINfPCujGRgBFwwyLTDI+v
 +TV6GXigwJmTeIIhAzbt2c5UrfGlFICADkkqKQm9ZMdum3XgT65tgKz+AuaB10mzvYUA
 E8Qt6w02BjNCqJl8C7sjFX3o1FelF3VU2ru7MECd3ys98svrDFCu2+sAlEi2ejApgIGz
 gw1YWBRn+JaRxTidvAqV3+TfzZ+ZMwVkD8+jw/v0s8kbDrCih+l0lGyr9dyHLUdNgGev
 LEoyCZuoKXqgEYIFvTQvHTbm6BKxDKMuvlUaSacmcKjE6wvw9nXLmagwYM2wBxCxw6Gb PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GL6g045017;
        Thu, 12 Aug 2021 02:19:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3aa3xw9n37-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYaRjlh0VJVjrkpXb5Bx+NndiRxcXuzjMIGs/WspdHjVAypgLtgnQ+M7cK/PcaMimBffoLuvp0AWZ/653fkydBjXpdDlpcSfTHul5Mdn+tN1EUrnWgS3m/Cip/sTFsf7oNYi16t0JKG00WcjN8bePbpvpuW+MzK/Ns4r4+WoBYhAAMkLle6vCAiZnYCT/w+flmMni6CsTbD2W3cpL0t/t/TG9QsGzHOU4T26SlVBerSroLS58Tf880+9H8ije6I6eTXp515wZc7T8RYTUmKRNoDYIXNQewQgScR8pjQp5y0igQI0O00nzF036yaf3Uxm+OVy3QdNxIsBVBIFR6681A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9raf28RglAZn6k1+01Tbi51tg8sLixVJzgzRviuM+T4=;
 b=LUE32xm2vYrKLhrx7RKC4rdnOKz47lZiHYTvb0tWfLIVdQcWsWOzTNnnFCmQ5wDr3UvqbsL2Do4xwEiqMguOX/dY/dhSDoqPpFXHMGhcd72DR3/hJnPGUCcoL5t2eQ6h0M5a5hPk5gPndX6hYvkzVcAbxQPLQyIsvlrXrmhztusFb30fbNQlknq03QJ5bBY0kClJPzceqIl++vS+NlJC6rkP7qk4VGx2CGESwnSXpxEGK69MQVF+BiGjz6bIiMO5g6r8Tv9BWZZ/zT5v2FGidpGA76D8BHS/IPSlTDMBjOWYNob6hFncIbbHFBYzV9mriqjEwKNCFfFRPpfeK7eryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9raf28RglAZn6k1+01Tbi51tg8sLixVJzgzRviuM+T4=;
 b=AINbo4Hqz9ffQsyAvVaH805j0f78B1+kAbn9nAGprKt8M9g1Xn7m0Qo2xZ1Ahj0mpyMMtIOs64c6aykdbY7abOTfsKKr9/bzvWVRFZF6JFJb+BwhVLyIFkdsimlB7DX2NZR2k3Ule90UkEGRN6NBt4wj/XW/Mt9Qlba0Mf9IJjw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:41 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH v3 11/14] KEYS: link secondary_trusted_keys to mok trusted keys
Date:   Wed, 11 Aug 2021 22:18:52 -0400
Message-Id: <20210812021855.3083178-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751fa296-c675-447e-d988-08d95d37a4a5
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39609AF3E94B5064EA8D008887F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGbMKqKIgusW346Tr/+oID66Eymgfz06D4BM2lfCt6wBSzryMOe8fnzO8Fb1UeRrKCJrN8h8TeY9Qv+voNMnji2fb9D2uUarBBSzhBpttPjvH1be13Pc74aoprr9iZ5qEB17c9cnBLDHPWNRxDfAWbhfp/87hs8mKM5ct/bSQcjCbQrM8ttejVEXNBzwW2NgNsaW/Hsv/w2eOZNG3KbSXZMAfwWVjszB+kePVUV5rZ83EkvkzMuiRkj/+Y8UEZanvyIVpslBd0wBUW+Zwhs1aRkBux0+yTiSfjpQ89mGqMDZueOeYhC8XNC6RIhHclSLLLAIsGN1PKlQiY+WXRRU9ws2M88KkfAp41g66tpyyelLuA1qZGGPjp2U1QkUnD2EyHBkH97uNh2Tk49B/zwjJYMSJYk2icpHDKD0pF7oNJVzLweqYR9EOVe6a1sv1jiYLpqzhtbmvemAC44mFKD9/IDZdcR+LsbvCbs8Sm35NuY54ICNYhmh5AGW4tIb4bX54mbVTyD6fcwkWG0WxCSMPA3Bdx3RNOyJB/0DFky8hpyUDhKFVJw+KyjBQLz5Yu9vrqdSvsX7WOvVlSj6++hdSywOkMPCADgF3fQtWTjzaUiJRB3OmYP7lAJLN8ro4m9RUbMlCuVDeRT+oMtz6t/OyHFVnZCKgXrtXK2nxLdAiE906iqkTSic6j92QdpQJpvTtsH7IJfY6rMt58Sy1ASi0wBYoFoyRuohGVHKBHDPZkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(4744005)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsrYYSBDDIcFxbhKA8NaSiVtf6SFVxXaiufcpBbow6CNwAMDY+B2uo57u/bK?=
 =?us-ascii?Q?Vq0PBiM5+1tgxiLEUsQcBItBWzSSvera/0CypEj9U8twMr0wknqmaQgJzMFc?=
 =?us-ascii?Q?OWu+zRTFDNUuIcCd2ppMVNRtFnrG3DclGxKczcs7wEH5ywnVkTXoaU6/7zsb?=
 =?us-ascii?Q?1I1fkF8o1MxAzCe41TDlKw1jy/FEgdjMUNfA35mv2dxSx50u2MtxFfRBInYB?=
 =?us-ascii?Q?07ER+VCbuUTqabloMVBAebSfz4j7msGITi8relcR5w0i3BUIbI9nuddGYc3p?=
 =?us-ascii?Q?+uaVZz7+LEMA4RwwdFEqa8M3cq81TgwWwnSCQXp7Xv+wevAZSV8JInoUaXtl?=
 =?us-ascii?Q?qRa5bviqg7SIS3Qij/c2ksSwf4App7HVEorL62zLR4DN9eJuDHg9ILXHHn2G?=
 =?us-ascii?Q?RIA4MeFTr9h9k+cYDH5NZXubb0lmcrU+4APiJJYDmrm7yBefs3n6dOi//GGj?=
 =?us-ascii?Q?vQVSUMvUC3wcTOB+KiO7jHKCcDMU2BzETl1NjYatnYUkgDAgEhWB4iIrr9cl?=
 =?us-ascii?Q?OqyWp5ls7Q8rYYqJR9i6bx7QLvD8WDJuofTiKb6KQ+zjM7jUIQlfBKB4TwnF?=
 =?us-ascii?Q?a0Prr7k1V9whiOarRdlxGyJ6Taj1R0Zcz6kG8ysnI3XquroxkoqQdt9TbRBC?=
 =?us-ascii?Q?DeRcrH9/dXzWHqWALwPgtwWqy0OEm8EIefkjsw6jEXxNpjHeD8HtjHo/2xrp?=
 =?us-ascii?Q?azY0nqHQG1MXzO52C7vDIjTqN6nle5ev7di24bisvGpCsFXiRYggYeMHAQnY?=
 =?us-ascii?Q?VyFMH/nmZbUbzfgt9Ov0qXEBB2Lf9rxoC+yPppcDTo5u1q5M8DW9S2bLLR6b?=
 =?us-ascii?Q?y5gy3VjgASaNV40214zAlkWJjBUeXQ2a8rDsmcnp9jjKPpZNiRwmJNSrYOLJ?=
 =?us-ascii?Q?kx4ZdMTS1Bk8fZSKshcRXTD8LsMcI7sFOym5MSmiEYadz/95UOJ+fBC3D80a?=
 =?us-ascii?Q?kfrPmKngmKm8WRFofDnOJzgaHY7LMRTX3R+o8MRoxLcTLM/vMk0Ci59EAX1M?=
 =?us-ascii?Q?aFMPbTg41udz/C2GmlnBkisPsPNs+JFOhbtWnTo65t/IdKpJxfeA+aVGOuJ5?=
 =?us-ascii?Q?hrFKLZK8fjSrAYobq8gaYtUDIAt7ov2EbZdVy7FL2vrr3koX9vWJ2Ez7cneI?=
 =?us-ascii?Q?TUVGm3lpVaYSF5rE0y0Eh+B3miv7fHTlPaHOcW7lOlYRE7rdjs5x5oG9ABZc?=
 =?us-ascii?Q?vjuDtYTIzWINF4bgycUNt0H/tMbCS5f3oDK+wPafb6GnyYYKANMUz1R+6v8P?=
 =?us-ascii?Q?bxv3Om9wc9QxbN6MTQZ5AkWMmSFvNsqPbB6R+NdudtD5SsifPdWjx8nHxMPv?=
 =?us-ascii?Q?Nmsb4kZZa9cOC6TuNuSCZwI+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751fa296-c675-447e-d988-08d95d37a4a5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:41.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owxWKp0t5ChSLp612KI3V9UdLr14fv5GCcLMoiYxt9W11WTM70pe9M3xYsfFDl1SQZVtAoLJu3V3T6+VYgEYGM90ElIzBsCA5FqkScqDZoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: 5Vo_fMuTYAaJB-WK-sgGppeAsXyqHGMS
X-Proofpoint-GUID: 5Vo_fMuTYAaJB-WK-sgGppeAsXyqHGMS
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow the .mok keyring to be linked to the secondary_trusted_keys.  After
the link is created, keys contained in the .mok keyring will automatically
be searched when searching secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 8cc19a1ff051..f6fcd53e3a0e 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -117,6 +117,9 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 void __init set_mok_trusted_keys(struct key *keyring)
 {
 	mok_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, mok_trusted_keys) < 0)
+		panic("Can't link (mok) trusted keyrings\n");
 }
 #endif
 
-- 
2.18.4

