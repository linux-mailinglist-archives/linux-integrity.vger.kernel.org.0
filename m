Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E61523012
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiEKKAT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbiEKJ7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 05:59:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22891DEC60;
        Wed, 11 May 2022 02:59:40 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B3LOc5004358;
        Wed, 11 May 2022 02:59:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=PrZjvGBgroFAvE05FcqoqbtsVKVlpsnVpczHpUQ9QC8=;
 b=gXroE/Q0w9LMiUP919E8MjnxmXi9PZL4p7bNnpF6cnmLkcBG6IDOlpVRj5jgh4VyH0bx
 OGuwBn1QYIVSABk23hzGE5I1xAeFmxNrcozyOl0ltxtjB5Oyo2QnF/dHd6Dwvi3m/NUq
 /Ax9uZhnCF1kWP39mYvtA7qmfxZs/voiiGY= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hhghh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 02:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU/r46DjhRLCp8BDb/BtZLFaraFFRPKJrdt7Hu1yC3GRqJNQMsa05eL4b5MMI2HKGCcgcDdgiLQvm4KgMkwsDbP4C69U6JO5AVWR43s7wLb3tT5MsckED2AOnnr8bIyf7fKti4NAqsI5oiNvTXzjiPPREue4Pn3yVwK1zFY1m0ECDSyyvwJ6CTiIMLvuERVySHz7xo6jjyFKFMEDQRGkSD96s0Nf+1lx+b/dzjqRsteTSjg7L5S+/XqUcctATcaRiu6GFnKaNsB5CInfpBWpFWnCh1qjOX7A1h2uX1TKY8F+Ai/ZOorH1fJdMx7kCh/lYNIxUsK+kuvU/UV14BafZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrZjvGBgroFAvE05FcqoqbtsVKVlpsnVpczHpUQ9QC8=;
 b=RExCNF9zrP6IMfftXJstplcLsmqgg1mHGSL1M+ytRRRRVh0TgQF/++hkUR3KW3IfKZbj1RliEG2RFr4YWEtPZO8/mKO7tIVFpzipFZqgT3eiEl9/II5sGfbHfQDBqg9rGHwXDsXuXotwlmzs47FhihI+2+SOp++Pos/7chokTynfnltgn4mmW71kL15hfowpGq1eOMZs6u1YAH5Ut6R9Z7+oER2fuqNIfMfe2m+ubZb7fXF27FRI685L/huhzdbKaJFxvDy1rlAh85IKJ+t3eTwPsMtyb5PO5QFh693UyIowOtd8dZGBaeXPefef+UeKkZfgI9baS0avLf+tpI/3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by CY4PR15MB1368.namprd15.prod.outlook.com (2603:10b6:903:fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 09:59:37 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 09:59:37 +0000
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
Subject: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYZR3SenooBtbIkkixHVw6lrlZMA==
Date:   Wed, 11 May 2022 09:59:37 +0000
Message-ID: <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
In-Reply-To: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b86e19-108f-4400-db46-08da3334f540
x-ms-traffictypediagnostic: CY4PR15MB1368:EE_
x-microsoft-antispam-prvs: <CY4PR15MB13686DF36BFECFCBB0E96D1EC1C89@CY4PR15MB1368.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJROBiy17hP/xpTFgQLd+hQMYtp/yXk5Z8uFS3hp5rOS1a6PP9kBc1SqGUu5inofm3V0F/aD22ykdCbvz1YK/RbDoeMTJ4XGCS06+1ahKOIiBrYD5z4WtK8+0c4dsNWhxurpUoAtYs6IcxNOha9v+f5hNAtW7QLpv3RwL/SBZvjolLcOeXtuooOfQrj57g/jDGQ84Ute33ChGwZLTKKOkPKr2qu1D07AWJekBh7bj9+oS9R+HZRBNI38Wf8g4L5VnpAbvOn4tpPufbhmrSa86Vjg4OxHFaCCUimtE312ZBzSM1OzJX/VOAkRj50gX+0+DOVxSFwsRyowUHoIaFswZunlPkSdwQQ1i0NFO9iz+jrqWG13yYv5K4cMXiRdwvvw4Acv6EnAz2VNhiN8A4myYaXR+fg/vDCeIYYdXJn5+a6oq7D5kr4pKPGowi+RxI+63zmX5ZG4EPRqqnMiORKjoZx3opGwE0YYMbFrtwEzPhnISzUg30ApVoR6jDuvePUjFdZnKbTaRcgdvXZEYz2LGy3FXeVt/ufFXhF1OD/IHpb5vzYw7WD3BXQRgjn8K8qEVp3C5e1ebkaTDCdlTZJUvF2MycsEjRmOmx8LlmrEdCLkxrkhK6GlNsNfYAy41DCvthsBOADmDPWyRf/xM3dHwTtyoKgc7IRwkcAh95eButdp4PpPvjaAym19dm/6LEnanxU7iEFdZQuU3m+1yUkaxCKRgtj59Dj2eVagH625lBH2J23KT16AP3rhxp/wfdD/+20hC36fC8GdaC+XCpgCVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(7416002)(66946007)(2906002)(66476007)(91956017)(66556008)(6512007)(6486002)(71200400001)(86362001)(508600001)(66446008)(9686003)(64756008)(316002)(4326008)(8676002)(6506007)(122000001)(38070700005)(83380400001)(921005)(38100700002)(8936002)(5660300002)(26005)(186003)(110136005)(54906003)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?per9JvR5sAF26pejPXPgkPN4aJiokBBBoDU4vALP9GpgA0rcKDz2pYrj5j81?=
 =?us-ascii?Q?hs0D/CajVnB5DUABYgOODyMhIcQieGqNac0rjLFH7DbpnW0+bLwvCpTkHPfq?=
 =?us-ascii?Q?LITIkILc7QCnkB6Yzo/2HcU61MD6TYSLMsPnrYIQ6NTcK6NDLh7t4s5NYvLM?=
 =?us-ascii?Q?L/2kuheKbRNpMpoFjP1RIJQ7GzskBdAjcUGwLO53l8Ax7HTYXfHYJ7tZWF8h?=
 =?us-ascii?Q?Q8HqeZdyYFAqrapJPmZDkHJqct/4yxRpp8cufIalhoKmonNdMec0R2V61qeM?=
 =?us-ascii?Q?gNmuWztn90oZfTlSj8j3/lOEmtdi0FPm1uWdIN/yAOPVq5l5kxugoqLc6Xoi?=
 =?us-ascii?Q?p6vxRT/ubtz1pflj/mlDkh5KuUA0/YOKojbtKnDiYbXtDWhC794hVhVFWxA3?=
 =?us-ascii?Q?9JNsFVdpfAq9rlCeDD3zwVFSOhL2zLTfsCpGey/rzQnIO4O5Ruk3Ls3XB/Ek?=
 =?us-ascii?Q?cRD08J6wVGG+b9J8mY0aDojLYIl+Ma3dOiZtmN6fl9/1Cx7fViNX2gyDYntS?=
 =?us-ascii?Q?8+FrKHx1IUxsl51P9+IIMADSOLicmDr3krvZ1JdxTyFMMa21PrCSPZa68/sg?=
 =?us-ascii?Q?cXJlou9a6J+AJIIbZu4ZCpYmHvTihh6Jp3kclm2VkRq4VkBifMI/Qo6TUR15?=
 =?us-ascii?Q?xMuIHsl6W1iE8Ol2r1j6Xdv65CnbC2fBT8jMDRbj1R826Go0NedEc0dVmK0i?=
 =?us-ascii?Q?tlauJHCpA9nhXxVIcS8daM+WAZ9BmiDxoCGGeYWayu61S8rvE6oR4fFCTbEs?=
 =?us-ascii?Q?53hlK8eSZgobbwZ/U2Gcl43Fw+wtn81sRkY1MD0R5sCoqMfIHgzl1fKG2NRn?=
 =?us-ascii?Q?fahm6t6mceYjj9nLeixoizCKAUTYzwlrDxQ6IhbeeaFk2qp/9izgwJxMdt0d?=
 =?us-ascii?Q?YLDY2+R4C3SkZ1czdyi+C2RvzGbXzksO+Ym21MC/PekEGLjDSFM78IoXue5S?=
 =?us-ascii?Q?sZFyvTLWqplzmy+/Y6arLMyfNLN3QhS7rQY7cWedvF0+GJ+ZL4oCeoFASZoA?=
 =?us-ascii?Q?Wr0yL5ux0QP7ALyAu/qQZVUB1cQuH7yAdExDvEwy2FY0kKpd3UwcpdKEC5bg?=
 =?us-ascii?Q?Mb+MYAe0X4L3LSpfO/QwcRIKTd0E90VkmKtAiRtrpGfoLVjmQu2KDJ6iqPuv?=
 =?us-ascii?Q?eRwmjAAFBB4l2jeb+kLX6kC0fErvm/fVFCvgJQxInZw1z5WIiDGgs5GfVJaT?=
 =?us-ascii?Q?Y5u8ko0jERATilmoVBYSE49AGBMaN25NQ4WdY/xgODpDFUjpW5JHt+6D1CV1?=
 =?us-ascii?Q?nEk/LqwnmOfHtTsQf1jkASkeMqxtn3nTcouREG+Y0q2f1zMpYQavfoIrLyun?=
 =?us-ascii?Q?fHfmBS8gY2oVc1ipKmIBnrUPjqQVj0RZwBIv8UT5lhdAi+acMLbdecPOpYxA?=
 =?us-ascii?Q?dyvd/NAy48T6t2mYxWNle/7OP3hk+yIGH1NlcM/vrUlyyJUwoAJmRCTskomG?=
 =?us-ascii?Q?jks7I9sXKLTpLOVnmgnvr5osXX4ZpaWXz4G24shoGBOz2Ayet2O4n/Ml9bfi?=
 =?us-ascii?Q?lKUYHL8AJ7aG9It+VkGlT7abk7rx5BqQOsUGcOAjSKPgKGgDFXWEIWA/4Qbw?=
 =?us-ascii?Q?Jvfi9+NqkdjPJwnz1faZcAYzdzv3bE53PfwuZYln9ziTfWFUcfm0MWewoAIT?=
 =?us-ascii?Q?ZkD2VpVRXX8EzIo2KESUV7QBMXlPboCvrsz4CNuQqS2EQ8RcJCkPaDqpp4n9?=
 =?us-ascii?Q?EOJ0dz6+j7x6NBRRdyBRgmccs+cDv21OBsA5e+YRs7cmvw4X9224KKn+dgj/?=
 =?us-ascii?Q?+ZvECEP3WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAF2FF08BA568A438508A94999E26DC7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b86e19-108f-4400-db46-08da3334f540
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 09:59:37.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EspkLo4qqHyDe2aEBThJCCdrC7K+Rzc29InClflpN+IS7Ix1RNF2t3O1yA/mDYXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1368
X-Proofpoint-ORIG-GUID: EvNtbLMbMhVm-Pl1cPTv3Kp3YxAJ5-pm
X-Proofpoint-GUID: EvNtbLMbMhVm-Pl1cPTv3Kp3YxAJ5-pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
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
 arch/x86/kernel/kexec-bzimage64.c     | 38 ++++++++++++++++
 arch/x86/kernel/setup.c               | 62 +++++++++++++++++++++++++++
 drivers/of/kexec.c                    |  1 +
 include/linux/ima.h                   |  3 ++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1320d9a3da3..594636f02da4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2027,6 +2027,7 @@ config KEXEC_FILE
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
index 170d0fd68b1f..54bd4ce5f908 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
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
@@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
+
+	/* Setup IMA log buffer state */
+	setup_ima_state(image, params, params_load_addr,
+			efi_setup_data_offset +
+			sizeof(struct setup_data) +
+			sizeof(struct efi_setup_data));
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
index 249981bf3d8a..ab5e7a351845 100644
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
@@ -145,6 +146,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
 __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
 #endif
 
+#ifdef CONFIG_IMA
+static phys_addr_t ima_kexec_buffer_phys;
+static size_t ima_kexec_buffer_size;
+#endif
+
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
 int bootloader_type, bootloader_version;
 
@@ -335,6 +341,59 @@ static void __init reserve_initrd(void)
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
+#if defined(CONFIG_IMA) && !defined(CONFIG_OF_FLATTREE)
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
@@ -360,6 +419,9 @@ static void __init parse_setup_data(void)
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
index b9bd1cff1793..74fdd490f7c0 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -9,6 +9,7 @@
  *  Copyright (C) 2016  IBM Corporation
  */
 
+#include <linux/ima.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b1744215e..dc6a59d61a15 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -140,6 +140,9 @@ static inline int ima_measure_critical_data(const char *event_label,
 
 #endif /* CONFIG_IMA */
 
+int ima_free_kexec_buffer(void);
+int ima_get_kexec_buffer(void **addr, size_t *size);
+
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
diff --git a/include/linux/of.h b/include/linux/of.h
index 04971e85fbc9..c2f58d2e3a0e 100644
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
2.35.3
