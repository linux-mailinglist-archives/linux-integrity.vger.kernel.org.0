Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144743F9982
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbhH0NWK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 09:22:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24662 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245184AbhH0NWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RAV6kF000885;
        Fri, 27 Aug 2021 13:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WGzvUC0KzJ1GLB+v2vHK1r6RHSdq3HuOreWgM27EDwY=;
 b=x4iHnrXMPAXSav3viYlr6YSsPnyJngwwcYnCsnl7yAV3iiGzJ6ochniJaewiSeOAQc2+
 VEhhO99lew5uYU1y8KeC037odhd4QByxVsdllzNh8Lv1cT24pHQwCC2NC5R1lZvjDkm/
 FKI42+ABisrVgWGvL4S4T0mxcl0XeqKGdMMqlLzdX9LR9YUir/ooeXig4l+cL/4AZeZK
 YA1/SsfOLgv6GMBm0bQOKPdzbndYO86iBSUL+fBobKURAyi8DAq2vTd2YPFVddFCFi64
 OK5GLTElu5P9tWiXSw8gEf+6C1yR00H9rUsXf9nIRtrE5GmxMvYGahZ5Qh3ethGg/Ln+ HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=WGzvUC0KzJ1GLB+v2vHK1r6RHSdq3HuOreWgM27EDwY=;
 b=iCL0YE3BjYJk5WYevNNRYpIjmoo4FKIUwFLwoZTwGzqgEQ5+odpIf8bvVQvsYgTZpvEM
 cHPaMmw/8MdDNUnTWZPrcbKXRqlNFO1R2klZsPrAcb305zXNXYjE1BOrHeZCpZaSmB9T
 QcdehMyT+aw+JUVHoy/FlciJiRpTGpqP9QRmVVoUaQCPULXQlJkNK05xEfExxG9UDeJb
 /oaL68oaQnsPM5JKBQUywdeODb92GLva6QK+SiYBUAs0MRq6UAgz3i0uBlMw/7SgrD5+
 eJCYWl4J7S3KN5gzqTzC0SO8OheM5XVRHnRMJVVcMaGkDobZMpgEsdQgYwKXXuB7LTJi eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap552bhjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RDBYUT007537;
        Fri, 27 Aug 2021 13:20:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3ajqhmjm17-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYDPIALFqXTWPhF7Y887ewFpm27rwqzd9jBq1Jk47lvWkV3VLSNfYpli5U0dnc3C4cv+aOfA9Mi0fDxDCKSuSJsvE9l2KVV0QqO96Nsu7LzJOQor6/KgVpjsrQ6y3GL3i7HZpdtu05EGHjyisYDzUJQSwZvb+gil438klaChzHcKw8NoXsIqi27LAL7g84KwaWtFWUsDCSgjGqYCYPBkMbLQk3J4WYAon0juf21ds817jcpH/4yc2S742puftKTwiv8Zq7LW8pUFHA02FNfEM8hf4Uio1YE/KpqeeGOIZ+I2Gb/V4B2VKAORSuhRp+alvLlQ8pgvwrNJIdol84VThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGzvUC0KzJ1GLB+v2vHK1r6RHSdq3HuOreWgM27EDwY=;
 b=gB+tqa+IlmgJXN0yR2DNUZoNdd2I0CRJiUvR7rZ+cc7x8s9PQgDSVaPGBEGuz+2XnEy0xnryY0Z5kEuhuUt9WRt8xBHf3MyZkM/Dyw7oPWETGwU3Q76yeAKZ6Bqzgmqk7HP4gY22DyVuUpHisV2xtELq8Zf5U37wtUE68+r65fM+9/bYU8Oebp9IHfouzzqBNfmmJPizKMpSF9Ld6fMrs3wV/A7cT8bh+ek6wg1ASMzNEyawHkDPXw7IY0BEvugQDITg5ovGWp/KuaguojLKfgtCiM5AjNlQN0RANZTtIl7Pwfl8FO7qUuIlL5kqyd+JDPNMg9ZOQ1tKGBCSf08iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGzvUC0KzJ1GLB+v2vHK1r6RHSdq3HuOreWgM27EDwY=;
 b=F4rfcA2uAJyBncY2OVbgAB/sg2QMvHLVMTOa/VJs4zRYnHrFPnJcsxZnUcBTxxclw65xKz0Ijpeq/ZjJkaykoWEg1gVI0QVqE6O48o1hc4u0uPxDqTA5AF2nfKLr68qQiSH6BzyRnHadP2RHrSnKEk3i8OKXpZxpSVIy5DYD9RM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3621.namprd10.prod.outlook.com (2603:10b6:a03:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 13:20:40 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 13:20:40 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v4 02/14] x86/boot: Add setup_indirect support in early_memremap_is_setup_data
