Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D03F0F3A
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhHSAWy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4870 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235068AbhHSAWq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0GV4k021872;
        Thu, 19 Aug 2021 00:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=z9nmARSvIbc+6MEia4U0BG9UgBzB+H+F5UJsJAG0J94=;
 b=SxpSAGz4FwAeUQXPKsVCyRU/MZtF+WYy1GxrbIBPbnEAKgSPE9H5/Ry4mWa8c6tZL+i4
 Z1+cuLk5DythhI3pHDsIvTtrUVeqGis94upKZfoycx3VoRcHgqySHxsp73eOMTetX+BQ
 ArdxEKsmPhZa4NekSXxBdOgfbROIVO9w6Jc2XFNfhkYqJW9YWa4GcshAWzyjDkP/W081
 ER9pfmbFBQFcKtozfl1JdPsdP4ZUu1y7tuTc7ANsj1WJVBXZEgXOudLL5S4ztQNQWWY4
 6onYzB4WXWKe6NSjjmnvoLQWQhxNFtLpIKAfT7BdiDSjwc1nO3ePz9DQvDPeTB25eiMn AA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=z9nmARSvIbc+6MEia4U0BG9UgBzB+H+F5UJsJAG0J94=;
 b=LS+2L6YSYOWnFDets4zmklBiAixAy6FtmNOo50pyL4QzQLO6KwtbJp/f872U8vwxO88z
 j9jO6iK57jODNHOYT2jTkHO/JlFu+rcHqPw5o7TVWJ5CuYR3VfRvM+bV1Reu8pn9oJ2v
 Hj56LP176pFJ9qsx0zzbyBYwzNoQ54cDIUD/QWh/D/VQu/Bxvi42EKOMBvsvjCHCorbH
 8KPf8Slvl9AzBKUMOZJ+IGSN6/18fEJoDfoVMmaEFTEe1pvgcysczAQulVXbtC838usP
 /BpojgQSeUqbPfLEJXDfp72um1cF/fTBDklgzTfszHw9LqWZZea2tNMQrcRpbEnwSsWg sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24jghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F0G8007664;
        Thu, 19 Aug 2021 00:21:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3ae3vjf8g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzUM1PFPkwPZaOj9IM7VIMw8NX0636Z/BReVSliI2Vc3oDd5NBtfQQ07QTHpCxBVXUtw/OJdevild+1KGMjrmTFTog59qSJf9Pvk7k/UIk+iPkZBkC09Ht0R/Vx8mV9bIb9RiB3Ye43o3W4IjzhQ5HlWy9tyYUj/M/dEuCSzkCpg0CP+pPJ14HoOvrpCL3zsqwAO/geDeYat411io3TT6NJPPRFF3pUC3af1Eya6KlCGxIf6RyD9rB7uF3WypANOtYJNl3Ds1j6vYqe+sfp7orIM6MjqJhtMXnBnHFP2zAbJr3uEam8FSX3OrcoQ0ENyHFbteN9bjYLVlEkE1ky3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9nmARSvIbc+6MEia4U0BG9UgBzB+H+F5UJsJAG0J94=;
 b=WxZK2s38Ts5/90X2ZV2aFruYCyPtVPJ+5OziSATtYbAihpUKjb/FYxDReFZfRDD05RlLU/qSwy48WxrUIPbVmFCHC/CDyaxS+xD8owLYybgFUPTfAECiLPdcsHsi4gAAVdOFd3VFGWBGPF0zIedNY/Ssmd4c3NC/Rvoa7n1ASYtRTzUT42ddsjB+qcoZtoAVsxfRVKpd1e9F3Ei3P7WzBkCxZmTIWzA9TI6nkUGWymiGgA82FMUgviMPqeMWOwzTcAJaNYOJJmzkc499GnVkzLrOSF7iWwZlFftjNUkgPNLtAOQq9FucKjby+qX3MASNx2CJo54FX6sU9IwAMCxatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9nmARSvIbc+6MEia4U0BG9UgBzB+H+F5UJsJAG0J94=;
 b=xEzPbIAfoFXfzEdFxuQT7aH8deJozmFWQrvEZTFM/ReQSvZi/R9UDLRSgiVZEkdhTeJ3KJAFzd9Kp6F6mZe4JDEnT7OyXJh8YChDu0vHl5h3lBTePb6LmaQE7cXTlSWiRxHWsqhZGvsANRa/Q1z7CAlImoDMXJ/WfkH3mRFfJsw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:47 +0000
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
        konrad.wilk@oracle.com
