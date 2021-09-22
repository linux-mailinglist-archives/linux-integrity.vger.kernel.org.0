Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F70414861
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhIVMGN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 08:06:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65316 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235848AbhIVMGM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 08:06:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBSIZv028916;
        Wed, 22 Sep 2021 12:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4+MCedjo/5memT6V6U7lXUw+WQ47dosuocHGleG7aeY=;
 b=NHA8edqt6YKmrsZ43k/fIfsdj6kQaMt+0OdQGe5p7kbXuMecGe04hIn3RpqgY3uW8iyY
 yXSvJQxlKaSj48NNL7M8nTzNRYbfqHeXoyaJYRdn4EL+qAclf4TI8qNuKkFTt5sOKcH1
 d/r6Qsv2NLG5GmMKdxO0guike8Kb1yimK1sIMjxnM2tF9LW7J+VRjOxnKZrMwn3uSFZQ
 8crgUYUcR7ebvneUDCuiMLeAbk53fL6xFDQrE+uY3Tfk/XKu1BfqUPHxNBetsHWewz9z
 dd9R8hrT6pkl5tLZLnIfec5xbeALGb3vI9VK3RZAn6WHIMH1T2BGDx4y6oEE9OxjJAth LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rbcu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 12:04:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MC12sb133857;
        Wed, 22 Sep 2021 12:03:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3b7q5c2f03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 12:03:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW9AFvf5N0UNWYSevHvfLFvoVkHtdMuRUmeR5dVAq7vcrZMyklkr6/y6lbrihQh8p/nBzSn30ESZ0xS1zLfKncsd1r5eligzJfIzAC3ID/LTKwXbJTfH0CgywPVl9lOD5auJTJrkm8Vr51toLzhbSGJIOMQC3s3tc71DJ2kdAowR288DJOLILsIkWITnnuA+UHkm+8Gq08gpDuKD1WyQwhWD69Gsi+q3ijPQdszrer9EKl6szEJf5P81FCdNOz+VWAWCia5jDYZbu4XJimPMAEhVjY6RUz6qRvYUfYh84rnfve/1sxq+FLF76AYu4BAs2a5U7ORvJeNmzeb7yCzuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4+MCedjo/5memT6V6U7lXUw+WQ47dosuocHGleG7aeY=;
 b=L7UhNHdkI93GJGZln0JUysmKdSF7AQPT7UJN/vi8mLRQ0RVnkmt2aXp0GABRjKF3BtyYBtVCHh2DMnRy3d0uBku3wdU/GxBZUl9068mau329OSh9fceK5SOSqyvtDn0NLYwcdg1PXLAW92f2ilt3g9mSPhKKTU4Prelp/nFxfszhfKu4DxjQ7w6CT8XmiWf5pakEZ7KOymUfqYYestbCcO4T/P6L1aRupngYPzyH0V3dG9Aw6tGHPvtYQMtjR+HH5ZeQ3nNGBDdFTm0XFUKJj2Y4nhXcVhtt15B4SjbzI5yBpAAXLym17B4SAxwkkb0QjcJsP+bcmFlIUbRatq+Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+MCedjo/5memT6V6U7lXUw+WQ47dosuocHGleG7aeY=;
 b=EGRoz3wQKAY7Mm4K4bzs16WmCIMnOViLx/yqO/NW+RmDfgBnpbxSLBGHDOmeb91ar8H0kc6hECyXRTyG5ZoKta3bZm0vNj53ZY4Z7mN6BmjmgJstaAqzgAPZMQ6m71sYmDQ8tNqtI+4A4dWkaR/Gwq8DBM3zUjbPrHB/p9UIwpI=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38) by BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 12:03:46 +0000
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::3cca:22b1:cbcf:eeed]) by BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::3cca:22b1:cbcf:eeed%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 12:03:45 +0000
Date:   Wed, 22 Sep 2021 14:03:36 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v4 02/14] x86/boot: Add setup_indirect support in
 early_memremap_is_setup_data
