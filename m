Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31BF3E9C45
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHLCUh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41552 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233613AbhHLCU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2BxEp016204;
        Thu, 12 Aug 2021 02:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=Wlz9fR2ARvPuaF+T0b3ZAQwmtAebnGk6j9SAqO4OwCs=;
 b=k8ianQuNgdW6A96zi6xSALpoZTShsBVvNglr3UVK9k/jCWg9t/J2XE1SEEH3o54QZ6lR
 owG1clRgdkoIADd1J6hpYXFXcf60HiDHbr3AKoWuOg8ofYyVhj3SYJMvX35wmQMNN5bU
 Bp/M26wK2h7BbDyAKD+TgbInn3L0Ao/zGXfcpIvScBjkkiSAOWe0+GoQSvee3xemhFp8
 6I7WeM7+wlAxfZ6WkA3ZVd4Vj8RNA5mS39PbQvrkRp0FA6Z5nO2r/ziZc7579/eXORN/
 Nxtj0wbTFLOpHZTqdQ+4ScwsMHd9xSVw1EFRDkJtka16UYPo14WmF9z8XhdMeNvQJf8p 6g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=Wlz9fR2ARvPuaF+T0b3ZAQwmtAebnGk6j9SAqO4OwCs=;
 b=s3PnUKNYCxCL88XPptrPJRg9nyWLOaKG0zOx45NnkmI93B9/pnHUKjX1YeyiPvL6jipJ
 3IyW/IcKkA+uFMeKIqMQf423/gZ6ozLf0lM7G0e3o2/GMILseCuEBXlNYFPOfqb0aCT0
 MQx866+7xfic60c7yVHxL/4Wv+pF+pt0E0UmV0xJS+eNMudZuqOrHHw4CWSfZrfHi3fg
 OK+nMOrH8OR6eJbeXl/yp5UjOyMQk33XvkHMJ8F7X2+juAuSAQV5t97saokOVwJleqJx
 bVQTBbuwi1Igrc+J1QzuaXA6M0/iQrijDBw1h92AkoTxKuty+6euAO3zztJ3FiLKHOFU ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqguqpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GG34143063;
        Thu, 12 Aug 2021 02:19:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3abjw7j7jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ9ACk63rZLQPGgfy282N2Cpd6sMyYkKAoIFLyiK86SX6xAqaYlltVGvPLB18cvo+uxNIR5EVVXsrLl6t+VR8FQn4d6GPuNhpl+o4a2lM5r5rBEdgxzB6UMxs9FGocX/FpZhjvszriEsKTGi+Ek27r/RQiQrjeqY2T+LOtR31FOiCCy8tpONE9F/UNUj+e1ZxfI5AQwEXeKJUJi03PZrQ5QNjaweMEncozBGpETsVLzMHv2OKBqieGK2BTd/6dPgC++EjK0Ok4Y0LxISq0L1C0fy2Vs6FH9ZmnHqEzdX4ikHn+Ln23wm+09z8sRUAHb1d0WsKBZ8YW2KiMjmHsnhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlz9fR2ARvPuaF+T0b3ZAQwmtAebnGk6j9SAqO4OwCs=;
 b=Helaw6OlX3FhoWp03srvGHmum/QO/Ro+MQ0hoSbWdyqhraArzB8+CvpEz0y+wsfs+oHIJgF6Hm59QktjGb7eV8z6VZzogN/OcRY3IXkulRGQBhiZdJhvDC/73oT8jUyW+fXnbf980OomQZWdPSA0+GA/X2zL5EzWdrjElN2y296UFMeqCFcw3/HWMQ78JBXaE3+JVZmP7xgVEamd13z50ZCvYqJCUyhmsfu+CqMSgViSKLuK+hLVbtvR01sMvInDWs1Coz8d1G8ziSTA55fnGsvVajZ2MLs8gZBFWMXlq7dQwk/Ep0oro3zEc293kEXUhzZuwynR4YKRnLhOXGxHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlz9fR2ARvPuaF+T0b3ZAQwmtAebnGk6j9SAqO4OwCs=;
 b=KP57ezL5bHqUvlw43bd9xHe7UW5S7KTIoVOzK/USr5b5WP4yKGR6kv9HjIx+aoi56N/FHc98JclZPlj49/4/tKrO8rWDSkNS1+MkJhHrZCdsc0hSfY/4BsMCmNb0R5f1LAKJxNq16+L3twv+pVhPSQXOEalK0o/sH5oMHauCUq8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:15 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:15 +0000
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
Subject: [PATCH v3 00/14] Enroll kernel keys thru MOK
Date:   Wed, 11 Aug 2021 22:18:41 -0400
Message-Id: <20210812021855.3083178-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a76053f-a1ca-4698-4f4d-08d95d379522
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB41682AC9D190F4E9BA8FCBB987F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfwOVOfbedqEMvUvlcl63BMnkBLVot2FzDAY7PAzTAAteqtvHjmW6OPVUTRORVAopmhjN3zgxGG5gX9jZtxBloEVDu7kK2Z6V0i/pWhkRs6t/zmYZG8Ox8BaFQ+QcepRipTzqJDEsbf041TmlQtat3zjZnGa3RpAXAmLhF1TMQglza8a4ALlrA1NcnE4129SmiEu9jV1qdxyyB7B3XTBmdU2EFMtm/MIDVWDiNtMla0wbBNBhMhDLKX64r/2RcA092W8oo6aLKN1nNLbnt0Ji3iVxiTBe/3xRpNbEnYKnrdoribZKWE2dyDh4xIPY29tsKJ9IGbcQsmmmphnOPbodZYpTXZdonIT/zbRIRrwPykxoAsDl4B/smKY7gwgL8XBBYXEGgEpYRXPsGSn/a7lwOX4jTfeX8Lm7pylnKgxRP7UqGyd/PYkWWQ970b7yNVLQ7uWjEc5Oj6x5smEAE15Lld5TdRrbvKS4PdMUJq4PduQiFwaUyY3QM1CUcw1lBBoUk6mCODYFW+NTpX/A8yK2OyAaYL8qo4ExrPqKsuOeM2Juqk4r42RnrHOdnFEBbPqe0hHS25VrZTbCjjJIShv8rMLcq+1Mie0GF/aBsAKctpN15uQaqksVpFAGhUuO5lx0UI0may0aFA2F0/Aawwb6DWoFwzFf0wOthDbAPcmuIjiPDFDj3L+cEACQ/zvXcHLakkr/WVJwcuJ2NJUzqCcA/RLzQ3GW8lYPC1ff3nUsT2os4YSmBaPu8aXl6YIGAp9fs7CGF/xnMY1VpyBSd42sydb50M4qsOR5JjSSDoVv9LAy8u64Ev94S8FkSbLBYGTv722G8SbAWNw84PXjOU0aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(966005)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNXTqfSw6AK3BTVQ6CDVd5iO1H4xnLusveYr5GbDtvqkpKFIVKTRTWKwQ5TB?=
 =?us-ascii?Q?ErcappXjXcoBLzSBfOOtn9XTciInxlWq/lAMx5kOkdj7mOHyC8nRmuykp1TZ?=
 =?us-ascii?Q?4u72RTF3dyPvUYr9D6zIg09i4lCXFYjz9FfJVWr4a+D9vanYV07Vkvr6tHPG?=
 =?us-ascii?Q?Cnl533DkizvEGajmJaRa1j2HB2UnR8qH4QawRQqPGziErkC7dchGa7A+gUap?=
 =?us-ascii?Q?GdE/+pxEYun6J6BIgfqYr47jtHmL/xJxJdUfFgZ7hjWe+Tyc5skpV0YLhRzB?=
 =?us-ascii?Q?y3rFG/oZSKoKTGaZzkO6HNVXrmTKx28qm42JvabgScH8oAZz7v9hEsDUYR2p?=
 =?us-ascii?Q?7Iswi32WvAWTlITk8ro9k0fjst76txH1GQ5Or+8MZ7LGumClwNPcBBrCRocH?=
 =?us-ascii?Q?qC130sZhHYuRLQaz/aLxoJzumSkr5W2YAk2hH6RqfWVZ+y08shVFJ0FhUhUq?=
 =?us-ascii?Q?RN9T6RMytgXiIJc2MXvcZgVF/IanAu+HmwY2VT4ktK8fB7QFhW+DKkSd7Yzw?=
 =?us-ascii?Q?F6AOln9vtzATXcaUIgQwmlEQA51HsZilnpVYH7uCWJWvYEz7GEl3Q9H8//wG?=
 =?us-ascii?Q?lTklydjbRPjEr34zYU8+wEBtjdTUYuYhFLi4ZzM0EPww5T05tsJv/tUHw3Z+?=
 =?us-ascii?Q?NCivwmirT2qaCgLorWInPN+86FWnAHMvR/ksKiWcyL6gNoHSQzMkC250UQVy?=
 =?us-ascii?Q?pfQjKJWA3kp/M/+w39k12YkaEOazmmhba1or3z7UsmQTV0QppwkbLpdXy7R3?=
 =?us-ascii?Q?adW1vXQIlo63jaYbdeoqpujqlIjxVtaJCODTlK/bVwq1ri3E9NiDtWFY9KE+?=
 =?us-ascii?Q?cSX5NoI7CakbY/lVaAZyB/jbmT/ykGKmgMbU+AsicU9UIWAdqeqFffLk17YT?=
 =?us-ascii?Q?3PLYENVn52DnEd0h+8tLO+ri6/OmHSmgjKIpeIYvjNyIaOFviF2qAXg/d+1o?=
 =?us-ascii?Q?T/4++8Nn6A9XpPb+PC4JnBTzXAqlY19xiUePLaJRancb4TIfPn+CHvo2zhVn?=
 =?us-ascii?Q?BBLywDdpsrc75+Q56P1q/rUmGhNVH10XVjtxrFfGRyZyy/qs9ReEuKD+TWuC?=
 =?us-ascii?Q?jZuVs8GViWuA9Wh83cWGlb07rjQX4HpbF6+n3hrDVE+vZaqWUWRlx4VDqnJn?=
 =?us-ascii?Q?5ZXvi/tFXLNm1kZGXaIZ9YQADDbHQfCIKdELlV6dMjKBLQlnL83jr+2jCPR+?=
 =?us-ascii?Q?Gitb6gcJyk2l3awmK4fvj5U4Cwc21OL7RdsnMST6FyIS08FI6TN8FSP1y+fr?=
 =?us-ascii?Q?XUBXjbmqpgUI7z96x2ltPlWtI4NmOWFcCnMA8oG+sMmOOhCsxjU8pLwVqwd2?=
 =?us-ascii?Q?fFwUJ+/BYruuOInJ8PbSWP1K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a76053f-a1ca-4698-4f4d-08d95d379522
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:15.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68gg4aRqYyxTK4IN5PqLjpsI0YIzXhDrlRh7NBmQs/yxRdr827ByJmFA/tfsy6tlv5wo6TPIDldqlM0j2D02VZPO38x4uQl9VfTE1HfcfWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: wxFH3-JG-ug62rs9AfTLKRBod8GlHfU2
X-Proofpoint-GUID: wxFH3-JG-ug62rs9AfTLKRBod8GlHfU2
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-user development kernel build.  When Linux boots,
pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
Linux .platform keyring.  

