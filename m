Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2263BE119
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGGCsE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhGGCr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672a8XF017205;
        Wed, 7 Jul 2021 02:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VvtRZG7iF38K/lY85XiHx02e20BYTaYTDdf4OfOhxcM=;
 b=P+A2awKLup3cT09nUHOAVZVjsPFEn9HjzQ/00j+3cmzJWfkJ4/fL/zvzxb+Na1pTH5pS
 eLBwHtc45uGf5AhZo5APLIcHQG6uKUK2KNlIJBmhqfBiS/XikncAH14a/PO2r78RtWD0
 ARLlg8udCqohlZGVMaO5MtWoEt8HtmxAr3d1DD6M918JJLyQSa1E5wLFpekbzn8zmbYm
 8tbaFtqBjhiFapc3GcbQv3Dslk1APTGcStjnecMHTNsNSE9bzmApJ5m1zhblviedWZcG
 TpQZShHBOIyQUQE0EfnS2RL3FMN/urIQwgmNMZjAmk8MHiwJWe6jAHiRVp/c1SYwEcn/ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ec4yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aUf3070944;
        Wed, 7 Jul 2021 02:44:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 39k1nw7q56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP6TAVo2/wMSQ1cHWV5B8obPRt7IWubQiRRbZLRj7rScAPeWzQ8e4wp09oNarG1PsiWyA0LZXypoZb6VlfQx7I08WT2SafSJ6HAxMiMNm7v+RQJySsj49P2DtcgHOYFYY+EBsgyZzRy1ztrvsP0O6HkjbZZEN+5WXuWMZ6DVo17BJzI+6PRCwHtzn0ddnLt+l7lEcnUazaIhJBAGyGITB2Qq663Ttghr4GtibzmKxtc65kCj7Ymi6+1dPVtI9vAcFx12i35LECzVUqY1dDGgo5k5c+D31ShPPhkS4f6ZWv4g/yAg/woH1BCyYB+558uVSUUYHE4OEi0/ROGyrcsicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvtRZG7iF38K/lY85XiHx02e20BYTaYTDdf4OfOhxcM=;
 b=O27PAJKNyrTxPdpdQf8/lOme7tOX1srG7Fxop4WHm4yLzxgQjwjijcXqZxPX4ywbExKJO+9+s32oWWnK4P6S3cXVos3d7qCQlr9avlZ7HfHR1bFhzLzceg4JNcPBnijuHB5SauMxnMedWn0j6slEtp91ZLjO1671a5JOPQLqfQCNDLfOSIIT6bukQYCFUddQI2fa63QKiL+ZOLZYzTnakZZoP6mjmVq5de3lvBMFIethDMrZuhIXrRmsLEyxmnZeoBG8HxwwMGIauwBDeyOJWD0ORJVhqJTasy5nZx5dqpw5IhqeA1Zc4gloMwLRPikOaabZzkBg+Q1Gh7QZ7ksITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvtRZG7iF38K/lY85XiHx02e20BYTaYTDdf4OfOhxcM=;
 b=yfgfIVsqv6qoAuKfIDQYKnREkCO9ZRPT+7g1t4jM1LMAGZHPXKqoezaO4u1Kf+xiRMrj+qchY0+OVKudmQXqlKcqdcrIQnlf9GiHacp2gn385iUUvy8gHucTqErBTE4+7WMOWQJAyZOZT+cGXfe62noGHrUyfL0REi43ufo3ltE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 02:44:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:47 +0000
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
Subject: [PATCH RFC 11/12] integrity: move keys from the mok keyring into the secondary keyring
Date:   Tue,  6 Jul 2021 22:44:02 -0400
Message-Id: <20210707024403.1083977-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed965cf1-86d3-4997-fffd-08d940f12f5c
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4166DBE4161808000A37A0C6871A9@CH2PR10MB4166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5b7YUU1CFOaLMkEM/jWOBGZjvTawjucIYk1TpFWBy2nS7L8KtL/Mhrg1rBfnvTBR9zMZs1ZSRrgrFTaIoJWoxMBJ8PLHU8Mgk4aFDE7EgTrwM9Cd6wFo+9XeCtwDoO3GvTNYvqJKqXlOEnJ+C3EDXTa2WgpUnEwg/7aroaus77c397rd4BxceFqmJXY6x6gYyBGlNPc0RXlsPHv8BNVSHNEc8GHF37WNc7caHNH5jUGICgiupe7nd2uL7OgjakRglkj9mb3/qVZhoUsgErTZ4G2ukFP3Pa0kScXgrATLXeGveo15IvUSHX+2iuhSroVfYPdkh254/ksfiaNEHQ+YnhzUk6LCxzsLazojwMaUdMKkr9fexrNNomdXsfWJTqxswGq/p/gpGul+QqW2QXkW20E7utYUn3ivCHla7+VZ0TKhPhmJmgHYyr/ATIgT7kCu8WwjJh8nYZNr4fN/8Nx9NiyrZjDEP4vcYaEDg8+VvERnPOMOjaVocYee6pMduj7SOqr+B7ZVEcavD0qClPbb1NjrsCLn1wDKE9/0+4HBeYtvS05XmChP3losCkUcPj7xph15QPRXX0r2eBWucJOL9nA+wIKrbQSYO7iPgPpPqiMMvXKfiLm8hMWxma2ZaU4JZFdnRfyfHtVLiEohc+Fn+x1sYqz06v9wSz8zNntIh87BzJeUKtvpFkaiqw2/7Hy/UwPn8Whjt0TN5STCcaR/8yeXrgYVOQcpFv+KlJodUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(36756003)(7416002)(52116002)(2906002)(4744005)(7696005)(4326008)(44832011)(38100700002)(83380400001)(86362001)(316002)(6486002)(38350700002)(186003)(921005)(6666004)(8936002)(956004)(66476007)(478600001)(66946007)(107886003)(66556008)(8676002)(26005)(5660300002)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q02XCdCAL9JgCqnRsNYRxMVGTHNvZZM93mT9inm9sQXpKp3s1tmt3RvDvnHt?=
 =?us-ascii?Q?sZ2c5x3JhBHq7KW1R3R7VzhunnT6pV4qtfU3MyOuNsveBBKIm5RVwcSzNr3u?=
 =?us-ascii?Q?JDND0u9nBmQ+V16x8616er2H69Te3k4wbjqV5dIh3DjI3jZoeihgJx9Q64Jx?=
 =?us-ascii?Q?hTcEqxstWMz0L6zJqTGVJ4ZHspFlHZQ/+/loXK45/XUNqvOAm8FyJj6pIMIR?=
 =?us-ascii?Q?sUjAKa170ApgsPaF+ikQSWb1PaXnoY1e/yfpl9ieg5WfQC8weapkhGgMc1WF?=
 =?us-ascii?Q?TALJVTqgwrfCgZI9zfmV030Q8lFyJzq20v4mUFrmqogOz/52r36B6Gai+jrr?=
 =?us-ascii?Q?Wc/dy1WYoAeyIWQCZRF/RQFZHTdZJcdAe9WeLMM0Sg3Yb5XQm9fkyivNaX5Q?=
 =?us-ascii?Q?GYkTTLpeUmdm+xwhn81JDoSp5WGeHekq+dW6+Y4xM1YbShaYE5OkngUCbkHE?=
 =?us-ascii?Q?cKyDo7s+4u2EmasHYZVvqssHjDlmnb89N8pWk51f/KzAEyUDX41GpJ+BIX+n?=
 =?us-ascii?Q?BOJdpsUFDGthgkqIAFR5BObzZEaq7wLIw8IM63nUkcmKVJusJIFDwquEq69X?=
 =?us-ascii?Q?TQr6Shaw9W4dppBiBIasLAuynMen2HShw/SidacGkInKkxvoEE5TA9TF/W7c?=
 =?us-ascii?Q?hBO92qiUjbh1Ilpp6rTnYr1Jjkq0WxlrSHh/yQbBLj2H5wg8iGUKqC/FtccX?=
 =?us-ascii?Q?KWU9asgiWc7d8V1wVeMarbzXU9y5A83NZfgeswa0S9Upbwn9Q4U2kVtTAAqW?=
 =?us-ascii?Q?GNU6kIoC64Lwv7elQekGiKj2F9+7HkiFwMf9k6s2o4Ub41Xbzp2N9UOQMdt+?=
 =?us-ascii?Q?JDHv+O5xF1dLdhEIn86tOIqYr44kN19MbLpnVhPpIGdMKVQmosfSeSsSgNFy?=
 =?us-ascii?Q?P/FS1BrZxm7i6y9sl8eGH6ZANMf/+tV8qEGOC6S64fcD36fBaE4CWwitOm75?=
 =?us-ascii?Q?RTNVnKkTlfYNebN/z/Y/AxT5zFZ5UYSXFsTWps5+/2Zlkfd22P1+VnUS4jHm?=
 =?us-ascii?Q?sq2S3t6L1B8ldyzVX+vbLSDX5vuTuNAVeeQE/YGQa7MKQR/uTkl/+kUtoQtC?=
 =?us-ascii?Q?5wbUOhVUEl9XL9bcguwdOz67cfoj65s2Jx/qvirConwTT7nS5IRp1ztnud8M?=
 =?us-ascii?Q?0zfHXs9tprDW+6Za9znxpjVLoBVk1qKno0+Gr3+NcdGyF0MuNiAWILFQNC7/?=
 =?us-ascii?Q?a60Q+oXzdVHwY03UyJQWy3tQds6F7mc0CowjkETHmd6TY5spyxV2UAXJNXek?=
 =?us-ascii?Q?C56geaOmHW8kPM1y9A9c8V5ZFhYoiTOPEQn8eLDewJLQVO1AABgKy1/wrGWg?=
 =?us-ascii?Q?tMTzud1FyJ5HIvYI/TLe1BIN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed965cf1-86d3-4997-fffd-08d940f12f5c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:47.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+TNiWrFJQS0FNn2Fr7+Ef7baTS8+tepBjIZrFJI+8WS5xvsNgSCySHcMrIu+oJ22ROGexy+ZizcM96ZCADcRFPMY+8tENKGz5c3xWBIxIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: BK59Kxxta2jnfHlYZ-BF_RUQl3cJZzck
X-Proofpoint-ORIG-GUID: BK59Kxxta2jnfHlYZ-BF_RUQl3cJZzck
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys added to the mok keyring are only stored there temporarily. After
passing the permissions check, move the key from the mok keyring into
the secondary trusted keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 07547f1a4806..e301cee037bf 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -175,8 +175,13 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 		rc = PTR_ERR(key);
 		pr_err("Problem loading X.509 certificate %d\n", rc);
 	} else {
-		pr_notice("Loaded X.509 cert '%s'\n",
-			  key_ref_to_ptr(key)->description);
+		if (id == INTEGRITY_KEYRING_MOK)
+			rc = move_to_trusted_secondary_keyring(key_ref_to_ptr(key),
+							       keyring[id]);
+		else
+			pr_notice("Loaded X.509 cert '%s'\n",
+				  key_ref_to_ptr(key)->description);
+
 		key_ref_put(key);
 	}
 
-- 
2.18.4

