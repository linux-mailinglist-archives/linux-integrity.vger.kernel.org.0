Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD73F561530
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiF3IgT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF3IgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 04:36:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037131DF4;
        Thu, 30 Jun 2022 01:36:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U0LfIt010118;
        Thu, 30 Jun 2022 01:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=d/vnZxkiNC6rOnYcQAFXUODpc0s8W7hTSTRZDX1vukE=;
 b=Tz32/+h8JVJKzbCuRmbndOGKcpVBJYGQh+R/PR4sSZWOaFRxwjCRRnWPQQo4dWb9NMRk
 oAuOZ3v5am8rhrp7TkIldxp/GUkNVaqyga7a+R0pxyraktEsLHV1mqarT2TKPaMl3lqt
 Xb/iMBP2vTcc1Pg8C1gK2eIWjwPfkrlghpY= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0tdsctxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 01:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWY1aigwZlyZDjt7v8CQHHxJYZfbmrNMscAm5APWpywkzWQ85tiLyKUgYPJbrRh7CwB7YCWX7lse2T0bhK5pCfWpnY/ZeGhxDsLyRrTEP6egf2iM6mNCerFNne777JObuQLcTalZMJfLuVv1xw9jrw3g4ppYg58V39T9ehu9Vt8orSfY1JAtEROiDgrGRE4fkh5/cWrKTLMlBeEWLpMyX/sXgIeRl795DTdnXaefEoHVFfuapXKK7lHQw8xKpXVMgZtfs6vTQvKLjmAe75aX8xyzRohMQiG9MiB9lxztSFdcmquBR+dGWTQ7cPgt9mYUAWCXaBALQ0Wj4VegfysKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/vnZxkiNC6rOnYcQAFXUODpc0s8W7hTSTRZDX1vukE=;
 b=RlRoZnRWpdvgHiHh3Q99ngK606MS5ypciYQJSlhZfv6fsIX/8j/EGsQoJ+/YoRVQhH86kA/MwVhbkN6QFfH8R/VWZQGsxyPuygj76zPrszpEWKGqKACkxBazQMKm8r3wVX7q0sJrRCqzHvDkZDqEbj+/b9V/6FIm85+DGp2PiakcWledsIqcr9rAy5zPqeFW9STtOqDGkfusGhI83SsipjYIgZsY914m+rwChSqoNEN+jgm9HM94HNyHUPmpW1kAQtUrQCJF/GgbJy7kGztzgC64rfF5cJqkNaFWvgvHL8Br8hcJpseK9CCJt77p/st27mQQHGje8K/EAJP9fLNXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by SA1PR15MB4531.namprd15.prod.outlook.com (2603:10b6:806:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:36:12 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 08:36:12 +0000
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
Subject: [PATCH v7] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v7] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYjFx0SApM58Y/sE2piFEMXX7o2g==
Date:   Thu, 30 Jun 2022 08:36:12 +0000
Message-ID: <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
 <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90059dd-a373-4a79-4c22-08da5a7396fa
