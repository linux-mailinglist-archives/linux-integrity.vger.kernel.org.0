Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537833F0F3E
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhHSAW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64680 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234748AbhHSAWm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0H5TD000821;
        Thu, 19 Aug 2021 00:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FgBEqvoMlz7uexqJINhHi0sCZVKJam45klrZZQwKbt8=;
 b=YJfvg3SR9CaCJmdRyc+HrH7XI9D+xtqRKcc8yirckIwV2eAkc/+ollA7Dmd6oFGTLK0I
 mGvK4w+3vLh2xsGxyiJZ4Y4QC6mg3r0EEXsoZccWLM9yhRjsX8MbtQ3CgtC+RRd7qw2U
 65x36ouCP98SZ0Qwro6juHHCsGFJfhBCUWQEURZtLpKtxdHpsxELWLzOo8w2+4Cupn21
 AyJGibydqpsWLde75dT/4yVe3MOmhiKXOCIBvumicVOEtWuNrUFg2rElz5Wy/+aGFIVz
 LXRhavcHM4z50mc9xi60j6JiFm0VQmMJEv+LrTwqtm1Om4YqnzFYaGMoS3Yz07DhKDVV tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FgBEqvoMlz7uexqJINhHi0sCZVKJam45klrZZQwKbt8=;
 b=ON+AeuI6pgYQEjAwzECcdGcBZ6zmu9So8grgt/qMARUTvbbuH8imq75D+smumGtb7Vuu
 /1tObcvkSkt3hP8H/NiqyFXiYuWb4oFD9DE9hf3euzXka9llIdD0XrWi469buiyLRtjH
 WUG13KDOh1oFeexT4r2PLL6fBv5+5uVA1pz5NuMLy3hZrVhOKPVob5HpwxvOTbqBdX0/
 Op83ijVVpqXVV9b507IcByS8Aysk7d6YjVSdl3AK+whIKyhEnb0i2sOlhHEDs9dY3obI
 8+hGxeOJvnAK7sXgNf4lyoVqbfCvcoHFmE5aTBVtJn/+gOokMsrzYHbB5hzpUnnXv95L jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf4dm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F8nL040503;
        Thu, 19 Aug 2021 00:21:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3ae2y394ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzQio2Et5XdZQXA+18fu+nDn7EEjKnMedjj8DVyqgeaGGV2o/L23atGOW5KyR8f92tKBfftoGxigHXX9ZscBgktoo5nQYveceL0oxavXoCJdayMWTo1kLgtKaO7iETrZjPo/YAd5imTW4F8eHRhYAIsJMItwlro1Ue6pLlTAh9uc2tC7z/qbJLzWAFqir4EzBW5YFBLjJbq/i0LEvWKd3SMV6Ck6da8NhypTVf/vCGBUsvYnwlvf8CE8uIEbAxzPQkFod5cOMWDINUx5VjPRktNdLDSt7NtNJ6X28fNqlRmmhWj6bl5V/gIa6OGtq5IvclrI1Q6X7nH4w280E+C6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgBEqvoMlz7uexqJINhHi0sCZVKJam45klrZZQwKbt8=;
 b=CI706sHhNGUXw/v9ClLmCa+cXrrM6s0Isap2qv8pLP5PaOt4DWIdXa3d8pJPA5y8b6B8uh9bSW0BZ4pxBcGH+A8Gdkcb1Wx8FSSDGMMbAnf9B87YLwNZq0VA95/ox7ohXpsc+qt6BqXFki3XQvlV3jAxnyx2bZEdTyi49VwikMSPbXp6UVrsY8GbCcvJffNAdtLdEnIffSJZX2RN+MLg3PaKQh0attIYkyJg5DmXTZqwY3CILFC2hgZUDNXSXXZ9EZTGpXdOgo34ovUOcda2QsuFb/QJltdKAnOyX2PCeMzWo0ZAPIX5vWDvdg/obiWLoGyknFY+Eo6JmXdM1wcGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgBEqvoMlz7uexqJINhHi0sCZVKJam45klrZZQwKbt8=;
 b=ZkRepHzJAojQCc8X2G8QwC60/+cwGuqDkq//Jd1sgvZVGrKBnWXCJyWPPdAhixMD2PHbJPib6qSKwiQkdvBUd7+MH2SeeH+bqcKaxawaHysYWPInoc+ztKgBu9vWAvKquQEd3iva1ODPwGaXzM9KN5l+sGfnOXCl1FCmRv18/bI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:36 +0000
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
Subject: [PATCH v4 04/12] integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_ca
Date:   Wed, 18 Aug 2021 20:21:01 -0400
Message-Id: <20210819002109.534600-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a81a0b68-b96c-4455-c118-08d962a74e14
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116915C4557E772E6E4015B87C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaND0lBfjRQ0lDMnxC75bgOVYOx1Wu1nee4PZnPvZp0sZyRuWbZxNCXvyXc3a8vDFRknO2UKG3JY3iGdhzSpSLskm15Fvx3Al0XdvAPCtGmtzHYi0x/FJFA1ZaAHP6BsYnj+O2/qJSdx09JLKG97kYs+/mRYFi0ozoT7BlhsWhyBn8nydt+BcUiqCLlvXypBVffQ9sEWtq/ajirGevjsKmRLcMwhfhO0C49X5d/KktVpJ1b+kuDi1tED57p0WCVYp7E3LdCFj6cBcGMB/gDFdtcFGtd1WAHiR+Njepnbf+7oNgo9HKK/QoYTM9Q3KwqJ8KA90JTwK7TAPyjU1eYBYRRP6r5ZTvDkUTLmM1AMLFkQ6AWL3WdOjbNwsLPKxqfoj18lyOj+wSOBmOni6oXMa/7P9iHU8+8v4mxOFra0nbEGMmFnSyfW19tUCzSs4DmzDcPjx0JUL+kZhKlAwNV0AiUFHWbPc03K5HPuo9go51yubWGBCI8rXoniQQK2Qnvwi1SJbbsQqXGTnAnkpIKGTmPj8FfJARZNC+uE+Adz/hc0Vq9FVYaJRy7kGD3YcXo8fezLpSH6/av8nX1p/jcS6q49v0bhzNzomV5XqGIAhURsGGXaJiF5E2stztvOEoOBBZHlLlp+TMYsh1O8QSThOJToUz8XP+1EwbRn5ivZTIvnuGhxIoXLppx3SC7Lcwv0BoEKeOrUVgT9q5gIsnjSYe3YWESZfnAlFPfrpWGkkxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXVAR3R5CGdQRTfxgKQskZ6S887Cud21txGun1DqJXKRy2wS+lKxIGlhgrau?=
 =?us-ascii?Q?CsA5BMwfICMeWWGjOE4XsgY9+9guONXxG5GslaYdSCb0T/zReaZttoA1uH9w?=
 =?us-ascii?Q?OXPI6q8Y76Q1F74TSkVeyXA6mBh/THBSMNcPIgKS8vKLt8Wyioq9Kly+mTpZ?=
 =?us-ascii?Q?XemvUWIHTHpnqT3rJ0MoIOME9R1Ik39xGxlnrKxGYpzP/1pQwKlS4Rks2Soe?=
 =?us-ascii?Q?pKT1b6rXK6MO9GccJosW/KiGM7UiTOeaHHMQBlIGLMm6U4UCg/80QBhznIHg?=
 =?us-ascii?Q?E4cH96Autq8z4jObAecB9PbxKft56QURNPC4sPr7ieHFREFlPOqfUbRwJjzy?=
 =?us-ascii?Q?thlEoCDAoibXztysAjbBlnADSPYwv0G4phGJ0JtNoRgkMWE73trRvXsYN/89?=
 =?us-ascii?Q?naHq1rOWxXIZj6mD6HrSmnzIJeM7ziDxAb/O9ZgQnO7Ou1Jz+VdDmsPfN3sF?=
 =?us-ascii?Q?qjzciNlmK7FoB2znl0cKSyd/SSMjbf9sB+hpVdE6wehLN1q3c9NQpN7X/wju?=
 =?us-ascii?Q?Y9si75NF7wAkzWtH5svy0FDMniKnrnPcO8kOlDUYMSPMQ9xz98ILA+lpClV7?=
 =?us-ascii?Q?jkrrzMyOIe77EABrKALWPpDI8utjow58pgpVnfz2K4GTGXC4Ve9SAPQGk4F9?=
 =?us-ascii?Q?IG6SoxU2MnoeZICBWamvVdyJLMAzhiTu4QLtKLHGlz8mUz8Qi5G7FYduJRhr?=
 =?us-ascii?Q?jscNsXqBtYs5QKWLLS5a4a7PZqqLaYeSQXwbbKdLzI92GFEIk2ceNK9bKBq4?=
 =?us-ascii?Q?kR09J8mvgFKxrJluUOPV9SqquxwFB60Zn9wvD0s0IgdKUD7twKJ53w7Z3mDn?=
 =?us-ascii?Q?V4gOeMo1oR3UyQGOL3q/80Zbu9IvJcEZDDGMThCJs7MNqaI3f/cJtweLusS/?=
 =?us-ascii?Q?lZdIdsEunAjWBgMkC8b4NRExK1j+K+kE0WlgfjwFHqPvvY2OsDbW7sRK6Ub0?=
 =?us-ascii?Q?lsTxS8VfoPNc9dL83d9rbTaNlQaNEn1gsGuskRRtkCCrNKgxpaRw+oEra/DC?=
 =?us-ascii?Q?6WY9aBd39LaJwUAPyAdKeRl8tyLcVB4NrZYLCzIuCL/4Af91eiM9ICibXShT?=
 =?us-ascii?Q?Sg7vACv91dsqT0U4jRioqh6iPqrJahnxyK5acSrLSH4DmT52tSf1BBUX3d/w?=
 =?us-ascii?Q?UKujegWDT8rxJPH8QL04uLQ5UpZOMmkUG4tIKazPjrnMqHYCnLtkR7HKVR5U?=
 =?us-ascii?Q?zyqTGIlzHbHNDrMbt0eOV3gWs63H7Qh3Beikrcjggp9mKP+7DiIpjnsWANg4?=
 =?us-ascii?Q?nX2Sj2qbxG0lj3Lf0+a7KuBqjQHHVlvptqWcot4+uD2TuJn27i9/tVHaUhz+?=
 =?us-ascii?Q?8xMGtT56A3hXln4hOM8AiyhT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81a0b68-b96c-4455-c118-08d962a74e14
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:36.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAvsnkIZJ0utzQMFR1ntDOcy3VAObYHvihPlqQSCnB+ShiHgFMJjX/2DpQW7+0x31HWQTREztHFWShTRk0SxL3OIeQjRrGmUK+p5NVtcOak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: JNYco7saO3_A1zbC-zPvYKpMgL6x-ste
X-Proofpoint-ORIG-GUID: JNYco7saO3_A1zbC-zPvYKpMgL6x-ste
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
v4: removed unnecessary restriction->check set
---
 security/integrity/digsig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 5cad38e6f56a..1f410242752c 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id != INTEGRITY_KEYRING_MOK)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MOK)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
+
 	if (id != INTEGRITY_KEYRING_MOK)
 		perm |= KEY_USR_WRITE;
 
-- 
2.18.4

