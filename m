Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4883B3D6553
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhGZQel (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241096AbhGZQeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:34:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBn76007952;
        Mon, 26 Jul 2021 17:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LiFO4qmfHwFk9iYsEi9clU3XuBoutT49lghhLOJiNN0=;
 b=l2mjm8KctmJ7MKkDfsmUhCiWXEQ9Whz/2KqEli0MsQjc4yoncdIFfGiE6UBpH4aqSS9k
 j318ouzLRsRhI004wGQM2OLT4dYl60w9r0wLujuy7tgHpK85rQM6jbjz3MTX7fxor5Jt
 doTTXeIquoM31vORAIv//ZlzIktiCW8yQXVt8deHPLBlaGhrOSwd7LFJVMeLyJCxs5vk
 efSNrPPgLT5axyYzeYgkoDLkArCCy57W+h3Ur9keAGeEmJH641NnBtMQ+ctN/+Vxv7Oi
 upKBhN2M4daOb4oICjOLYXU5SVD+O1FDd+x6OiGQfLHaBHPzDTjD3a87JHoiWndaO809 3g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=LiFO4qmfHwFk9iYsEi9clU3XuBoutT49lghhLOJiNN0=;
 b=jCwmzP9u5I6XLbPmpTjBZ5Tct5vH24B2e7ciA8VAIVTOIxx2pHrZtnjeqI7X/okdQ9Xj
 zkthbtR5oBlXCATAZPgT1gYNrqxHoZshUUHdsnHOll8BIwWB9cvnYhBjlxspRvgJqhj9
 u5EPkhFckLg9ZwBjNJ2o3vPO889gDEowR3DCheWbWyndRo4O/bY0zuOloHBj3ht7kxeQ
 r7lhK1zyBoPPbiNUOgD+7imkOpKYptKX7vcRYxZaIy6oVIplQCzA8e+XVa821lE/ArOI
 IAPOWPN9oLoef7hPuYNLZFHESvBUST0CcfGraUDnFvMi9963R1liI7ePfWFrfkHpOHcA UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBRKV160219;
        Mon, 26 Jul 2021 17:14:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3a0n2gcpmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUl5VusTvKnjapm34tADr249qQEjzvYynK/7qyI1Ins+zmEwazpu5BoE4hoentBG8RZjZhT1xEljVuQneox0Hr/xYNwbYZOflOUCm/QsFU7Mztv71RlSiymcj7tFkehTetnp4IBcIK/2pl1ebXXxbiruPXrOjdPVD4GLmp6bWmYynQzObEsl2yZQ7MN1qMZLkWAKOnaEZb04tCMkdZblzp/qMrxP+TQb3LAJ4Nnma4K5Z23Mjq7e4h55WaBrM5QemN52IXiTc3BO1gcdhQxJP/WEc7xkt0DAcSBGHP+sNx71yO3mFhahzLMC4I1EQGh+fxfTPILN/Rp9A8BbCc3c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiFO4qmfHwFk9iYsEi9clU3XuBoutT49lghhLOJiNN0=;
 b=TRIsIn79OgDLDwIyrekWONNdQlMZzPQvVpVsnC+bK9/FFIGBpkY405HFnvpocB6jyHHvjQJ7uXNyiG352YejlD3DHhYBZNJJ3e1AQWcVn3EsM6YoipEZSDQt8ROdJKr2ErIj46FRKTSDsGcp09fSFbxxNlWjgrCA56+TLXQXSzbfqNINcS1OD1Ezs2jzCAz9C81kP6GRp/AAu/HxqU1W6DBDYRlpDIxgiqcNLs1GwOQA/yIJ6lOzuwJUPmMOfk9aDFvGm8IgnHVdsujsg0pF3cDp/TFvUqKhXhZgaW38pbjKkt4eiz91TlA3Jbuaqum0qyrD2+iJBTBHGIKibLfrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiFO4qmfHwFk9iYsEi9clU3XuBoutT49lghhLOJiNN0=;
 b=dt9AMMxL6dwdvK+fVW+Ly9RwVFAXcROKx1oz5IpZZifSLJC+EXfI5C+qSdDMTkTnpdFHrbxGjrbRvGepKovm7C70+LWi+BgXYrvqnzcQpsM2qB39hBn+U1booCEfupmf33RpC5BuyLek4Me5eXQSP66HsE7Nafg2u//F6sB/UAI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:14:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:14:05 +0000
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
Subject: [PATCH RFC v2 11/12] integrity: Do not allow mok keyring updates following init
Date:   Mon, 26 Jul 2021 13:13:18 -0400
Message-Id: <20210726171319.3133879-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:14:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c1b0624-980e-425e-48cf-08d95058c564
X-MS-TrafficTypeDiagnostic: CH0PR10MB5019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB50199052116668CEBA94E09087E89@CH0PR10MB5019.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUXF2mfMdrzleDXwGJMWjkp95uMo0vW7ZoUOcW+ZeuFgyLxVQ9aEPB0yBkQpGjfcUy9oFWFNSgVqUjygSeZlPgrTe4vHVC3VZYQ8endS1M1Nx5xV31laPkbEYJ0R5ZuYhOmEM1iI9lQy7sjQMw5hgD4Q1MXE2eIWqDXl4M1i0Ay7NFSRi/YeaYwV7tWhzAJzW+jArE5fT2sgOOLZE0e9+W211gQjqYzDgZZkfuse6ZvWBJalyE8mxFWi3IsVbiqEd2HCcBSfzqnGQcRDLFklbfrON07v2b2pIruOxFFLYWiKAF8/QgB63ckGH0K6s6WcJpzu9/M3nqiYRI51iHogGlmbvs2jKZdJwqu7ymBObgx/0S7Vk/WP5/D1S0QTkCfFJP1pBszN+ct+cRZ3kmIl5hpKpvxUKjSAJ+nhB7eNaBPXvk/kBQO8rgJMYH8+axg/y7f3fwflailgn1lBtzeNFyTDhOvji+d0UpQR73asW6NJ7I+51qlUeiulmGAcvQ+7xYTR7iuPlwLXqTY+VNk0ucKpmTmiOi2xELDoVx5GsjVCKNwLdgHH50SCt7LEPTCRb1X/7lsJz8xPHPA7kjk1beVepNAVMKDoDv1JPr+mrUTvG4R8gN2tUV6B+DOesaD/3NaXHzp0X5KXTNonSqbSly8OJblRgvMU9pRMQvuve2B1Z52QQaRBPukk9PaRnOamKA+mux3BnGIsmzbmII9QVhJALBEtjpyZ7+gV4CySjPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(508600001)(8676002)(186003)(2906002)(15650500001)(4744005)(1076003)(4326008)(7416002)(316002)(956004)(5660300002)(2616005)(8936002)(107886003)(66476007)(6486002)(66556008)(83380400001)(38100700002)(6666004)(86362001)(921005)(7696005)(44832011)(38350700002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK3XdGQbo+wBtPUwrT2nqoY7PIqP+DkRyOvwmSqb1/fQwSQnMZJw9shVujHv?=
 =?us-ascii?Q?2jnB1P/Pq45xtPg9hC+6RWmQHtVLrFfiMiwnrUyZ1gAWwgjbQZuAUyrBCa6B?=
 =?us-ascii?Q?SEg+1/Dfq1XI0Xtzw3FNxm4NDWOhd3Dd9oe8BA59ME/yfsf/H0vstp3aeZS4?=
 =?us-ascii?Q?9dhXCNqgXp1YxThB0aCwczHKZDtRT1t1SAF+sMCcApCooxcjbsorstuAILZ8?=
 =?us-ascii?Q?7I2TwPq4jhexoa4ehHACbsijF9RDerv/TF/+J+kxCVJYlPG+a3JO/21oTwrh?=
 =?us-ascii?Q?pMnuIHesvFf1IJmwyRMXNHbjugefpYVeyAWuuBMn+6Kn0zCO3vZzWZHucsj8?=
 =?us-ascii?Q?OkbV1stKmngEBZV7CUOVlQJ9Q3kJz0Hx4HX/YeOfwJHsWeF/akOq5U65sdMU?=
 =?us-ascii?Q?VUn6TwnDPWQNybJ/zyhZQ2yt1wzxkUExH3F+1RsI4UWMt7QoQjw1I0Bjif+r?=
 =?us-ascii?Q?UEkE6I0g6+SK39rhuUi2S/4vhOtUGoj2LFoBkJ74S9x17TDKCzTsJPj6+YsT?=
 =?us-ascii?Q?k41oJ4aTW6q+B4QN1LsDA/eHmCOrXfFfyrthr+iwsKnbrbOCCB2eCSmxEzuj?=
 =?us-ascii?Q?l2PxnqcTtDRXPEK+J4Xwu2A+XHWgDDftPy2ltlagugL+begthGY4u5bjaW6Z?=
 =?us-ascii?Q?nubh3xoPFiYmx2D9p7py8O9Rl5bGrhx/vwm04O3OruD1QLwLsUAkwe2ESRzw?=
 =?us-ascii?Q?y7gwb0rAcUxmCru9xrFll4BLzrGlVfFzrFEahTVXZ2hcimmcPrkUvRcJlyk1?=
 =?us-ascii?Q?z4eKANj0fiKME2PfEM5Y6ugz7owgD8d/+UdgnzgdBKonu9ezFbR/KlMYL4Q2?=
 =?us-ascii?Q?4zBSCON8hUGCdYgA4O5HzG1ZjnVnKGMMmaYWuAa6TA4dhkI9fPsc2UmRZJb/?=
 =?us-ascii?Q?58qFu8qPjrpJZqaiynhqN/Nfsq7fI73j49Rdnm2yzhZ6dXTpY3NLRTqrEtl1?=
 =?us-ascii?Q?ZapBYMfbwPiczqeoquplsiLOCMCc1IIXUIoEmYamgxhOixa2UJbhIU0v6eKW?=
 =?us-ascii?Q?8u2jKe9ni/BkUfLrFCUBd1P/ZLEdftD3K7pGpI/43FiQ3e7aGI+v7Z4Km+tc?=
 =?us-ascii?Q?hCkhxV6h5VJaNEnlmfWfja32Wv4S/oxvT/w6yx3TqU3fsVE3j84ZUO5fTVNv?=
 =?us-ascii?Q?8jgOYyLA/NwQUg7aShoKjWK41KLhjPwQc3IHzzTMhOvRkhxbSpF8+NaKu3QC?=
 =?us-ascii?Q?Q2GQbcgnhp5tqqTjCyOEMWXez2hkPoZVhvJ5fCZdwlokHW+fckLaHHRMbpu0?=
 =?us-ascii?Q?HPvMKkFbv0DPgmoBBXRekR5be2wwBGqF96yGnFkWxHqa5lHtPmx28C2DbgLL?=
 =?us-ascii?Q?Sw90Fi4TLGcjutAD1XZ5+nuV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1b0624-980e-425e-48cf-08d95058c564
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:14:05.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z5ygcP+kR/KEyBkuPm/tWHMRBtu0eWQktQUwrrSnkSE/+CXl2P8GbOnkrFNSMrAMwWIcPue1dbyJ7g5ypzRE7qGstU2UhniopETl1l6jQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: e7jeE1Cf4FoaYQgzPEh6NbxuVtRZPpZF
X-Proofpoint-ORIG-GUID: e7jeE1Cf4FoaYQgzPEh6NbxuVtRZPpZF
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The mok keyring is setup during init.  No additional keys should be allowed
to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index be4860c596b9..3a12cc85b528 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -145,7 +145,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	else
 		restriction->check = restrict_link_to_ima;
 
-	perm |= KEY_USR_WRITE;
+	if (id != INTEGRITY_KEYRING_MOK)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