Message-ID: <20210922120336.x2dkneeh3acaxj6k@tomti.i.net-space.pl>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-3-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630070917-9896-3-git-send-email-ross.philipson@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38)
MIME-Version: 1.0
Received: from tomti.i.net-space.pl (84.10.22.86) by AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 12:03:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5affb83b-9a45-4c46-1ff6-08d97dc10756
X-MS-TrafficTypeDiagnostic: BN0PR10MB5192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB519273395294A6E866271C6AE3A29@BN0PR10MB5192.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zytiKboeU5tVTfUWVp6+Yi+YrVt5HR2pED+hV7C5M/vy4et77QklOaKirMiU6UpsxWQEobBNSwJdOIc+d2RXpXMPZjVxJgRz/3kHcyO6ylH/3L9WvFx524IeWnLI1AU8HqG323KySWHjLMjbtLSCgiDyrlanRm6MkcqQewrgcoW8RAe0pOqPXNyp2Vd+wjZFIP0cQDbRc+K2R2v/SJf00K1EKvzK52gMGy78bT7PX3eocYtNW1ttTyzkxybfjZsYf6hI9UgiAlwNZgYkZ/sg1uajkXiR+eh3k0K2LsceCA3cLmziAfq4fuEFAVjs6welQPUnw1Au6o+2pVdrsQ2BRNNBd5lyseaa/K9+C2QbdvLhiXLFMVBGO9T9P3xRF6fzwxAeqczJifnh6Lk3y1k5K9uSrEWFNFuHtFaERvQGhAuqrAg8j2wQ/eozW8+lKwfIe2wiTBFVkNVk9P88U1HIjio1VZWKiAsmWrNVohps4Bm2fsuwBMIB4aViIkYeLluPGuf22Ep7Hj8L/U/46YDFKSPXmxUebo3T4cWRGrDIRV1FTxc8tyWrYPwMhDk3CSR+lpggI8voeqLcSMP26ZnfF4X+VDmRZly9DbYJUIKqu9XVKvvsgBWoIGkUYwr+bdJ5da+qpxFDAoC370FwJQRwF8S9705v/ciSR1k4es5j+STID41+uNm3kvHYd+zj6d0osbVzr2GQFCl11uudurq+0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6636002)(52116002)(55016002)(7416002)(9686003)(38350700002)(26005)(86362001)(38100700002)(7696005)(6506007)(5660300002)(956004)(316002)(6862004)(66946007)(4744005)(186003)(1076003)(6666004)(66476007)(8676002)(44832011)(4326008)(83380400001)(2906002)(8936002)(66556008)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQkosVDcvDIiu9t7hWiprq1FbZKdvIDfYmNDfokpwBGJDJwxiKwprH3LhnTf?=
 =?us-ascii?Q?NV6FuW+li6Qfmk588gVYC38Wa0/nY9G5Hw9eyMbRai3UBWvG9DnkD53446K0?=
 =?us-ascii?Q?uLFoEQs7oBHxJz9azamT8h5lzsdFzG0RP6IUbRu0Kh4dmcSIFtUcp301taxp?=
 =?us-ascii?Q?q/Vz/nbjm1ykFR0hQqsgv1Nw/UbyQnMNPItlOuZXUcR++Hd0bhm69TERE6mE?=
 =?us-ascii?Q?XNQTtJnzLrg+1AE3dNDh5yvhhL66UBjH+4jgCEj9X5wfnOG0rniHzVUQYe00?=
 =?us-ascii?Q?B7TN9KeA/gJ/wmQHS3eUqcXfz6Tj7+P4SAsFcbzUwwCW6oCyfI0ihie1mfRg?=
 =?us-ascii?Q?quJVQfyCxk8HFK1vz410hem+Z045YQx27u5aNUvmB9jOX3WAtGrQ3R8Pxqdj?=
 =?us-ascii?Q?kF6G2EASyzGdfxspY5U9eoozpsIB5nbebHt6BMsM2I1sMZ0MH7F9OJNF8GVb?=
 =?us-ascii?Q?nvTQHHz5w8VqbFFCxXKpNcZUkndBQ7JD6CT90PMp3bMP8ThCfK/ckAe1ZjRl?=
 =?us-ascii?Q?+e2tsMZ7MEJcNC2JUEMLu3GiJG7cS3QsYoHmKOj5sMb+sxT8PGYcRq1coCrN?=
 =?us-ascii?Q?qVb+QVcEzIwwGFABUfNP5xEbSi8ppkI4n++zHR/it38mRysi+YvOvZCr3dTH?=
 =?us-ascii?Q?hszJ1Yz7GVph7vgpNjKt/3e1CVJLpO/EcNmidRTHlc+9EUBk+fxSqXcmJqtQ?=
 =?us-ascii?Q?jCf4zCc/m5h7WRgOfVWHpSYNj4mzdAJ1th1Ey162isNcA/PKV4L0D6cXeyU2?=
 =?us-ascii?Q?HskiYrxlUINgw8zBs7B+KpkLmN/esMs/KWk6OzXHdSyUScndLurAY5tOGDq+?=
 =?us-ascii?Q?pw6p0CT2wAPNwWkTDwU+2mXH/mK06kruUz3ncJ2BWG3LYpUyMSNp6jc0q+gc?=
 =?us-ascii?Q?St2yW59ktF6fB6XuJYUP2S83bu784b2ouReM2WhzY5UInbLcy9ej5uBocTjg?=
 =?us-ascii?Q?eBXUudQXsRhDaR8vERTKD2pZT3ow5YhDCqEPI2bs0KyKx79vtcrOov5G+6yS?=
 =?us-ascii?Q?f/ktN8tGNLbWE22Ygd+9EwCbenI9WLKhpxFFBDbWZPpw7B+obR7II6xsQQ5/?=
 =?us-ascii?Q?oH7O7Dgw7MPwnVysWxq/c0ADHhdzQI0KHPIrGP3odXrckIHwTN2biOZgQfTA?=
 =?us-ascii?Q?VfW6KW0Sxslvk2+viVrYD+OWri95aWstMzO9rvQL/tgT8YYOeBWviySL2umJ?=
 =?us-ascii?Q?llEialqG751oWaUr0Qid0qlT1OIIV3VM991kncCVD92N6d7ACdk5fhxOm0Wi?=
 =?us-ascii?Q?G15Jpmz6cqTC+mc6G4cZYW6AFQMmqJL7BWph+SyMyzuyeOWujHrMmxR0/m6M?=
 =?us-ascii?Q?JrD275cZ1kbab/FHhSYggnF3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affb83b-9a45-4c46-1ff6-08d97dc10756
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:03:45.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4OpFkWfww/ptVhfPfZP9rL8/phvBRRPUQLfQCHoWT3sQP62amwM+IL9bNqX+ZtMrw8tezKiRC5KGMM17v2lIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220085
X-Proofpoint-GUID: VA1i5HFreql99-PyP_Vx83ls1bdjzBLE
X-Proofpoint-ORIG-GUID: VA1i5HFreql99-PyP_Vx83ls1bdjzBLE
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 27, 2021 at 09:28:25AM -0400, Ross Philipson wrote:
> The x86 boot documentation describes the setup_indirect structures and
> how they are used. Only one of the two functions in ioremap.c that needed
> to be modified to be aware of the introduction of setup_indirect
> functionality was updated. This adds comparable support to the other
> function where it was missing.
>
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

This is the fix. So, I think it should be taken now, regardless of the
fate of the other patches in the series.

Daniel
