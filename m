Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE540B9F4
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhINVQp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55190 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233561AbhINVQe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxaSa026025;
        Tue, 14 Sep 2021 21:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VQn5A0JD8Yg+MpFvgAYxzFUIymhm/fofi/Z4INBhbdI=;
 b=RuhrTFG7aDF7i4p+ng/x2aTNXEgC+dBR217tKxg5Sujm0P217ikjtMpr/sPZz0F++q5N
 9B8+jdZvBJleJHbLraqrVJ7+yng8W721++B1YXbWXtHvpmd42KJOLo3jyUrzzrl6qnDK
 d2n+K4Cch2AaOFGZakrbHLsE20JDrqtB+6sEcFhpjynDlpF+gYV3Q1ASTCtwk7NVct9p
 dal2QW1T3vuAcdhyJaXyYyf1Mp5h893vlPJuE2WgDin0fWW6fMVzCzwwka/6FBQt3G3C
 mpx9CEe5uim0yUfkPj5/uSDk5aHhWo796L66Vtwj/2NyYGmz1izguE9+0cmYK5/u3gMi VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VQn5A0JD8Yg+MpFvgAYxzFUIymhm/fofi/Z4INBhbdI=;
 b=Xgi37kerrXTpKImUgNv1cM0IRGkUUbBLbYaWSWEwRZNJVKB9lDbUEF1X+gxwl1TodGzr
 FLOTVndDAylTLnTHtQbSIqcEHcv2Lq/jXA5zYo8YQuApt7ePUGk1jdQu7lhRzOliDqto
 VEZChjqnti53q+E0Y/dG24T++IokHnkrbSTgJB5w2O0sZwnJq7cCS4z+mNGbzNA+gVb/
 77mW/rd8MPqvoOmNtwaLSV0DyMi4+jTEJKiN2jzZNHp6Z8ePLNp/udhj81UdXjwl1o3L
 /V7i6RQjj8DGH+fpipnHxL5kMun0kExWM0BZ7tPXfXVxdQ6zLYENbj3OyFNA1jvvISzQ BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4sbcya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELAPVn097320;
        Tue, 14 Sep 2021 21:14:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3b0m96w3jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/qvda3BZPW5xNA0WbZV3pGFUk4atWhx9tU64WlnITNSzA9Tgrsq06yY1JZVULG7+bhB0jeKhKBdYwHc3aphNkJ/ySD6TnQPKpQkabywhkGWRBN8nmLg62kPnYA6xQGFjYnzT9N2buYHqL5z4Dm2ess2VcM3qTSq1oFiSoS5sjNzNZ7U4uF1rQiAFNlpfGT1P3UcqmgXDE+SOpKrLSZni7JIOrFJ5VSf9NOssIGytPrheWkzykIPpt3E4c8/ecMNZRxLfUQv/N199Ny726IXJk9WgWLKog04DBBAqBmo5PXq4RIVt+AeE+YWXA2vEvbwbYXOmqRz3jlDbEPyQOj+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VQn5A0JD8Yg+MpFvgAYxzFUIymhm/fofi/Z4INBhbdI=;
 b=dXk8HS6JGQBpsVIWuAE128IyKdhPIwdlWLWt7D+tqVXWwSqTiHEvXb7eVcI0zHzySRgVZnbJ7a/YfSUUX9KIojbfcxKvUHPPIZeLbQaZbjucXUABs4NOhI4pVb9YRh9IND0twCkjzltNLKjWmO9HD4/J8A0lSQuKTzlhXcSo/zwXElYW2VvdPrdQ+lhlqI7r+Xrn1IG1y46MzFO22Kf3/PI08EbFzPgWIlMgEjsanQ+x1HrrJzTFq8Z92l8nOVxF/vN4wlSu7cR/Z/tKHf83w1u4zQgm4LuW5VHH9JcCo5wwXfc1IT6mQ4XYsRBN40/UgOnlox3YSEv1JDMQkskmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQn5A0JD8Yg+MpFvgAYxzFUIymhm/fofi/Z4INBhbdI=;
 b=AWtIGQq9iitJlAO4QTn9audYeknoiVgKGBSUxOdwZfhkO4ScFpIdW48z42HdMccI/HITtW/5RccP0UmDRaikcittWX8kUYwIy6OGzwFiSmjoKKrB8L9C/EZjh6VzCYmbxTfIqpFgEYMeglWMnXkFNurrwuEf9ynV2tElpZ0mCBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:51 +0000
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
Subject: [PATCH v6 06/13] KEYS: Rename get_builtin_and_secondary_restriction
Date:   Tue, 14 Sep 2021 17:14:09 -0400
Message-Id: <20210914211416.34096-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6290c9b3-17b6-465e-864f-08d977c4b0f0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB49080B6E367F1EE01C5C5F8087DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96WDQjU0kgjYfIuWBsSkdIJawb/BQdqQ1ko4Ztrdl16UGH/HNoo5412BGyFOMuuG/x6+BJ3b10LwlZrYRYFrHljMAsv17w8ZsELbmCKFpyknzY6DvzPKBX1fC3AulK6aQVCm4tigsbJ++2oht93i3GFC0KyubxZO8NPu4fOtq8UsE1XPDv544z0qvkBi+d+iO/i4LJ+QD1OWG305OsQki2RdiMPrjkALAbWKfykKifea386MMZZ4uH5TTXuiRaiRbSXqjEGyRz/ryO6iHox1wL/Cx7ko/F/Wi92rYY8B8v3frGaTJhsgJXuzhc6nbsz9lIaiNYWje9qvvv+98C25NfZpJhp6hXxoFhnNStxgzispngGoACM6KcDQa1ZeQ+V4HG0y5GCQyahmtln6z+Rudp2Ts/8l6ku1zg/F2/03IVgWg+cuuB8bq5rfW+R5dmIQu4vMcX/a+pCunaZZN5tChhK4gDEiAPfK1QX6aSO7z9SHvhTy2GqcyVAIsVlF81IHHQVahMRqpNRGoNvT92gMlRkR1nk5egsLZOlkso+YwWFUDPys3dXj84O4o52g0OmQKdm1gQ7OsXbMV6sVoiiLHdVAjIUgESMawcQkRGMDsTny7DJBrZbMi6yg2WRRbA5pVYX2uDGuw7lA8C+SXhTqWBj8sRPj4RF+HPun2QIR7lrD3uOmIhmqR2vwC9WsVKPksJCcz1xigGhoWIuqldGc/mrAdXMzzP75FjXciiDqU8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdRMx5voW31ofaSw39at91RP/VVM2XphhVsoH+eoEemXytzD2GudAcohC+tA?=
 =?us-ascii?Q?IXk0LUeK4szP5x++OTEkn+eV3S/EwvzxzMMkPCIlP8obuiGYXK/aKIBUDrnd?=
 =?us-ascii?Q?OJT/iDDoDUSpYLW5A/TiIB/f2QawVvuLhkDJ0PecwMGIAS7cPP3+DwCfEzkS?=
 =?us-ascii?Q?6Q3FqPfn0jkNKtyogjsxQU+WXQ9dLJgUkAOialbhbMJa52eCjRkvvjza6yCd?=
 =?us-ascii?Q?IFzu9dl5QqlDba1UndhYSTs5LtO7X64rg2KwX+s37qWGtklJ7/Fu5gn6P4y3?=
 =?us-ascii?Q?yLHkF3Dc5vGP7VeokdqqIwXA5EuI5TYuFPF5GV+TGdARbU2lmkgxjSW8FnDz?=
 =?us-ascii?Q?cStDt77h7SMsuKweoiwIbifA+1jFfGeOJ5LeHMj4aWwVmDgUryX8Wi4BZgBH?=
 =?us-ascii?Q?WaGRKWBMbHcBs6RWbpGK0W4+G6tUGpAPS2afuA1V6Ik9tFZ2v9hmU/wqAxs1?=
 =?us-ascii?Q?dIS+1DNNZMpQC2Ho+Y4zbOXPtKyYASuVnJBjGnBRUJdKYrniP1OMhhJQ7DXf?=
 =?us-ascii?Q?ptGwcyrTuQXcbcuoDLoi8rlK+/OHfeyfh7cK/UQ2TkcwJdOk1DSJyt4YW5Gf?=
 =?us-ascii?Q?7A9lUqFA90mfBHAIoFPhuSEscTGFmHOqOM7ibcIsXvai7IhcbO+mnpdoBeLc?=
 =?us-ascii?Q?VZyDFDdNWjpUjttiTFjCG5v+yz1Ct+zhLps+SqL13/LJlhsrwrghQJ+iN2Nm?=
 =?us-ascii?Q?57cAOHZrJsdiNQ1yql2W1ywpVsX/SLz/sVq1b3bpAMZaSV3/01137pvbed4m?=
 =?us-ascii?Q?yPnwMB6wipMF6yl++620hiqaapwxQSXv8+u8q102FOVWkA5MylxhoSXxW8Ez?=
 =?us-ascii?Q?ntRvXgsJNsX6B7PiqC2TgtN4wExpkJREBpITYeYRTmqs0KBpiSYuV37cRlVz?=
 =?us-ascii?Q?0esWBAE8+iD4K7mBpg2pj7xt5PQXqG2psmzyKXEBRfFnW9qBzCqfiO/5x70N?=
 =?us-ascii?Q?B6FExF+7J0Oxwt2aAIjOhsmUSCfU4gPSNtsRgC+sTZGz5+p4Tc1MWgvCELlh?=
 =?us-ascii?Q?t8wclb1L6oHnwJievYwxOoXW37GXMbg8g19/6lIaO6OeIyeGRl7DEZPsV0jW?=
 =?us-ascii?Q?bILmFlsaM/5ahus2xd173MTGtaOVbP3uvduE3vJiLs30S6dDmu1Ea2Bm2oEj?=
 =?us-ascii?Q?umsmC3fORxs47gZS/9+KU+ftd2PrtKHrrh7+1TIIboFct36qaE5KLMujuQph?=
 =?us-ascii?Q?xsKO2sK+n0pLjetg6eZOGBYhtkVWUsUAtN0sJqGDV7KIjbQumHfKHcrbvPip?=
 =?us-ascii?Q?zAB1X3MHEvY2Ura1h0ehGEBZpmU1FxhA+ksBrj3o18axoQyfqDxuZXgsFNaR?=
 =?us-ascii?Q?Y9zl3y8bYKF0ayYdeoJXtkfK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6290c9b3-17b6-465e-864f-08d977c4b0f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:51.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3Sr0Z8BwcvWeRqP1CgsMTOBRpMjZ5lEl96hgPXPJPF8n9bo5x3vbNEiZUdA5b++ipi/l3vHksN9s9X9CzpihCT0MhzTaSP4rxXDtRPBGa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-ORIG-GUID: Kxs1MgWx37bsRe7LJg_CNillVMe02vjY
X-Proofpoint-GUID: Kxs1MgWx37bsRe7LJg_CNillVMe02vjY
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To improve clarity, rename get_builtin_and_secondary_restriction to
get_secondary_restriction.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v6: Initial version
---
 certs/system_keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..8f1f87579819 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
-static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
+static __init struct key_restriction *get_secondary_restriction(void)
 {
 	struct key_restriction *restriction;
 
@@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
 			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
 			       KEY_USR_WRITE),
 			      KEY_ALLOC_NOT_IN_QUOTA,
-			      get_builtin_and_secondary_restriction(),
+			      get_secondary_restriction(),
 			      NULL);
 	if (IS_ERR(secondary_trusted_keys))
 		panic("Can't allocate secondary trusted keyring\n");
-- 
2.18.4