Subject: [PATCH v4 08/12] KEYS: integrity: change link restriction to trust the mok keyring
Date:   Wed, 18 Aug 2021 20:21:05 -0400
Message-Id: <20210819002109.534600-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cade36c2-139e-4332-29d3-08d962a754bd
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB51167A9F7AC784567034FB3E87C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sg/ETLqVYL5R3gMS254w4HVk8W1pJPTYJDsgbRncWf02cSYcHAtNob+Il0u79XB5pFVyMouReHqtx2yegqXEovzynJnWx6Dr+et0zXUcfyDy8oHBHIY3uk3VAHpYJAqlbm4+IRQ/EcEyW8rqZeFGsneMRtbdz3okmFmedndIYap9EN7gLawz6YzIgEQqppltvubreyGLSCDZlHEr/ADizyJ4DnaThBr6QwKp9723FfmrKl9DADrezIwN82WBZiCN/VAN7kMWFLK+YuwIN8S+8nRZSK78syakhi8pRLbQnSHy5YRirP38WIX9/zCANvxo3eAMiL3HpN5v14OGJgPjvzkWjvlRxg46eNQW/u0VV4rNcnrLZrJQ9uVciQD3tUR5I//gPRUCSHrUiOOWHymUt0hslRU15oBMWsPPf8NARJn94C2ljTfkFEkyKlJfoNfpQoVJfUEcLlk2UTnPfbPzVypE6hySDIv9XI2CWQ5NGR9DTgdie10ieqPcJEyxFk7lucJouuBVVXV4YR8BWOz4/HHCGkhk/O6HdBgWbwe3o+n84E+IRylyzjjat/dshh7JB0Z9FKKGSK5qQEs9kZ7ukbgP9Hdkhmx7jEFWioc8hGjbCdjSpDqm74vOof0KFaxY0z5vw47D1G6a99SNv1seWxFBb6kMQzsvc9CsBEt3D5/mfJUVk2BDe0ays7zApTy2H5LPiExMQVUAH1yKLv9oE/rBpqggUrzvIW0IAQuLX+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9EhAL+AQ1EzRptnsOVXZUrAV27VrcOvtkFSZkW5xFKiE2QYl2xJBSiPJnPx?=
 =?us-ascii?Q?SrmzwydxQXNwmqkPv+cxkZSss9VT2caezfB1P+XYW7rgYseab5CaadLuKgB3?=
 =?us-ascii?Q?749MI1om3Kr3eaZBkf4hzzR2XZ0gWETdE4UBYCgO4AAiACy2GcskZUMDJ25e?=
 =?us-ascii?Q?dZF2lllx9TmNDpN5JTkj52JlW9Kgq0CtoMXbLMRw7aefMYzfr6YEuV4aKaUl?=
 =?us-ascii?Q?QAO6fRXTZ0sjYGR6bBAwZP/bActCzbr4LwhvXum9qnyN2h2GwreVH3euDz9c?=
 =?us-ascii?Q?Tu1cnWXmKD3/cKNOJMpF+HE2SvjbZ3YHNa8qPEP0oVkEdzuhx69iHNiDIAcI?=
 =?us-ascii?Q?z1CAO6ic+K7ZmH7FfVW0W/7gYi9+pDEztbX2IzIKxI9MzFTG5V7cJyWRD3Q/?=
 =?us-ascii?Q?wMLBGqszDs9iqgkcxfp541ILYCCnoSXXxO9nCNzGgEFyivtcipdXy+28A08a?=
 =?us-ascii?Q?zoATpsIAwKxsw4nlmQ8nMKqdlUy4vhxTpKzBhl6ONRqGnEL5OZ8bYENGsx+D?=
 =?us-ascii?Q?a55Zp0/AtyBf1JlRIeCYqyLr5o9XHM01jziBOzGwmHnXhgn1xqEn9W6wgrP/?=
 =?us-ascii?Q?rcCw2bwBQXZuCmNpVCzZZrTuXdH/oPvj4cFK6DlRyMcEV2peo/83ToSaWkOx?=
 =?us-ascii?Q?7cr6UWliaWhNBrznTrEtKSZHpIBR9Qp6jMwHzzJqBbXrqpffsVpxhymEZz5G?=
 =?us-ascii?Q?iHzi9h6vDo1gowr/lwLFGjjXNE7bkTITOcL54hwIzM1G6VyZRug4HmKov9Ol?=
 =?us-ascii?Q?RLv5uuSHzCcX1iGOes7NVkqg6nS7n7DtGsmp6vvznmqRm2Zs69Ttt3l05EBz?=
 =?us-ascii?Q?4H3DSUBgK1N1ylh/88mz2hx9XEvVdlxXzffUY/hQ1XBpMW7C8jrT9xSfcUbu?=
 =?us-ascii?Q?86BGIwZ/oF113FyojnfON5/bBdeE0w0j/Lx33j5C2w+5ZkhlBj3DBATERxmT?=
 =?us-ascii?Q?QBY4KIk5DGgW9O553P+B4PSK98xIxsp1+mfsxYw1KUXLZ8HZMYko/ByjOvDb?=
 =?us-ascii?Q?+E0t08CHOVkva77unOQT8sn/GsW3AgjftxKLSpzE/FkuN31AOvubHvFn2tst?=
 =?us-ascii?Q?2o/5SXl0S76qaxWSS4XnqM7RqvtrMD+fB5oqfK3vj4ZPRdE8SiaF6Dp2pm47?=
 =?us-ascii?Q?QS6gE1Q0FNV09CYNyj/L+sg+IxjkPie4DRr24A8uEpGFCWrtjkEnK6CeBllo?=
 =?us-ascii?Q?YMz1DFp3Jy6zAAaEs1YlSYbQuy59LGD181pm7B/OPA6GAlNOvGibuLt4VhP1?=
 =?us-ascii?Q?FbUxAPQUAHCTNSh8V2tTnWGDszUWl/ypks5VlMK22H2r90/3w6k+EV+ON5RK?=
 =?us-ascii?Q?fGXAFgD1/mo5vF5a9gMBn9v0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cade36c2-139e-4332-29d3-08d962a754bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:47.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVJaVNqX3a5IC4i9L9sDc18Dk7G2C1M2CjEoVGjHQiyT3zbkV8iSphiVgmaAojujvPms++N13R1KlqVQgSwmIHtKwGoUdfy+v0qoX+ryTFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: yRTuJ5axHSzKyhtk9n-GlwAjY8EpgdQM
X-Proofpoint-ORIG-GUID: yRTuJ5axHSzKyhtk9n-GlwAjY8EpgdQM
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of the mok keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .mok keyring will contain these keys.  If not, the mok
keyring will always be empty.  Update the restriction check to allow the
secondary trusted keyring and ima keyring to also trust mok keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v4: Initial version (consolidated two previous patches)
---
 certs/system_keyring.c      | 5 ++++-
 security/integrity/digsig.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a75c815a42c8..1c39af137cf1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -89,7 +89,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	if (!restriction)
 		panic("Can't allocate secondary trusted keyring restriction\n");
 
-	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
+	if (IS_ENABLED(CONFIG_INTEGRITY_MOK_KEYRING))
+		restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;
+	else
+		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
 
 	return restriction;
 }
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 1f410242752c..a93d558b795b 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
+#ifdef CONFIG_INTEGRITY_MOK_KEYRING
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_ca_trusted
+#else
 #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#endif
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
-- 
2.18.4

