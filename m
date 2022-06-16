Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CEC54E611
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377904AbiFPPaS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377893AbiFPPaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 11:30:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA8C2E9CF;
        Thu, 16 Jun 2022 08:30:16 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G5PoWY002362;
        Thu, 16 Jun 2022 08:30:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=jK93FpCkg7jvoR6GT+eEaVcZG7TZeEYRktaAjHvJFEg=;
 b=eqATSxGuVTkeqlGYeofq50jXF3Q2CVjVTdMVvK8W4/AytGuFXz58bK/lWqmCKRD0j6XF
 LH79maSsHjicU3RFXiQbqYbEbElc0rRoIFPgYNZrp0gwcPVV1jLyOEDwGsQ9Y0o+7Mx5
 ZhXuwZ62PzBPmHPrs/QjPV9GPRuGWRM+4Wg= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gqxc5w52s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 08:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQAGVeaJAhQ9VBygq3T4aNefML76FU0Xg9GkvRezUz9Gk+39GXPU2FJCCQ/AMMXx9Iiwg2p997LdgYzlF+qSp9zcc14VP2rnlaDx8so5uMkOdTV0asUiQwKdfdRy7dvycqCxwq+mFUjzSLXU+nt023lTwY4tJxWTu7EgouL5T9ZbiK8xcy0KaL/VRF0QDZIHg1GlRV2O23gN96MPIJId3rfptAJrfTaEerhiUSmtzrB7qGB1B3Wo6KKTn7FnfuXl6jU6ZEls+U7jYKkbFdFJDjX2WDmaxD7XUAAvxjOfyTdDjINFmqfUKg2+q2H/h25Rj+wOa1q6oJN3XktNXy5IsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK93FpCkg7jvoR6GT+eEaVcZG7TZeEYRktaAjHvJFEg=;
 b=dp+apfwT3S1do8mbuREd7q0TylnTpnnn/VvD3CC4+Z86lKr5qx83FYxA0z5OD5C57tcEQ/1KmCJOa0ahnY4wMIilGuQ4KcN5AKtjKPXcGoAzXV2YG3JV88uXoTkyiWocc7V8yTZnEyKm44+58dz0yBQOdzlfG6vqI2oC0NPZi+ahJJin75oiBVb2P2pHSCYlykckmn5kzjvFCR1OfjzI1JSQmzaQbb3+nZY0ZiulgcFepSbTY6hRUQm6KUDQO0uLbS/sBiWxQx/BBw24Fyp0L0BXVfyoORFIGgHCWbB62UvKaBMEL5zDEL2y0LpBJcokBRWMkYZXCxGBxS6NG5i68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BY3PR15MB4884.namprd15.prod.outlook.com (2603:10b6:a03:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 15:30:11 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%8]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 15:30:11 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [PATCH v6] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v6] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYgZX3ey/aWxd0WE+EiviZrAsROg==
