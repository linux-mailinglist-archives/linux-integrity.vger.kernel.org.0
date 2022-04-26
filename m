Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B435104AA
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353425AbiDZQ4Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353542AbiDZQ4B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 12:56:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FF5C66D;
        Tue, 26 Apr 2022 09:52:53 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQQgD025162;
        Tue, 26 Apr 2022 09:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : content-type : content-id :
 mime-version; s=facebook; bh=VEvRakZ9lkXMC0OV4FdAAgdJLXG/rwe05D+JgT6arp8=;
 b=FyrZQAcOf65duZFqEBPtw0dJ0J+KfMxOf7fd/TkiEDCxyt2mRGMt0fVQunwZoNvuFi9u
 YWFOeDgqvwDqkkWQpcbNQtOkCzIbUcEi1H9ui5lyxKALK7v7ryBl3Pt/HRseU+giiWyL
 yWmM6NF4953/oU0rBkTN4ZIv6ONVltrumGA= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fpbk8bcqu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEyOCVZF/sftzqyWYR/NunAWMpZpB679/VVjoyTMIhvd7u91OwUSmNLqEhplrob4+Xr3ikB2FtQ2RkyOjMnITQL8VdXeOBXF/MoaHi9ZipFd6WnXqD4rlpVsyUuq0OeOU6XRjoePP908gkfeJ2dmLDy1ehjQr3uZt5+8t2QujQXOTYWpP59Rl1xhSYkJSS3zVdNMnjDqs3Ua+zMFVhRoGviKIVOB9MoslGJx2M9RuHZhmHdGNJ8vVl6kIUeVOJym3ZEmdAsmJdFQP1+Xx80FlLCYOXw15n7xFcY4ej9Hziy4GbT6/FjDTocSLpfl0az0ggXttLrHF4XewqsbwFlyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEvRakZ9lkXMC0OV4FdAAgdJLXG/rwe05D+JgT6arp8=;
 b=iNW9xOKxlbmFq7m8g0T76cGBL4uukSJdcTnSmBEd1je+0G419U3mGGO5u8wwt+4s1ltdB1ySQRd4sxQFvo7XNlbcxm67ZMAnN8XqPcLFVN43V72Qlc8pMx3X1+WRybqhbex8X8FCaLc9OhMlV+DSZOFixYp9yu79sN5GLEaVF7PxIQrMIrUFFgs5IOKt2v0FwHdca92bAdTnDFskTd33TSpYZ/PeKFTHZxG2Ac18aJM4yiFZQE++Ds0m2vagf1BfnI2k7QXMW1wZonT8HtCmlzue8bdvYzP2cs7oRveTfDx1WMKZ++HNLYA3r+V65Mr9yEBrlaX4GxDZ2y2Ti4u5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by PH0PR15MB4334.namprd15.prod.outlook.com (2603:10b6:510:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 16:52:49 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 16:52:49 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYWY4Q62zi0Q79MUyPBeRhACU9Yg==
Date:   Tue, 26 Apr 2022 16:52:49 +0000
Message-ID: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
In-Reply-To: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede73afe-ae95-4134-c175-08da27a5329b
x-ms-traffictypediagnostic: PH0PR15MB4334:EE_
x-microsoft-antispam-prvs: <PH0PR15MB4334A70F16E5ABB5490203CCC1FB9@PH0PR15MB4334.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bflbpwjaPzGbSgop5h0eR48iqxZI7Ow4U/i0qgC2Hiqr2ywINS0Ebg4WJ8Cpd1pvK45kmZFI9h1UDD+IUKSfGwz6L3473YjjCSOiRV4H1Q8P4ZTcaiKffPmxfcgd38V2fLcz6aUzFFoEkNYcTsfuWyZFDbF/4CNsWRsyjBlFtrRX7nT0vHeQOqSv8CEh4itScauZtCIXYWkfUaQjKS2qUioyITtq9v/wCpaXGj5NueCcxOBDP/WN6Q6qh68CPW0dC7SQ4Y7Wp7KxpAPyf7ris6TzQXIPOQ5+IPhRK126sn6UHsuL+YCDLLnaMoryV0bk6b8rOFLIUzaQnK64PXoVjWG0H2g+uNqVlM5/2FqbsFKsiOGeYSFuSyDVFxVGGzCw5iXZIbVlqd2QNgmnCst9j4oFOb0ANNg9726NXTaY1PHnM566sxSKcbM0I0MtZ0h0O7YrmaAL/XOmFmqMGxIfGQ/ZT0rmEud39CwhCHCxECYLXV25oBZOih6/0IfXYse2XYC4xKe8hBNltidCVmfLqOigKXOJk70rEeAdF7sTSYAO5w5p+iC/Dmlm95MnU+l0yc5EBugwf0D8vBJGQjfRu9sLVFXMnxBpjbE1jewouClm5Yd5fOfXozTzR1GU5OXXejgoQsw8X1VVEQrUxzy5OK9JF48Zbm+CO0wgXmgdY5ENx7peU91vkoQwGo9JfEjn8eyQcLAIxBX0SPTFXCQvY1T1CRlXCSU3qcalfes+8p3+KAn9/z/XO0qYnao8/afe3VdXPT8hxZaYpqkVRWJDIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6512007)(71200400001)(110136005)(66476007)(91956017)(54906003)(2906002)(76116006)(4326008)(921005)(122000001)(33716001)(38100700002)(38070700005)(6506007)(86362001)(8676002)(316002)(66556008)(64756008)(66946007)(26005)(83380400001)(186003)(6486002)(508600001)(5660300002)(7416002)(66446008)(8936002)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MHUYIhiQ9PxS0Zjbbk3q7Lj6Xgts7F9ApjFipQzr6jknooI+QNCSkQOsYIV7?=
 =?us-ascii?Q?G2GeP1UvBecRtrKj3DdjdlKE/CNiVCFO2Gyot+Ak6SGBsSgV0k9fWCy82+My?=
 =?us-ascii?Q?8utweuerYq27q8QSQHbCxbabsvENeholWNjBN6TUJE4JZ32b6bE9Gs8sEcGP?=
 =?us-ascii?Q?QsAajJolQnBgGVLCgIcsQagxwzJv5QH/05DvJ+TcgMDTkcLjSSm6O7gB9Lt6?=
 =?us-ascii?Q?MsMQ3syJB/LEGmTmXJyqMAfMhgCUbgm418bl9Fx+G46tYAyVgAXJXWWZVuPH?=
 =?us-ascii?Q?re/mws2MkFCxxB3oowvXmx7epgaALOzDDfPSfvgsgSogd3zJ1Mcg2y9HjhTo?=
 =?us-ascii?Q?b/O/QMMAdjZ64K1ziO1/Ff4hPyPzn6ZIJhb9VB0NHUnbHYkfvDeFiPNuDFOn?=
 =?us-ascii?Q?zh1kftYDZDMGvEAD6rq6MgxNOHg9e248Wf5ecrCGRajZrXJfRXVO62z7t2vt?=
 =?us-ascii?Q?+Qwz2TwGAOsOpzmTPjnKEM14A++7NJQQCybliM9LLpPg6l0eh/a36647bupc?=
 =?us-ascii?Q?RBQAuNBHDHermfnmJcLORsiOQELzd/THNpKdW65tuyz3Y+TfQcl4m2LAUMdB?=
 =?us-ascii?Q?xQdrVXy7MEkqQKKi+ahi8gUnWJJzIhuxXkUiKxhp3jKu60j4auj+FAIHTBYC?=
 =?us-ascii?Q?PIJcFMmbcWFyODgewx0lxQlv8MaGBfChqYG68D00l+2Sb6nAkfQK+WgKUxnp?=
 =?us-ascii?Q?Wq2JRKv4VWZOEw80UePtp68Izik8Y6XQL71M2GDfUEQKICLccJlc3ZrAEuwA?=
 =?us-ascii?Q?fN4EeY/wOCzwkENKISfFF5ntUQ2eW5PDNfDp+kVK2N1zzWHCXMClxdW683vd?=
 =?us-ascii?Q?lpXJr1avfRPUqrDJpbM0qhyZeP7l1tbIZhm/W88tOHmaCZ4EKE1V2/3kOSmz?=
 =?us-ascii?Q?zPst4KqhRXpwXjkk8qzPYjd3nag+K3Sv+NHh1HWurK+fvHD0/hKzbNGat8hw?=
 =?us-ascii?Q?CITOxiLROLMvjd3TQpQDLIFCuDxcl7cH8rIuesDBwDypuhAybnJLIH3ByA+Y?=
 =?us-ascii?Q?NuExvrN5KJVcdQU8Vh2JnGjZlez3Z9KcUdfoOxGfUlDz62xVd2mZUPp11JKp?=
 =?us-ascii?Q?Y3BDuWSAy+qwpUIdfGDLvCvZBDBrx0PjwvNno2bFwd+PlNP367vCrG9ItHZE?=
 =?us-ascii?Q?8dY3eInGBiuOm6cG3MtQnMrHv6yreLl/i/V04P66gRxl3iMT3Qq6+LKReawv?=
 =?us-ascii?Q?iDuSCaeTh4IpjeP75WQBSpm1Fmgrt+x/6jIkOjuesC1AHD0f49NtNzuEvFMv?=
 =?us-ascii?Q?57bAeMIgSuPfxMbLBCg8VhIgdMtmeLO84QFWMRhiIPyIEbXTQ5/g4Z7Hpfuf?=
 =?us-ascii?Q?lAhuEfD9Ht9buEexJraZ9kSD+0p65nlRlnmv9AY+LlZccIGlOOSM0eMIu1BR?=
 =?us-ascii?Q?+C0PQQYeaMBlN97zdV/FlrZatm4T7x4jzhCtbdS9mKb66hCGDKRHQb+LRimH?=
 =?us-ascii?Q?jH278HjMOO7AVgC6KARWmUyg/sinMdQUCG06C31TxBF2XBGP9Yf8FhYzA3+x?=
 =?us-ascii?Q?nhesgFXd2rTLTks9ddX5CU9OGZYqOt+y7s43j8dtk95B0w9VXMGuIXtohLVp?=
 =?us-ascii?Q?vUmlty6XV8A/suK4z8L55GCwI+bDeFVYnC8By+5+Nl+OdKsqPU+xAhmPzUK8?=
 =?us-ascii?Q?zZ4XsE/pSH5E43hlCLLjHIpz0JUMBWJXRbdLxy0f0dacgriGHNKAIKbtcYI4?=
 =?us-ascii?Q?uvic7OCHSXLNjpubsHyjg+OxlHkImV2rqQFiBnbDOaS3dP5jeleVYu6qGksX?=
 =?us-ascii?Q?DgoK6h2NyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8040CAC0FC1204989BF19C7539D9C36@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede73afe-ae95-4134-c175-08da27a5329b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 16:52:49.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irerWQQEBW8Z6t594/F+FTOYXincSJgrtG0Y/atuVrnOfxzMnimUwoaOVA43WxMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4334
