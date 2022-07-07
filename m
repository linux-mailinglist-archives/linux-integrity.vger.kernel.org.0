Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F356A5CE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiGGOrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiGGOry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:47:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C832062;
        Thu,  7 Jul 2022 07:47:52 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 267Eff2m032514;
        Thu, 7 Jul 2022 07:47:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8OmyNxLnian8xeNnwFteuJfd+JFBVri1N68SN3eODVQ=;
 b=PySmfjiiEJVrySayPu9lyHgugUo16skR0/xJiGN9nYYlExxBueFH3l1XXgSXMyGlva02
 wpaes060IIOqNPchIkh1xZ/BuE2yZ0oPVTbPz5SSvupB7UQJ9ItTWa+C0RWTf5N2k6Hr
 IlgpFHFg73HEkKkByjLz9FGjMqc5NtkSwEE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h5q0skkjd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 07:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOXQledBCNonqTbWcLuWsCYLSH6Sb4mP8I6R9DQoo503Ge6mJ0t7y3Puz99sB6lloAPit2IZ2K0yls8goREpTgqsZgYQueQk6nULWiZJ03NJrl2ac3owhpmvsFMtcQa4P0FjCh2VD2N78AYwISVBFOmOK+ob7b6+sZ0+zzCHuFPaI3ciJTJ7+VNqk7DQR7ON9EanhiSuA5WOI9J6SZbgMDVXxYUUav6CDo34ReOPlP5kF2qwlkNOxEFSb8bBRAAOOfZ/Ke0PcQbdyz1nYvEqpFAWKsZ8e79jAaJjg4fmuMdyBAEWYiJgLppojYjel3p6LEBEXswQD5Yt086PGEpDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OmyNxLnian8xeNnwFteuJfd+JFBVri1N68SN3eODVQ=;
 b=RV3Er3KnV+hpIUZX9j55VjrtxXKnGLG+0ctXG3qRbhWzvAfcAM2Uk4oVtwuE1luGvLFoOQdZXNJhh9hlSZSAa7dOxR+fzLrJbcU3LBvMoD/LHaroNRjrvqz2eeg0QNRy9Esv2KHJg86qxkGClTE48jBsFxB4r5f7/aoT5furSLII2YLPNo6oeEaPW/cu0Vs5dzFDyYK6EpJcIqSP44ps/ZoSvk2XLbWKOg9xk9FnIrbpP6t7KdfKXG/jUfezX2LPcPTdFxD5OZ35S1QQIBGjlFZ9GmcDsdkbo8aB1gnEPbjHal8/Tipy+JZxSQOH5SyimJpfwcIYVwZa5D70QfkerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:47:48 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Thu, 7 Jul 2022
 14:47:48 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "nasastry@in.ibm.com" <nasastry@in.ibm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v5 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Thread-Topic: [PATCH v5 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Thread-Index: AQHYkg4ZuWtAbugnaEeOji57YiFWIK1y/OsA
Date:   Thu, 7 Jul 2022 14:47:48 +0000
Message-ID: <YsbyENo0bOLljuI8@noodles-fedora.dhcp.thefacebook.com>
References: <20220706152329.665636-1-stefanb@linux.ibm.com>
 <20220706152329.665636-6-stefanb@linux.ibm.com>
In-Reply-To: <20220706152329.665636-6-stefanb@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c8edce-3ace-448c-87a6-08da6027a912
x-ms-traffictypediagnostic: BYAPR15MB2823:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yViPSHM/u0Jdtdlp4ZM5rCpbUdU8jJM+4McCGQvXqY5VU2M9IZA85BtCLl+oYrkuIN5sw50idKlUciarpqdo4uTqMn9wP/2POLpxKI+zR4LlXr1gPOXfkWTzThnrDvpeqF9s9v5zslAGeHgMPy221pgzvJTidlJQKfraMe3srOnwfSYS1uYPqSsuTl6RTwPaQQTAKaMpM7M7FjYZjp5iV26HBbXP0Kz7o52lt9muVwgRQyILw5GZSm0Ia5BYcAKGImwudVxVX3qlN4Q+509KQaXZnyyHlS3oW0YGpNIepA6vQvZqSzASe37bkWsDpetkCLnTnS+yimGEmYsds1feOQ7ELMObXr0RGrou3r4e/F9db83QU5BM21r5EBUWQq9c6O5E6wnaMxBcir/4SnrTdWVX3kv3XcurBwrETbRuGRooO0R7wUXqcNZgm7Gp/efcLX1DRp9KyWqm1EUv+vZtIjY2mxd9AzAcsTODxLM2fUp09VG8ukesZNSWTtU2gkemAVr8l4LfSmaWkb0ulmx+W4Itu7A2/RYdP2uvYmQvGdM8EpJeJJvP2cLaJdJt5jdC3WH7myjOqSrM47GA9V4MCt6hONVPr1I88wVZIBf0wQc3Q0WXJPTZsOdDRL07A0n9j21afreakJo6Fq2w0ciVLoBLETGDGaH5VOiM9w0cZQgvHOx6azSdrx/cDirxsqSuKnZcSYuS6V0hYwYli1qsDog/O66lugvcit3++Xevf4ZyrPPQN2mBOs5jtWyNEr8+BpnN5mcTtUps0JWUwfAX9dnIyZhPfBbINoDP0x/MnazxPTrZ8huEEFUh2qN1nig0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(71200400001)(66446008)(26005)(9686003)(4326008)(8936002)(6512007)(66476007)(64756008)(76116006)(91956017)(478600001)(8676002)(186003)(5660300002)(316002)(7416002)(6916009)(86362001)(54906003)(66556008)(66946007)(6506007)(2906002)(6486002)(41300700001)(83380400001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qU3FhIkptQHgcwuKnYQ4mpS2HyxJijI+ixmpxwYm09OfjabaPm16lxcmDhg?=
 =?us-ascii?Q?P0HuYqwsrMonp8NS7VphZx9nklhnx/nkWgydaci9W/uCwchXz9vKdc6FKv+e?=
 =?us-ascii?Q?h9I1rge7s/ozBDy2L9a7KNpzf+Xd3YDqE6xXAQ0CnLLGwbhauCccg1PgzLgK?=
 =?us-ascii?Q?dQJ4ypVL3QxvO2swk1/GJIDEQL+M18hDsPyabrfQ1EkVS6dyeCzVFZkAsWAH?=
 =?us-ascii?Q?rcVR9GfsiWCkicOqpBbBtZ8DgXBgqxub+K4+kCxrBkbdqgZriudef+OGjBZO?=
 =?us-ascii?Q?yC6dKvTYr3E+WfjSR41jQVjEtFUfOztSYXrJdfCrIRKLiJ7/SeNNloMuZErx?=
 =?us-ascii?Q?/5OngZmg1TAbWLWGrLzixuT73M74erD9SzRJVPryB0xmH/a0gKlvUxBDdj8c?=
 =?us-ascii?Q?OtsRoO/cpEoA+BOBGVsI7U8LYArzOB7OlQyUwFkTpNAPYsMT3lYO7q9hiyVw?=
 =?us-ascii?Q?1zFIkb1gDOIvAnBZURKk/KwWqyrrz2CJTwxRKyjx7LQ3QvtQTTICIDM22cSq?=
 =?us-ascii?Q?uHW1yG1gG523HHCLqcsQ+Hm42cHbpBdm0Lr6mUgT3yE0YdJ2aVuQCiWDn6dJ?=
 =?us-ascii?Q?tbGSF1is2Gv3QlfPeUnUKNrAW3iwokwI5JQB7D1syjhuOR44cpKNQosFIjDv?=
 =?us-ascii?Q?hp7xyc+Z+WK2cwy166YEiRLVoxlVvieUos4FItBHAuqEFynLfhIRg3RaafVP?=
 =?us-ascii?Q?+U/w1bjAi40jUquacOeGOSiHI9sw0qX0VksrOdLtG2D7COfDn6/P3KimVQif?=
 =?us-ascii?Q?ApmDr7CRBuLtGY5gAr2N0Tsi5CxH9b6B+zL6VBTc7zWSKt57rxOqTGuFLZAY?=
 =?us-ascii?Q?TkXDc/AZwlH9YbuHG+D+WyahJZH/vyrEYoBLTZfBUGwUqEz1QeYZuwmtGxre?=
 =?us-ascii?Q?aYv9wc+t77f2t17pvyxv4XKrUNeZGbLfLVbzX6zeLO9m9kVgLOvjJNHKJkQJ?=
 =?us-ascii?Q?48EKzAyu0lxE+jHlaUQhCWHoL4ILoYYgkCdxb44DDb7pJ1weXQK8Ca4BQrHE?=
 =?us-ascii?Q?G3CHJwMwIQClR6VY5xi/yQFSNuMRSFgYMKwHVftS7rQqVYhoicmTXLnPNaHs?=
 =?us-ascii?Q?8Jq/atRI51lpfuNfcD3Ns4Q2iGx0J6Y7zjnXTMzxs0KOKe0B/1F94vgNM/Ll?=
 =?us-ascii?Q?oEl+RIcp04LLvud6ZTXxJJP+cu3B84LbWyYEks72Adag6KUG71/7+V6kGWzK?=
 =?us-ascii?Q?XW3ZencI8+iti+LSgXCBN3eo7oCUWjzy3JRNbaTBPg3V317wx65aPv/dwmLD?=
 =?us-ascii?Q?+Jxl6Ik+7a8L2u1mnUSuGjLgJNr6o7k6IOw4J2ng7vvbuJj0Liaez66VH2RD?=
 =?us-ascii?Q?ReWqD8HdMQwgYIJmDztLeHWP7P0TIc+QwPyoX490dagZccIB5kIkNMhg1XrV?=
 =?us-ascii?Q?F6yV9SYsz1ipTGtzf7jgOHCIV22I6mo7W/sNItq/24pkwPHWrmj1wMkiDnXZ?=
 =?us-ascii?Q?4d4HQivOWZwkB0GON+rrljiZdGdCmpmxvDdE+OtPFCiIKcTefIQY2hbocDzK?=
 =?us-ascii?Q?ldqrc4JD7MoF/4OrDoloG0yjTbcalAX3LQm/eBUGlaxeB4ANG5iYv20bFdTv?=
 =?us-ascii?Q?+vgTnRXUA6cIjmTtmGWFugO3WG8BZfhiUG7DyP6q?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB5DC7A98AC2B749A1F85BBD39354C4E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c8edce-3ace-448c-87a6-08da6027a912
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 14:47:48.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pibk7k4lhF6O+5eO9Jy9tT85a5Z+bR9PUp9iNuN8rmVvVF9rr/j+IWRDlSSuP7JR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-Proofpoint-ORIG-GUID: U1Z4wpOwNRTMEsvtFt6hcTpOyLW5iwXy
X-Proofpoint-GUID: U1Z4wpOwNRTMEsvtFt6hcTpOyLW5iwXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 06, 2022 at 11:23:28AM -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> 
> ---
> v5:
>  - Rebased on Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
>    forward IMA measurement log on kexec"
> v4:
>  - Move debug output into setup_buffer()
> ---
>  drivers/of/kexec.c | 125 ++++++++++++++++++++++++++-------------------
>  1 file changed, 73 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 548dd5b1b5c1..404a86bb3978 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -117,45 +117,56 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>  }
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> -/**
> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> - * @addr:	On successful return, set to point to the buffer contents.
> - * @size:	On successful return, set to the buffer size.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)

I think this new function can + should be marked __init as well; it's
only called from the existing IMA functions and your new
tpm_get_kexec_buffer which is already __init.

>  {
>  	int ret, len;
> -	unsigned long tmp_addr;
>  	unsigned long start_pfn, end_pfn;
> -	size_t tmp_size;
>  	const void *prop;
>  
> -	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> +	prop = of_get_property(of_chosen, name, &len);
>  	if (!prop)
>  		return -ENOENT;
>  
> -	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	ret = do_get_kexec_buffer(prop, len, addr, size);
>  	if (ret)
>  		return ret;
>  
> -	/* Do some sanity on the returned size for the ima-kexec buffer */
> -	if (!tmp_size)
> +	/* Do some sanity on the returned size for the kexec buffer */
> +	if (!*size)
>  		return -ENOENT;
>  
>  	/*
>  	 * Calculate the PFNs for the buffer and ensure
>  	 * they are with in addressable memory.
>  	 */
> -	start_pfn = PHYS_PFN(tmp_addr);
> -	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
> +	start_pfn = PHYS_PFN(*addr);
> +	end_pfn = PHYS_PFN(*addr + *size - 1);
>  	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
> -		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
> -			tmp_addr, tmp_size);
> +		pr_warn("%s buffer at 0x%lx, size = 0x%zx beyond memory\n",
> +			name, *addr, *size);
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +
> +	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
>  	*addr = __va(tmp_addr);
>  	*size = tmp_size;
>  
> @@ -188,72 +199,82 @@ int __init ima_free_kexec_buffer(void)
>  }
>  #endif
>  
> -/**
> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> - *
> - * @fdt: Flattened Device Tree to update
> - * @chosen_node: Offset to the chosen node in the device tree
> - *
> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> - * remove it from the device tree.
> - */
> -static void remove_ima_buffer(void *fdt, int chosen_node)
> +static int remove_buffer(void *fdt, int chosen_node, const char *name)
>  {
>  	int ret, len;
>  	unsigned long addr;
>  	size_t size;
>  	const void *prop;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> -		return;
> -
> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> +	prop = fdt_getprop(fdt, chosen_node, name, &len);
>  	if (!prop)
> -		return;
> +		return -ENOENT;
>  
>  	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> +	fdt_delprop(fdt, chosen_node, name);
>  	if (ret)
> -		return;
> +		return ret;
>  
>  	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
>  	if (!ret)
> -		pr_debug("Removed old IMA buffer reservation.\n");
> +		pr_debug("Remove old %s buffer reserveration", name);
> +	return ret;
>  }
>  
> -#ifdef CONFIG_IMA_KEXEC
>  /**
> - * setup_ima_buffer - add IMA buffer information to the fdt
> - * @image:		kexec image being loaded.
> - * @fdt:		Flattened device tree for the next kernel.
> - * @chosen_node:	Offset to the chosen node.
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>   *
> - * Return: 0 on success, or negative errno on error.
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> + * remove it from the device tree.
>   */
> -static int setup_ima_buffer(const struct kimage *image, void *fdt,
> -			    int chosen_node)
> +static void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return;
> +
> +	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
> +}
> +
> +#ifdef CONFIG_IMA_KEXEC
> +static int setup_buffer(void *fdt, int chosen_node, const char *name,
> +			phys_addr_t addr, size_t size)
>  {
>  	int ret;
>  
> -	if (!image->ima_buffer_size)
> +	if (!size)
>  		return 0;
>  
>  	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> -				       "linux,ima-kexec-buffer",
> -				       image->ima_buffer_addr,
> -				       image->ima_buffer_size);
> +				       name, addr, size);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
> -			      image->ima_buffer_size);
> +	ret = fdt_add_mem_rsv(fdt, addr, size);
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> -		 &image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("%s at 0x%pa, size = 0x%zx\n", name, &addr, size);
>  
>  	return 0;
> +
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int setup_ima_buffer(const struct kimage *image, void *fdt,
> +			    int chosen_node)
> +{
> +	return setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
> +			    image->ima_buffer_addr, image->ima_buffer_size);
>  }
>  #else /* CONFIG_IMA_KEXEC */
>  static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> -- 
> 2.35.1
> 