Date:   Thu, 16 Jun 2022 15:30:11 +0000
Message-ID: <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfde81c7-13e0-4161-f626-08da4fad1a43
x-ms-traffictypediagnostic: BY3PR15MB4884:EE_
x-microsoft-antispam-prvs: <BY3PR15MB48844DE7D1166916313B12E3C1AC9@BY3PR15MB4884.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hS0HAlm7ZVZQ7FgoKpQZuq6sKkizGT+qzHavA06gtB5nTwgo1rctyh6wRVJrG+XUeQQJdUI+B+fod7j2/U9hSZKzmvhBhBfwtuQnP4Oq24SZxrr+dnouqjvmAawW1FdWzuXANbDSjyAtyixhj5uspQT3wwgL2hPfGtkfn3tJmCPzIQSIdrqZfJGASYmTOgr8lX+jBK8Rs6YBC9Dq8onusmfnM1i3Qq3h8QspVP5GAIhkpTEmQWosYR2gW0xU8rPpq3EkOULCibSd0LuscQlxRoi+I21GPH3vU4Ojgb/Z6rjXUzdfAJeTTGdVWezVit0S4mAMBkTSkn4CMJE4XcwdPFnAud0nAWVW+GAXtpmHk1YWHIGN4VSMlxWvfRosC+9whw0QVRfvlNrslpZ5Nnfo1G//N3c4nd7IUCLQZwHgqCYjprnhwgOdABXEf59fnUNNEP6K62dq1X05pmkGX0LsG2Oi1bR6YJk7RL0TcL4rvjcw1Cx/O/DGdplDhobREv4d0JV4p8HGOUtALnOFRhtV8JbViEauG3lJUKhVM84wFbUehp6bGkj4M9WSFh+AtbgtVvAJlFA28z2vJZXR0gu4iYbTGVJKuoqEyLK+crnTjbJY+7n0m4Euv46VucCL4apoI9a6cK7K3UfzASf9IeH6GPdyrlpxPplzTyMeo1IFC9mR2bz2rhE3hw0sPf6ismJKFACinoAtAQHHNl1eFRyL3FqAKSLR3Dmgj2YKnUvSIkMyDnmLTi/lmesiqdQAZS+PkU5dS7lFK9bnF11/eVl+VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(316002)(6486002)(26005)(8936002)(508600001)(91956017)(110136005)(54906003)(6506007)(4326008)(38100700002)(8676002)(66946007)(76116006)(66446008)(83380400001)(66476007)(64756008)(66556008)(30864003)(7416002)(5660300002)(86362001)(38070700005)(71200400001)(6512007)(9686003)(921005)(186003)(122000001)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?obrQzwNkQ1DIF7t1tQ3zUqWvkG2tYJCt+5PzZSQ5k64rCyCSoR+H77sYDROi?=
 =?us-ascii?Q?E6MCV+Qb5I4k3BThm8NbUfaBittvtRZMcH4N/GCd2R4lmFgyw272hamQSKsZ?=
 =?us-ascii?Q?nMydE9wisKXr/iG9flSECE6xByztbcfspkK47nd6uP9qpJmGBRc4/LSEkmL3?=
 =?us-ascii?Q?MDxHJFsT0rPNsDIXKKZxN5OdzM8yI51Zimp+zX6+EmMojBt2pni9xOlRX4jq?=
 =?us-ascii?Q?UeakLHR2uEAKFtlbvfRuJJvORzKLh9fvQVDPzOsG91cgrPy5jejb2NTnGYmj?=
 =?us-ascii?Q?zUZN6kGxRAh48cvMl1bqxs5ZbpmuPTG0PK6isgOkdBWwrQm65gfpo2oIDugH?=
 =?us-ascii?Q?fzgEWnP1fWsxH9xEDIpSJLnH6Qu0BXrEGxBQ4aClhYZD8DJHgxAYVJjrILMG?=
 =?us-ascii?Q?ZWcn6fYJvDkrojGzxeqfM9irkpMMkssHGa3wOWpekqzJxHF9S3DJB0ooQ17u?=
 =?us-ascii?Q?w30NQcFboGkh+HBZ45TgW6ZZhu+UzEyadrjtkUkzGi/r6XK75ixa+FdHXkGD?=
 =?us-ascii?Q?0P8HVcgdWUD0EDOX4nq0E5IFzL1lrczRnfOkpVOQThZdoHRtBUHsE7gz2NI5?=
 =?us-ascii?Q?/l3oIIPzmyILbgMQxcIryQHq/Se0OczGN+2a5qDLu2qSnZ6o9bAktjPWfGn+?=
 =?us-ascii?Q?Unhso/bcMsqc8OFgYLNMcXVDe49inGn+aYoHsqJ3rZHQ3/m6+SB3RSpBG35/?=
 =?us-ascii?Q?tI+63y0VJGvzEBn5Xo4UVp3fdZM/xt4iULeTLVI7vD6Z5ef2eq6AScf7a5h6?=
 =?us-ascii?Q?xjCsCC3eQ+aE2avdAjH0iXg+zMVGMy3ct/12a0reYmWK9ku51q4qiUKHkFN8?=
 =?us-ascii?Q?WE5ZJVFtJjrVC7uRWEtwfdGPDPaJ2SsDnjRIZ0SXN5wOZKg8w62FZ1MYJng5?=
 =?us-ascii?Q?093VwWqIIxvKEtqe2rMgwB1V9hxnSTG1iK/WD/sS+vRYqOqJA537uKxTHQWN?=
 =?us-ascii?Q?UN9LiY/XWEOsJx1Iix+E83W7oMEvIMRCB5h4IL1lqM6hgKoeTjlrHkMWB/J7?=
 =?us-ascii?Q?Iwa+R6DOAIGFGCEqOhjgzLT+1YQx/2jcibjwA1laGbfAlZUGk4p4/2PKCN58?=
 =?us-ascii?Q?7Po3vIyojwS5vjDjMC7X7sLyE33ND1MPlgNqLrMVM7/4HNh+utYqQj0sYq9j?=
 =?us-ascii?Q?TeJgz7aVSpBN5FCM6wqZnBgUQ5PxySb/fh7/AVgzdFDCRu2bHuJXBqQoJpLI?=
 =?us-ascii?Q?1qQSA2X+litig3rOw3Mj2G5hP6xOcLmOpnCe3iihbbUXsEalL/zD9LEvImkR?=
 =?us-ascii?Q?aCLXg31OcusR3PGGzwPUTKUAtDv+q9sueD0V6QiaNScNkjmK00V7ulxGJEpC?=
 =?us-ascii?Q?s+8L5ypGu1Dr+AQC1S4A+InkAQuyVgGOiUiXJ4CIy/5b2uCePz6A8U+OiSmR?=
 =?us-ascii?Q?1fUBMlY4xD1c2HABOMmDEhFI4jfyBScT/13VWg0R5J5Je0Jz4g7X2MYSZ4H/?=
 =?us-ascii?Q?73qvmGwXyTiBltV/EhLiFcTFiLlCB5hdaA8JlxZ2tI+dRY0dZ9FMQQLohbvL?=
 =?us-ascii?Q?IlvxWeVMV3yHVgBadQyFt/kXcnKIAC2QNmALFiWmqyVvhO20QXR2hzESIC8K?=
 =?us-ascii?Q?CBoXNmQ79oUNZFcqYUPXp1lGjxkproROTw02Vn1G9hfpX9EVgg+ZGoUkwgch?=
 =?us-ascii?Q?PNqcMo2wT8z43VTauGv1sieNvnSQlFRYU3VvL1ioXWlh/bhMoXrkaib7/sC4?=
 =?us-ascii?Q?Gk5b9YOld8/OiJ/2YTNKzITwyueWMObKUvDzbCkmKcHw3Z6FIRgtY6YM8kt6?=
 =?us-ascii?Q?No3d4zecXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAF0104D6155E14D8912CA2741FF70E1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfde81c7-13e0-4161-f626-08da4fad1a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 15:30:11.4788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chfjgEynrKNcr/ADKXtrP7uOp8IP0OEuSItpxvrpLcsFteHQgI/BrUYtmEMfVKZ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4884
