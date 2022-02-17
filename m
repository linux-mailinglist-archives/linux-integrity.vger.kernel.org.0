Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6954BBCE1
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiBRP73 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiBRP7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E105F243;
        Fri, 18 Feb 2022 07:58:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqotH014549;
        Fri, 18 Feb 2022 15:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mXI6Ogd4QQmCmlIgjroCmDhCkZOvDem0Z4i+q0jWSok=;
 b=IJ0Rb/LZjdG4mhqFzGbPJHDPLl5FGIwbkeFUqtumEl6dMGehbcMNZ/yaVlRaBbUBOggL
 dIGZbKOku1S9JAevbAg+xkU1eCivdzEAmnHCX2rmKn4hBQtgowTj8LLU95BD7YhkRMxm
 4FnvzpAKYEJbyyX+9VCqHBSKcX0psY4+adcU4/vnsilhwBC4id0IgNGP1YDWjXGCEDwL
 rLfLgLo1L5Ww2xf0nqGWsMUGvIVv+4Ds+1P0staAgYV0f38EvnXhupBhhJS0y2fp8w2o
 Lj+sGX6pPpZIYw+3/IIEoKpoaizmAmm2DrxSnkYQP2QkLwdrKRk/BAxGqDj3fQNDqvmt 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb1y2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFvLE0055329;
        Fri, 18 Feb 2022 15:58:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3e8nm18845-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM6leLgDAbn+zFzeXZ1n+SefoaTGEVY8dofD0QmKpA4TWFnv+Ow0hiKao1t63fWUrasnu0lx6ajFco8tzqcja3Jf6L6y5OfGlTYzc6OT4qPi6MWTmkSbVy/3gLPvifXNLndpZ9B3dvaDLdWW0F+qz59RxvrcGk+6+ko2fMZh2fDcZTPB+PwDax+9KPOR4xv7T1dJ46/8eultjZJbcqeNpTuy5uznvMQADyEM0+MEwk2Wc9lAHMdNrNNqCxD12vU6Aebgs+HxscdOTkLP+pT3++l67GXdMHHzwYlFonE7ZniePnyIuJafxjElUcONDyaULT9dN2701HSNLRQFRMkmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXI6Ogd4QQmCmlIgjroCmDhCkZOvDem0Z4i+q0jWSok=;
 b=F0sb8LuoTfj2tayLT+YlAk8UBw7Px+1z+yudI6G1cETIYFcArcEA5n2+bcZpLuDC4l7YR9AySddj2r8sAH4Yp2P7HNZAryVZyn+5h6OoH/60KGjIAlXLW9DfzM3c+5x3tK7PXG4MVRxjfc2wteOyoif8Yju+sgMeHQ1Zpf1ZQuLSFR2btRdmW0jyQE3Kp4fcGZe94riz2oAQYog7t3pnJEKJErypSTLawBvWYgUsUixVFu/FWF+WwOgbA5MhN5DiUNeRlt3wZyM1HFFhgsrlAxQw5vxY91O1aLuzste6T6zc6JCuv2W1+d/8aLSVmoz6T27AWCESt7AFdpOoEeAc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXI6Ogd4QQmCmlIgjroCmDhCkZOvDem0Z4i+q0jWSok=;
 b=bosGlwvOhlWlqF7W/9sjEN3OWtvJU+rSTnB4GYT5i3TSynUShxjD4g3RSWvi+kh/MAkLtiryeGHoXd07Z3mNKBUoB0yl90OjWgkwgTgaD1LYEAlfuwyVzM28Cpbo5eDY12swHR3C9jZ/r6a4OlTIjTosl9JCxWj16uBoXmVc+hs=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:29 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:29 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 12/12] tpm: Allow locality 2 to be set when initializing the TPM for Secure Launch
