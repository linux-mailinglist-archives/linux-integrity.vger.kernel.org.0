Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32B93BE116
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhGGCsD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63140 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230082AbhGGCr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672a9JZ017211;
        Wed, 7 Jul 2021 02:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ZmQod4qvBmWOCJDpC0dpvXdZyvsxrEFYeq80iODTeUA=;
 b=Hhg5l5h4YjII2HR52pfY8gC2MsBnYHGL4wGQtxVoOyoV1q+zNbKJjIN8NKGi0QFDcAmM
 j57s/y0RIU4eGd5z3/TaJWOwsRq66IbWh2cyug4Q8O9fUHhFpdX0F93AbQjG31Jivy7G
 +2iS1lL2chuqQ5nqHIr6zxdFbR+6c7G9ZSTjz/53F8NNX/N3YuXx82f8BKL/9dGBlKKQ
 3+nrZUfiXU5psIHNjPScVhTRtpD42YuLQ5vFvUA02n2S7mTwU/6Rjl9bhn3FgLBOf6yn
 P1gsxbW5Vjml3GpzKn6YlqYdkHgQ8ASYfegXrbcGD7iAhtRh9wXsj8RxuFOoNxxfMSDU oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ec4ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aTGU070897;
        Wed, 7 Jul 2021 02:44:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 39k1nw7q21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf6Tilkp2eAGCVWrka0o5ZXHmTRkDqxJv/brySOTNOx2Y+kDJPXOHujg7Gw1b93BPEC93Huk0eF8/Ga/zt5V8U30H1H+T9QiDpO01NcHwdF72FsFu//i3MZwJ1oTLVP7PXCx9whjbiLB4ClOCfsdchXy+QyHWShF8hkpkJxs8zvolw03j8Ku7SUv5oJIDpGviMRBHhAgYBf570+x5MpH1DcddbYisur7/QeSGA49RJ7DPlAw5+6QNItHhNvl8hv13YfLPss+kkZgJC+6Upf5GWlSYhzUwu7mOYepXakcDhRcGOQpPFVOkF5k8EzvQ8SJv/gdnQM+YBQOIrTfzyWu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmQod4qvBmWOCJDpC0dpvXdZyvsxrEFYeq80iODTeUA=;
 b=PNoEFEFp38BMbK7xqh1M1HuOnu/lOI1llC0AbXgT2eTsnHaI6AET/cfeKP2j3bsM5UySTxJoFoe8Yq628J+kAen6WTU7eJ21OT8zBXB1eLfZbigTZsj0wcSdEJQQgewq6jBDNlzh6b8iKOOg1iHUzQlTYjHBcBats7KpKxWEd2n7zuE2MB+QYrPrsBxG2zwMNGYUFSxLF3sEuxNQWn2bWJi1QOyzuCPjxEBXmy15M5rxFxWk/nxPCN31VuBwcBk7adi0+iqm4VM8xX+DLTGz/9nN+Yf5gpZpL/va6Pg0VS3NGt59514oqYFsxAsD6dLmuCVz9WF1G8yCW6hyXS/JQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmQod4qvBmWOCJDpC0dpvXdZyvsxrEFYeq80iODTeUA=;
 b=E1aQ+j4yqf8EPFjtb8AKjCNcWz5vIUAdfCLtaEJhi6sxVhpsyCjWQt2kzREV0lJQj/HYgFjisCmnd8FuKXHIZe2zLKqhwGLuI9GNMOUZZlvnlIIitz7Uk7iEUwoBfLWC3wkYQ1VARZKdNyDzDRtHUOux3a7WMrchonaXaiqKOkc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:41 +0000
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
Subject: [PATCH RFC 08/12] integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_secondary_trusted_or_ca
Date:   Tue,  6 Jul 2021 22:43:59 -0400
Message-Id: <20210707024403.1083977-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c61bb5-7168-4d1a-e659-08d940f12b74
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863EDB4644FEBD7E07BEBAA871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NspFxjNX3PbUyqjwgfki5BJOAa733riLWm3ciM00GeuOvxC7DglSgX6kopK+v7B7mS+r5d5NoMntlXW2aMwiRnYVGaUgeTMjHW0YQF0WT4L4IWWXrufoArvaRAUNmQx6l08e7eTu2lMZCikvhoKGSFOM/ftpZJw83Ver57hn3sT19ES7/x1FiFz9gH6sHbrxU6cz0wAKWO/oJ4I60j4pisrsihjQZXhQky+JAPWXSeZM2FrnhxhM6oa1+navBvnPNBik01Ge4FAE3MjsCHCkZiFkF9tE7mYXkPaQWZSmB4FlyNdIIoX0yaPctJfIfa0ieCFPyhEDbIStSKeLLRm7yHjYvawhzNViXcdxg+JvSQhbha2LLSThkFoVO0nfefrQ9bGn2tAUvf/nDpJm0HubVN0Ph+o03WeL8zF1NjAjvuLqHRTDLkD3wCQP8NzKpp+nPEa2u7fsO0mWVzwh4e+rmYKkkvxi96KTSGugfW6d2tGaWQXyhSXE3AHnYaef4CT7gOD2x5Px0i7LcnrgDkpuv/bLf+3LUNVB/BrQRP9gkoe656vTH/C/Pq4POGehkItND1xhAOmsfBEaQaqAvbyX1z/3o5o4xYQOYZhrjQ7XrwV7PZUV/4GHw7vMjSrsbGGwCoUjGvTig6YBcYkol9/obazI0do/UHscd/ayjtthFTJ+1wBD1wejZ4f/JKeL41svvl83VJ9sNduhLYuGxX2XXwDi5KN4hihKTs3YLFBvmhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(4744005)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+N1Bkt2sGMpa+A6lRcnEQuBFNWF9eSDOKH4omTJsRu95szzVLAlzv92+X3Q?=
 =?us-ascii?Q?GsuU34vlZovdGqR3S662WAON0cbOWaU7eM4uLHgtXezd/Nj+uFolKFj+dJ6+?=
 =?us-ascii?Q?vLNmYAL69nklEPclfWHYgfEPFtEvJVRYdNFya17TnhnuH6XQWMXzyUQc25j2?=
 =?us-ascii?Q?XypVEAJl2wVitZU/2wUoljucIX93hRJ/bKe3O9It16lYKSJGWssWeyCrzgj+?=
 =?us-ascii?Q?B9RUqDErnb4Difv7DBAH4jW7UVh/KZRrHYd+ZlQAiE6EA0XFaYTaTYdFUWde?=
 =?us-ascii?Q?LQDT0Y+WI1EdmvncDGp1q9B9TI8YKsJxq1sCOcQAZLUD6pmbT5E8QKtQGk9M?=
 =?us-ascii?Q?An5wb3aBC8FaePRFPxZCdOMBEekwJOGn77CX2KZxm9cDJLWMIw7k2M7J+moj?=
 =?us-ascii?Q?R9mXaD0uFTO2hgVmjPdIhEB5N/+LC9f39Y9rDmmPqtW/W3hjECiFIbgZlrdL?=
 =?us-ascii?Q?wZ75GN0wKag3+CkWilPrnR/xwkW8ANJjL7+CirWZLqqdZwmKsMebU25Wgn0E?=
 =?us-ascii?Q?xClRp6fo4OnC05/Nouk0YLDgfcwNNIfr66wS1clS8kGwNxJQA+T8QTUJUZRq?=
 =?us-ascii?Q?/pnzd+DSp+H8PkilHhq3CJ0qnAAjULVKrmvRxEiz7eSqi0Ogk0OkARAPLO8w?=
 =?us-ascii?Q?BpbZ53kdQTvKSmWgsC8URuTE45/OsSFEoaQWsqPIB1HUcl2J5xe8AwCB79Vx?=
 =?us-ascii?Q?tLIuivd8oIlHKw0CxiFlRNAJ/uhwa1hiwggHeS7j+Kxg8RyRVCWKxiXin9Bz?=
 =?us-ascii?Q?aPT2Dlunz8qYdooWmrXZYqE1VeUAKYOLJgOWzU7PxWm2j+g3Gmx+2jZFIRj2?=
 =?us-ascii?Q?lcug23VNcmmI2juDW1eN5Q5TCu+MKjePeyeQdo1fVNDN02ACmzAR3X9tinX2?=
 =?us-ascii?Q?DZhCQtR/gur6xxfGFlfQKEaeNJqO4GtBcgl/zCP994KGzNrWFlaEuw+C0XhO?=
 =?us-ascii?Q?jyxHQetp1HHTudQNtU2IsP6doIAEj1JnVC10meryXPZETWHVwIhFM3f/3HLc?=
 =?us-ascii?Q?y3kxBOUslUDBNl4q1DBY8syv0MwrkkDObpM864XBP6QWG1dXu8benwGs6EaH?=
 =?us-ascii?Q?T3PCfMAVj9LXzbLhqXGQ3Dw55Ms6nujvgTZfEouYCGhyhoxjTk6HqISFuulV?=
 =?us-ascii?Q?V1XAk5PEoIeOgHfy8p2XGC1hHLoODzmES8owLhDlN0QP60dw1wJrTugcmcPv?=
 =?us-ascii?Q?22CnxGyhGXRyghg8dBBkGt9dD99DQoCWhco1bQyHiKj3Hv2fGuPb6T/h3drr?=
 =?us-ascii?Q?zxhzEmuloXTyCEoTwRds7hqRVFZItVD0xZH7f9aXq281+fPXOAVxnz3XMOon?=
 =?us-ascii?Q?5exof13NFIWjYp1bd10IRcDY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c61bb5-7168-4d1a-e659-08d940f12b74
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:41.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZypqgWbnQGwpjqEpgq7pQDviAzut7632Toztt7GCL1i1A2darxhX+IXzdCMDUsG3DWShqKzAdTDG3JP4Z9I8KbAGn8HHjQhHw9MeFjoAnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: rZiOoQNgqSdkCoAeZORh2voxyjOT2QFQ
X-Proofpoint-ORIG-GUID: rZiOoQNgqSdkCoAeZORh2voxyjOT2QFQ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MOK keys to
restrict_link_by_secondary_trusted_or_ca.  This will only allow keys
into the mok keyring that are either a CA or trusted by a key contained
within the secondary trusted keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 56800a5f1e10..07547f1a4806 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -140,6 +140,11 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MOK)
+		restriction->check = restrict_link_by_secondary_trusted_or_ca;
+	else
+		restriction->check = restrict_link_to_ima;
+
 	perm |= KEY_USR_WRITE;
 
 out:
-- 
2.18.4