X-Proofpoint-GUID: vjgtnR1ph3rpj2hZZPSsduVjgQiA-lZb
X-Proofpoint-ORIG-GUID: vjgtnR1ph3rpj2hZZPSsduVjgQiA-lZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_11,2022-06-16_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On kexec file load Integrity Measurement Architecture (IMA) subsystem
may verify the IMA signature of the kernel and initramfs, and measure
it. The command line parameters passed to the kernel in the kexec call
may also be measured by IMA. A remote attestation service can verify
a TPM quote based on the TPM event log, the IMA measurement list, and
the TPM PCR data. This can be achieved only if the IMA measurement log
is carried over from the current kernel to the next kernel across
the kexec call.

powerpc and ARM64 both achieve this using device tree with a
"linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
device tree, so use the setup_data mechanism to pass the IMA buffer to
the new kernel.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> # IMA function definitions
Reviewed-by: Baoquan He <bhe@redhat.com>
---
v6:
 - Remove IS_ENABLED(CONFIG_HAVE_IMA_KEXEC) check from
   ima_(free|get)_kexec_buffer now they have the ifdef guard.
v5:
 - Guard ima_(free|get)_kexec_buffer functions with
   CONFIG_HAVE_IMA_KEXEC (kernel test robot)
 - Use setup_data_offset in setup_boot_parameters and update rather than
   calculating in call to setup_ima_state.