X-Proofpoint-ORIG-GUID: KaMt9SVpsfgVlxrMmEXKJHXtP4gCoWVw
X-Proofpoint-GUID: KaMt9SVpsfgVlxrMmEXKJHXtP4gCoWVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
device tree, so the IMA infrastructure is extended to allow non device
tree platforms to provide a log buffer. x86 then passes the IMA buffer
to the new kernel via the setup_data mechanism.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
v2:
 - Fix operation with EFI systems
---
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/uapi/asm/bootparam.h |  9 ++++
 arch/x86/kernel/e820.c                |  6 +--
 arch/x86/kernel/kexec-bzimage64.c     | 39 +++++++++++++++++-
 arch/x86/kernel/setup.c               | 26 ++++++++++++
 include/linux/ima.h                   |  1 +
 security/integrity/ima/ima_kexec.c    | 59 ++++++++++++++++++++++++++-
 7 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..bde4959d9bdc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2017,6 +2017,7 @@ config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
 	select BUILD_BIN2C
+	select HAVE_IMA_KEXEC if IMA
 	depends on X86_64
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index b25d3f82c2f3..2f7b138a9388 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -10,6 +10,7 @@
 #define SETUP_EFI			4
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
+#define SETUP_IMA			7
 
 #define SETUP_INDIRECT			(1<<31)
 
