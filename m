Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E397525278
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356509AbiELQ02 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 12:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356234AbiELQZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 12:25:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708A13D65;
        Thu, 12 May 2022 09:25:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CD3Q8S011385;
        Thu, 12 May 2022 09:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=MzFNaqVCDMdllBnU8TBqgdAWeVOMqWX9vccwO2+sZXk=;
 b=GC9I13SlQf36Vq4PVlwAr0mdQHCRD+4YjYUDZVzxjsBYFCRDNc2jTEsQpjNwDYSHLLFv
 K2RerA6ST6QPlUG/6bAUGHMUIAh57KhKMH8a5D35+RoiXB01nE1NDGMzmH8ZPwj8i61b
 NltSr4e14KQuEh1Op1g48HXZZoTlhGfFBIk= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyx2neec9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 09:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk4Loaipb9fSg0GMxh04RgdDadPNwOUqA+dHq1LI1946agw8AAsO9tNm7eG+so4EJ+BAi/Qg42wcWtgidrnRYZqonnuCLItcqcWbt/HKOx7DDW7b4G+mQpvy+QqbgLo9lJLblDfvGvhAKN6mm5ZcdngS9tzsZfr/WvSCBavdUCfCIWo6e2M55NUxcl9SuIuURuiNcZxA7sJNDY0Gn5ybSeYyRu6q86lbjs6gaNZZzsppcVe2TXibaGOtxFMRcLS23gvecFS3547Sn8pMEZ3lXQehXg5xqJaCMov/Nqxz2DCcBeQlwE4qkq3bgYqQnvdDFR+cjo/JbAizv5Xj5DO0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzFNaqVCDMdllBnU8TBqgdAWeVOMqWX9vccwO2+sZXk=;
 b=QJHMPo5MFAxhETSq7L7eNNBY+Q2MIA+1I7mT5nWExsMIwcUZJAUTamDjJiBd3aPPUXlynprr/OjV6xf+QKiIBWSrARGoSE5rjBpykGJreofSRhR7HtpvQD6Bt7DUKrJaxu0g8ssMyLMRDjrFpTu0NkNS5mFiosl/ccp/QwOZ/po85JhouOfVoOXpqc3krXZbA5MVAdg9g7aKV8MQL0kn8+C6CQPeCNrOrOgooCThkbISwhoYI3ALYDBd4fEgLWZRytbwVnvfqkKdPFj0P/7ssUka57mKPN7aaZGAY7rubwCS0hIWulwUZ4mt8SmNIvZWclItALru3etUFt4WSXyLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BY5PR15MB3650.namprd15.prod.outlook.com (2603:10b6:a03:1fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 16:25:50 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 16:25:50 +0000
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
Subject: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYZhzxVqT3nOkmWUWyxVUnnMcrjQ==
Date:   Thu, 12 May 2022 16:25:50 +0000
Message-ID: <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 876c2a9e-247a-4707-7086-08da3434143a
x-ms-traffictypediagnostic: BY5PR15MB3650:EE_
x-microsoft-antispam-prvs: <BY5PR15MB36502E6BD062992C9BB7ECBFC1CB9@BY5PR15MB3650.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRZVJOEHLwCUiIJD5egiRVfpvs+gn2KdRW0jWA7jq0G8CoIddZf+LvJwj48R1nFruQFRV7nWbfSSDGs8R9MWpx9M2tlyM+1gSndKS9JuG3XWPwgvtCYOaB/k4oTK8mvTe3d0NJzOmteP5B83ijPLoFXiaeibVXya5uSNy+OCoGoIEX8C4D5B9JcE1mb210k9axTuaaHQpXVxHqDr6c0vTTw4mn088m21b68bvV+vcJlrdf8r2HKrbvWz4LExqgcTATi2VSeapHE+y1uUvTiuJXSB1B7aF0pdVlGN13vTGMTSvN1zIMevFxBLaSn/1YLz5+vi5Zk9F0hm6sP4g8+x7zXA8hzjs2dfC1kUxcYddItsGlrxBSKxh7yHHV1CLASbiMJdYkpHaJKMQCo0WaBSE5R9tmbWURZdcXQUsWiAzvv567o9tZS790oYW6UMfU42kAaz+8vuOlQXm7hmq/uRIle/7sZar6HBO39ZyEmf6kRGiWH8a7x10L4NWq3aJVgr1NjMTTtdTDdE+0irSKN8cEL907gL2g2Omi/hU1QeMI1fW7GbPDrRFaZ0YOu6g/0TwIq4bX95k3ybizYvW0VApTxqR078VXTsWaifqWAeDKQnkQDKaduJudBZxwlJxLaHZvvIUfmFLgyczYp0WpvV2EM+xJQNfpGzVPkAjve1OHeZKYZMkxU3AibSMbApJAY9L9jljSxSbxi85ZbnEYDcVeoSSFPfbTb9mnqcAZ5sfBdplDNJv21ZdYYOV5dFc1cQZ5oPRCgd7mYKW4gHUDDseA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(6506007)(7416002)(2906002)(5660300002)(8936002)(6486002)(38100700002)(91956017)(76116006)(66556008)(64756008)(66946007)(8676002)(4326008)(66476007)(66446008)(508600001)(38070700005)(122000001)(71200400001)(83380400001)(26005)(186003)(6512007)(316002)(86362001)(110136005)(921005)(54906003)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gkB1H+/g5AmBEz3cdOwUDHaqpiX3g8SUZHKa+xXzgfytkoBEc8J2OAh/YGTA?=
 =?us-ascii?Q?QMIR9ybEvBtO8fx9y0i0NCqX4GnxU82i7SxWB4Oef7iCvoNfS8gOX53N2Mgs?=
 =?us-ascii?Q?CvLndWmOBHf4tGFokJlou43BqgplTDAfJzvwNWxsM0EOXmxc6dwFUHLtp98r?=
 =?us-ascii?Q?U40WR1i/0odpMXVt81Asgtws0QxEAF+pfM93/fJ8y8IWT9prurpQ3IAbgKQs?=
 =?us-ascii?Q?oJsh2WecmnDOhkreMRrkA1S91290psArvK0uGuAXUwfV5JiS+SFrEL37FuBW?=
 =?us-ascii?Q?/YmT5H/ZgqII4BuvPbf0nZruVEWVEUj5qi29QT7sDqkKk/KIuVsyAr7NH7RZ?=
 =?us-ascii?Q?HulZo24vLuNE2WBo1jti58Ux4Q9lul1zpzo4TAAmBBd2zklFpefZLxMdBs84?=
 =?us-ascii?Q?pPsWerNkDn95spwS9hpVkQmdKfQ8/I4MfT+zz0ZvkNvdKVY+CUBZ8cJGLwLm?=
 =?us-ascii?Q?wY6pPINa0KoDyPGP67KKmAT254B5ZfbPPgqiCs3RGxeAgAMih23T1Dvi7otV?=
 =?us-ascii?Q?f5uAU3G3Hx7QD22qyOe+xWccHxeTDnzpJb34ag+Q6S5jyRBPnzOLI9xYMqNI?=
 =?us-ascii?Q?xJt7Rf9B/zehtPjQibXzkBHOua+628wi7Wp/OlIYVUQchul2y8SplgHbyVs+?=
 =?us-ascii?Q?N6MQq4wSVBZMqbgSZ+tcE6pB2VcbxgE5GB9GtqkngOZ98WS+uBesFEh2IEdh?=
 =?us-ascii?Q?OFp6kedQxJleY6m+A0aZHwKq/YbeVWwrXHDLJFPCU+mrH7y5Zkxn9sGpySRQ?=
 =?us-ascii?Q?oVv5abJEKG27VyLO/SjnDFHWVj+PU9GhVFeO5Z46F/ayZ1zN7NrHcT2CLf60?=
 =?us-ascii?Q?Z8vytmDhEvHCcJPuGM2G2ORaKHlRv9AZdp5bCMDuI+v/uo5qrEGMCUBB45qT?=
 =?us-ascii?Q?X2v15O4Rr7IwyKbdkTy/hRM5qUiUhupx3xZrxX8migDScWSHNsXlEZdtVjFU?=
 =?us-ascii?Q?I7LupYNxfsKawXr+FU6EOBo/A3Gq0crfiRmciqjcgYJsH8k0TedXkhY1pU7h?=
 =?us-ascii?Q?truStqGvm0bppdcVd74gLXEeF8CEgvj98IPKFL5Z/3i/KBxlnx+C30oZsvqm?=
 =?us-ascii?Q?ZSyTCakmtbMWY6WMxChx7ppqPxSZ98qr/mDJhxkPQwGDEgZsnFrDJeI7Y45i?=
 =?us-ascii?Q?l9QPkyPQmLrtGvBPXOgyho/X1XKiY43NfJ9Ma9xviCc1/52RjUeyvVUvQSqC?=
 =?us-ascii?Q?DwIDPYrnFV8ieCsaZPevEgBlFRkBexpaX380zcebDvQO0o4twH7x0LqDKTlF?=
 =?us-ascii?Q?auS2oh0npRb7PFojefsVZARkhrP5ZwhCOy3k5KellQUsgIkMh6RuUHqnrB5j?=
 =?us-ascii?Q?Xfuq/wg9YDeODn2+v9ZcG4buJrk0V9/8QLpcC85jnIIazm36TEuMhJ39lkH0?=
 =?us-ascii?Q?7RJFWihGqd4TNy4pinRF56uHlboy6bdXwqpnqVaQz7ROaE+g4XB04NnCUx8V?=
 =?us-ascii?Q?Tw9aPdv7DGbE1EZQznjANqzHi/oF52xWJ1kyrV9GWBoxuBYhsEnnDkb19uEN?=
 =?us-ascii?Q?rrqlg7aZ/4wM6uEABSYEeMoB3FY1SRmOFR74QC5LNjZnjHYDmLXHNu4PIjVy?=
 =?us-ascii?Q?feYqkRNByC0XyeNw87lm5JIUA6BRjqGKkWMs6UHAPjQwLk2SJ4xPRAE24mUl?=
 =?us-ascii?Q?jLfHLweNBHz42/6M0Go78fX7e+M3kySD25G6+8LKkS+IEgGJi7KazE5QUKvD?=
 =?us-ascii?Q?uOG7hGUtxVdgqQEYrWwxcBoSiV9JudOApeJ/it7/cLtugD84FsYByJIqPoZX?=
 =?us-ascii?Q?fdARP++11A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB89D6A19497C34CB7F3CCB32FF415A6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876c2a9e-247a-4707-7086-08da3434143a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 16:25:50.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /o8evXTZlpNteZ1OMy8ig0745rJTu9DwsUUUKt5piqQ+lZn41czCMtfPQkXp28bh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3650
X-Proofpoint-GUID: lR3suiKvbeQpoibWR0XFcBtygbz6-3Oy
X-Proofpoint-ORIG-GUID: lR3suiKvbeQpoibWR0XFcBtygbz6-3Oy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_13,2022-05-12_01,2022-02-23_01
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
---
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
 arch/x86/kernel/kexec-bzimage64.c     | 38 ++++++++++++++++
 arch/x86/kernel/setup.c               | 62 +++++++++++++++++++++++++++
 drivers/of/kexec.c                    |  1 +
 include/linux/ima.h                   |  5 +++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 120 insertions(+), 6 deletions(-)

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
