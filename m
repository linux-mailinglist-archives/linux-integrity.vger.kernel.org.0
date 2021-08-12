Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EA3E9C68
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHLCVW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233780AbhHLCUm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2C0o6016211;
        Thu, 12 Aug 2021 02:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oYw9rq5kRDCmTjFFvf42NeJU7vHf/fqd3JAdb9zMsO8=;
 b=uD8WN2tI53e3J0qLVFAHXF028af0Kg9a+XZEZcFr++jEyJfxizaQiyMkjvhTdupryv2A
 qFZA3/j0M0fweRfc8fgwW8LFMB61Gzd/n2v7Ioi8k148/Opg1djDQSkC9HEenBx7vz6y
 tJ/5azvzmPo9qx+NWKEKYdjjRsxTxJLvCeko5uhC6zO5rCdrdjH1Fu1W3jfo3tVE6ZBG
 APjUHtsgWjZPFgrtBwl3j68FmINZXrw+Y+Hrz+khII01CziCOsxh6oWb6B3WsER3Cmrf
 cskb+3c2LjCxxOclK2DVkV0ksRVERXax++tyEhuMkPEQ1NAS3NBXeXxHg4/c0CLQSCmu 0w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=oYw9rq5kRDCmTjFFvf42NeJU7vHf/fqd3JAdb9zMsO8=;
 b=nsYt+aFY3nBhS52sELf60nA1q5+qyKXXXr5dzyPR1V+MYLKLtzmYNpbyMtf47sQbi0UG
 gDkSa/MeYiVfKp9IqN5NmA/dirzzkSOPOwcVcP0LCzpbIzyovh7oxhm/W+ZKt1ctsY33
 bwbr3EP1iMDHOTxXZNQ1/A0FrqpA3+YqdFku4oAofAC3p4gHpNSKrFljWGDQSPS5cPCp
 1ZeBW4qX5GVWKRlfEsClw9NXT6/EieL7QfBs+pPqbt7wlF5nGfGcWM7cgAICsEDq/vkr
 ivUP/Xekzvj4f5K8rZY5I29wwRwbi86dX+91LnSIDEow6aVhf30vgaqbq/5nsjHTnUIW VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqguqr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GIHM143188;
        Thu, 12 Aug 2021 02:19:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3abjw7j8gu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqwviq3k7JXidmV/RBKxZ3EpJA8z0rfPFA7dNReKmav97kpa2ltGsQD2e00XbBJCyJuXa5JdbAGe46IRmxjstplizTM5DGoYKuazvdx3HXYWP44f23ZMuJUU+K9hct6K2Su6SE3Mu3+faZoDJEHdeXvfn2wTh/XZ65xUUi/JT90VnP4VR3py7s+hUY3oYnN206OWE1QFA6ZiooHmutLw7CGFFdeugf36UkPA6vkwj/O6PZfX9I4G2V0DRP6poYYE6mY0l2nYNENzi92ZAXT7XD/MtLcDLEXYY2BsLZHB09ofoobSWcLu1GnbDYzsAhTYw540K8BeikLEo5f1pMfzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYw9rq5kRDCmTjFFvf42NeJU7vHf/fqd3JAdb9zMsO8=;
 b=NOf6vMd5O+j6FgWdXBTKa4bV4Q1g0R3ZiroTpP5fTkrBbkuMwbl2FAzsJO/LyvtVodwYNaf4LZhyULb6aXFXp0+7czTBaZ1I2RLDJEjAAGfoZ3Mg8W5f/bN35cd2XgL0Ih5SaAOURp/GDciAebD7868wj2VI11VzelIvc8dthjBt3msZDuQ+NU+NgyX0yVVsWgGSTvueBRKd8xRSm+O02cJDYaDduFAy+emoPCsrPhVVNbNtAFSZpIpApSqjJXHZcd4yiiX8kB9cqbe7QyNL/GJMi/4Q5dsedufv1KHPOPbuDmj2qRl+xnGWzPVNYf5IdbgYBQ5pA4RBxGxQhp239g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYw9rq5kRDCmTjFFvf42NeJU7vHf/fqd3JAdb9zMsO8=;
 b=EvjPOwOaDk/mFXY9xCmNgK6q9pEvY36Jt21DUpM4jowwcMclPXQOY/OcLTe5UcFD75rGu914nU685qv0A6PuXDtiY6JRLetrUYbzM6oCtujc5uKPW3zbVOYq+4mfuuRVXgfIFPa9tcYuMbJCqAZVf6PCYNogkn2N/Lp6NKHeMMQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:48 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:48 +0000
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
Subject: [PATCH v3 14/14] integrity: change ima link restriction to include mok keys
Date:   Wed, 11 Aug 2021 22:18:55 -0400
Message-Id: <20210812021855.3083178-15-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 635ad231-1862-4b52-8443-08d95d37a873
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39609CF79AF53272D92737F487F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryY3L80Z78I7V9l4H0V9O4oauhB3NP+mw18kRYXEEDs4p+niu0Ou//rbLzUCjSzbOuw4KjPnXyYVhqrIzUgqGW8U+J6lYZxZ81LpCpzAbtDSJp1Zw6Xku65XuZ0OxJXLgSorQe6Krh8VdHCSp5N77o4nkqGXb9iC8WcuchWRVio4Dxojn62Be4keC1ejBCRaRL1vB0AGRe9mcgBalYZ3IpfrQQb2uNtZGH6ma4giGTwOGY4CYpjATCBl+OUaQkYA06+bL4BofW5nyMKv55qhX0rzvXgmAIf1OuWMD+tndREBW1iZ9h5FqlYKuOercgmZUfavnCPdG/rsDu4XhW3joMGr5QQXsiTt0GodWFQJKsZF6qLnWGMw+Uo3zbHOcJ1lqUR2272IWDXgF+UghhLuClWF/CVPy/HOPeMHO+FuS0Gw7F153YHN8C78ivXeb04ADdtH0Otk8r26xCV3lZ/iov0WffVTQoNWhQBSedAdl+LrM80yWv6l27U1nkbule3HiEIUhYR5DpFeEDlpH62UwsvsB4fdg7UQEUyVdzuGsjJmaHshpSTXal4V7VjrMVVUeSGjoRueCJm2Vl/1v3NwBBcUoSrA6879WsCjAqJkGZ/xILbR+rVnffjrFEGqpCvkuL61MdSr1k+aAb/BcRGBOoUneYnLnhFm3+9pQme4TN7STm9SKmRbK+dU3SBd6KkXQXdHV5eyrJDEzZp5fuZZCIy/47zymLzfKpszQTROLKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E/W5j2BB7/ZoVPwx1qLKyy9ypyQtxpABGh+a5Ynm2J/l+6UbMi4TIe4sWqd4?=
 =?us-ascii?Q?eVWe0SCQDEy+RqrW5T1vBvZ86KlYAP9uccXG2Y089g0Ac+snp64EWT547g5f?=
 =?us-ascii?Q?Lwsxzyx8fnk771SPvPzqopC0HvnVetvNJD1bUT7u+I7s0uUOSjt5s7NJIQvn?=
 =?us-ascii?Q?a/5tZzb6OV3Xa9l3a7KeaPaiGeTUzMexg1VIKbS2zKEbWTljPbst4eGlX1WN?=
 =?us-ascii?Q?DDDkQMJGNYdiyzTPmKA/1okRl1E2LnC6iU7AT89zGRNMgvjcOo0xWqtkmuoj?=
 =?us-ascii?Q?NVO5QodQITjqbkyPAwdqhaW4KXMy18C28+6r/4ee+bOdunyeKwPHWKl+CFQJ?=
 =?us-ascii?Q?sLm39h56pjR1oSKqjJwnnSOVnMFKZk3Fmb5zQpHOEjLUSTPFFIi7dsA7E/EN?=
 =?us-ascii?Q?zcZ0XK10zhJxvkV7XorFESKCjGiYBShHV1As6QAZGa4kfJu3ZuQkxwYDoQrK?=
 =?us-ascii?Q?8HES28YqrirlKXaOKzP+Oz7xPi5as3xJtB49CwyYh9yq4QFG+YbHPPF+I1e4?=
 =?us-ascii?Q?GStorAWfFPItcXZzmERL3PTaj02Kk6RNH3swanxfJP9B75zvtDcDUIm82kaI?=
 =?us-ascii?Q?zmfK5XOd0sKz3d/yUILCmb3icb4dbH8yBCwk1ItCLOiGDUwJBep/rKX6sDo+?=
 =?us-ascii?Q?Gram1TvRQKXpPp07pAdA9tvnDP34f/NufzJrrIu2Z1kkk89N2c2C8Bh5DcK/?=
 =?us-ascii?Q?XALy9aX9cLffiYGsBcE0m9cuLJVUgIl2RGEPQSlQDQTPIM23rsnYtbMvSwlw?=
 =?us-ascii?Q?s5FmaZif6I5Kl+2gFjIWn1JtNryWCaUs86Z0zkwKrB3BdDsOKAUoAdqxzMZ3?=
 =?us-ascii?Q?M4XOlFXQBDmXN96SKAldiTpIDGeyebIHPjhm00M9Tgg2OyP2eZCNGxpv70TW?=
 =?us-ascii?Q?r7CLsrIyt3z88ipuwJ1AO6m7lv5Q1yQHN+9Hec91e/9eZnSu7DoIPBoX/bX6?=
 =?us-ascii?Q?Aqq+5gtB9yW2XrKMtFc1pEgGY8yt3EF8gPWw3gikkbXc1It8Bq4Fak9PUHiZ?=
 =?us-ascii?Q?IKeqBUOiqRdPrC6TRASslKdP7WRIyAtXCOLAYmFkayLOm997X1N+HmpzoFIZ?=
 =?us-ascii?Q?BxHCQD1p1EegwIEP21Kx6NTuKGvceU40MJdIJaDdWlyoYvZ/+gw230wn65mO?=
 =?us-ascii?Q?NOyuvZtq0uth0jlawulNDsahF+S5E/FqGy4eHgU2RRCdy/5vK3SaetRZR9OW?=
 =?us-ascii?Q?pq/YjlGLirM525Ayp3jPiGWZNwJ/ZV3kCZ4DgHnvovyvEQM8GIEvf/cBx5Nd?=
 =?us-ascii?Q?7vo4cAMqtpFGVVipSV0623Dy3BZ62Z1e6ZZ4Oorbl/RN1xunn1jtynHatIWz?=
 =?us-ascii?Q?ERs5mkzbSxfiy9XdgCx0qS/r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635ad231-1862-4b52-8443-08d95d37a873
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:48.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncDmECj7+KH/CLedqbgXeDN9qu5NDkhgAQOlbZqfp/binIsMBc92dYT7Lyeh2yjlYoB6aldN4Rim/YTfcudsWSgs+HQtBlaZG4SCb1Js9iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: n0hbztuBF9QMKC48Ejok5joQfzd3Mv4D
X-Proofpoint-GUID: n0hbztuBF9QMKC48Ejok5joQfzd3Mv4D
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of the mok keyring, the end-user may choose to
trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
trust them, the .mok keyring will contain these keys.  If not, the mok
keyring will always be empty.  Update the restriction check to allow the
ima keyring to also trust mok keys when the secondary keyring is also
trusted.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
---
 security/integrity/digsig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 996bea950972..1419ff4fc2b9 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,7 +34,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-#define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
+#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_ca_trusted
 #else
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
-- 
2.18.4

