Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A282750FC86
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbiDZMMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349781AbiDZMMB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 08:12:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F9152791;
        Tue, 26 Apr 2022 05:08:52 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q1Nguc016089;
        Tue, 26 Apr 2022 05:08:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=sTueZirhjPUHUFPDvMLQUSWGeY0IF7q8Rfa0v/lTiHU=;
 b=aX5+/+VTwk0RiAQrVTG0DVWR3BtC+QeJoQUmlrRNiVWI7+J/kYZEYpUyPr0vGyA/jx5k
 nkKnap002u9Dyruk2oadY5kA/WUIME9lqvLpUts02sILWSFfhu1S93NvWe1kSO0jrpxB
 wUC2U7cELR10VJKp9EpTjOb8FFosKxwuyrQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fn1gdwnt1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 05:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD9w8LBi3z7Q+lyOUH2qenTVaBoYueiQzLO60dd+3BBIcv3fQrESe5ps+2rGvBKtucjnhq1ZIK8/6ORAYSrgs+zpntd7YxM1MnM0BddI5JTtY2cTXYlIK6As27cnaIkJJfGmVUC7uv+7zq+teYNQHyhX0drn3vTPwdTVV+B3Qg6e4+j6d5sSNstlgZFYeCaxbRAgQbP+mJqUKazGL4ERnyl4QSBhpOlnkMwDQp8qc1WIIfozIFP/Qs4fBJCUEdUPP48OOLcWsmoEJsmNQ7BSvRBHDVH8CDZlD73//Y7a+7CNeFIm/qWLE+YJ9hTeX06znC2HPhP3XUjXYXqD/6uF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTueZirhjPUHUFPDvMLQUSWGeY0IF7q8Rfa0v/lTiHU=;
 b=WB5pqcmbXdtYoZrzicn1z9PoAjgDekWOhrWE1gUqZyS4melkW7gOxBb/8+15bAh5QLH0D+eqouCWApnMmfb/9aPiOzKFBiQoGO29J6maBGAjBMqTPRYDpnEA/K0aoejq4wJogA3g6dJpPifxJYr8STQLs786eovwouDDuegT4YBMKFOv/ewZVonduU4iCg1qoCJdLK949902c6a2nJbMsc/NarLtcENmWesF/AA/sxg7g/ch6lkFUJ6PgZgI6ZqCLQCsxBOWFinVSOLLSnH2ha7tNw1yd7pVV861BpfLLXiC/4+tcjhRh1vi3FCjKKdtFSFWPmj2ty/3+eY/xxOPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BY3PR15MB5076.namprd15.prod.outlook.com (2603:10b6:a03:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 12:08:49 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:08:49 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYVk//Rm0WwwIkeUGnwDIT6Grq2q0A1peAgAFJh4A=
Date:   Tue, 26 Apr 2022 12:08:48 +0000
Message-ID: <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
In-Reply-To: <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed81f313-29c8-4551-e226-08da277d8587
x-ms-traffictypediagnostic: BY3PR15MB5076:EE_
x-microsoft-antispam-prvs: <BY3PR15MB5076EAAAE7DDAF09E01DCADFC1FB9@BY3PR15MB5076.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChEXXWvZIq94tYo/qvayq05C/4JELbpHKp7vP1Q4z72VRP35YnCw+dNfZGhbeApjbzTkqr3EE2AOrnqRs8MrH8pE4mq7jWXtE/QWAo0HVb3sqBgbRkV4Q/G+qfNjpd59ImFzzCRICz9XDw2xjE2GKR0Icdp+Ar4UUbFqTAEGJrYNLhB2nZcUoXvT24INAtD4Z6+T/lAGFlaLA4Mv1ZCr/WQh0kXoQLlYQ6aO7mVTdeevCcpvzGenfO806mlgmVTP9gxhWy8gRtshMDAIqKgQpG6ieFVY9BOqn+NUVGpMfZhZ3g7PcFVbhISy/fHS9FM6SJ0iSK4wIwIOE19Bvocv1yr5oktJ1Wxt/BsjltDsyhaBaNOq7aOUur1ObTFbTJv1lsp7Bw3BLBdZQ9Fz1///Fxn5EYiC0RP71JO55oxrc89yBqEQ1MYOwvXisugmnKQ7x19VRYibhARZHvAvS8cELB5UplHXtGImPliDTJ/KA+oFytC2Y2D721Uptz4UaYnwS01adIGwyUwSNQS5UbsiKELJl2J7kSLU0CnJEupWwVKp9bdx67wJwZKSpx5jHQbSxRclarVABZEWClWXIJeWVyW6l7Fojz7yuMjmknpWJGw7LOUh138JiH+T/BVeJB/9SikxcZjmJamyCMfRcetrzn5GrU2s/WgPLUcm3Abey5tJ9u6LX9NMVX9P9EBhbmnUbul7MQH4bXJvLCJH/iM0SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(91956017)(66946007)(33716001)(76116006)(508600001)(66446008)(122000001)(316002)(8676002)(4326008)(6916009)(71200400001)(7416002)(5660300002)(8936002)(38100700002)(6506007)(64756008)(86362001)(66476007)(66556008)(38070700005)(6486002)(6512007)(186003)(9686003)(26005)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9Z6LNVT63kXSGacicpH6EdnAi7D7HdwCM7y53tz5fQygGPayodt6evN26oC?=
 =?us-ascii?Q?x1A7ovq6fdxAEx2wV6uaSUcc/2R1a/pj3LpAyuITqrWrM4F6jOhozQrgHjQA?=
 =?us-ascii?Q?WUMVSfIy1tGJ+JM3x2XT+m15F9EP8ViiYLNRgXTptewNdda1KiMNbk9kcwNK?=
 =?us-ascii?Q?XuNGpMctDedHjlCBC5rFKL4667abSYzJD8jt0Gef/g4BE0P8mSAcXFYnjBOA?=
 =?us-ascii?Q?xSIN/RKbPbd36530djhi2otEzttkKMIH9wDdg/hOC4H2eh4FrR3Exs+IizGL?=
 =?us-ascii?Q?N7yt1G318AZ9XW+z6hcq45JCFCZNZkZtiMPABV4pwrUrtFhAiiiWnN6vZFIJ?=
 =?us-ascii?Q?79CG1GSzaPnC3GkC/VHGeI9L57/4aSR8QjBHhr+7l0+6ZdzYPd4J3MaYUJEw?=
 =?us-ascii?Q?Y3NBbwHCJB1hcEdVYJ0X7xIFl396hENw71ihi4/6qqBTDIGZhluuBB/jh4Vm?=
 =?us-ascii?Q?GW8lhh2r/NfmjtqPsR86XM4d+rIVyx0FsZHyTTcu8gHJgigfAkBxGnsBJZB/?=
 =?us-ascii?Q?5mxbHrvwAqoB1Sqd+OqymUhlcrz9VmBiiLo0LHaFEwiUIacpobxzM0IRbmR4?=
 =?us-ascii?Q?brap5VCqqdA1FY35REtUMd18TwvwzcoB+ltVw0X+axKzm+hBNubYuD1oxswi?=
 =?us-ascii?Q?Oh9zK/LmmKq9du4QkRJqTTcH2hniFUAAmZ8Fpjf8cM0Jp5CzKvvtjD+3iZKX?=
 =?us-ascii?Q?UUkQQx2JE3B8quBSOqdjEuvSifZpORP7cOcVL21K54A6czsW+YwvSzMMnzif?=
 =?us-ascii?Q?rV/85aWI/N5cY1ijWBM+1DoO0USdj9BEsjNMAKZpqXR2ZYuWjTdo/i6vfIpp?=
 =?us-ascii?Q?iRqGw8xy8frlgvOjHVZJQZlPhZTDod12gpaMR+U03lkfBfVZQVJ2UnL+ZFnD?=
 =?us-ascii?Q?1aRX86AM/ns4UOjzxj+zM6LTLX0UhVgjWvm1PUWeg/19EoFT4JeKGB4NlwN2?=
 =?us-ascii?Q?33OQVGi7Zdxxn2N4u45lEYed+/5mLaWe1Dw7ArsK5Lt+lmC9H/FnuP2+4teL?=
 =?us-ascii?Q?QPwY7XFLLR9B7jjy7FDTHZmF62hXoY2e+YBlXcFOciqGR4QW23fO9FUDVUpq?=
 =?us-ascii?Q?E7kQknysi4XrwHvUwmQqz+fi6dN8+O1rInlMLduZrOCNxfLz3izMcgoSfAtJ?=
 =?us-ascii?Q?LEl+l0iwPd8PWJUMwRRTNrSEE01x3wKlclgPnwW35oI1UHFEDBgHZWCKcz+e?=
 =?us-ascii?Q?pJPbDljsbqqMouwyaznLlcn0yfKrUfNnSwehw0Cs/4s9SK2nWniHlwXxHCJO?=
 =?us-ascii?Q?Nsq/CdP6H/0/2RV+8LUQLDdV5F0J8IoJLZbI3OsHK0WLWV/dOtETiHNQyQGx?=
 =?us-ascii?Q?J6priyPaS2AogbnyoeV0fzNBN9iT3EERQaoFgz0FwunEDY0itJ83bvzzOTFm?=
 =?us-ascii?Q?qUiC1miPIpyXGA+ouKPmrT00dx7mjkoXLPTzi7YWk0gNcJBfOPZhf4Jjs7HG?=
 =?us-ascii?Q?eCkpz/XoW3ZYtMHpBJnzfEEmd4KCdcDXmuFiB6WRLwz96roE+QU9ZYuZ1yUP?=
 =?us-ascii?Q?Ty34akDWqlNcG58GYeGln2VmywYkc3uwDRHh+bS1MfRwtEYGeYLkjyeoD9WE?=
 =?us-ascii?Q?wT1cEitz3QrQw5yaTZ63ONgkLhkf16Tpyc8fXW93aXz/mpDmlDVP6c3KAbKH?=
 =?us-ascii?Q?f8/JslU39dJ9qwlVm+kG+2j/dSd8xfS6OX1hxFleFNLcxFpQXd9dpLUzde67?=
 =?us-ascii?Q?d5ZTFYLGWSvnrgAov6xNW0+jlcGpTUqtuJUknSVgqvDeR/RbRhsFTHS3iFwG?=
 =?us-ascii?Q?SFDp46KAAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FAC7032B1A2104F8E1EDAAFF7DE072C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed81f313-29c8-4551-e226-08da277d8587
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 12:08:49.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDc2TRmXLtXqMwzUIw4R5ZKif5ft61WwEiGf5tEaf4Hk6hdQeKtm9PdCz4RwwroW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5076
X-Proofpoint-ORIG-GUID: FtBVWcFfUczcabtYXTsPCW75Kpc4WTAw
X-Proofpoint-GUID: FtBVWcFfUczcabtYXTsPCW75Kpc4WTAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 25, 2022 at 12:29:17PM -0400, Mimi Zohar wrote:
> Hi Jonathan,
> 
> On Fri, 2022-04-22 at 13:50 +0000, Jonathan McDowell wrote:
> > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > may verify the IMA signature of the kernel and initramfs, and measure
> > it. The command line parameters passed to the kernel in the kexec call
> > may also be measured by IMA. A remote attestation service can verify
> > a TPM quote based on the TPM event log, the IMA measurement list, and
> > the TPM PCR data. This can be achieved only if the IMA measurement log
> > is carried over from the current kernel to the next kernel across
> > the kexec call.
> > 
> > powerpc and ARM64 both achieve this using device tree with a
> > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > device tree, so the IMA infrastructure is extended to allow non device
> > tree platforms to provide a log buffer. x86 then passes the IMA buffer
> > to the new kernel via the setup_data mechanism.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> 
> FYI, after applying, building, and booting a kernel with this patch,
> "kexec -s -l /boot/vmlinuz-5.18.0-rc4+ --reuse-cmdline --
> initrd=/boot/initramfs-5.18.0-rc4+.img" properly loads the kernel, but
> "kexec -s -e" fails to reboot, at least on a test laptop even with only
> the "boot_aggregate" measurement record.
> 
> Without enabling CONFIG_IMA_KEXEC, kexec boots properly.

Thanks for giving it a try. At a guess your laptop is booting with
EFI, whereas for my testing I was using qemu with legacy BIOS. I've
managed to reproduce the issue with qemu+OVMF and isolated the mistake
in the setup data calculation I made when EFI is involved. If you have
time can you try with the below on top of the original patch?

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 07625da33075..cdc73e081585 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -277,7 +277,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 #ifdef CONFIG_IMA_KEXEC
 	/* Setup IMA log buffer state */
 	setup_ima_state(image, params, params_load_addr,
-			efi_setup_data_offset + ALIGN(efi_map_sz, 16) + sizeof(struct setup_data));
+			efi_setup_data_offset +
+			sizeof(struct setup_data) +
+			sizeof(struct efi_setup_data));
 #endif
 
 	/* Setup EDD info */