Currently, pre-boot keys are not trusted within the Linux trust boundary
[1]. These platform keys can only be used for kexec. If an end-user
wants to use their own key within the Linux trust boundary, they must
either compile it into the kernel themselves or use the insert-sys-cert
script. Both options present a problem. Many end-users do not want to
compile their own kernels. With the insert-sys-cert option, there are
missing upstream changes [2].  Also, with the insert-sys-cert option,
the end-user must re-sign their kernel again with their own key, and
then insert that key into the MOK db. Another problem with
insert-sys-cert is that only a single key can be inserted into a
compressed kernel.

Having the ability to insert a key into the Linux trust boundary opens
up various possibilities.  The end-user can use a pre-built kernel and
sign their own kernel modules.  It also opens up the ability for an
end-user to more easily use digital signature based IMA-appraisal.  To
get a key into the ima keyring, it must be signed by a key within the
Linux trust boundary.

Downstream Linux distros try to have a single signed kernel for each
architecture.  Each end-user may use this kernel in entirely different
ways.  Some downstream kernels have chosen to always trust platform keys
within the Linux trust boundary for kernel module signing.  These
kernels have no way of using digital signature base IMA appraisal.

This series introduces a new Linux kernel keyring containing the Machine
Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
This variable allows the end-user to decide if they want to trust keys
enrolled in the MOK within the Linux trust boundary.  By default,
nothing changes; MOK keys are not trusted within the Linux kernel.  They
are only trusted after the end-user makes the decision themselves.  The
end-user would set this through mokutil using a new --trust-mok option
[3]. This would work similar to how the kernel uses MOK variables to
enable/disable signature validation as well as use/ignore the db.

