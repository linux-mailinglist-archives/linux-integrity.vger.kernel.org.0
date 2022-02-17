Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFE4BBCAB
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiBRP7F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBRP7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94965EDCD;
        Fri, 18 Feb 2022 07:58:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqs5h021140;
        Fri, 18 Feb 2022 15:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HJtko2ujR35s+tDauCGM6pMVDqAU+bjuZVBRywIV+PY=;
 b=dqF9eBM+7QQQmeCO7s1tlbuAojkDNZnkTcnXJ/HX9zWbnU4WpToSnDPDNn7Pch7dnMGf
 PiaeUgBQ7pbnkPthHdkgCTyIQ5wVF7A9UC8Gje3tt3WxcWxSCiHbQurSXQQsX8x1CuBZ
 I4KQ/EQAGIyv1R6k7BPIg/0Pd2AXLP4g54oa3/awWPgNN4Ox9Ec6RECmfy1EXMJf3edr
 /VrPSkrdHkOsjFLmUQqVBWmdh0x4gMzVTYLeyCiOhpvhCD817c+2OiuGGbaNryLqQkga
 kDeVVEzVBPWXziXiqWgt/3+k9BLoXqlPGGZMHTvFiqgHhCURE8XrJ+YY2r7OP3nNBU7u +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdt22x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFuFJm014591;
        Fri, 18 Feb 2022 15:58:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3e8nvvhsvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnaEL1R1IVGEdceCqq2LCxzxyOkxo+y2n5iR3G776H9S8uhi3V2R8Uyv4reTUN5L68vrXtpgb27guQ2AbcxUZ8IujNgC/v8DVt0sijIXNG8yhv5afMg169N7/uyU87hiIYCA6eo84OralPs6mTaHR0fjQJyySntgNjV5NNEQPdDxhrocn8Z+4bDNeYOjtSW3UcJivA4lbhEupP7WME8q8eeb6Ks88f/6mlHlbliUkJB6/nEttXnoGqYdgJhKeE4mhWby0mmBNJrLhzyKtpNPyBd9DdHJkr/8wUIM8qU6mif41d/5dOoMtlXNxS6tH4r9kpqieGZ6HDVMSUN6fK/myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJtko2ujR35s+tDauCGM6pMVDqAU+bjuZVBRywIV+PY=;
 b=MhSKEVH9lZq5Nl5mZNHqJmz/+rBVVrr+D2fGXJwRJrWSRH/nuAhBfOWosqS8rocG5xojeT79tkBtKvmUIKnRmDLMDjfuxlcGaarKcM/WdF6vW4arTfCWG8kYvUkX1v9vhn7r15MpMn/MzoRvI+j7xSxrzIEIMhdSqH0yUzsjkQXSZX088wT9kKVANVl61sy+20YnxWQ/1PNet2FokzMFN/UZP03xI2ARqI38EWLNun5XfKK96t9k1dvcaU7YicaBbtSe84H7Bb8AW4H6ERiLvTQ8tdcdGdMHKkYcRaFpMtdBTHNh4QqadBql4FdVEokN/9POaxjA+PdsjdN/5ixU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJtko2ujR35s+tDauCGM6pMVDqAU+bjuZVBRywIV+PY=;
 b=IEZoSpaP5k86sZH2FAz4ITJb3JBc72JykwTPpY6ZV8UuNRBobJISil4rcDx604ALw8f+lkNnnThdykIcml2GPgYzVygxmhhTdzUn3VE5z3zQ4zMvlwr+205tqAgYrxP8fNmMrzfdrKVkerLJZXai4V96qZSlju0xi+GhZ2PwuDg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:14 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:14 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 05/12] x86: Add early SHA support for Secure Launch early measurements