x-ms-traffictypediagnostic: SA1PR15MB4531:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/ckD15o32Gz4r6Ap0JsmOZO4VNpS72dKj2p10dZO77DWEkwWQqpmX/eTpyrRuboloolHaQHnc4z/k5jWTHBfxcLuIl2tSxsBm8IJE2uCeJ4RiRYQScdavW6LfWloOqmELHLpDk/oYAkr19ozKdDMYbHJ6rTnT3QGXktcDK2q5QZUJk4Ts8DSKMOfjSKLHyNpRsxFhQfMDTNkE0SxLwgRE9BctHMwH4dTNhOymCWkNyFf0leSHNktVvbBoV9aEBPiTY2g5dW05bNGfxCFcS9ePqMTXp4H2IfDk54IvXu1X7w8++9253pQgen5RUf5S0bRllSb9ewOP1Kc/rf1KWvWXGfcKIv2dVivo2ahkoXMD221nlpLxTfa4VS/xxA4RrDqfLk6Ax98BVS4COtzsomaeiBrDsPN3nlp5fl+UxnGjXNpCz/QbmEGr8er9/fY8wElEwVVJppRdrRXF9bdUCsN/FPPm0ZHPkZH5RU+ObICCsBrsBXaBRZACSvvhGodDT3fYCJuP6iMxvRSDppFMMle1y7oR/Y6oQ2Djdk8FFsY0HefMI2Mt2z5eRX17J7YCrNwAeFoKjA8tmzC5FF84thnd0Jd1qK3fKydzPuj/4oAnQfdDmBc0VwJCqra8pwrkQvPejO0zlpNOGTGwydCICq5IxFMxZixq/optrMeJd2dChnMtzk0c3xMfrICfI2eMWFfhnvrpKuNKaOk5OThnt0xKxAdPmdz1TfGulsKJ1sup6C3qNTs69E7kZiN4LkHB8zg5zpce+2MMh7rsolYS9StkTu+ivRNYsXFG+xtX/bLe7flgdDS5CVrIm6dyKgzbgsHmyIGy2genxxW8URNuo8/Gb59QVbUzfMNTYyjmVBAgRffs+VZ7jBDfV4ovxYDOSV2K7BA2pa8CQyytE5q5v/ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(6512007)(38100700002)(86362001)(122000001)(7416002)(26005)(186003)(41300700001)(921005)(83380400001)(38070700005)(9686003)(6506007)(66946007)(64756008)(8936002)(91956017)(71200400001)(478600001)(966005)(316002)(66556008)(6486002)(110136005)(8676002)(66446008)(4326008)(76116006)(5660300002)(2906002)(30864003)(54906003)(66476007)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gCsvU5D7F3KOlrL2DtbFv+Omrk8U06zAiCzZriOBgWSnRtd+ajVS6iDMgwV4?=
 =?us-ascii?Q?HK+60p1gOD8CkCPUpi3ok3GFGjSWpW+Ixg9Hd72LCaNgiPupDk9bvf8RxGr+?=
 =?us-ascii?Q?GYu6b0TR+1MeffRnU+4zCqPccgqo5gH4Aq2es0/h7w1JrF9nh++nNA2V+S0j?=
 =?us-ascii?Q?iMZx03plgfVO51Cqi9Pl2tLAJJjxMHen0ZOMbrZoheJzUGwi1h42HSiy2Jjk?=
 =?us-ascii?Q?4NzZnAm5EB8gewHiQHsJh7o/kNAjZ51gSDgU0EpEpcag277fTX6ZD9z4sbgY?=
 =?us-ascii?Q?EizbAXHkIidhMneFlBWobP7jh2DEmRy1OL7ZfBo2Zy6INumwwHh4iVrllNmx?=
 =?us-ascii?Q?8Jbi2Z0rdJOtGE4YSAHbG0hIT/3wvYSfrFRKckM2ZNEJKxRkIDIRs3qd/5pd?=
 =?us-ascii?Q?PZojbjF9OJuUy3IUoWi0qYmDwaPV7Xkz0lCccaCOrtDzQlWxjDr453AXC9Bi?=
 =?us-ascii?Q?z9W1SQX5/WRg9rk18TsE5Mea6XqnQFGFZlkftRkPfXG2dtbspyaakrJOrXc1?=
 =?us-ascii?Q?UFUG74G1Np5yB+7ioGOl3BFClntrIoUCMD0bratzbbLc2Saiyc1Ssoa9Zp13?=
 =?us-ascii?Q?5wAenSKJxao8lO7NMG6FBU6Wlj2F8hNCeR1mE/8IqH3IIUlANmmzlIwxd+Lf?=
 =?us-ascii?Q?mvKoapjEDATWczpNP7fTu1wBWvmhkZrHwUbnuCp6NRlNJRym0IylwSGQOhee?=
 =?us-ascii?Q?uBFyk8DXm93mPewicENPm7wpnZuNdvHf0OgZrQOzstxYSaXiQ+E9GFlQTPQl?=
 =?us-ascii?Q?W5TVwkmrxN0LiJztGTKtBlQuqd93e044rfdNUn9NHH8KBFcpNFiuW9nAYPZl?=
 =?us-ascii?Q?p5uMYnQrbB+e4eOLAobgHIRddPCUKj9Oyyks/0La60jyINUUtgP2O632ja7h?=
 =?us-ascii?Q?9vYpnoQ+2KvIEfnmLKKqtY7Zt0xYgtpK50xuOckVuIGEXmRPL7dZWBoel9yt?=
 =?us-ascii?Q?dSHb8M9H7VFylCmF1IudhLAA94TgDkR24nqoWkQL9tXH+VYfgay6AoB6dsTn?=
 =?us-ascii?Q?zQturrn/G/qHO8bNsVnOyifAdvGlVLXwT4wFoGjZKY1usi16yu+eATr9yowK?=
 =?us-ascii?Q?e5eYimsCUl9ymjpQlVK+eUwbGgUDZdJPcoerIWWmh0vX3Vd3aGwXM4T7RXfE?=
 =?us-ascii?Q?YagDIMmTvfcB1dFwOUp7mY2omj0LSb0ccHuK/QUhKC0m4zt60+QNmfKO0GfR?=
 =?us-ascii?Q?OrzqbCy730gV3/kU5Qmu2J8kpWFHIC5aFOV47+19TQKl9FbuBKZ6wJSZdEGa?=
 =?us-ascii?Q?DWNtw3sIlifgxmBkJC5HNSmGbLn1iJcRJ+H3i3XerutUKfjvf0gHL8Zzd00/?=
 =?us-ascii?Q?q7dFzrLdnFW049fqxyg79iMalnUAz6Ag+jL0O1TSxkupzfaWYr5rQdZhhI1e?=
 =?us-ascii?Q?RE192JuAWLd1CteZbq4xSLxPpKj+VLKa4pTfHriXNeFIk9Mwr+KUYSNN9slH?=
 =?us-ascii?Q?C/dSXIvicKKkiUWg/RlXDL0E8WQt929tMpmK9o9CV0HjX/2cZaL0204zY1kZ?=
 =?us-ascii?Q?TZzZMAgH3rEgmqksaqei1jtD7SMyGmyTC0O08zCeEoh0aOfQtwPSkOlwJf5Z?=
 =?us-ascii?Q?ocVqz52/BqFjXl+aKuWswNM0+YHODSf4SeMmSZnv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F395F811FBBA9643A454F62D6FE43F4C@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90059dd-a373-4a79-4c22-08da5a7396fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:36:12.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yuRE/UYGX6mxI/6EobzCwNIRLfkwYKUWWh1M5R+KKZ1emefUNUSm2Pwm1ylwJrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4531