When shim boots, it mirrors the new MokTML Boot Services variable to a
new MokListTrustedRT Runtime Services variable and extends PCR14.
MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
preventing an end-user from setting it after booting and doing a kexec.

When the kernel boots, if MokListTrustedRT is set and
EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
mok keyring instead of the platform keyring. Mimi has suggested that
only CA keys be loaded into this keyring. All other certs will load 
into the platform keyring instead.

The .mok keyring contains a new keyring permission that only allows CA
keys to be loaded. If the permission fails, the key is later loaded into
the platform keyring.  After all keys are added into the .mok keyring,
they are linked to the secondary trusted keyring.  After the link is 
created, keys contained in the .mok keyring will automatically be 
searched when searching the secondary trusted keys.

Secure Boot keys will never be trusted.  They will always be loaded into
the platform keyring.  If an end-user wanted to trust one, they would
need to enroll it into the MOK.

I have included links to both the mokutil [3] and shim [4] changes I
have made to support this new functionality.

V2 changes:
- The .mok keyring persists past boot
- Removed the unrestricted move into the secondary keyring
- Removed the keyring move bypass patch
- Added restrictions to allow the .mok to be linked to either the
  builtin or secondary keyrings
- Secondary keyring dependency has been removed

V3 changes:
- Only CA keys contained in the MOKList are loaded, nothing else
- Support for kernels built without the secondary trusted keyring
  has been dropped.