Date:   Wed, 16 Feb 2022 22:54:38 -0500
Message-Id: <1645070085-14255-6-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2db15ed-173e-4d3d-bdbd-08d9f2f778ab
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB422629E340D2F75C6BDE4425E6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4MGg2tauMzhNGFDQ/k7u3LdsG+aJ1/C58TEqqMwGkdwfkF3UPZH3EeeKXc/UtcGN5AtDVI78chLj/n/YtV9v6MBk1D7JxpNxAQpvwuCyH7DzM80dZ8N5jZsmqX73Dj79qY3CDi6q0WwmrK6lruHvB06nygfLJMYcTzo4a3R03N0SXIR6whtvi+0LAa9L4hS8b2gbCYGVlVIRzc+8pQHjau4tAzFJIkYnCnI8K0KX5TbWxMTEmKTTVw490VEhVvVgJmTVcxpdQ6hl1d8FYXBmEfiGQAf6sIp+rccz97FlR+xkNZTHFKbsM7EhLZhf2A+RaCzC4N94KTbANB5vtp7tXk81rJ2rP4Sl7jPet1QQEYNIatQut/mXKvH73m7RzZx4AAuPvWM50UQh+e78awPp/DPgcIu00qe5KPHICGZM1nLZBmsWsezfR2FzCSNiGvNQ6WUV3kJMFBKxwRy29xgIEBxMiIGw7Cj4Ny+tzveQ+SkczRRbWz4VCW0sKKRxz97OotPkTTylnfFMMln4SwmJP6DuhjigeouMavcd5n1VbfOUQJ3oZRPp8pHKvH79vtxrwccqIlEyOYd9sl1kdUfYdU6HuKA3lJIN2etWj7NQ+ehi+NGyhGJmOPLrYGJgldTS7PbmMp4grhy/DgwtKyI1h7X33oIsghqtJYdbHevMr4bBX3iLZPjcYc0qyf/icbz/dRoh4E1XQei8HuiJBkBRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(83380400001)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XH/RZ4ySnSvS9HqTxeu8mpkvF/Zw218ZC3sFqHtS4vH7cVONEa+ZXFFpB66k?=
 =?us-ascii?Q?xD2L+Va6/q637wZny/T180+BPGJd5/lCEvJMpEaIyM1rEbbxKpmLYUNHJWF7?=
 =?us-ascii?Q?jginfR2voRYjKirH0jZbXBnRpDk4sCIIwq6FkFloyyObbxxDF9LbEYlS8XGa?=
 =?us-ascii?Q?dclg96mLfK7nJbUf6pYca0RG54ULwpmA9f8lQEgy88hNtTummksksyVhUoiy?=
 =?us-ascii?Q?PNdv/w+O3fmyTYdVp7AQ8GiZgZJiyv3eILYoZXm0xjwjmYsbZVN0J0wa4lRZ?=
 =?us-ascii?Q?yChvD83rlt70Rz28J5IsXE4whkJZVtbsln+f5uwxL0xerj+aW5YvLNmVTiPH?=
 =?us-ascii?Q?AX7/R1iBHRFAQjosfa9pFqWH3KlYt+T+O+2OLs9PbAMH7bJLpVV5Dojyt5nJ?=
 =?us-ascii?Q?37r52gvdmZyxVhcElGeVSOlscNdvhUJksx2mwT9cmHikNpqFGdySOo0pxeZq?=
 =?us-ascii?Q?O0ERqR4MTbZ4TN0IwwgoFk+Dxr6DeEU47LPquiUaa4VkY0UY/lFnDUwX8rJG?=
 =?us-ascii?Q?Vkg4k6ISJyp77rYSqQYWUOKznTt5vzsFG/DHrjmXmST3dCvZJxncZMDoFyNL?=
 =?us-ascii?Q?XRJu6Vj2kYba2JMPbKaSQgAOSpdfPw/xUTXeEB9cYJzGicxMV/j/waVrcZsI?=
 =?us-ascii?Q?nQ5UiS5483PCYW2G9MVg/kjcmduXVDX6de1PnrwL43I7KfkTcg41rGOe0a7p?=
 =?us-ascii?Q?AdsAazv93MP247BEEg33/l+MOKL/RsFBydlodSJ9A7fqJIvX/ZLASv2sMocF?=
 =?us-ascii?Q?l2jMxA6Qghp9PZ0LXVDZMYfSjsfx3N8t+yEREwz/O/Qd2WQ3SHaA3Jy+5e2o?=
 =?us-ascii?Q?csVJm/3OgVSqSM77q97gW1h36KzqC53Y40r+Iay7ZLoyXyrgBKwnf513yMta?=
 =?us-ascii?Q?i8ObPmkPJzsQvs54wTjUDiygls2o8eOLC2rRIGbtbMV12Q/oQ3342JETYSuL?=
 =?us-ascii?Q?efNLWK2g05UbU8iy/Z5CWg/XiAa14tJgB+0FF1PDzecMPKLvftprHUtWehmO?=
 =?us-ascii?Q?o6QqER6GLBOTE0B90NsdrMhDr9ghvKGMsBWysN4akICgC9anNX/MDC8GIcmO?=
 =?us-ascii?Q?uhOoRloVA3xfAU9ROhgrgcBTdpf0o1SHo5qLT34Gaj0sEH0Mu20iJspOw1nj?=
 =?us-ascii?Q?3qcZv9VFr5f3kIrQQHjEPelIicMCKLwH2T6XavDEdVj9xK0AArO2WSC+rEd1?=
 =?us-ascii?Q?GZKmVwv52hzMyer9TFyjR2FUzevN4FIyremd+f/4nX6/f/Fk3F+8/uWzujDA?=
 =?us-ascii?Q?lsPqztQCgYOnIDdkbnceIWMmPAN8P56NUqpXdBE3Z3Y9hJ+AaQPPmtr2JMYb?=
 =?us-ascii?Q?c+yZTEOucT5bQ2mAeCpUsyFDGgdMJmW8AdVbj1tBQY3rUetwca+IE0YtZtZf?=
 =?us-ascii?Q?EDQ4vEcZBDUkeZid0HAmYspK6kyFs+Qru9FJQUKMBMS81UA6o5yAbvMpzmfL?=
 =?us-ascii?Q?fwkJI3NqBfkmeJnsJY8ZTL7PTKlau/gfSMvfFMwjerdUXevMDucJyXhaCn+N?=
 =?us-ascii?Q?WCmdZjJRNUlY9moOTSqn1BL2OA3K+k+yC638GNDjpOi2aeFhzpJqMut/7R2w?=
 =?us-ascii?Q?+wlPOTRZgM4lVpUkjPfiVNR5ljvA8dAH4GQRmKIGdTHHYuuiE2fCbEz4t8Yk?=
 =?us-ascii?Q?1RcmMs+HfPp41cE1Tc5Z6AEbrVyX4mchu41pnP3fEVhhEoALeS8G1OJ/2sUk?=
 =?us-ascii?Q?Ln/hf/i5PY+gJ8T5iE4u6dRnz1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db15ed-173e-4d3d-bdbd-08d9f2f778ab
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:14.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWEyblIrW0W7SiDbBLGGz1s2fDTLrK/Ab82ulwSn5wLwFVT/gB+ukLfeTo4EO8OCZyyFE/uBkIlginbkFrfuKABVPWj4dC0BCbXHpU1E6Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180103
X-Proofpoint-ORIG-GUID: pWUw6dZKIvUswG5eLXP7R1CI6K-3xam0
X-Proofpoint-GUID: pWUw6dZKIvUswG5eLXP7R1CI6K-3xam0
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA algorithms are necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA libraries directly in
the code since the compressed kernel is not uncompressed at this point.

