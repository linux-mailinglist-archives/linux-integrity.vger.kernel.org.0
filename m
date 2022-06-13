Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D1549632
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jun 2022 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbiFMKzo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jun 2022 06:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350220AbiFMKyp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jun 2022 06:54:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A7F47;
        Mon, 13 Jun 2022 03:30:25 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D5lDxr018357;
        Mon, 13 Jun 2022 03:30:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=9LDgPrNqybz/FBegQilAJUab/Ck5B2P6C2Xr482yJl8=;
 b=QRMl/EExazn0pkW3xO8uqHsyT4sPmlMWy1iy1Jc6mT2kFOKlBOa01un2V2itdlre2pVa
 SYiD5FBS58TUVIGPvKvHCZ2g486Rc3dvVfwqvdoi2y4G0P3ibCcFTaIdbOhVwBmK22iW
 ooYQkH3PU5XQ9XEl5YpponwtD+aFzMN5XlQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmtc3y80c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKTvlzTG42KHX6LEx52z5sPdyQ49oNkrlN5iq9OhH2yS4quc+SYrhxed1u3QEl2OhC9F6B919MdhFPcjRLA0g14F/ZleOQCj3BRbRuzGXqNyHcuZ71VArmr9ou4+DFZ3tokGknTVo8jpW+87mUzMEJz4rr8SknhoRFNXyjYbP6aseFWb/pf3IDgZ+v/IChVDkXanUShVZaunjMPLpTB+SjSX4Yt2yNtVcdKiPowGU2zGLyOQtrwzmD8cvRqMTKuoc68IujsQ/9PViPSHUlMvBX6hXklV9NPJETbYk4ndCUZPIhg9aJnjbz8RA1DIoYu03N0+2/5LsNvnHEmUt6FmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LDgPrNqybz/FBegQilAJUab/Ck5B2P6C2Xr482yJl8=;
 b=ZtlWg1jc8z/5uqa5cWcGIyd2mZ5fsFbG8cPEtZfuAKqGoLpA74pyEvMB8kKbZP+8zRWp0oDIFuM0li+L6obGnyfd3iNfM8q5UsGQpD/Jt8Y+rAZ40HaI36niHUw1/hDrQm+lt48CSxccwV7WYxonLzf980Qwe8TG8/JS7Xdplhc7aiA/xYjD8HTiLijOPv9EmZLGBcqaTSs8yF0RDMJDOK/KG6e1w8xD7SQectU3kJvmj0Lfj9d++qgfOIdv/DtkFH34o/C925mWPI2Docrm5PmML+viW5ICZ32SSGHXPkChMwoivrHwAenKuEjq+EldnCkn0gegJpuk4ONmLAjqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by CO1PR15MB4857.namprd15.prod.outlook.com (2603:10b6:303:fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Mon, 13 Jun
 2022 10:30:21 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 10:30:21 +0000
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
Subject: [PATCH v5] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v5] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYfxCVApGabBMHwEaalnRer0EXpw==
Date:   Mon, 13 Jun 2022 10:30:21 +0000
Message-ID: <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf274295-efce-4d4e-b98a-08da4d27b81c
x-ms-traffictypediagnostic: CO1PR15MB4857:EE_
x-microsoft-antispam-prvs: <CO1PR15MB4857F04F530A18F1229DD051C1AB9@CO1PR15MB4857.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAlQfuvfovkCnVXWCOGi87a+BAPSQdbGviTBxY3rbQsUimFqraGyFqlsxXJt+EJNCLdqFdN64ncz7wN0Dv2g3wVwEmH5xLHE75aBOaOR4HWAJ0RtX9H4l+0r0hhEiZ9uFIrOvSf3aU/ioDpgKIaylBExgyA5PEDC4mjqYBL+RsljII+D67FR7QX76pZOAEHZPnpviIHs6i5u78bY2CrUk2wuy/syYh0g9gGHYLI5aX0ya85odYPL+BDI+karSqJl4xCPON0qV5QaFADvIGzvOJemriPbj6Fy7e5OUs+30Ut6DG41I/kb0vTXa+xhkd5W8FoTFdxcfFB85rsvM1ql0gQNZLYJnvcgWXWyg14EPIAZrCpGvKBTmGJbiC/ulvA9sDjfTPRt3U7br7FgI1aGT8M+jpZwlcMlRzXin86umzV3StMSTZ5u3z1oeVTNncxg79BXZG2T3xliGSmQrggt5Abm55HoVMUw7PwoUbr6icpXzcFj94e0CV+nGsWe6Qz2lmWJa0Jy49EsDGiR6DDVvnl6YmFyYUgsRpgvg6Eg515SpOuGj9k2rZ7CU+E3Ai8QkBV1v6CEaztFo8uCmybllY6KcPcSqdaeoebT69uQgNbiqMKPjm5HiJJZAXVXNa1s8LwUonF5225zyfaY6StH4h/p5zR/qCzJlae7A7yEtuSus+O50w+d9401zGDxjAFnqiwV5utQwDzI8unG/N5uTuwumoCc+xBkvpJQvQqA66m/knCrSioOE6Jw6UXngAnfiSDF7v+oMxfa8YMePZhbCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(110136005)(186003)(38100700002)(9686003)(54906003)(316002)(7416002)(30864003)(38070700005)(6506007)(2906002)(921005)(508600001)(6486002)(5660300002)(122000001)(86362001)(76116006)(91956017)(66476007)(66946007)(66556008)(64756008)(66446008)(8936002)(8676002)(4326008)(6512007)(83380400001)(71200400001)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOi2EZf2GRQ7gcfyRZ2oPGNcwA7AuJHOJK+LXMbx0dV7YDD4C1fMISdaFuC2?=
 =?us-ascii?Q?wY1JbLnzwAFJkam0nqrhMyOZdu21gpqNDyssK7qq9kg0nW3xaOO5r26DPNUa?=
 =?us-ascii?Q?NblOD0cqwXas10ASlLzAoxHooul950ToHfP6igC1qmzC89p9hVPTXFfr4pRm?=
 =?us-ascii?Q?QNTtJgEjCsRw/yTX49MatdlpbVNyLzZlhkE6DVumia+inN/oJAMLLWsAyDHM?=
 =?us-ascii?Q?B84xFmogxxvVX4SlG81ziCTW91MUaM8eiCVIGLylvmFwO9OCkdQtGbcSI+Ba?=
 =?us-ascii?Q?H8B1CfNB2gJVelASl2oTRZbuAsm33y8tnKLEvuX4C5WaXbyCl/duAeirjEVn?=
 =?us-ascii?Q?dwcBS5R6NGXiXGIsa3Fm9Q7ldxH+XEAsOxURbvaQWhmXaEN4TORyM/Fb4Y9C?=
 =?us-ascii?Q?I7TS7FS3sxjaUcBrFtdZAzLCFfeUovkNPrvSuf6DdaC7kqpbuq2wz3HE28cf?=
 =?us-ascii?Q?uV9/wXBGlwMozYj+hdUvaLDWn8O/PD2RR3a+4e20V5Ifu315JXH18FSMLE/Y?=
 =?us-ascii?Q?NB9+q36/p5+Tfz+xRCieUWb4PkIp1ijY+kcsG7jv5ztt7Noj1QgXvdVEdWW8?=
 =?us-ascii?Q?s1M9Zyu8NVDgVUhjYdIH3HTc7J2y4il+zegBydUAeED7eL1H1MpwcbNGKfAf?=
 =?us-ascii?Q?+jKu+CatuFNg4rxzND31EwOE0zgUGpXQ+9wWRVjnYBSV8DW/s8Ud9JP/Syow?=
 =?us-ascii?Q?5jlbeKKJQW/BDmYgDkJDaSnHY8BkyG5QCBwZJQYGRopojIldh+p10YorxNJT?=
 =?us-ascii?Q?7ZiRkOyJy73n7MrcNnzgwGFuK0BLSriKr3apY9C1fhAGemYbvd6kJyksgCMS?=
 =?us-ascii?Q?w0EPzpoS5fleynwwhprMiuT37uY7K5sPd/StrXgxL/wy+mLH05K0V6q8wSj5?=
 =?us-ascii?Q?zbKfeYLKkHMYhr2gCI08VgojTh2IHKjPv0s6pU6mCIHXJm7VLJ4YWH0or+O7?=
 =?us-ascii?Q?L7LvK5TnLw0IDqsgXKe7g/bcCWfwF7ePelxcpTZvrSnrijlz6qwptwTQluYW?=
 =?us-ascii?Q?oJJf5FQwD2TQHbKVNFF5npuURCYwGtFrNaPr4PUXPyIN46x6/Pr9jWQ3F96r?=
 =?us-ascii?Q?8cAek038AzRazERyiTLZ1QFGVg0SmeOVJ8Fzcw7Obt/KSR5hKY3DBm8ED5Xs?=
 =?us-ascii?Q?Pp4p/ZazA95gu3WpkTOvxwyDUH7pMQ4Dwi5f70BO9MgHpWj4DS0NXyhtF6Pf?=
 =?us-ascii?Q?JsCv+ctqNS86I6WrBRKbTWDIjc/CFNdbEmmOCztngWH3n94syzAHzRGaV2Ed?=
 =?us-ascii?Q?jBjyLnYKmEL6vgCAAR1KSypej+4ggkBGPlt1Slzja33YiBftGWjax3a9822F?=
 =?us-ascii?Q?SY7ilUlkVXseJfC1gytBXdpdnMitX+dmK7SszN/W8f6XyNvXUkK8Dmoi96/b?=
 =?us-ascii?Q?MGxH4MIukyyC+/Pq7yRociuN8dEr44tGMvSxSyRHgAoJOLEY/DR48ldLJmyK?=
 =?us-ascii?Q?MaGKbM6QgzLf9BHstxY3XpIIQDmzUOWHSJBjso3LDQJ1/FxB4vRgpSijuY98?=
 =?us-ascii?Q?MguC977z/bHGoD5hFadiC2ClbmTqHFNBTA7NDQpT3LbIrVvkcl3+JncBEhW/?=
 =?us-ascii?Q?W0H81PHdlTCt253csIfQrX9xn8cZifClaL6ff0RkZ5rFcpBiXsALa9+h1FZk?=
 =?us-ascii?Q?OnBBmYbuSvjStSa2m1hQvUQ+MbEdWhlnJHx6eYP1TAu0OT/tZxVM/B/j9VvI?=
 =?us-ascii?Q?w7odVh/y+MD5y4Bsdd3U5G9CKphTLglYDE+6VS85aKdF5EG8wW+Waet7y1zQ?=
 =?us-ascii?Q?no/oKtUrmw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FECCD14696E7874DB65C9DD40BF029D6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf274295-efce-4d4e-b98a-08da4d27b81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 10:30:21.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +n+MhOdfyA977m6pza8JTF2xDlAjxrNy45+6WDubbq+8h7gH2u80u4iTmst7YAvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4857
X-Proofpoint-GUID: igl6kECCYGwSzk2cl31v5Ml5UltOkT0T
X-Proofpoint-ORIG-GUID: igl6kECCYGwSzk2cl31v5Ml5UltOkT0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_03,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

(Mimi, Baoquan, I haven't included your reviewed-bys because this has
 changed the compile guards around the ima_(free|get)_kexec_buffer
 functions in order to fix the warning the kernel test robot found. I
 think this is the right thing to do and avoids us compiling them on
 platforms where they won't be used. The alternative would be to drop
 the guards in ima.h that Mimi requested for v4.)

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
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
 drivers/of/kexec.c                    |  3 ++
 include/linux/ima.h                   |  5 +++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6225c9952e8..2cc727125cd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2034,6 +2034,7 @@ config KEXEC_FILE
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
index 3ebb85327edb..2d0dd8b6588a 100644
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
index 8d374cc552be..42a6c5721a43 100644
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
@@ -173,6 +175,7 @@ int ima_free_kexec_buffer(void)
 
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