Date:   Fri, 27 Aug 2021 09:28:25 -0400
Message-Id: <1630070917-9896-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.45) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Fri, 27 Aug 2021 13:20:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 236405ed-0399-4d5b-ceac-08d9695d7707
X-MS-TrafficTypeDiagnostic: BYAPR10MB3621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3621DFAADFA8610D85134537E6C89@BYAPR10MB3621.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHHBDowIX4IVeQUR2GDfh26exyxSyBd5pZcanMUc0EHxxEHKS28RvwN9yEIImC+3JwNnfku626DHhxxbmbnHjmsIpZkQB8ObIZiIvRCUGlVXKfKb7lj/jw8Z1bjWvrZhDn1Y9wy4yS5eS3tc7qXLCYEISufyxz1oJ2/oBCPO26QuvDGbthZJ2FM8/HuotCLW8FPi7qoDgIdKlJizfUKrt5tPtGSyEmbogfv96EzNnAVN3ZVSvS1296+IEvVt4VM9h9KMjLhnvucWbZgdNEJ0bXQznJ7L8bvBwXEoGYFNtC35QDvgz+H9R/mAA2caCtfDb/VspJDozyZzf4dh5UsbneFT+KZw5P91sNBnmBZ7htfv8n82TTekTucVFSt9BFJ7JOX6KesK/AXZ3Ry9+De+nWGDeS1mR+qjdcphQfko+c/6+sy+RxLWv6LNHT+BOYKxejuhDs6LoUcgssq4P3owv4WP++hOjI3Cn0i7z6hNakOsUnWs/xrnXqX8eGOmk9qjr7GYVuffCLTPPlUC8/DEvkBIZIsuxWO2+YYPMzTUhG4iS1mel2s0s7WZ1JjEBhiGrSdIyWcn4d0aqqjtgFwJzcOP7SVkBl4M/GwBLGvgm2I1OnuTn568iip/Fg9Fkn+jow34dLkC/3FNNTSIpiNkDrmkfU3iEmkznU24FQYOqif5uMwYPsNkRjjXEKI++UQrnsAERMIYN1nTDyosR6ZXgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(44832011)(316002)(86362001)(186003)(36756003)(83380400001)(7416002)(5660300002)(478600001)(6486002)(38100700002)(52116002)(7696005)(4326008)(38350700002)(8936002)(8676002)(6666004)(66556008)(2906002)(2616005)(956004)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMsTsc0H9kTFbWIBVQDyeRklh2tFm0qXwJIZ6Dfi8BeK24TQVz8Rw/aN2OQ2?=
 =?us-ascii?Q?Xl/azu7+qEhFrWxhoAKgR4oTyyz6HxkRHuilbcSHufX5jn1r695rVOOt/9Yh?=
 =?us-ascii?Q?gnSJCyx14Kq3mshsbHh3AlROOCz9FNd2bGmkPgeUBfeIrNXS7WDWvdLsphUI?=
 =?us-ascii?Q?vWevVEHlbwjBbxAx3d2uzKfn6U60KvCGxjgZdiP1Fc+1JoUC3X7DgCdMJJsh?=
 =?us-ascii?Q?heYyxLsn86H9wFFKdVMRFWvdxmpSKrjWcnn0rz4Z5bAVbNszRuO8ibHkpwcq?=
 =?us-ascii?Q?vyIERae/5+337bRLCi5L5cQ8UP57/YTgQcaEzhyA60J1SeA+XtCB6hkC+1po?=
 =?us-ascii?Q?ZT8WzZ//uNnC+RvMqHDb2ZFiBdNNNFLBT5x+DqIMoFQ0/XKm3ZPXhVuB30Lx?=
 =?us-ascii?Q?S2xVTT633tTo1I9ZFQaHsjN1FWsk8LOaSWyQxNVsR/zj4hdMOnSPmFjmn6F4?=
 =?us-ascii?Q?eLu5RR8T61n6L8oF2C3MbDWIRwOg4Cav949dR+e29rCP7ltjvchyZShFtPmY?=
 =?us-ascii?Q?0R6zMDI1bsBFVAKgJJOLFpZE06bqwFoVQ8drCJw39AEIVx+tgzDYPCksDtGi?=
 =?us-ascii?Q?Iq0xEMc9oATyKei380/gyTEpenM2wfvHXhHEHXpGsrBLmM192LOOXYodcpiq?=
 =?us-ascii?Q?h/gtUKKoADgCV+YOudq/WAMnxiajp4kWafrks8crHfL9uQvyoreL7gcKDhH8?=
 =?us-ascii?Q?R1RZgHzAn1ZNYqd1DpKZ2PXKkSD59o9OjK9RPqkGSeXmDS6V0WCisvqZ8Qr+?=
 =?us-ascii?Q?/QWODaoZhJyx8cC/yYAL+8OuEUMrIapGOjP0KAsv+U2DxN6AizExgqTbMJ56?=
 =?us-ascii?Q?PEyeTV2xajo8MkKp2IdYqOR7kxQYgQQnnNSVlTGmGD7KW66vF5IOIzz6JGcg?=
 =?us-ascii?Q?FpHEplvbypJqrLdCZbL0dMnOs7S+jh64NYD2GKiCMgW6jc4k+jWmbFfH5vWK?=
 =?us-ascii?Q?gCTDrAzFYblxxhPgBZMPF40lFVUCW/b+HGF2zoL9QW95FJ0fbwETNWIgehbg?=
 =?us-ascii?Q?YYa0bEjNwUk9Cp00g1h0GwqJmiXdHaxiX3q5ch9lm8ixgI4OPqU+o9d/l+Qu?=
 =?us-ascii?Q?3KQvbogDAsoZrbLs92kh2v2t5DXQFYyU+YkkTArV5W7QvhrFZkmypqXKz7+5?=
 =?us-ascii?Q?nkIyUmhi1vXIDEWhY5CgUp0wHptzGVGOPZfyAjqfpoqTswldGA4ahtyXLnM6?=
 =?us-ascii?Q?YjH+19Y0yf99w/dbMo4feyHeAQMk7/6wlTVSihg5PEZHGlQKXDmYjAbJqyTt?=
 =?us-ascii?Q?laoDtb1VhCcV6L/PrLGdSNm+Ys2n5rJYNcT5rrISTYD0RCSWK6EN+zQmhUi6?=
 =?us-ascii?Q?uaG88TONg1miNJz59UpmkI4S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236405ed-0399-4d5b-ceac-08d9695d7707
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:20:40.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLKU3TdSMPHoqv4QafiQmdH4VMrMW+bOqPJ7gHMRlFCKO5QtJnXipgnnhPJ62GYexVc1PdvSXE+2XJcPz5S0aeUMfGTozbGtfsFD5HNmhmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3621
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270086
X-Proofpoint-GUID: waUfI55wC4QR_fzVivaiUztW22bxIArN
X-Proofpoint-ORIG-GUID: waUfI55wC4QR_fzVivaiUztW22bxIArN
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The x86 boot documentation describes the setup_indirect structures and
how they are used. Only one of the two functions in ioremap.c that needed
to be modified to be aware of the introduction of setup_indirect
functionality was updated. This adds comparable support to the other
function where it was missing.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

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