The SHA code here has its origins in the code from the main kernel:

commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")

That code could not be pulled directly into the setup portion of the
compressed kernel because of other dependencies it pulls in. The result
is this is a modified copy of that code that still leverages the core
SHA algorithms.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile       |  2 +
 arch/x86/boot/compressed/early_sha1.c   | 97 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_sha1.h   | 17 ++++++
 arch/x86/boot/compressed/early_sha256.c |  7 +++
 lib/crypto/sha256.c                     |  8 +++
 lib/sha1.c                              |  4 ++
 6 files changed, 135 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6115274..d1791bb 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -105,6 +105,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
new file mode 100644
index 00000000..476bda2
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/unaligned.h>
+
+#include "early_sha1.h"
+
+#define SHA1_DISABLE_EXPORT
+#include "../../../../lib/sha1.c"
+
+/* The SHA1 implementation in lib/sha1.c was written to get the workspace
+ * buffer as a parameter. This wrapper function provides a container
+ * around a temporary workspace that is cleared after the transform completes.
+ */
+static void __sha_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	memzero_explicit(ws, sizeof(ws));
+}
+
+void early_sha1_init(struct sha1_state *sctx)
+{
+	sha1_init(sctx->state);
+	sctx->count = 0;
+}
+
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA1_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, data, p);
+			data += p;
+			len -= p;
+
+			__sha_transform(sctx->state, sctx->buffer);
+		}
+
+		blocks = len / SHA1_BLOCK_SIZE;
+		len %= SHA1_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				__sha_transform(sctx->state, data);
+				data += SHA1_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+
+	if (len)
+		memcpy(sctx->buffer + partial, data, len);
+}
+
+void early_sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
diff --git a/arch/x86/boot/compressed/early_sha1.h b/arch/x86/boot/compressed/early_sha1.h
new file mode 100644
index 00000000..adcc4a9
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_SHA1_H
+#define BOOT_COMPRESSED_EARLY_SHA1_H
+
+#include <crypto/sha1.h>
+
+void early_sha1_init(struct sha1_state *sctx);
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len);
+void early_sha1_final(struct sha1_state *sctx, u8 *out);
+
+#endif /* BOOT_COMPRESSED_EARLY_SHA1_H */
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 00000000..28a8e32
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ */
+
+#define SHA256_DISABLE_EXPORT
+#include "../../../../lib/crypto/sha256.c"
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 72a4b0b..e532220 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -149,13 +149,17 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 	}
 	memcpy(sctx->buf + partial, src, len - done);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_update);
+#endif
 
 void sha224_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	sha256_update(sctx, data, len);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_update);
+#endif
 
 static void __sha256_final(struct sha256_state *sctx, u8 *out, int digest_words)
 {
@@ -188,13 +192,17 @@ void sha256_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 8);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_final);
+#endif
 
 void sha224_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 7);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_final);
+#endif
 
 void sha256(const u8 *data, unsigned int len, u8 *out)
 {
diff --git a/lib/sha1.c b/lib/sha1.c
index 0494766..71e1b2e 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -120,7 +120,9 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	digest[3] += D;
 	digest[4] += E;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_transform);
+#endif
 
 /**
  * sha1_init - initialize the vectors for a SHA1 digest
@@ -134,4 +136,6 @@ void sha1_init(__u32 *buf)
 	buf[3] = 0x10325476;
 	buf[4] = 0xc3d2e1f0;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_init);
+#endif
-- 
1.8.3.1