v4:
 - Guard ima.h function prototypes with CONFIG_HAVE_IMA_KEXEC
v3:
 - Rebase on tip/master
 - Pull ima_(free|get)_kexec_buffer into x86 code
 - Push ifdefs into functions where possible
 - Reverse fir tree variable declarations
 - Fix section annotation on ima_free_kexec_buffer (__meminit)
 - Only allocate ima_setup_data space when IMA_KEXEC is enabled
v2:
 - Fix operation with EFI systems
---
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/uapi/asm/bootparam.h |  9 ++++
 arch/x86/kernel/e820.c                |  6 +--
 arch/x86/kernel/kexec-bzimage64.c     | 42 +++++++++++++++++-
 arch/x86/kernel/setup.c               | 62 +++++++++++++++++++++++++++
 drivers/of/kexec.c                    |  9 ++--
 include/linux/ima.h                   |  5 +++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..670e0edc074f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2033,6 +2033,7 @@ config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
 	select BUILD_BIN2C
+	select HAVE_IMA_KEXEC if IMA
 	depends on X86_64
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdcdf532..ca0796ac4403 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -11,6 +11,7 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 #define SETUP_CC_BLOB			7
+#define SETUP_IMA			8
 
 #define SETUP_INDIRECT			(1<<31)
 
@@ -172,6 +173,14 @@ struct jailhouse_setup_data {
 	} __attribute__((packed)) v2;
 } __attribute__((packed));
 
+/*
+ * IMA buffer setup data information from the previous kernel during kexec
+ */
+struct ima_setup_data {
+	__u64 addr;
+	__u64 size;
+} __attribute__((packed));
+
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..9dac24680ff8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
-		 * SETUP_EFI is supplied by kexec and does not need to be
-		 * reserved.
+		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
+		 * to be reserved.
 		 */
-		if (data->type != SETUP_EFI)
+		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
 			e820__range_update_kexec(pa_data,
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..c63974e94272 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -186,11 +186,38 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 }
 #endif /* CONFIG_EFI */
 
+static void
+setup_ima_state(const struct kimage *image, struct boot_params *params,
+		unsigned long params_load_addr,
+		unsigned int ima_setup_data_offset)
+{
+#ifdef CONFIG_IMA_KEXEC
+	struct setup_data *sd = (void *)params + ima_setup_data_offset;
+	unsigned long setup_data_phys;
+	struct ima_setup_data *ima;
+
+	if (!image->ima_buffer_size)
+		return;
+
+	sd->type = SETUP_IMA;
+	sd->len = sizeof(*ima);
+
+	ima = (void *)sd + sizeof(struct setup_data);
+	ima->addr = image->ima_buffer_addr;
+	ima->size = image->ima_buffer_size;
+
+	/* Add setup data */
+	setup_data_phys = params_load_addr + ima_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+#endif /* CONFIG_IMA_KEXEC */
+}
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
 		      unsigned int efi_map_offset, unsigned int efi_map_sz,