[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[2] https://lore.kernel.org/patchwork/cover/902768/
[3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[4] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (14):
  integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
  KEYS: CA link restriction
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: add add_to_mok_keyring
  integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_ca
  integrity: accessor function to get trust_moklist
  integrity: add new keyring handler for mok keys
  KEYS: add a reference to mok keyring
  KEYS: Introduce link restriction to include builtin, secondary and mok
    keys
  KEYS: change link restriction for secondary to also trust mok
  KEYS: link secondary_trusted_keys to mok trusted keys
  integrity: Do not allow mok keyring updates following init
  integrity: store reference to mok keyring
  integrity: change ima link restriction to include mok keys

 certs/system_keyring.c                        | 33 ++++++-
 crypto/asymmetric_keys/restrict.c             | 40 +++++++++
 include/crypto/public_key.h                   |  5 ++
 include/keys/system_keyring.h                 | 10 +++
 security/integrity/Makefile                   |  3 +-
 security/integrity/digsig.c                   | 15 +++-
 security/integrity/integrity.h                | 12 ++-
 .../platform_certs/keyring_handler.c          | 17 +++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../integrity/platform_certs/mok_keyring.c    | 85 +++++++++++++++++++
 11 files changed, 220 insertions(+), 9 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c


base-commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
-- 
2.18.4