X-Proofpoint-ORIG-GUID: YNNtJYWmk5ECO8Cmu_bZ0384axbhGAX-
X-Proofpoint-GUID: YNNtJYWmk5ECO8Cmu_bZ0384axbhGAX-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_05,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On kexec file load, the Integrity Measurement Architecture (IMA)
subsystem may verify the IMA signature of the kernel and initramfs, and
measure it. The command line parameters passed to the kernel in the
kexec call may also be measured by IMA.

A remote attestation service can verify a TPM quote based on the TPM
event log, the IMA measurement list and the TPM PCR data. This can
be achieved only if the IMA measurement log is carried over from the
current kernel to the next kernel across the kexec call.

PowerPC and ARM64 both achieve this using device tree with a
"linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
device tree, so use the setup_data mechanism to pass the IMA buffer to
the new kernel.

(Mimi, Baoquan, I haven't included your reviewed-bys because this has
 changed the section annotations to __init and Boris reasonably enough
 wants to make sure IMA folk are happy before taking this update.)

Signed-off-by: Jonathan McDowell <noodles@fb.com>
Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG
---
v7:
 - Correct section annotation to __init for ima_free_kexec_buffer + also
   on OF variants. (kernel test robot)
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
 arch/x86/kernel/setup.c               | 63 +++++++++++++++++++++++++++
 drivers/of/kexec.c                    | 13 +++---
 include/linux/ima.h                   |  5 +++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 127 insertions(+), 16 deletions(-)

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
index bd6c6fd373ae..53f863f28b4c 100644
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
 
@@ -330,6 +336,60 @@ static void __init reserve_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+static void __init add_early_ima_buffer(u64 phys_addr)
+{
+#ifdef CONFIG_IMA
+	struct ima_setup_data *data;
+
+	data = early_memremap(phys_addr + sizeof(struct setup_data), sizeof(*data));
+	if (!data) {
+		pr_warn("setup: failed to memremap ima_setup_data entry\n");
+		return;
+	}
+
+	if (data->size) {
+		memblock_reserve(data->addr, data->size);
+		ima_kexec_buffer_phys = data->addr;
+		ima_kexec_buffer_size = data->size;
+	}
+
+	early_memunmap(data, sizeof(*data));
+#else
+	pr_warn("Passed IMA kexec data, but CONFIG_IMA not set. Ignoring.\n");
+#endif
+}
+
+#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
+int __init ima_free_kexec_buffer(void)
+{
+	int rc;
+
+	if (!ima_kexec_buffer_size)
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
+	if (!ima_kexec_buffer_size)
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
@@ -355,6 +415,9 @@ static void __init parse_setup_data(void)
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
index 8d374cc552be..f2e58ddfaed2 100644
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
@@ -122,16 +124,13 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  *
  * Return: 0 on success, negative errno on error.
  */
-int ima_get_kexec_buffer(void **addr, size_t *size)
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
 	size_t tmp_size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
 	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
 	if (!prop)
 		return -ENOENT;
@@ -149,16 +148,13 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __init ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
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
index 426b1744215e..81708ca0ebc7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -140,6 +140,11 @@ static inline int ima_measure_critical_data(const char *event_label,
 
 #endif /* CONFIG_IMA */
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
+int __init ima_free_kexec_buffer(void);
+int __init ima_get_kexec_buffer(void **addr, size_t *size);
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
