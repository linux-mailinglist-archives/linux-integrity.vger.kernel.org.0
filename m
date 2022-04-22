Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7A50B91C
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Apr 2022 15:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448209AbiDVNx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Apr 2022 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiDVNx5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Apr 2022 09:53:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A758E58;
        Fri, 22 Apr 2022 06:51:03 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LNWhG6031206;
        Fri, 22 Apr 2022 06:51:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=9VsBEUOQNsP4nfVcXVVZUgUvvFzaO9ok13WxJ1gI1Fc=;
 b=UxqohwnV9RNI0pkQVtZvGy/3h9GYcftlEGrElNtcH0in4JxG07U5/+uOFW0g1AXHNiR1
 MaYEGcUvzMQYooidzRdzWhE5huAh7a+l9Qjbt6GnSbX2lG+JBcmI2AVjZgbM1k2G01zk
 BfdceP7jaLgB5VLWijfyX6k7v8vDPOL6D7Y= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fket44hnp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 06:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFA4dij3UQ+kb5BeeyhBStCA+NE8PloVvIbqHFuyaMh0jDtakfr9pyKWeJdgRCkZsPOEN508sW+wsVMxsrY8V793gZhodEUNQc/OaHpDotvAO+uo9XXwXcWH9TOqoPQrpV/SQqJzBZ3dq6Qk848jNwzyfozo2laYdd+YB0nJX6dTVr0ub5L6+1WHTIV77Wv7Q0vChmG899ATajLLBtnN2avWMW/Csz32of9Qhdg+9ZXE0R0wVyrKipCaKZlx2QS4RpG9QirkLrr2FeR8rSHwWAgHVpHWTqv3a0X1AM9efYBiLsM01fja27j0k9PBjEWDXXwsIwMfaIJw1TLKsjpbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VsBEUOQNsP4nfVcXVVZUgUvvFzaO9ok13WxJ1gI1Fc=;
 b=IlMO1UZ+8a9yTtbHfKWIE3oO4hhzTUKrTRVsdnSDKKauQY9DEgwFO3UEL4L3Toq3DcKCzxAOL1GhZqF/o26uuFAyKWlU+oNSLXRaDfzmuLTuxBBjPhfPE6JGr+XGOIDDAltVoKNkEfTwnPQ55Q+OV/ZZ3QWlAIugKRvQCWYl32JZkCzXJXYRaIMjP81cjsUiEaI98N5XtwGKPB42lJJ2hNyW/0AoFOn5kK/NuO73bnLOzduGxlgR57qO6MZ/H1zlbNdSfIS/VUELw2spj2MLA+uir+pyFd2GoweDXZEn7R5zMNI9SvM7rz1KQlAVonOxaC4dfg2g15VemLKMgmSmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4545.namprd15.prod.outlook.com (2603:10b6:806:198::7)
 by BN8PR15MB4244.namprd15.prod.outlook.com (2603:10b6:408:a5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 13:50:59 +0000
Received: from SA1PR15MB4545.namprd15.prod.outlook.com
 ([fe80::ec7a:9302:1175:a766]) by SA1PR15MB4545.namprd15.prod.outlook.com
 ([fe80::ec7a:9302:1175:a766%5]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 13:50:59 +0000
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
Subject: [PATCH] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYVk//Rm0WwwIkeUGnwDIT6Grq2g==
Date:   Fri, 22 Apr 2022 13:50:59 +0000
Message-ID: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a835ab2-80ef-4198-f320-08da24672201
x-ms-traffictypediagnostic: BN8PR15MB4244:EE_
x-microsoft-antispam-prvs: <BN8PR15MB424406C65F7E72A44ECBBF77C1F79@BN8PR15MB4244.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coqDAv4KP+764pdayxr5n5UsvbFIDlzWEZ+i2JGtyY4GmhvReftspjI0nAvw9wil1LWLZn4GvYCwXgQ3S9Rky598YdiSpozaP49qfEb5RREvonr3ZUOH8LUBFYFqIhsEH6XzGaUqRWUKiiu+8yZs3Dj2dq+VaG/eD5Ltx7jmh8jByZrlKFwHwY0jGZ54F1oPYFfxyCr6sHqrxbo9QjRFnIl/v/wAnxBLrA9ZunuFe+z3OMnewOczhBjYwV5DWkAa2WBaLU0KJW0/i5hLk4IZzNoB+QlcXD/Rsii2nFiO1uWhJmcqMdS3TtwalaqiLrzaP5lh20WIBhCsaLNPFTB6kKVMIV1rEaq0WaGpraM/D1pS5lYGMb8tJh8dtKJXHjCpbgbP+4JEUS4E7YWHN5rZhkmhYe+5PcJ0pHGxU4A/62xHj9rkNYR/iwqNtpEdTgaBPIaPlAX2d+trUaNMj7CzofS/27fNXBLkEYg3d9HyRmXbTV7+/8jZWepWotZjstHkA7QNiQzNt6ydrtOX77c9vd8jWYY/d4tUfMyj15dZiOWegA7CM0PgMkaFPK1AxWdJlQOd5vqCIaJUu/nlbucmephX5ywKFmDLjNOQqSocn7wDCZCCvv6FZcrv4WUisBXxPCrXx6zM0Scb5Biuyi2WomkZBlXeD7uzd3nzJtLyVyLrKrTfDWqSK2cQYVGFryy3XulaD2F+MFqSsaODKlE8fr4z4oQF8vZ0aVdPDXOqN42XDhHVDmJ0ZAK4/qYAHkbgxR5+pDTThQ2qb6b2DD1dxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4545.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(86362001)(66446008)(66476007)(66556008)(66946007)(64756008)(186003)(83380400001)(110136005)(9686003)(71200400001)(508600001)(6486002)(91956017)(33716001)(6506007)(316002)(26005)(6512007)(4326008)(8676002)(76116006)(38100700002)(38070700005)(5660300002)(921005)(7416002)(8936002)(2906002)(122000001)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6eRdCVtNplCoWfWj1CrgsNMIUqBrxXxlMsMDqRjNfB49zAIzyFugYDNvv9fr?=
 =?us-ascii?Q?focrdlzukO8rrS6VRNnWtSSGuSxTe9nXLd6rDJyYfFUjBV7TbCWculZ67vJ8?=
 =?us-ascii?Q?oURp26t0Ois+zzXkUc0nmfWj8PeyYoD8RT9oaOwCtTbv0Ce/zqjigUvs7xXA?=
 =?us-ascii?Q?y7JbZkTaehNGPHWCD9ZVzunMSpuMgPv68Yn8uXAQ/yjI9PRXJnlj4LBvwwjL?=
 =?us-ascii?Q?2t/jN0/QGJlJ3hUBO4VQaxCv3RqwWOP/+ae0+uufOGT+xfu+mIlcYmryEI48?=
 =?us-ascii?Q?f2FeXwBsuxiZt39C/mXoxFpnOyUjIkqvLeqI5QfKC4Y/DyztnBuqtQYJeRw1?=
 =?us-ascii?Q?0kgBR+zTWiV28Ef4fXfpGY/192vY25oY053BF18h0G/kr2w5pOGJwaC8hktz?=
 =?us-ascii?Q?rcarkTUSJKfexHuhJfp7Pqnp4NAJIzhh+v6W1V4ckJqY8C+dc4coh8RT/WCX?=
 =?us-ascii?Q?FiLLHXLyGjgYvteofw1onjS38LCVcU/z9/WXFLgRD1Hqf10GrpykY8lJsumO?=
 =?us-ascii?Q?XwPVQiCmwkMJ8V/tRE/zQbRkmRjsJA/7LrSU4zBUZCd5ogQ5TmzOT6zc/PeR?=
 =?us-ascii?Q?dV8ciUS4EZxUARAqnsIQdSNKZxllB3N1vVuTYPw05bghRvIasCUUTyTnXFby?=
 =?us-ascii?Q?Fqh4HwAi+mmHae1kHBgqwpwUKM4xmDvk1mhU2IYvuxqV5m79DArLM1OKesHw?=
 =?us-ascii?Q?TTKj5/kTxMuilJpcRtZEZ/AGibac+u2uPv0r96SXMt+oN5KVjn1qPpNlOXV+?=
 =?us-ascii?Q?vblwklXROJhfg6mRAXSBbo45Mx3e9WjTXDtT23Ic9vST4exGkJuF90EBzicU?=
 =?us-ascii?Q?7TNCbYIBoA9hAomNbl6sbh9j0aMGnwyv2mhmo1t3WKS+1+ewQhWLoANE1F6a?=
 =?us-ascii?Q?IN9znkcyiz9nBkkRgTdRJ8uyh/Jf5kswZqATw1hOxf9i6O4TdltDu9G+6+8r?=
 =?us-ascii?Q?VeVtOO/4Ed10SMpatmoAQtDpDw6DC0AOjeYLeFs/EnRuV/BSldP65OieHSoi?=
 =?us-ascii?Q?vBxrvcSL5Z4wGxAz39wRDTzcKrDR2NqNdR1d5dNfSylJc+y/Wf16JevFhDLi?=
 =?us-ascii?Q?8IccLaRfmdTHD/aIp9sbqhSw79nPlKaVfS3jUDraQI1EMD5XoGWcgp/rBRXK?=
 =?us-ascii?Q?hLLo5lN4h3z8dkWnetUj0IofawI210KVIQpHR8XstuUlqDeguz2mXCNQJVoN?=
 =?us-ascii?Q?vVjI5U4C5y8HfqYtBAhaTNoO+2JQJc4mVi+Hm6rtTXLZsHkvVSbqrPj+0n2j?=
 =?us-ascii?Q?udRozTI0kBIZGyJBB6OtxUxLQOBGojWSu+24moiyjaPU1lYKprWy8c+UkZ1d?=
 =?us-ascii?Q?SmqMBAx+lqKOj+rmwhY9dHqPY5hUBgYQBYog9zUERqRHxSQ17NLeehIxtcYQ?=
 =?us-ascii?Q?hr5kWsKu0HSoh+HRYan6BSzjsBTGHJ/sXf50wQZs4jpoUSm/LCV/3ud5HCbh?=
 =?us-ascii?Q?yW5KuO6qyhHjZ/QMuxnDb2qY9JJzx0CO+K2kouPDz8eoUVfcnm5CZnrrB8Oj?=
 =?us-ascii?Q?xmeRJdRlcMUBUEKhSHSIAUBhJtom2VMpXzphkWZf/+bVRqlFZCgKRC/ski3I?=
 =?us-ascii?Q?L4XgA/iU7PNTWYEeB3wdRnyZxRhSS8IogzHMrqtlr0mlJ6uKo1lVU3kflhoC?=
 =?us-ascii?Q?EidMUrKcXhDLeIP9eX8q6uOineGztgpPldB2R6Bv8NlizoJk+Y/Amr6wIAEK?=
 =?us-ascii?Q?F83z2oMB3ks+Q8ov2+udEoQ6spPU6rVkmZNDNOulvNYoRpo64K0wo+tzbLpf?=
 =?us-ascii?Q?E6bmQg5u4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4342DB23FDF96C42B98922E2D2DFF008@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4545.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a835ab2-80ef-4198-f320-08da24672201
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 13:50:59.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUDeEmsvBDaDoPxVfMvdN0r1yUgjyo50YvlnceBXqIWKSSiy1jLYXQC9VKFtt13b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB4244
X-Proofpoint-ORIG-GUID: Tag0HOYZFQhMJy3hlPR52YDOm5JEDJ2c
X-Proofpoint-GUID: Tag0HOYZFQhMJy3hlPR52YDOm5JEDJ2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
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
 arch/x86/Kconfig                      |  1 +
 arch/x86/include/uapi/asm/bootparam.h |  9 ++++
 arch/x86/kernel/e820.c                |  6 +--
 arch/x86/kernel/kexec-bzimage64.c     | 37 ++++++++++++++++-
 arch/x86/kernel/setup.c               | 26 ++++++++++++
 include/linux/ima.h                   |  1 +
 security/integrity/ima/ima_kexec.c    | 59 ++++++++++++++++++++++++++-
 7 files changed, 134 insertions(+), 5 deletions(-)

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
index 170d0fd68b1f..07625da33075 100644
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
@@ -247,6 +273,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
 			efi_setup_data_offset);
 #endif
+
+#ifdef CONFIG_IMA_KEXEC
+	/* Setup IMA log buffer state */
+	setup_ima_state(image, params, params_load_addr,
+			efi_setup_data_offset + ALIGN(efi_map_sz, 16) + sizeof(struct setup_data));
+#endif
+
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
@@ -401,7 +434,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
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
