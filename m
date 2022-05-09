Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26651FAF0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiEILKj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 07:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiEILKh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 07:10:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0313128F;
        Mon,  9 May 2022 04:06:40 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2498xBAe017728;
        Mon, 9 May 2022 03:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Pu8PEoIAnroCzj+OZdSR9sRX4i+JbY5gBEz81k7eNqI=;
 b=o17A5Jc3xcU5f2RkZqx6zdj6uG+pQt+T9mh4L13uBDik04CBHt/JNuwJmAaYQEuuJ9Qn
 peGOC2GWqPFgxqY9NUWTWZu5Tc6p2z+sRJrs2Nr8F+q+KWzEEAxlcXkSw09fapgNJB13
 sJtj8HEL9NnW63lKJN4c22KUvgf7IP2RjMI= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fxywsged1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 03:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB84eZ8qIIF5RNfAjOLce19HqEzDADh0fEmkvhqYkxhEZ2GY+BtHSzMC/YLtZ6rgRv9nWZLdpu1AUze4Y1SvxpxRzdtbCaC5zNFTD1uksoLzHzjE6Wm5Brc62timO6/4qpkEwoiBCHpX/FIf3t2PGQrmHVBaGA6t3kS9x7/Cg4wMcsZL01zeds0tlEmO5Ps9ZQOZGybdWYHa3DVGZV0GUPpjUkzsJm4OTfrBwWchWp2I2miIID+biFjiu0OMjSIU67QBKq5dFzResLoUf8rweWoI5Gcc8gUG3lkNJLj9xwQNCcslt6rB+pNnk/S7QDh5pVV0hZkxjMOps5QZlIL/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu8PEoIAnroCzj+OZdSR9sRX4i+JbY5gBEz81k7eNqI=;
 b=QVLZ8XP+dTMe7WTLZNTD3nvmZkOd9Frh43Yu7ia14rHN3xPXdTgh/NBLGL7Bw4rh0ZHvBPdX5rmwX5o4faXFVJ8nVsnNBIg4y44uCAtmKUQpXMqeA22N4NE3Y0JBsZlbPDIELbXDwhX42DxeoWslAyFgKpgmUCEIokf5ncUJngE5mGs8Y0WGkzfjMXoEvipUc5oQ1AOfJS79AZXmNhj4PplDmAmkbZC9LBLatMLiPNxrr/nvNt+vNW8+6XdJvIl/hBMRLlVVGoMLyTytuT3q2+jDPIS2AESu8ktCj7yMGQjmR3xFnD4+3buZnPidWc3WCQKFF8Z6rxtFOaw+ZUbdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB3706.namprd15.prod.outlook.com (2603:10b6:5:1f5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 10:40:01 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:40:01 +0000
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
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYWY4yqojcPM99qUKBDg6v3vLzMa0WbyIA
Date:   Mon, 9 May 2022 10:40:01 +0000
Message-ID: <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
In-Reply-To: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec2e7bb1-eb09-4825-c1d9-08da31a8452e
x-ms-traffictypediagnostic: DM6PR15MB3706:EE_
x-microsoft-antispam-prvs: <DM6PR15MB37065D7FF570D64644EA8CE7C1C69@DM6PR15MB3706.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ma13OFIzMN7WXpIAGGxua0FpBA0fTeQSmkgz8nSBq+ChaXrJGBwSWe19eKiisukCg8MQvfnWcAibBaWE0kfkyluRLP8rlEyd/p00em/l08vhCrAKu+M/4PrQTszY1HJZgES2pLxxEidtYLXRmRUtaJIxwNyYaEhjsWYFGwG+k4g7+zJcltm+1AmdVTnoS7yqLPovlPkIASght/L86NqUmu1PU5Uy0cGyRcF95Y2XKDAyJKwTvYS0GAwEcU0bccbWCoObbT+g9o/pn5+ziwGzbLZt/MzCihXRk8bCIM5iRbbTM6RxdtBDqDUY7Ic/WC9efLatkQ1zygLY4zyJFxdX+IwPXCdxC66fRYdKp4NvtvOmQfkYpXK5cul27PoeGQpvaeN2EDKdZGV0LLqumC3brfuU5QQY0Q1ELZwOKBsPFVBVY1UYgLoT6com1qtTv1Ibybr5wGS9xs4aXONkOSKa1TO8zhW6P1o0INglTOeZolf+9D1BtyVm2v/Fjo4dnD3utrTAeWhhcFAe7Wfj6zVZPG7va1yKn2Jl6S1fIqJGwLEon9Sm5ym7GLFWw8O1I21AeDl+0oEH1/vyRf3iEEmd1VulD1uGwmLyJo57ZmyqGe6C4ZPsfvFyFGB9Irv+pF8aebszU9aIB3itpwAFLJC9lyHKYVcvnlTpCESoFgkNdQd7qxGf8cdhyQhMTyNKReH/l0KR31EnyylvzYo+d/rRH0YeTuJ+naAO1LGJBvRuNs8qUijn5ZIUzAfD4UgIOgFJAOa6Sb2hf9LRccLTgm+Exw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6506007)(71200400001)(110136005)(86362001)(508600001)(316002)(921005)(122000001)(6486002)(38070700005)(2906002)(186003)(66946007)(76116006)(91956017)(9686003)(83380400001)(6512007)(26005)(5660300002)(4326008)(7416002)(8676002)(66476007)(66556008)(66446008)(8936002)(64756008)(38100700002)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2AxrdSLpZcQEz18fKTM9CdyZiXQzqOEgJfZDUdY5S73jqLr8v1WVOlIszjIB?=
 =?us-ascii?Q?lyTCt2pQOxdrcUoHDfjCNLUJVGxw1UMYB1QQph9LgcVEgOdiHmqKjGp8npeQ?=
 =?us-ascii?Q?togOEPRBc7D/CPUid5MJdHig5GUNIK2qSAq5gugX/Bkndg3RUdE7xfBFlWUN?=
 =?us-ascii?Q?lo2SW2BijpvFvYXu29bS40BW5EdhIdjG4k4bayXLPsi5t5p7in5nx12FGWfb?=
 =?us-ascii?Q?ta88OHeyNl7qZKsDfrKCgusynnch2G8lNeuu54JVFKsma69MV59qS0frH8zR?=
 =?us-ascii?Q?fxgN97pJQ6YpX5xdQrxInMGtZcVlHjOwYpBWceSD+1+UCNeEWdq+VYHpSP+A?=
 =?us-ascii?Q?r9rZ3IItPUnbuMp/LGNvAAOPGKtEErsEILMmXDFpBfvo8wRSPDmloe2gJpUn?=
 =?us-ascii?Q?1HgN+SlOS2dlYEBWpD7ZHGMV9ku6V7IDDCiNGvo2C9xgjjTTYMqhCMPWOc6e?=
 =?us-ascii?Q?4qAqTMvINwnzdQk1Bls4JWfd60B861C50ztnJYiVG4DAtNFd9E+4yQ2qRj1W?=
 =?us-ascii?Q?O+NKwfTOKLSpEjSHFeerAIORrRHyW7QZ76THPyNIA0KZbktyduK/3a50I2AT?=
 =?us-ascii?Q?i9dvgm0dMSO4vrtESU2Eh+EbgKYRPCjRb5hctlMAnZJAcxAscdXNyVT0kqda?=
 =?us-ascii?Q?82yJRoi3m2kG1f4gcZq5Wd2bI3y3Cx9/Pw0kFDqonIz+XqMGOTpbCw3oi/aM?=
 =?us-ascii?Q?4dqxihynCsz8gguFB9g1YLK41u/xv7MHQEC/isi9yrdlGzoXOUi3bjslF7Cx?=
 =?us-ascii?Q?7cohbPHQQAtfPg/JAZUGvJ9oOXF/QnhK89ydk3BEfn/76FYStREuPJkIiNWG?=
 =?us-ascii?Q?dM2lP+Bd83LHSprC9WDcZQWTsc4gHQsK41t2yYTNKLdoo9ZeSyHvW8W953wS?=
 =?us-ascii?Q?FAPcLCFIjChgpvyKFMReOiu8WnrrqxVcY9VUkhK8Hlv4d02lu0QgTw1KBEVV?=
 =?us-ascii?Q?7AkSOqYGPlCUOYhVQxFS1nDjt0SyAntyZr14I/6wbosbRwI7fl9hlXQ+rpiR?=
 =?us-ascii?Q?PUFw7Caj36N/xNzhvmr2gecLOCijotmBnrbjPSkWxCnD9UhjhiofQfkJ834g?=
 =?us-ascii?Q?Kio2A5rqqZ75c8BDgNNK+HsAe22zvXGoeRmvUYBGFSa1g7w1nuZ9ZMk3y3hs?=
 =?us-ascii?Q?yl6kAsh60azd8Ow3qAHvdPWUjHlOzdN9OCbOXhsTrkik13Jv7NZivuv++xxD?=
 =?us-ascii?Q?6/EhkinRtpkOEd4CVQ7TeJAHYFwkL2qJEFrQ8S5jcunEflVQZ/af5vvqXclm?=
 =?us-ascii?Q?gmK0+A0352B3ktiNnj26bSX0nxYiZ/9a+yJWoFVuqal0esgmNAum6S8qkMzg?=
 =?us-ascii?Q?8LaAl2RlfjTYhC6GAGF8iXHsqrPqavgXlj6fY3Ehahk74yMvHe5INBpLNut5?=
 =?us-ascii?Q?jU0epLlC3J4vBtHPX/+KUhY4K5JFR8Iz+Keq7tIQQ/ICzGbjxzvkgP32sUPm?=
 =?us-ascii?Q?oz+ecKBPdBkz8SgcXn33AKdMWWY5FhyEvuQfXFAOo0/hzknid3Ihgf0H40Cv?=
 =?us-ascii?Q?iiu9RBTG08XkGtvSEcLHmg5OgfaUmSZ35ErpJUBFtsJjnTDWmJ8n63Arj/zB?=
 =?us-ascii?Q?DcqXYFLE07kJ6RfyoA78dqbvUkcLliq7mmT0y1xPYwSyl+ddQRo+TiclX8O3?=
 =?us-ascii?Q?RaORrIs2yleo5oiPE2RBZ7rAcjTIgfcqRLVK563+b7Pd3PrQotiYzN9OTIpD?=
 =?us-ascii?Q?7a/Zp0REOmhRj9RmXM0zwvNyB3NgOMNC24v7LlbnvHeil3FVJHkFGEVJsNEX?=
 =?us-ascii?Q?m8+efkUm8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF079B2A072B194A834768CA0637B4D4@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e7bb1-eb09-4825-c1d9-08da31a8452e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:40:01.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BaAvGOUravI4RLYpqPL49lWvCMMRuoB2/UyA/OaquX14J7Mg/nD7oap1yfRgqeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3706