Date:   Wed, 16 Feb 2022 22:54:45 -0500
Message-Id: <1645070085-14255-13-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e388292-268e-4f22-dda7-08d9f2f78173
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB422656F4ABAA0FD707EB5F40E6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTWuMRAUlZ8cjBdEfWGuaec1NoZz2Egi2y1rIHkGK0UXxvFmBJkOgJs3tb7W1GgI6QGivX2v0C1fTvB1fkbgnrjeRD7yH4/u4J5OSUxPfHlwiGM53KawEUGujsH0F1AluCKXe4FUzxzYoYm0Uegg0zytrxqDy1PpHj9lAJ9yZRcz2JqWEtB2OwqWyWBxwdRlM644F5oI/AAoZvN04IBB3fBmnIB7TNOjkGbB/U8OcOE6hy2B3WNmqt+T1RsDcrIsml4662PS6Cqw/rx12IrjWADGLC/BxO9YToUBvvzKb9epLTtu216Rw1mOOPj5+/Xp4Feh2qjmT0xF+0SDnDX4wbbOh27THyXNrx/12pA89TNMb+HXLmP7g0VZLIU3AltSV/MY4nO6Q9DiOTq56psJlbgd5dig5Wt2muoVj/CLNqwPLuI2CIBpIyc4B+tCldedd1Xy6W176ZBvcHYZbbNpS3XpBDJKF55B2SZp1e5209/JHbCLdfVsNaOg1hhKgDaXN4EODxKCNwdK3+h12WfvlizIxzLuUHveo5Fkq3coJAbeVq041oAQ3TSDteXqT7R28ImFQ5kjHqIgwxr+AZQvgA64VDtkr13lgGKpWBKtZy5AaJu/iaEctvPDg7106NNxksZIke9a0m6l1RF5y9ggrtfQ7Kyw0VNC3khuifZAbS871IIYGBkQSxpGLe7z5b4XB++9b0wRO7KeYWCIUrdmCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?76VNjF6L/3b+PAxdmnC6YuEyE+MeHY3bAp5H18nRzyp5R4XqqpSvPHaaZHSP?=
 =?us-ascii?Q?r+xwHnDFWKiJKZbtOI3zu1u5DQwMKGeU9wYQtRC6m6oa4bbuhxEPRISnj+E1?=
 =?us-ascii?Q?nmRAGDtdEFlMbL8OQHNIetpCsbdCqQnSgNQfmzK2JvuCrx4/Aa248ZCtuxeX?=
 =?us-ascii?Q?/oFos9Ywcy4/p09oSRZTiqw9p+t0JrD9vb/ZvQydKuCHEhWjrHjo1O+QwS4q?=
 =?us-ascii?Q?NJERrTNHFGtueo7ppOfELApy9VbNV/NnFumkhRcN9ST79mWctvtYQzPYoYCW?=
 =?us-ascii?Q?6ozR4ciJ4Vk2XCx9wBsUrmqaLYsvl65zHWKwqf6AtbhOxtxTMxY3EhmXrnKC?=
 =?us-ascii?Q?yUgaSmb1bmeK3o/8oJ4tREgj/RKYRlTkFYmW4Amw8leqj1vo1hAt0Xrb5pBU?=
 =?us-ascii?Q?13zFLoHPDVj4cNaq0GTAQVTp3rz1hYKohsfJRsdykt4n+4wpsoKFBE7H1YBJ?=
 =?us-ascii?Q?5NOXMK+U4CzRKa/7RmCd9UHlXN0CTitqdlncpEfgpzShvfBddfvQTSRoSYcy?=
 =?us-ascii?Q?kniaV8LDrIQyVhoUE8UCAy9klqEgnGKwrNmciBfv6zC9m05Y3bVL0gJmY163?=
 =?us-ascii?Q?cwUfi9nJohg7tvnHFjcmDaJ4Z3Ul4CWD//BpV7ZkurZrMwup9GCn1SSM0jES?=
 =?us-ascii?Q?4OWG3WuDbNGuo1ENLJgPQ/udXiJCgCa+RZzuvDsdjhOHE9JH9Qw149kU/C9A?=
 =?us-ascii?Q?M6+UU7onQvQMN1lFPPpn6US53iWyGcsPnrEUP2NhIS3xKsH66JwnLGdiaJRx?=
 =?us-ascii?Q?ll/hpkT06uHQsrN39XUhenD54STIc2g0Gc3Nld3IHzYfOPX3nAqKnJ5WhR4s?=
 =?us-ascii?Q?hzBb5B1WKTpatfzXDJ0UF4sdVj1ibOp5Fel2Rpv+tgcsCPsMWtPAKqufOVQN?=
 =?us-ascii?Q?xlrZv2iuHa/QJkLtEiCf4fUgJXyqrqs8gAU8aeqMsTaMF8bKjgk2Er4RzGBE?=
 =?us-ascii?Q?0lgMsFHNgrI8TfLlqRt24ZV74BM9CFpXco+bKgAHtEXHBBT1IDr4vlk29SSn?=
 =?us-ascii?Q?2bLiuktpjTwwSrrrjKIaikRTH5hKxTt7vIiTo6Q3h8zOgFOJ5MAqJ3RbdkIH?=
 =?us-ascii?Q?RMxAdu5oHu7evUp1JXKVQMuERVpbin3B3eojo1OBjFDGY/gLmu/9HIblYMoj?=
 =?us-ascii?Q?CgeinfpToOYoTVaWXS9BR8LI+9VWOToAPhm482YJO6P5rvev5aRuxcA6zM56?=
 =?us-ascii?Q?rKRxJCitVe5GkE92pePpdoDuxR6fAzZvxj25A26I7j3SXrItUeZg+0394cqA?=
 =?us-ascii?Q?F4Dh66FrI3RZqHv2omh8rB92gKtxQmutsnbKLj7IvGMXla3+uZ2K66K3qne7?=
 =?us-ascii?Q?q1rMSUzv+fQkWh+yk+KGU8QOjnQjqO9gON/z6k33mstMJRPP2fJ59BqwwUTe?=
 =?us-ascii?Q?6b+MrJ+k0RjYVxpZ2KkIiMxCNHTgxvnn3WGmuNa7LoHJxdJYRlgLrxkkytqP?=
 =?us-ascii?Q?hr0t9jtEpM6Lg6NgvUCZvnQ7a3tL9JMHXbwXKF3ODTiU3jcY6PGPwPA/b5XR?=
 =?us-ascii?Q?atoVBuBWN6sWEdsXndH+2zRWAKZqi/KpiC8+e1ITDpv9NxdqoVnJMGTFSXq1?=
 =?us-ascii?Q?9HfcuYqKRkPb3Q+NbF2Z2x2u5jg+7qaYsKX3Az1OOJ5GzPeHvuuZsQfUPSAT?=
 =?us-ascii?Q?vho45RwJ66zGFg3GLFC6YIQLv5zUIwbiR77z9i0xAI21Ys7016Z+wOWwFm4o?=
 =?us-ascii?Q?37AuzIZsn2e4Npf7EW+K6BPY71s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e388292-268e-4f22-dda7-08d9f2f78173
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:29.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQtLTn2tLPxo3S8cuucfEa4UxvfUbczj+NDjYHdMfj/7o7QOMDLmelXeUBXrZhkHaDFm8UHXHfUVCGTNRmMefQ7TmMg9R6blmRuoVgq9p8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: zjnLAhKLtd6kD73OB8VjyPoZhpLyuqPG
X-Proofpoint-GUID: zjnLAhKLtd6kD73OB8VjyPoZhpLyuqPG
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index b009e74..7b8d4bb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,18 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
+	int locality;
 	int rc;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		locality = 2;
+	else
+		locality = 0;
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

