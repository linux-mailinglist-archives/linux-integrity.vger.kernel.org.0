Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FCB5462D1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347667AbiFJJwI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiFJJwF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 05:52:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40FAE46A;
        Fri, 10 Jun 2022 02:52:04 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259LPdfJ018591;
        Fri, 10 Jun 2022 02:52:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=OHocMIdaUgyijZRpXdIcWCnhBOvkiwGevOMoXVt0MLk=;
 b=ADlNhwShlskCi7PT7VZnkib+Q9o+iV4KrZWnN0bMO+sBY3U1bqXDWOf0PY6XpaGGOAX4
 qUeO1rq425KUi3xv0+w/TPgowZ3X6dXjwAXJ+7Pq+4AF0TevREPNrbLZrILguh4fRevx
 aMc1E7Qwa4FGIgkdTlncoQdThOZzjSm9hrA= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gk14tu0ba-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 02:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l41I64BKiGCFe7sfsPf4GJKCIWzWH0fp4Hzv24ucnsJwLmS2crT2rI60A/UCaxaGOWLtuqqksF6hCWTZhRNAoInvp3Y/PpizVHjWjBWwrWLU60NcutjRCbrh4Lguhcrga/zfDQQZQ/QN6AwCxHK4dUx2wMcdPQ82NEVd5uYULlgPzjyG4Z8FX2qc8rA9I+B/H+mH5OXvAXUxp3r7xtA/EKAjU9VTiPG5/7sn43Vxj70Uyrj/LiFOqk4fwRN4cBuiJqkPwPk22FFN0esSSmA1Q1Sm4a4U2WEg4dDlr058WeRiSqEionDIp22TjUlpaPCuwCNfz56NJegxh0MFRtZWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHocMIdaUgyijZRpXdIcWCnhBOvkiwGevOMoXVt0MLk=;
 b=oAuKz/r/H1ytigiLV9gy9L8ro0U1Jspre/xPZLPTV2UAre8MdJRis65/mo/M9/7LZ2z5kmDvMlTES8VKjZXvwpAS7jp4rZxDLYq/uBS5oJgaFG+5RG6x2XQSP7Ef2++deLEB3o3kQboU57OvH2MxO/WHjGwRWXpQxzWwsnkKmCnb4CwiIvIxs/bYHx3lmFrCLYiE+wZPZXt3oO/hzbX2OuELh8t2FUEkwRpufGHOCf9WTlguBTyAUmiIE09HTI0WTgwKKTfalqsgnkLpVmkHcpF2D/zMGjp6cztP1aIIQ+o4MxRmQXfBneLeNF7W1f4oLOp2FiPuIRqI2+0YbtTVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 09:52:01 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 09:52:01 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Coiby Xu <coxu@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYZhzxVqT3nOkmWUWyxVUnnMcrja1B6XmAgAapvQA=
