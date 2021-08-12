Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AEB3E9C37
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhHLCUb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhHLCU1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B9hP031679;
        Thu, 12 Aug 2021 02:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HgTXRIKeppjXFu8ue1hL/Fs0S+QcCYrzkhd3VAoGn/Y=;
 b=phZ0+mcptJKpk0gn3NBXFIPuuqOPSZBo4RXGKphPGaB34T8LtDOAHJBTonf8iekDQX0U
 mUNiJQXK+PG5EUcxMIMu4aTveR75rteUHB+PI6eOtcC7yUhptW3g3/3Iui8kjvIPMW6M
 d+TpS9d4AjiQWTim8wzWePBAyCusF/7xYusopqg/f0Hx8lsNvK4LdC58Tng2BwaKgy6y
 Cj6TprsYeg2pxzADNPhvW7rSmRMow1lpJIE9O2rAE9WwhrfEMr+eVrqJzQGPYGGO4nbJ
 DRg8AMsY0JRouhb+smLLXt8JzmbrjbrlRBN0H0YsFyDQAryv5jUTGuKEFLtfo6qAEsRP +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=HgTXRIKeppjXFu8ue1hL/Fs0S+QcCYrzkhd3VAoGn/Y=;
 b=FWio4/V4Uni7R0Y4mQqYz5oYzuYpT7n95oAAIHLvHx9qoG0EuY40bQfpxM46OZNhl6Xz
 WNrDMKnRdWK0M7CNXkIGH6fGaqdHlbNdUy8lxPpIszvdgojT6Uptb2xkHzytqMND3QlU
 OsUfdaoGpDDakWuRZFbcz/1Fn5UtRDlvlmUjp6henoNAuIVWxLJNjwzxzKIZC4IWbz/I
 nQGzGBaLr9cowZEsRI7ORrztXRjwnhh/5k1KiO0dvW/atRsYf2XGG6pTwmsbYXtpHema
 irvOSmI5c0lKrcwSMqT0uZH/LocGyIP2rly4bZWZEWhAwMGMuw73H9DqSX2kkAQiX8KQ zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649v11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GLIq044942;
        Thu, 12 Aug 2021 02:19:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3aa3xw9mjn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoe4IOatsUyZGlqdznY8gNsdV2H8mPA4cc0W0pP1LJesFWcixPTJeMfEWHp8BiJ+n4NfJhRkg21LoHYcd9rFEJ2APkSyojGn/te4Jmi9SSlqOf/KqnVqykPUc5mx+zOu7UArQofTpIuCsoUmRGbeSinV39yB0IkSQx5/sOSv1/X563cYadrnTg1hiO00EVgSBLTy9sFjeicum6X7FifDup7CS8oIRBxa26W/DEqe89dsA//fK3EZSdLW0LmVThpEMGh8lk/wKDarZu89Gm4L//W7n70WGJu1g7vSQWtfU0JW70HVHiuuvLjEoxGmsbmxsf3n13Mpo1O3i0aCjrvFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgTXRIKeppjXFu8ue1hL/Fs0S+QcCYrzkhd3VAoGn/Y=;
 b=dkKfBpDdhCtlL8yK6Rk1fGutGUD3PvSlgvfKF5wSjgCVCRhZ/vA/6BdIznARGIslzvP1hOlfCNJCCrVkggqMc5Nchmev0iyCtmsdNcOmahvhOqktIi3t23KNpZ4Oy/hIuLsyee2cHl7gc8SEMOBypofWcYiYe48rJEdlJcQUoqQ9+axQbeJbSyylBevc3Lp6hzLQi3YtTeCIQ75bM8CYNZA42hPu2PqDqNlWjitZ5nU+mNx2rXMAT4ewVyRZkM1MoUT6Lsp2QQ0Q326CIloiLfaErqtgH59CFjCyTW0ZcmkhIjx1XKK+xLTD0yuq/jMP3GnWJvqeKF5pF2GaW7bJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgTXRIKeppjXFu8ue1hL/Fs0S+QcCYrzkhd3VAoGn/Y=;
 b=Co2S0umssAHvOsoSXN5x+h/Pq9BC3Hhru/yzvOICMm8lRK6B5zWUXmLndV3bFDpZ0Y/+sNwS9GWC4m2wgVUX6eTSEotJF0Hu2W2BWHf+jBXcnE89Oa5Xs7cFynnp4IHLSrwW0Tfg8x8QvcmdREZPANUqQMS8tGFC+6R+qYXMaq4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:26 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:26 +0000
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
Subject: [PATCH v3 05/14] integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_ca
Date:   Wed, 11 Aug 2021 22:18:46 -0400
Message-Id: <20210812021855.3083178-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 158fd5da-9a5b-4857-48ff-08d95d379b55
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4168A175DB03C0848BDCE84E87F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /o7sJR6QgI2ay4rOxoZ2LDi17uYY1pgKDJ/v9eh1Y28vnkdkzzOO0us7fY2rq7vwRQHWp4G3DOa4dDXf2Nu1h8vuOwDirdZZH3ctAX2hKoD2nCmsubCa0hBKbICl5RVMMMUcfbgfW8A0TkgmKnyPhIieN5rjpVWK+zjdvLylAy0B/DQ+eYbCBi78w94ZDlWEYeJg8EMd7ZLeq/Bagn5nSA+QaFqvC5C7oBqtJY/teKZpBUtdP2zuxL4tPkrzFpzkRX6N9BZSxUfnGZn0tFLQ02B41AxshNzdOHZqTw0PS4U+9y56diYGTDMdlQvRDV6eBn+EMdL3DzADmjLvovvPxSCi33lhlRmLpt1WBTaCIl+KN0yS4dXNESvECe2AS6cdCoZXWUR0gWQ0PFX5R6JVFoofQjOrhDogvjv8+faDcdWzn+7CqWDVtvnnUcjiZUN+U8/jYbWcLXbiPn0PkpToRMgugLrrEPyWMlZZdQZo7eux8RZZAWwNepBhTCSyaDihLytz4iakQcmo43tviSFQk46O8Msm+9KAW9ytHuWuvTphjKpmosvkcb8ZGo/4UvehgzFmNwHq6vAVZnY6NQa8SNsnAhCrYb8AkaVZAnad+TZvYcZjxn9mG4LNq88mbcuViUBRqHDjCxA6ffEQlzIJMkfxBr25DsshsyTnVhGmW3YWLqbOXV9+c4foMD9D6zvutSXmfUuVModlEnlHg3uPjf65dB48jo0zBBxLApHoqes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XeEnHzllWTuUTvQBdA3OLS6arUZaDOkri3PSoPFsk+CM288Eb/jdNpKQGlWE?=
 =?us-ascii?Q?bd5DHXKU7Ad1nCeBXg9ldZq+PL08VnqNzcHgqpDAwxb5WOOun5sl0OanX4q6?=
 =?us-ascii?Q?UQ0Ntty2zR62Mx8h0E4llIUAm4mgbgyiMGkJM2pGcBMVN51jRKpcsAyllf6V?=
 =?us-ascii?Q?Q4h4j+GyzPakcE2+iKCmf0rwpITZORPvkrc/+T36XL5ohJR0t5EHgPNUpnlW?=
 =?us-ascii?Q?lNjDi02cnNo+4E4WJTOoJLMNrIn+83hX6gnnpmBY8xNB4+vt9XVABjuwNAZ4?=
 =?us-ascii?Q?lltPvCJswSRPi+4BkhGRSUZveZqeXqOhJLpipOXe5C2vF4TRUPjG4Hj9mSxe?=
 =?us-ascii?Q?ad+FqCJPRae5h69gpbpKUg6UeuvLXbI7BcrFYChY90R95NoYAEOtsCgL2tJF?=
 =?us-ascii?Q?08p+rB4bv6jwm0IoeqVrop5ygegmO297JMSazbvuHLqXoFPw4CcNtBryVaO4?=
 =?us-ascii?Q?sVATb+wp/cLjFAfbmgcGHn8Tjtg+WB+vvOsTIs+0enMSgbIJQ5W1p1Af3Q/w?=
 =?us-ascii?Q?YdcXHTZtSxhyZJ1L3R7WDuUGzL04lm0WQcxkWwqO7omROcxOssAbYdzrY4aH?=
 =?us-ascii?Q?naA+zsNTL76aU0MjQI7EAXb5Uzbsw7icUKbPWNyJa6rIzVlIEeZ74lm4CZV1?=
 =?us-ascii?Q?gi1xQSgQQE5K2Y/p5rsluZhwmfnS9m+SVDCGZ+MFlFezk54ZRyq6Jw1iqv6C?=
 =?us-ascii?Q?GNr1jS4G9dgwIwMIQF1cyEGPGHyVWtMFOUvfjpiUQE3TfIzq7F174TmpYsdw?=
 =?us-ascii?Q?LjalBoczXPu1SdH5bzOdf6mBc9wphXQKCVPvqIYZlCdTl3qU48ALRXzTRUb1?=
 =?us-ascii?Q?VV2Xa409cWOF7zMIKqy4re3OkKKF5vkI37eXJEWjGifPp1n1vStaCIt0yrOY?=
 =?us-ascii?Q?99/Y9q9lNEYu4Nqi/jzs91IRLAVtm7O1FnRNgqZFmcd9my7E8asV3ivsDvjK?=
 =?us-ascii?Q?ia6q9H0Y7lyoFVrADbSBGT/1PdkvzHTBb6lQi28wW4+sLUqDgxrTJ1kguibY?=
 =?us-ascii?Q?pvl8lIxofckLpZOs40aZ6b+KwUC6TDjwRg28Mg2UpGjDYNwp+ioROGYlfQYb?=
 =?us-ascii?Q?ZvpCuHFoG4NIM/4ism4pSVBPOTxuPVXkerMOhmeHu/mcSR+y6ypOyGed1ZOM?=
 =?us-ascii?Q?gQjCfzN5xejPKpW2yKtMqMNBswvpJN/XPDVqMQ9GvP2tVmhhIkJ1GgveDUDy?=
 =?us-ascii?Q?UzW/UOfQNIYm8+jDeKCaAmS5OUb8j+N5/qBU/YR7WzOuh3N4RE40dTK7FAeX?=
 =?us-ascii?Q?a/Wfy0Omjbu/DZQKWbsfvLGFFhc+6lCTSGJmEdU6RtmBAHT2HE7KeC02l7iy?=
 =?us-ascii?Q?6KtLGu2js9c+6Wj05qgLaQE1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158fd5da-9a5b-4857-48ff-08d95d379b55
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:26.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFf67hd61ariRawNqYv/k5/BrBif7/gkT6kE/0RQNh1fQYmkpagaum9qBviHiuQJYfOVh2MEhydkJ7/ybyymTufsBMvi5SwjyukkhXr1DuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: Kbtdi40C8DpECuYTJvZUVFU-pvGDu6QN
X-Proofpoint-ORIG-GUID: Kbtdi40C8DpECuYTJvZUVFU-pvGDu6QN
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MOK keys to
restrict_link_by_ca.  This will only allow CA keys into the mok
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
    keyring gets created even when it isn't enabled
v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
---
 security/integrity/digsig.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e07334504ef1..ec94d564c68a 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,7 +132,7 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id != INTEGRITY_KEYRING_MOK)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
@@ -140,6 +140,11 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MOK)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
+
 	perm |= KEY_USR_WRITE;
 
 out:
-- 
2.18.4

