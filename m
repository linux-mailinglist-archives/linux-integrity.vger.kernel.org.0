Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1093E49DB
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhHIQb5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:31:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhHIQbs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GCKSt013022;
        Mon, 9 Aug 2021 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hF/HqXKJMSSwo5Hv10xGrwyxlnU8dLb+X7w26GaLHZ8=;
 b=po88BWBOjskVgkXbWyXJXeNnmwwVva7i6bMDICjptl6yKFWp8cejbReZeJcp4orsDR1x
 ZuDrcfNkui4/agdGYC9/ihNHyXkbBsfKQBhkurgbqH/75iPZsRodTHMYlqS35tN0lr38
 smGL4ZnW3GtxVmFa2gYvaxO5a/yX38zqhaH++dmK7c4jzCTnRMUkuRMAtCYFnUGeZlIw
 f6bgfzaKHlPnr2hsebO32KoQ1WYUtft+sDntcyI874uOMsj6+jZZGRZiWf6CvUA0QG6H
 mDdKPjQDJdrosqI/r40LFGGa6ZVNPV2iG29VWUvcUxzCYWpkqPB9JhnY39YmGUawPbcG ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hF/HqXKJMSSwo5Hv10xGrwyxlnU8dLb+X7w26GaLHZ8=;
 b=mD1PonBjPkBCYxMX1P/JAJeJ1T9ThtDC+PkSfRdNyRf6W2DbHKyNNMFoRQggWb1iU8Rv
 KUx1iysAgnMthyB9Rm0eNFcpuolRCySf3V5HLPtyR+lnNtNw/6FLcr8sGR6tQL65E0mN
 oFlIOmUeLNYV3R7m0qGotBhkwqf1EMuwaN+dEPk3p5yHfknfS+USjuWKQVfEJUKLAFTD
 wW3WEnglObPzs7PGhwHCHcJvdvDYu/M/SsUCejr6oHnQx933fkJTp6Lj19PhbwIYMclK
 L48DqkF1dj6GQ6kt9/TPGLdMpMsAn1biHfNKivvwt1tZzhjFWMWx3mT+quzGJax6qvVT pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17ds2ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUa1E066307;
        Mon, 9 Aug 2021 16:31:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv385x7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow5c8GkrDWaoFzNVprORAOaqTfidf0y011PGtRghuMlwp1+c+abU+NcbHgxgfXS62yEPQSEqzw6DLhlPB3uIu/h47MKsFIU67ApOEMDDUOYV3qMcKrn0abS0a3x/Q53lYljI3zNgHCYH8YLA2CW/3xKQeKpWJIJ/jBAQuwPQ1Ca/glHxGyZsZbJsGUR/jCErfctBuL/fN1JPbzjDH53yyXfOxGNa/HWnJw49vnaEBnVesyivTkf8RlxZg/zLxVnWmg+/yQOG1k0B/srXcJGZtFAVNB0hXXFa16UQhJuLNP/YLCB7oadYNZlWayW3VXU3DN69ev1SVJ0yM0xY5GlqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF/HqXKJMSSwo5Hv10xGrwyxlnU8dLb+X7w26GaLHZ8=;
 b=RjRNUus8X306KO1ouIkHUfdEerK6JzS/0ld4igB21qkZ7AkLPdh877HPF/a8Xgjwk2LyE8nQfH+sjaEzGRDZYW92RsQBXy7Sb3QZy3zcMhgC1MBdGKE8K2mq/camEkEAgS0HtSP2qQVOomi6NibPVrjnLzF6P0xPTR7hhW0Ap6X+vSdjvE4CyraZmowyUdAYcPX8HysjA0Y3gBu+qAXFOEHllr2iO15hyDYOzWk0uvZ3/ryRza+P+oYZ86uCx8PAlEr5AorkyuCQScXUmQWffvoBoAHhOJewkEojxsHZlrFnLOPl6OiaOpTOpto/veTYwZId6T1Lqh1cJRFOrmG2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF/HqXKJMSSwo5Hv10xGrwyxlnU8dLb+X7w26GaLHZ8=;
 b=z+ZQaLvELhwHaoDBsmi2GIPh8crZniFWgDXVlHid/TUD5wD4DRoKdLo7rD5Syl4AMizF+9yC/mQWpIDIayR9DBRPa7JcWnx+iFJIuy5oDDaawnPcbMze7SLL2NuiJQAgN1PMoeBCqjgabUfzZQQVH63MJoT9ZbaR0XqPWjZLRrs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:43 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:43 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 02/14] x86/boot: Add missing handling of setup_indirect structures