Date:   Fri, 10 Jun 2022 09:52:01 +0000
Message-ID: <YqMUPISvPs3ce1oi@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <Yp19W4/ZQm/8U+BG@MiWiFi-R3L-srv>
In-Reply-To: <Yp19W4/ZQm/8U+BG@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36100d40-d30d-4b49-bb05-08da4ac6dde4
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2501D01A9E1997D374D2CDCCC1A69@BYAPR15MB2501.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZUxYHro7v9C/QaOyQ0MMETkOfKTY+MlX2UjoyqYgThTHsfTEMI3IWN5pp6PO8AviiFg/Ajre0wGzH4wF3r1hNwbMReqvFIVahPVx1LXy4hwJiKLtYLIebdr1MXxyM6nMlFKUVHE1N4wwXu+GWQOKgQPJ3L63kWMAKZd24NX/3ox54IpVOM9hpjTAOBa6TggHzYusdhjGLYpL8TvqQzj87Akog+iHdvbbdUh8fub27mqc3ANVMamOVNnMO0N8wExT34LMTIO15HEkkRvuZpFtGnbJ+BTtGWHQFt5HPsnZ5kBhC98Nl8yPKpP1rlR901MXuDpwBDstZeZrkcjz6ru/CLqs+zcpq7wDm1qvmFZ6F3fMyPGisNYvUDLf/OeZ3jySXPE1nhIdlhac8VCXqOFIBgi4fxjhLEFnUbfzz77kWbXu+EV6JWZY1NzVJ5iWBQ4sJJPFvABp3OC4jBgbvBwxb7hLsjlJX+1lpMUCwCqjFxGEJ7ywXLMyqPe51WHuRvSb6Z9LhKEkpoEat7XRfpeegmAdkf09Cw+EnRVPrhyOhZDEpNbhVbRjeHWUpSmbtG9ZHWOwipRqfVt4ov2AlDdaAa/tbtLqLqVtZiGon+a2/p4Y1PBFIcjcTLDCHt4CEQsDXM8LOdOwiRO70u/kOgwVN9L0p/xWrMGzCdaWozmOC4NlVm/Om6vCZBiVXoIdpUFTAF+7OVGpVhp+w0pmNaieA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66476007)(64756008)(2906002)(4326008)(66946007)(6506007)(8676002)(508600001)(83380400001)(6486002)(186003)(7416002)(71200400001)(76116006)(86362001)(38100700002)(8936002)(122000001)(6916009)(26005)(38070700005)(316002)(6512007)(9686003)(5660300002)(66556008)(54906003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nfE23hhax8FkIGIQMM8qYLTsQmOFzB8k2SMZyUGSREmg+ffbAPo8bWAcifv8?=
 =?us-ascii?Q?qOCVUfqStt9f/zHZhVZ6AyKydJwRE71jn8zozZlD36McHc6341TVPvaXPlH5?=
 =?us-ascii?Q?nBanR9h60KPUpAlF+8/Gp8aFiTh450CXaZObrgBzVIyyFm5HDe/yk2E6aNHj?=
 =?us-ascii?Q?6kOBq50db7zdAhYns84SPhiaW3MXOG7a8E9Luu8JwiP+NvVdOM33O/PkgTcJ?=
 =?us-ascii?Q?4Aij/YdcYc4VFtHnNayeBTpK9moUuPZi7lQxfueNrZbOAvIDIyZ088bEZ/GB?=
 =?us-ascii?Q?rdoUMVEQk93hayFVHOCA1XaLQH343nWr4JUk+YKiNvX4QKwAZDY2U1P8X/nG?=
 =?us-ascii?Q?GicKMO63KM5BI/z0iiUUhJjGuOUonaVVfIWQjyTURMNJl/YvPN3QAk81ukAj?=
 =?us-ascii?Q?CvXvZQy6hgse74ocle49uMA61hjket9b0ngjILS8HiD0HkSd/zfhxmRhmSZX?=
 =?us-ascii?Q?/Ll8TiUmclOJVMfL/SHeO/PwyzGCiE0zC1y2mrE2bMM/7WGLCIVft6BUxg3P?=
 =?us-ascii?Q?q0NOz7HqkfNh4XJnikPb5PtVzSdc5E4/UgPwybQPgrqtjNQJw7Nw574X+uho?=
 =?us-ascii?Q?fpUBJeN2ClNjugjXPBFr/nC4Bezz4XvD06SaWuv/Y2J6aJ1rbDPt46tYYfU1?=
 =?us-ascii?Q?LIRpQQf6T4TDwv2E5r5RQcksjtc7hMKvPkzHcshzAKUIuR6CCcdFn3gLYZqX?=
 =?us-ascii?Q?F4Bsj4q4NoaLmy+uM8Y5NHMGxzm7LZLo7EBDzAnp0F1kwgB+JArjEY1MBvpz?=
 =?us-ascii?Q?8Px7A1+S0LUhXWiplBRVlVUXYTYa608ZDwOO5qjLeAg6BNaMakjRJyGah8/M?=
 =?us-ascii?Q?5yrMDRdz2BqpRIObo3GV3sF/RWcKkac0xmBgbTyEdOGahe4Usyr+VzFi814K?=
 =?us-ascii?Q?DPAzNU99cl6MJd2i/KPESSfRynqlRUwnS+uZJ6sZbepWv10LT1nma1R/jzDZ?=
 =?us-ascii?Q?jeBj+tWruX4HVVnpoyJHQEKIdfB/jTp3YguEv0WICJl6lGpDN80p7oYD1iIG?=
 =?us-ascii?Q?xxC+oAx6Ff3VjHr8uqT53MDgMjY5RcJi0nZlQyt2zmNhOOg9TnXQCkGnRPor?=
 =?us-ascii?Q?N+cs90K2dnT1aamnF32nrBgGvgPQQ5D/J0OT/TVHnIlWt3gY24zXPAnss+UH?=
 =?us-ascii?Q?gHzTwh8EWTjNRmL25PcB1QGpkD0fEZ/zcLSPJ7CNGmuoc677JroRSE6tipMF?=
 =?us-ascii?Q?Wa8lHeDDIZTKRdZkOVuPA/2rTZCP3vXceXwvHcfl2VYKripMCLjP2qFZVqAy?=
 =?us-ascii?Q?uo4haqCdXTCvwaNFSa7m35Y6+BBfnutDsVmJD9DZ0b9hR9wr1iBiXIyilM5R?=
 =?us-ascii?Q?UhWNaulhXfTIx6TpUH5akc7JXWL6xbxAHVu1T1cZ3A83NNVeMbcqa4BZqigQ?=
 =?us-ascii?Q?uIzGPjpgOx6XQv8T4cQkqaCoBmAE4ItX0/8LInulDOFtqFysc45JX0Zk1bXM?=
 =?us-ascii?Q?Hvl7FevjVx1KL06lVR3NRcT9rLXH19jvSSk4KrXS55ADuRogTo1iiecK31Z1?=
 =?us-ascii?Q?zTkil9ufZH5ojjiETX/cy3n3xmB5P5ptNA9Job4ZmBYZU42K4bdlKymPHP/p?=
 =?us-ascii?Q?RKSMpjerhbb9E0cATtpnNqzZEqwyMmiloSYsamsb0dGO1QprkxyT8vDRhb0B?=
 =?us-ascii?Q?O0j4s+SUmSqAcS2hEaTCZdLC2BRVUrz26MhQIWd4TfQ41XMfMaeYYuHc9bfW?=
 =?us-ascii?Q?1DpsY1T3c4+TjkXrVWsCAx/FfGUTZt6xsy8Q+pt9DoWWI0Rw+LP09AyLLVsA?=
 =?us-ascii?Q?ClWQKETKOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B7F8BA58BAC014B97D1238557FABC91@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36100d40-d30d-4b49-bb05-08da4ac6dde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:52:01.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpiFNwqNcH8b6akxSuVJVmVoG+RwzSsBuVyfF0KM8b5/G7/ENKUhaPg8em8wu+5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: Z1o_0gk6-2ZC_qsBl7xy6IhFeSwleROJ
X-Proofpoint-ORIG-GUID: Z1o_0gk6-2ZC_qsBl7xy6IhFeSwleROJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_04,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 06, 2022 at 12:06:51PM +0800, Baoquan He wrote:
> On 05/12/22 at 04:25pm, Jonathan McDowell wrote:
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
> > device tree, so use the setup_data mechanism to pass the IMA buffer to
> > the new kernel.
> 
> The entire looks good to me, other than a minor concern, please see the
> inline comment.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks. Still waiting to see if Eric has any comments before deciding
whether to spin a v5 or not.

> Hi Coiby,
> 
> You can check this patch, see if you can take the same way to solve the
> LUKS-encrypted disk issue by passing the key via setup_data.
> 
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > ---
> ......snip...
> 
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 170d0fd68b1f..54bd4ce5f908 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
> >  }
> >  #endif /* CONFIG_EFI */
> >  
> > +static void
> > +setup_ima_state(const struct kimage *image, struct boot_params *params,
> > +		unsigned long params_load_addr,
> > +		unsigned int ima_setup_data_offset)
> > +{
> > +#ifdef CONFIG_IMA_KEXEC
> > +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> > +	unsigned long setup_data_phys;
> > +	struct ima_setup_data *ima;
> > +
> > +	if (!image->ima_buffer_size)
> > +		return;
> > +
> > +	sd->type = SETUP_IMA;
> > +	sd->len = sizeof(*ima);
> > +
> > +	ima = (void *)sd + sizeof(struct setup_data);
> > +	ima->addr = image->ima_buffer_addr;
> > +	ima->size = image->ima_buffer_size;
> > +
> > +	/* Add setup data */
> > +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> > +	sd->next = params->hdr.setup_data;
> > +	params->hdr.setup_data = setup_data_phys;
> > +#endif /* CONFIG_IMA_KEXEC */
> > +}
> > +
> >  static int
> >  setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >  		      unsigned long params_load_addr,
> > @@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> >  			efi_setup_data_offset);
> >  #endif
> > +
> > +	/* Setup IMA log buffer state */
> > +	setup_ima_state(image, params, params_load_addr,
> > +			efi_setup_data_offset +
> > +			sizeof(struct setup_data) +
> > +			sizeof(struct efi_setup_data));
> 
> Is it a little better to update efi_setup_data_offset beforehand, or
> define a local variable?
> 
> 	efi_setup_data_offset += sizeof(struct setup_data) + sizeof(struct efi_setup_data));
> 	setup_ima_state(image, params, params_load_addr,
> 			efi_setup_data_offset));
> 
> No strong opinion. If nobody has concern about it.
> 
> > +
> >  	/* Setup EDD info */
> >  	memcpy(params->eddbuf, boot_params.eddbuf,
> >  				EDDMAXNR * sizeof(struct edd_info));
> 