-		      unsigned int efi_setup_data_offset)
+		      unsigned int setup_data_offset)
 {
 	unsigned int nr_e820_entries;
 	unsigned long long mem_k, start, end;
@@ -245,8 +272,15 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 #ifdef CONFIG_EFI
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
-			efi_setup_data_offset);
+			setup_data_offset);
+	setup_data_offset += sizeof(struct setup_data) +
+			sizeof(struct efi_setup_data);
 #endif
+
+	/* Setup IMA log buffer state */
+	setup_ima_state(image, params, params_load_addr,
+			setup_data_offset);
+
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
@@ -403,6 +437,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 				sizeof(struct setup_data) +
 				sizeof(struct efi_setup_data);
 
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      sizeof(struct ima_setup_data);
+
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bd6c6fd373ae..c9f375045e0d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -11,6 +11,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
+#include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
@@ -140,6 +141,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
 __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
 #endif
 
+#ifdef CONFIG_IMA
+static phys_addr_t ima_kexec_buffer_phys;
+static size_t ima_kexec_buffer_size;
+#endif
+
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
 int bootloader_type, bootloader_version;
 
@@ -330,6 +336,59 @@ static void __init reserve_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+static void __init add_early_ima_buffer(u64 phys_addr)
+{
+#ifdef CONFIG_IMA
+	struct ima_setup_data *data;
+
+	data = early_memremap(phys_addr + sizeof(struct setup_data),
+			      sizeof(*data));
+	if (!data) {
+		pr_warn("setup: failed to memremap ima_setup_data entry\n");
+		return;
+	}
+	if (data->size != 0) {
+		memblock_reserve(data->addr, data->size);
+		ima_kexec_buffer_phys = data->addr;
+		ima_kexec_buffer_size = data->size;
+	}
+	early_memunmap(data, sizeof(*data));
+#else
+	pr_warn("Passed IMA kexec data, but CONFIG_IMA not set. Ignoring.\n");
+#endif
+}
+
+#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
+int __meminit ima_free_kexec_buffer(void)
+{
+	int rc;
+
+	if (ima_kexec_buffer_size == 0)
+		return -ENOENT;
+
+	rc = memblock_phys_free(ima_kexec_buffer_phys,
+				ima_kexec_buffer_size);
+	if (rc)
+		return rc;
+
+	ima_kexec_buffer_phys = 0;
+	ima_kexec_buffer_size = 0;
+
+	return 0;
+}
+
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	if (ima_kexec_buffer_size == 0)
+		return -ENOENT;
+
+	*addr = __va(ima_kexec_buffer_phys);
+	*size = ima_kexec_buffer_size;
+
+	return 0;
+}
+#endif
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -355,6 +414,9 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_IMA:
+			add_early_ima_buffer(pa_data);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 8d374cc552be..d3ec430fa403 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -9,6 +9,7 @@
  *  Copyright (C) 2016  IBM Corporation
  */
 
+#include <linux/ima.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
@@ -115,6 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -129,9 +131,6 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 	size_t tmp_size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
 	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
 	if (!prop)
 		return -ENOENT;
@@ -156,9 +155,6 @@ int ima_free_kexec_buffer(void)
 	size_t size;
 	struct property *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
 	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
 	if (!prop)
 		return -ENOENT;
@@ -173,6 +169,7 @@ int ima_free_kexec_buffer(void)
 
 	return memblock_phys_free(addr, size);
 }
+#endif
 
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b1744215e..ff4bd993e432 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -140,6 +140,11 @@ static inline int ima_measure_critical_data(const char *event_label,
 
 #endif /* CONFIG_IMA */
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
+int ima_free_kexec_buffer(void);
+int ima_get_kexec_buffer(void **addr, size_t *size);
+#endif
+
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
diff --git a/include/linux/of.h b/include/linux/of.h
index f0a5d6b10c5a..20a4e7cb7afe 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -441,8 +441,6 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_load_addr,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13753136f03f..419dc405c831 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
-- 
2.36.1
