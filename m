Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D03E9C51
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhHLCUs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42640 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233630AbhHLCU3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2C0o0016211;
        Thu, 12 Aug 2021 02:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=dJ3YY6AzIV6WxseBfX0AOvEokZPb+Q4tqMd+xZ/zLao=;
 b=h4gz+CRf4kbdvaIKgo33lJwI7fTHJsuljDCLAzsvhCpbp50TlwXAryTthvxlyCimKBWE
 cDmjn2PUB4qNQJxjSD3thHy0kIO/WWJnp4u8w1881AMFTv4/g24A78BIStxNBm7eWh9A
 8OQr94wzIvvnei6eFz16gWyRPwqseUFWxxr0aQ7f141NmjPGajDBcf36d2+R5UBwwmG6
 2FZGWtQCvPepqpIVynQc0HDDY/pxO5f/vx8mqI+Mr27esM00Nq9nW3wwlb6gpEgd4MxT
 46TaEAIxND+9Bz76/z3Fc3zlqyVYhv9hzG/Ld5dnruSIpMsjgQyDDimjnNu4LTXo4WrW cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dJ3YY6AzIV6WxseBfX0AOvEokZPb+Q4tqMd+xZ/zLao=;
 b=vw4RyB+JWabPxoS80SgUhZe3IUROR0W0vZ0Ffh/jVgHRC7Yyi3cU4wUqZw18RsxSI/Af
 xdrA9vYmFdxQk06HzHkHYu8cyi8oISwNlBo3Ejef8DwPomU/qaxylq3aXcPO3v9TB2Xp
 1Eg+gwLlnacPOhK8OYKjcj1hchxkw1AkNg7YJuSO9yOuGXoEolnfV/SEccgAj2fDbsaF
 pf0L0Ek+OlE94Lj+TeKhgYfnkJ95hoXuXyVIPZi/M6YdulsuyFbtcyCfZ8X+b+QBfW/4
 d7UT47pBCOAKc7IBOsk55eultjLGKB/4fm1atHQv1vEsFAn4dzgxWgbjSsBMhgE7wxb6 YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqguqq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GLIp044942;
        Thu, 12 Aug 2021 02:19:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3aa3xw9mjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo2pbNAmedcr2vFM1s0ivUQtlUVasiIAhi9AccKODrDpAtGchsu1zQ+Pvc78slZjwmlBOs9l3Ps3OUotjxlfxWkkj9Ath5+ZA/xpxc8t456x86pJnfXiBSYPexN37TaWWAzjNWVnFZ1vHvoy2ksQ9fGyRmjR2ryfVbHfiRmoJ+pr5PfsJYArCn1bgKM46Fow3u5pHCPFpP4dhWb3rTaVItd/Q5qKIhohj3RZ0sZ//9wLk2D3pAHtLeX/zFBElgTWRBheN981vKwT6CNduyWFAXKIhTkVe7c+i0kjTIX8SoaGI4O/0XiBx1rJRw7e38jKxjvHZunDC2d7ozYUBWvVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3YY6AzIV6WxseBfX0AOvEokZPb+Q4tqMd+xZ/zLao=;
 b=e/5gA8AOBAKUsRnclEihW8RJxuhJ4HyBCorohxAYnVbUJzb01D5fNS6Qfi3EKcAuas3QsPBymnqo9WYm65bNZNgFo528dZM8DTxky7IeGXTXBE79aPGgpuHvDQfVCu0Wn3JGyc0weVbTdLhne3FWfXO5FMGnY/I2F/Fo9MGV/aMJRHNDyzvgFAftPob9pxPwDsFaXKcoDts7l3DzIiiQZ5jHew0rx54E8aYiZgJKalC/e8FnVEUCclVbTBtLo6ys+xMjDn7l86CNaAhD1kem2SDXLMf0wsxprYjaJ+O7iMgeo26BEE7wJVUho7bZSskYCMfDjZRk1LWyAm/JLWydwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3YY6AzIV6WxseBfX0AOvEokZPb+Q4tqMd+xZ/zLao=;
 b=0GPs9HXhxSTNhbqRf5d3eXXSH17hiZUoRhwhzMF1/yqEgAOyUMDPu14MYkcYqAN5+xRr3np/e7ILdw+PgHAjB0hR5Mu0imtQYg7rt9dbjcD6zhEproCCaiPMiitt0GHaF1Ry2rh5NJW7UE1T2FYP0tT7ewniafsYXSTNYKpZalI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:24 +0000
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
Subject: [PATCH v3 04/14] integrity: add add_to_mok_keyring
Date:   Wed, 11 Aug 2021 22:18:45 -0400
Message-Id: <20210812021855.3083178-5-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8425c6e3-71ea-446d-7089-08d95d379a19
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4168C5EF88E8948C39F365D587F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hh/JgAOPwMO5vDvC7L1JdGTd9Z/U/hz7tTNBdbqkdA/dBf2EJIy5KVn0JFgx+V8RRN2RSFJOFTj2zjyUhzX/S2CipcfZZE/8gMX1ulHDMCOdoZjcv0EWvQUIIC4iIhdW3bYCYvk9wOzxLnDJ8AiB40wBtVDyud7eWQrN6U73F3v9JspT17qD2iFfIqYi+3KapbRdcC7yBQqID0YtWAefT4onkiq9Ccfz0t8FrH2i8ZaGAbRkuJDAoQ0jAjgkVpgTMMnpeU/4DcJsJQ3NYD7iqyihccjqDkCqdB+xFvoLBfi80+YIbNhBdqX2rpi0JLGM7eVh36as5LxHuPco0I3pSft1ckax3BFG4M/f5OKWhnac+ul9ixfMmnv6/T2n8gA7fddOp0FaiJ+FdiMtRNUUDV9WFPKjq+t2CNlISN7TeJSd0Bo/Dy+uqrOJve/jsbIi3e+3RIwz9rStV7s1vnOtNlJWZli2e8MHvjAohdsoNZbzkd0fGquHjLDUWhBC9u6TVQEZbxPvvp8WXoH6fKBjVexzrTnIyk/yX1i77V1iRlgRPm8Q3uqdc3VXJXBBn/idb6lDAn+emxNtD/kFZTjdASRWK+avz0Y7SVBMAccxqASwvSADYUatwxdEmNsZhV2jpExgznUgCHxA4BwImevHKUBdziWet0zNaT2zzDu/aAtIKML+0Kmqcx9F53ZSh67dItySW8uCbiWMy+ZaBgaMgqT1EZreIbXK5BMhbNnfyYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJhl6oQjQPqeNL+W8aRSheHoG7/W8tmRlObOkb6/DwNXyOyVbQ5mzYOdD7Q1?=
 =?us-ascii?Q?DVP9fiHtKyuU1+plfKvzzB4h/AIBm+7aCabhpW9Y/4kcVOqsa1iFoxLzAYyg?=
 =?us-ascii?Q?kmUhCkkXIRVMhfAR6Vt+dYGRecCdz8eF/C2wTsbHr9t8SvhtQi44fvwY7rgb?=
 =?us-ascii?Q?bQLrPNDcqk2aVxrH3kteZb0yvHe1Pam45D60zlVUk5I42tJKbfbYLZXBDnLS?=
 =?us-ascii?Q?aGBgOcmSDNGdTUrvZ75ZKUEATZxtINa+y/REBcsPK+mGgfULjWNQObMpQuAA?=
 =?us-ascii?Q?Y4kme+u8Dw/JwNcF9+TQgsnucUTkpXoKOf8fLhN++vrH7GqtjR1mFXWRrgkD?=
 =?us-ascii?Q?nVTWgV0BG0x63fDln3Lf/wJpnSxExJ4+eaFIqhzJzVJm9iP4dQBQ+FalnGE4?=
 =?us-ascii?Q?FTSycUF87PUE3+U6zFKjh5a7iuZ1b0oaVos38iF7K7VDngpuZr39PELNn46w?=
 =?us-ascii?Q?uUMOtd/onOaWX15ZLRlSDzZ+KPhDq/JY5SD6FA0wNZgUTZzG3NKNNmQIfvLP?=
 =?us-ascii?Q?WVuRbG7zJffMicavSTrNQaZSlWiJ4DIYciifNc23ztOgdnatxPupY4eEVa73?=
 =?us-ascii?Q?zQ8bOFlvfyfqYKew/d3kqKLhA6MkO5pV8WGfiftLn96tfkCUsBtBFV/DKxoW?=
 =?us-ascii?Q?2IL/Y90pFNfCB0IY6ICjv2nt9QbOeu1slY/yG2yWJ6L8QqBIgHRDO9Ll2AWg?=
 =?us-ascii?Q?cvBD6TyIhMOe5PT+eKS165PIHDAveabJ1hTKMRaFjHpaaWQDvofWGwJH3wvR?=
 =?us-ascii?Q?9XkoRNDEPL7XhRxG2qB2SVXfxCSTfvSzMZ0kPDN6r+zpmwRmHWIHPjsQXyG7?=
 =?us-ascii?Q?dhtKz0lBwvAvdBrDFY2CLuAi6L358zi2lILP16VSW0KXZoa6VEDk1CY3oZEH?=
 =?us-ascii?Q?dKkDfZRHslrHKdhY7isvgDvECXB2P2Hm8szY6SDFQPsG1d0XIjpiyMelePxt?=
 =?us-ascii?Q?JrovhswQ/crZB97zMRMpznUt29eSdjoBqaBxwmT/V0iZBD0MZyFsnwpnTIrn?=
 =?us-ascii?Q?8Ya26RFdv77BtcKpyijwIbj7/1A4+yz7MlOk3imDZDTnCfq4DzYMOxipCFUi?=
 =?us-ascii?Q?CnN+n3ULltNHhthyX1q4zXP4bi2yJb5vwvAd5uHMTe0oi374ufD/3F9JYQ/t?=
 =?us-ascii?Q?QmSTObNb/fsU0q189CxFNAQFAKpUZb55GCYghI+relryn0dA8NZw9HLBypJ5?=
 =?us-ascii?Q?8casXwnhjuoPVNaCoCjvhUxUeiCIJYa64KonB6o+MDqTA2G4zmvj7eKLJCXX?=
 =?us-ascii?Q?ao8X6O4Pih6jKlsNWAZilmp7X9sddO3tPGoQRGLojaaBX0Hdp+rEfzfmvK7h?=
 =?us-ascii?Q?ieGi84aaDUtmnFyMANsysz7w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8425c6e3-71ea-446d-7089-08d95d379a19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:24.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWmNKWKUkatl7yVzzXzQP0pbee/LziAPMCd38xCgIoE4dBiK1g0SV/PtT9EjajlE9sE5s+G4lD6qbDuAcjMhN3WfTvaE9nHxQRt4koXRhmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: LOJzTOVf3E5A7kR_B68n0LBiRbzS0QiT
X-Proofpoint-GUID: LOJzTOVf3E5A7kR_B68n0LBiRbzS0QiT
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add the ability to load Machine Owner Key (MOK) keys to the mok keyring.
If the permissions do not allow the key to be added to the mok keyring
this is not an error, add it to the platform keyring instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v3: Unmodified from v1
---
 security/integrity/integrity.h                |  4 ++++
 .../integrity/platform_certs/mok_keyring.c    | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e0e17ccba2e6..60d5c7ba05b2 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -278,9 +278,13 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
 {
 }
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+}
 #endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index fe4f2d336260..f260edac0863 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -21,6 +21,27 @@ static __init int mok_keyring_init(void)
 }
 device_initcall(mok_keyring_init);
 
+void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MOK, source, data, len, perm);
+
+	/*
+	 * If the mok keyring restrictions prevented the cert from loading,
+	 * this is not an error.  Just load it into the platform keyring
+	 * instead.
+	 */
+	if (rc)
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to mok keyring %s\n", source);
+}
+
 /*
  * Try to load the MokListTrustedRT UEFI variable to see if we should trust
  * the mok keys within the kernel. It is not an error if this variable
-- 
2.18.4