X-Proofpoint-GUID: jOg3K4Gc05f7P9_x4C9EegOpAde3JI5r
X-Proofpoint-ORIG-GUID: jOg3K4Gc05f7P9_x4C9EegOpAde3JI5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_03,2022-05-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Can someone from the x86 side provide some feedback on whether using
setup_data to pass this data across the kexec boundary is appropriate,
and if not point me in a better direction?

On Tue, Apr 26, 2022 at 05:53:47PM +0100, Jonathan McDowell wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so the IMA infrastructure is extended to allow non device
> tree platforms to provide a log buffer. x86 then passes the IMA buffer
> to the new kernel via the setup_data mechanism.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
> v2:
>  - Fix operation with EFI systems
> ---
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/uapi/asm/bootparam.h |  9 ++++
>  arch/x86/kernel/e820.c                |  6 +--
>  arch/x86/kernel/kexec-bzimage64.c     | 39 +++++++++++++++++-
>  arch/x86/kernel/setup.c               | 26 ++++++++++++
>  include/linux/ima.h                   |  1 +
>  security/integrity/ima/ima_kexec.c    | 59 ++++++++++++++++++++++++++-
>  7 files changed, 136 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..bde4959d9bdc 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2017,6 +2017,7 @@ config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
>  	select BUILD_BIN2C
> +	select HAVE_IMA_KEXEC if IMA
>  	depends on X86_64
>  	depends on CRYPTO=y
>  	depends on CRYPTO_SHA256=y
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..2f7b138a9388 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -10,6 +10,7 @@
>  #define SETUP_EFI			4
>  #define SETUP_APPLE_PROPERTIES		5
>  #define SETUP_JAILHOUSE			6
> +#define SETUP_IMA			7
>  
>  #define SETUP_INDIRECT			(1<<31)
>  
> @@ -171,6 +172,14 @@ struct jailhouse_setup_data {
>  	} __attribute__((packed)) v2;
>  } __attribute__((packed));
>  
> +/*
> + * IMA buffer setup data information from the previous kernel during kexec
> + */
> +struct ima_setup_data {
> +	__u64 addr;
> +	__u64 size;
> +} __attribute__((packed));
> +
>  /* The so-called "zeropage" */
>  struct boot_params {
>  	struct screen_info screen_info;			/* 0x000 */
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index f267205f2d5a..9dac24680ff8 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>  
>  		/*
> -		 * SETUP_EFI is supplied by kexec and does not need to be
> -		 * reserved.
> +		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> +		 * to be reserved.
>  		 */
> -		if (data->type != SETUP_EFI)
> +		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
>  			e820__range_update_kexec(pa_data,
>  						 sizeof(*data) + data->len,
>  						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..cdc73e081585 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -186,6 +186,32 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  }
>  #endif /* CONFIG_EFI */
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static void
> +setup_ima_state(const struct kimage *image, struct boot_params *params,
> +		unsigned long params_load_addr,
> +		unsigned int ima_setup_data_offset)
> +{
> +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> +	struct ima_setup_data *ima = (void *)sd + sizeof(struct setup_data);
> +	unsigned long setup_data_phys;
> +
> +	if (!image->ima_buffer_size)
> +		return;
> +
> +	sd->type = SETUP_IMA;
> +	sd->len = sizeof(*ima);
> +
> +	ima->addr = image->ima_buffer_addr;
> +	ima->size = image->ima_buffer_size;
> +
> +	/* Add setup data */
> +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> +	sd->next = params->hdr.setup_data;
> +	params->hdr.setup_data = setup_data_phys;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> +
>  static int
>  setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  		      unsigned long params_load_addr,
> @@ -247,6 +273,15 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
>  #endif
> +
> +#ifdef CONFIG_IMA_KEXEC
> +	/* Setup IMA log buffer state */
> +	setup_ima_state(image, params, params_load_addr,
> +			efi_setup_data_offset +
> +			sizeof(struct setup_data) +
> +			sizeof(struct efi_setup_data));
> +#endif
> +
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
>  				EDDMAXNR * sizeof(struct edd_info));
> @@ -401,7 +436,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
>  	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
>  				sizeof(struct setup_data) +
> -				sizeof(struct efi_setup_data);
> +				sizeof(struct efi_setup_data) +
> +				sizeof(struct setup_data) +
> +				sizeof(struct ima_setup_data);
>  
>  	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
>  	if (!params)
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index c95b9ac5a457..8b0e7725f918 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dmi.h>
>  #include <linux/efi.h>
> +#include <linux/ima.h>
>  #include <linux/init_ohci1394_dma.h>
>  #include <linux/initrd.h>
>  #include <linux/iscsi_ibft.h>
> @@ -335,6 +336,28 @@ static void __init reserve_initrd(void)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static void __init add_early_ima_buffer(u64 phys_addr)
> +{
> +	struct ima_setup_data *data;
> +
> +	data = early_memremap(phys_addr + sizeof(struct setup_data),
> +			      sizeof(*data));
> +	if (!data) {
> +		pr_warn("setup: failed to memremap ima_setup_data entry\n");
> +		return;
> +	}
> +	memblock_reserve(data->addr, data->size);
> +	ima_set_kexec_buffer(data->addr, data->size);
> +	early_memunmap(data, sizeof(*data));
> +}
> +#else
> +static void __init add_early_ima_buffer(u64 phys_addr)
> +{
> +	pr_warn("Passed IMA kexec data, but CONFIG_IMA_KEXEC not set. Ignoring.\n");
> +}
> +#endif
> +
>  static void __init parse_setup_data(void)
>  {
>  	struct setup_data *data;
> @@ -360,6 +383,9 @@ static void __init parse_setup_data(void)
>  		case SETUP_EFI:
>  			parse_efi_setup(pa_data, data_len);
>  			break;
> +		case SETUP_IMA:
> +			add_early_ima_buffer(pa_data);
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 426b1744215e..f58aed7acad4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -48,6 +48,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size);
>  #endif
>  
>  #else
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13753136f03f..419c50cfe6b9 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
>  #include "ima.h"
> @@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
>  }
>  #endif /* IMA_KEXEC */
>  
> +#ifndef CONFIG_OF
> +static phys_addr_t ima_early_kexec_buffer_phys;
> +static size_t ima_early_kexec_buffer_size;
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	if (size == 0)
> +		return;
> +
> +	ima_early_kexec_buffer_phys = phys_addr;
> +	ima_early_kexec_buffer_size = size;
> +}
> +
> +int __init ima_free_kexec_buffer(void)
> +{
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
> +				ima_early_kexec_buffer_size);
> +	if (rc)
> +		return rc;
> +
> +	ima_early_kexec_buffer_phys = 0;
> +	ima_early_kexec_buffer_size = 0;
> +
> +	return 0;
> +}
> +
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	*addr = __va(ima_early_kexec_buffer_phys);
> +	*size = ima_early_kexec_buffer_size;
> +
> +	return 0;
> +}
> +
> +#else
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
> +}
> +#endif /* CONFIG_OF */
> +
>  /*
>   * Restore the measurement list from the previous kernel.
>   */
> -void ima_load_kexec_buffer(void)
> +void __init ima_load_kexec_buffer(void)
>  {
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size = 0;
> -- 
> 2.34.1
> 