@@ -171,6 +172,14 @@ struct jailhouse_setup_data {
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
index 170d0fd68b1f..cdc73e081585 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -186,6 +186,32 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_IMA_KEXEC
+static void
+setup_ima_state(const struct kimage *image, struct boot_params *params,
+		unsigned long params_load_addr,
+		unsigned int ima_setup_data_offset)
+{
+	struct setup_data *sd = (void *)params + ima_setup_data_offset;
+	struct ima_setup_data *ima = (void *)sd + sizeof(struct setup_data);
+	unsigned long setup_data_phys;
+
+	if (!image->ima_buffer_size)
+		return;
+
+	sd->type = SETUP_IMA;
+	sd->len = sizeof(*ima);
+
+	ima->addr = image->ima_buffer_addr;
+	ima->size = image->ima_buffer_size;
+
+	/* Add setup data */
+	setup_data_phys = params_load_addr + ima_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+}
+#endif /* CONFIG_IMA_KEXEC */
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
@@ -247,6 +273,15 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
+
+#ifdef CONFIG_IMA_KEXEC
+	/* Setup IMA log buffer state */
+	setup_ima_state(image, params, params_load_addr,
+			efi_setup_data_offset +
+			sizeof(struct setup_data) +
+			sizeof(struct efi_setup_data));
+#endif
+
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
@@ -401,7 +436,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
 	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
-				sizeof(struct efi_setup_data);
+				sizeof(struct efi_setup_data) +
+				sizeof(struct setup_data) +
+				sizeof(struct ima_setup_data);
 
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c95b9ac5a457..8b0e7725f918 100644
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
@@ -335,6 +336,28 @@ static void __init reserve_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+#ifdef CONFIG_IMA_KEXEC
+static void __init add_early_ima_buffer(u64 phys_addr)
+{
+	struct ima_setup_data *data;
+
+	data = early_memremap(phys_addr + sizeof(struct setup_data),
+			      sizeof(*data));
+	if (!data) {
+		pr_warn("setup: failed to memremap ima_setup_data entry\n");
+		return;
+	}
+	memblock_reserve(data->addr, data->size);
+	ima_set_kexec_buffer(data->addr, data->size);
+	early_memunmap(data, sizeof(*data));
+}
+#else
+static void __init add_early_ima_buffer(u64 phys_addr)
+{
+	pr_warn("Passed IMA kexec data, but CONFIG_IMA_KEXEC not set. Ignoring.\n");
+}
+#endif
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -360,6 +383,9 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_IMA:
+			add_early_ima_buffer(pa_data);
+			break;
 		default:
 			break;
 		}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b1744215e..f58aed7acad4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -48,6 +48,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size);
 #endif
 
 #else
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13753136f03f..419c50cfe6b9 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/ima.h>
 #include "ima.h"
@@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
 }
 #endif /* IMA_KEXEC */
 
+#ifndef CONFIG_OF
+static phys_addr_t ima_early_kexec_buffer_phys;
+static size_t ima_early_kexec_buffer_size;
+
+void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
+{
+	if (size == 0)
+		return;
+
+	ima_early_kexec_buffer_phys = phys_addr;
+	ima_early_kexec_buffer_size = size;
+}
+
+int __init ima_free_kexec_buffer(void)
+{
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	if (ima_early_kexec_buffer_size == 0)
+		return -ENOENT;
+
+	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
+				ima_early_kexec_buffer_size);
+	if (rc)
+		return rc;
+
+	ima_early_kexec_buffer_phys = 0;
+	ima_early_kexec_buffer_size = 0;
+
+	return 0;
+}
+
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	if (ima_early_kexec_buffer_size == 0)
+		return -ENOENT;
+
+	*addr = __va(ima_early_kexec_buffer_phys);
+	*size = ima_early_kexec_buffer_size;
+
+	return 0;
+}
+
+#else
+
+void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
+{
+	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
+}
+#endif /* CONFIG_OF */
+
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
-- 
2.34.1