Date:   Mon,  9 Aug 2021 12:38:44 -0400
Message-Id: <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e62468b3-9882-4201-3698-08d95b530837
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2631A37E6E55263987BCA5BEE6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmPdWz/gQqZ+dQ5YmdUkP0flFx0JVbBxu43Q9nbg7JYTGdmdo4B1bv7JNFIds+RqvsnAW8hHv0c6pkCdokfvvyakp1qQyAmcFP57T6BntRvVGzP4bppDEgvrTvI9q3HCwePObJW04lcbv8ahe03+DS3KL4iGMTlFU52UmjlTMhXT2UHSyk4wBfVYxsKlZNceV6y3G6rIhVk36k+Vx7rarJvQuh4zwWPlsG1CRPX5c1uZqRCzb5haeaIJ1ysewzPyNtZ/Hzf6SlWhnV1gIpkMDQxaT2aUbLxBkkbU7txWASYXxZBqz+eQF5cEV9Co0EKgVLj65YAgvbfIaL031ezDi6b79cVWBcYZ6MyPs0N+YajE6QtDqgoq543hiLm8melU3smMtuvDm/DL6/FM4FhmBh1NFSjcLPA6HgdEvMso5t+2UBU2qtcj9++jFuigkdkuuXbXsDFHlB28EPlrsIQp9QPIKfJBk0q4ynUFmjKjKT6VK+fbirVFf3cPxOLN1BHgWWIY+dAEyJrxwLHw0wRcKKdKKs8L3Fs+ZDGCQB5eMn2tfLXfNJLPCA5OBLtUQSZp8ZaWdGjN/v1ShZI0TTbbQagcqWkjcu8HTuOODugWZPMbeYxxvXffYQb4D+N4BBS3Blo9xhXSA3pYx8EUWQ8dCEzTXzCN4pnRS0dJuTR6pfkSMZ0Ki3zZHjH/ErtjUuJ7F6SDZTKcdoS2FYLbcryPhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mERdg0uuIXZ8RuwEfrbERO2rFuOiuFglNr+0CLqstAa1TzJXu0vlkAAqIim1?=
 =?us-ascii?Q?7JetsYCcb2tBcfC8T3UMRgEY7kAaLlcisWy+HiIP8iGRUWyrS2kbaMKRoXM1?=
 =?us-ascii?Q?/qSWritbvN27Kojsh6OTl+mUwnTk6AGXXu4CcHzQAX02b5rMCz+NzlS8Z7Og?=
 =?us-ascii?Q?HNacA7dT9l6k+u4zJrclYpKudrMZGY0wr3BrXcgyQ8pwUuvS5sZaQg9xWgNF?=
 =?us-ascii?Q?XPu20ZJJL14q+iYZAT+w8jt/pRpUkSvewgCR35M+TjO7Xfze/u+1ypFuNTf7?=
 =?us-ascii?Q?+lZHkTzd9CIMBV7K2ENNtFJRdg9LdJ7DA2u39TLDPgIVoToyRM+OLS2wGIf/?=
 =?us-ascii?Q?a2rivMemN3Yw9Vzxr+HN5h1W5Rfk1XtmzFBtr2wndAvNBYQ1wUXlUbuOjNPw?=
 =?us-ascii?Q?C8jcY9utlppAthnbFry/kZutTjZ99RvKPU29c/SuSfSKMxYE9RiB4oTwpYKb?=
 =?us-ascii?Q?x7EeCWUGOOAJHJWZDE2OuCsJAnDRGGXYn3ri8ZLbKLdB9qjkHuGb808OLh4x?=
 =?us-ascii?Q?1nWFsctneWWoiPOpkPjbFCkY6H2c4aFXEQKDByBk0JfUQVYlWJrubzf3KOWt?=
 =?us-ascii?Q?st6tyJinlk8CrUlul+CJj7+Om2q5QylBuTQzDdwzzvduHXXKI2BUOobOquhm?=
 =?us-ascii?Q?UGGl8pzU2OitI+di/ukTDJV+ScfToXP1CaWIgWRN+KskqNMeKvO4FUN6j7bE?=
 =?us-ascii?Q?x7/sHg7wCC45VrBgA1jqK864KrLdc1vXIcnK5QDXei3j401K0URyfKQMfzrS?=
 =?us-ascii?Q?lrCdquXz6uz9iAy/3NZF1ZCy4sS+2ZYOu0KEaO4W/BGYtL2Afbzurvt+d6xn?=
 =?us-ascii?Q?xddh87eqKpzh/9eO3+bs178P7ofmoSaFnL9hEWOzdOw0uLR2cP+AjuldAJz0?=
 =?us-ascii?Q?/t4lZjQs9sOsoR2see2pd5sGq0+R2SDPNMOs5yKsacJV3TLEY5qiFJqsbhE5?=
 =?us-ascii?Q?awOT2ok3UEKWyYxtElBbYVMdcY5TCkwvABfoNs4jaRYRCj5fLh7XaE7LjAMc?=
 =?us-ascii?Q?nMVo3XKPSEEoWkMcqIKmYxGJhbToF7WbDDAuCAwmNvxywBBwS0pnAraPWkLV?=
 =?us-ascii?Q?GWz+0SiObDUyzI/3roGBqH/1AEcr79HCTOZDAXpuJXgIeXBkx3ZIUHhgO9l0?=
 =?us-ascii?Q?CfRKud9fRF0Fl5m6gADdEpMsCEqv36yItrArFsxQ9k4r/LDSz+aBQR1ncIuk?=
 =?us-ascii?Q?2WSymrqHIY8BEzEEzugK7KRgxoWU98A5ih5jclmpHrpwoxAIMIgYOdCRuMuI?=
 =?us-ascii?Q?rN6asxzRmjYAWWsLCS/YQOYlz8L1B9EoodSAV2DZ5MqRhcqUtA0HnXvTCOpm?=
 =?us-ascii?Q?os1bOUhqoU499kqd5nErYzR5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62468b3-9882-4201-3698-08d95b530837
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:42.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGL6kV1TYjh7/KDjGW81+y8p3pKOORBOQJm+B9ByosYVks+1j9TW1iefHa9nvrjcYOKFmGlb7Qck3xmFtbHtdwqJx1QTMIBb8nQfQRWIYBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-GUID: -7bCERF5-qqZENQgVQmjwwftFhrig3El
X-Proofpoint-ORIG-GUID: -7bCERF5-qqZENQgVQmjwwftFhrig3El
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

One of the two functions in ioremap.c that handles setup_data was
missing the correct handling of setup_indirect structures.

Functionality missing from original commit:

commit b3c72fc9a78e (x86/boot: Introduce setup_indirect)

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ab74e4f..f2b34c5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -669,17 +669,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
 		data = early_memremap_decrypted(paddr, sizeof(*data));
+		size = sizeof(*data);
 
 		paddr_next = data->next;
 		len = data->len;
 
-		early_memunmap(data, sizeof(*data));
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+			early_memunmap(data, sizeof(*data));
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT) {
+			size += len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap_decrypted(paddr, size);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				paddr = ((struct setup_indirect *)data->data)->addr;
+				len = ((struct setup_indirect *)data->data)->len;
+			}
+		}
+
+		early_memunmap(data, size);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
-- 
1.8.3.1

