Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1114528845
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiEPPPb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiEPPP3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 11:15:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85983BA71;
        Mon, 16 May 2022 08:15:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G0bPia010872;
        Mon, 16 May 2022 08:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=FMtC1ir7W5M+yD1P9nYEQilEk25kVUf9tU3kxJg2Ti4=;
 b=awZs/+deWk5auH8EYfvJ/vRkhoQei3LA/GsFH/yTtKVVfKqpcr4qYyGbl6ehqiWSnCub
 ZQAdqJ+Qq/l5BBwGxbS6ua2rvcZB3eLSnBK/OqQ4OBphmXoG0Y/hJsTGMjSsiGSayvCf
 FUbmFtUZh7X3uqz9+D8XZ17uqxLRbbYNGy0= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g2a5y9vx5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMDKYaoifOpeB1Ijuuf+nbchyrpKTFW5UhGxL2HVdYJFR/zfvOdwxwVXiVqqT2RHWUmMacf8CuNGuHt7+le8ERy58eXe95h+pRj4JrZAupr4nZBp8APMZgypMvxujlfkhsRHwPRCtdO4x8aK23GEXBG4CMVlaRE43n+4m9BYq22HFen6HuN77IiZJR32SonqVnkDmso7X6KXasX87E3y7XjtDTAvvLcMKoUxz649FpY3gSRooDF/RmBLgbc9yELCaoyFbhkzHR5NIXL3sKoRcRnicvscorNWHhoST72B4dbOivYdVgUP8I3MSLtlGoMpYhIPeDKBHpeRB+BSi5tKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMtC1ir7W5M+yD1P9nYEQilEk25kVUf9tU3kxJg2Ti4=;
 b=Xg+PyOlLXikvKSBPYzLOwAEVN4nUoJTrlFG6pvIUxWBghkPUJH9PlhP9YGlIIOlg3QrAeFkYBuy9+8tL1CroUvFVdtuClAOZgO+yQpRkCoj/VqdVs8mDqtNyVVbK9y+a1bCy3avCh3TjRnPjN6SsQn3oTnjAUjQoVyRc7td7DHsA/NqfqohCMIrHEzFrGAe9+rHTz6atKe2rZaw2/xCMmoYsX0QNYur+EM4GJvZ+2+6K4JRudABnEP6yxv/DdNpPRxi78eBQ2Eeq2AGjX+3YonJcFaQIguu4ZDFrdabPXEQ7KA1/hyT3Xp8rC6WioH0Hpg6n09yWHj8Dp2TAGSKD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MW2PR1501MB2122.namprd15.prod.outlook.com (2603:10b6:302:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 15:15:21 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:15:21 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
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
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYZhzxVqT3nOkmWUWyxVUnnMcrja0dDuyAgASUV4A=
Date:   Mon, 16 May 2022 15:15:21 +0000
Message-ID: <YoJqg/MUkQS4pDMh@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8bffb420-46d9-eb57-a944-b2389570f88d@linux.microsoft.com>
In-Reply-To: <8bffb420-46d9-eb57-a944-b2389570f88d@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec07b02b-6296-4590-9b3c-08da374ee4f0
x-ms-traffictypediagnostic: MW2PR1501MB2122:EE_
x-microsoft-antispam-prvs: <MW2PR1501MB2122AEAE99100E0FC9C72873C1CF9@MW2PR1501MB2122.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twLofgi3FqnaJ0eR2NcStGieEVU4IBCRoYNG9kwgDGHYbMm6MOlmjjWtSdUw9W2rpcSseYMQCo5sWT4FYVQ5f/k25nLrcgoy4akxgec5Dn2klf9AizYBAA6s5B1vY/lq9xYsBU8Oar3bOz9CHVQwx4zbzyTSqpP9RVLWoBLWIuMaDdyVlkqzRBgQayCGwR6wlen9KvAsB4L71hw2DSzAfjZynFXqWGm9H31hhPvovJaJrBcVC9Whrlhn9MM2o/G3w7QAh2geeU+hFnPAHwmEQZKi6M0Uo2iKkiV+Kn2LpBtJ5RU0QhehukuSDffQZ7UeQ0CmBkyhHj/j7jrJFDtfQmM4ouAe7R+IT9gINuFI/hAziSXgn1Yi6YKlq2zXjKqlkgYRbxWj8XxJvymGpQWgIvR82NP9yo/k2RLurrEOCnLhDXpHVT57VkOs0JUaTbGmH7H4jDjlUmXdq6JLFNx2HZLxtRwQJqTcNnWz7H7tDL6El64I7sBTaNQim4PZBj7WAcKFytDlpA+UDsMvhayC51z4M1pnDsYYaRhuBQiQl4IBH6itTa7xEEnJpyMv2goOYvSoFgyGqPl8Ck6xp+vmKj9/XKn5CZXJ7+AxlXQLwo/a/G20sOVDhWvbq4sJ8HinjqoVohiSsvYYXMy53wLCLFcGw2mvkkpjPoTwCSo4vmyq0C46FSYEwc3BQygAbh42Wli2oW9yMvYdyU3HlDKL/0MjRlLJhP8phgj+2rKGVW9pIp8nhf/8N9Y316vYz4Sk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66446008)(38070700005)(64756008)(508600001)(38100700002)(91956017)(66946007)(76116006)(8676002)(4326008)(53546011)(83380400001)(71200400001)(9686003)(6512007)(86362001)(30864003)(6916009)(186003)(8936002)(6506007)(316002)(6486002)(122000001)(54906003)(5660300002)(2906002)(26005)(7416002)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kXMer8ogCM3zzfOpiKHSt55Miz3s0XiijOq3UfdRjnxzCUgNAMgD71ipBJe5?=
 =?us-ascii?Q?CYgOJ9TXZKdQyrN9UqBe4WmpQ7OQBKSCIXhsILiWDFJLUt71xgq1BVhfF2ew?=
 =?us-ascii?Q?JY4obaf1Rh/9bRLumn27pjTdizhZVKcDMtVWtPjGv+I0eE7bTgTaEqgkh23/?=
 =?us-ascii?Q?qXY4BY9Ny6sm7AE+Ybu7gN7qYjcqYTLzYpdpOi3EDxgjCqoCDxnElRII/IcI?=
 =?us-ascii?Q?M9JCF+qP02LaWm8CPhMsWvSORgnFSxgcfwqwWCGmFzJoI7MTNkTJFE2bs95j?=
 =?us-ascii?Q?jB3SoOlfHl649E5LSQpZBszQF0UGUU1XjAsAyHwWbkM4mh1wXE910gbT9tKx?=
 =?us-ascii?Q?tNKCDAjko1orbFxyE38Xe/nDfU7rV+68kLF1gO69e4WkbRECXmnJve3lnmrv?=
 =?us-ascii?Q?odK17lvL2aRi0OqBaUwJcYY1vccZqUMqvkTxq6Uyjk3UpEhJOTgxlKGiH0iZ?=
 =?us-ascii?Q?az4MtPwnePguNQin/+UVMulnfYkaeKHl54iFQ56/4zT+TEhoBFsUaBcze4nX?=
 =?us-ascii?Q?mGISS+AkwjnSGTDdtLgHjKJpkiShXMOaFekeuUvXLXStGyhxGHG6ysjeu7fY?=
 =?us-ascii?Q?ftOj6meItbTZN85w6FvvSxFmb7bz3v0hCT1qxr3rpvCqQWC+XjxDer48MDBe?=
 =?us-ascii?Q?mfY1eWTeWJCgLADk0ih/r/pUkMj+Y+eL1spvz8XM7bc86CVAvm7Ovmg3gnt4?=
 =?us-ascii?Q?TDKVe6rUhx3KjItOvvBhqGwZjDAY6Qr8HwagxsHbE16fqgtcQ+o7VlGSWATS?=
 =?us-ascii?Q?kwhWa9QWd2rIzKgXkWV7UeJtmxAl11da2N6OkMA8zsdaWBwkAfRC9DnLwZQt?=
 =?us-ascii?Q?+y6g7w3Gz1PS5tBuAIgtLZgqdvPyLGyEJcOr+k+t9I5UQrBqWT1kh8nnyW71?=
 =?us-ascii?Q?UxsLGzzmB42AtmCk/qZsDhuh1FmFEstHbB/TOrNWtCESv70WAGh9JpScJ1wv?=
 =?us-ascii?Q?STpuNFBfY8BDLrh/I7+rzGVTOIqQy9FPINtNuv1MlMjGn338lQAqoqHr03ag?=
 =?us-ascii?Q?0E/KF6v8794WvNEkpJpLX6dNa0eaFNRZyPCszu1kp0VLWObEzbS8owrh+iA6?=
 =?us-ascii?Q?p43DrHmhh0GySsUGih0mxWCCcH44yz30rNXbn39BupJHdCx8dJOgwYxYSJq4?=
 =?us-ascii?Q?ZaFtT8bGwJx3IRn+HAsob1pa3ZexQcwnoeVN2+2v1RYL9eROUxRyymipk6Qt?=
 =?us-ascii?Q?KoQUoYKMqoEPipnFYyib+BDwIMkdFrbwHqbiR1fOgk+S9eXg0ujKfSmbzGvO?=
 =?us-ascii?Q?tcw5kSUO9cPfoRVNCic2PnKWm8CeZtB7r7uwsnv/bjXWceoGvuuaFUBXO94/?=
 =?us-ascii?Q?+eRGQselcyfaAz0AL+nvHQkDCZ5sWkm8KAQ0ds1nW2hCdBR0lAnnc+SKJqCB?=
 =?us-ascii?Q?H3vaDTsC0QDXFkinUj7U1FoBod1ehUti5lhOLA/7dwF3UDWHg4XLo8yRTnx2?=
 =?us-ascii?Q?PoA9eZ3sFrJan9OSAtzwKr60ON2Yeya4/RoHbiAZUNs74OWqDCfZVSsDAChE?=
 =?us-ascii?Q?Qee0bHuPY78LCc9Yj+5Aq5+7P9nSZvZeC8YPDI977Fe3+QbvO8c3ZfoyY2nd?=
 =?us-ascii?Q?eNQgbQY4Vwd2uqrqcs9GNvorZfwl9JsSsnJaJ7frC22LX8jh/7wccquryINa?=
 =?us-ascii?Q?WGuIvuv9X8yHDNAvRYSAvJ+UGVOsZSC64wlzXYC5Ixzuvf3wc/AdKbt/Kl40?=
 =?us-ascii?Q?0gZCGcky2peLpKRob6qJ6CDxDPlu9KpXbuKB/aQUm3SUX/moiO44xKu9M5x0?=
 =?us-ascii?Q?r2uSuDc3ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <406ABD51780B46489603E65FF64450C1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec07b02b-6296-4590-9b3c-08da374ee4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 15:15:21.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqSf1LkOmlKK54U+E34mIHXFawW9WE6L3TBnP3vNENn+QWY/NrXwUjgUxNtfks/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2122
X-Proofpoint-ORIG-GUID: Agx-Wqf8ZlpQR9XdKEe-NNJnQBNhyj3i
X-Proofpoint-GUID: Agx-Wqf8ZlpQR9XdKEe-NNJnQBNhyj3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_14,2022-05-16_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 13, 2022 at 10:19:17AM -0700, Lakshmi Ramasubramanian wrote:
> Hi Jonathan,
> 
> On 5/12/2022 9:25 AM, Jonathan McDowell wrote:
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
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > ---
> > v4:
> >   - Guard ima.h function prototypes with CONFIG_HAVE_IMA_KEXEC
> > v3:
> >   - Rebase on tip/master
> >   - Pull ima_(free|get)_kexec_buffer into x86 code
> >   - Push ifdefs into functions where possible
> >   - Reverse fir tree variable declarations
> >   - Fix section annotation on ima_free_kexec_buffer (__meminit)
> >   - Only allocate ima_setup_data space when IMA_KEXEC is enabled
> > v2:
> >   - Fix operation with EFI systems
> > ---
> >   arch/x86/Kconfig                      |  1 +
> >   arch/x86/include/uapi/asm/bootparam.h |  9 ++++
> >   arch/x86/kernel/e820.c                |  6 +--
> >   arch/x86/kernel/kexec-bzimage64.c     | 38 ++++++++++++++++
> >   arch/x86/kernel/setup.c               | 62 +++++++++++++++++++++++++++
> >   drivers/of/kexec.c                    |  1 +
> >   include/linux/ima.h                   |  5 +++
> >   include/linux/of.h                    |  2 -
> >   security/integrity/ima/ima_kexec.c    |  2 +-
> >   9 files changed, 120 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index f1320d9a3da3..594636f02da4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2027,6 +2027,7 @@ config KEXEC_FILE
> >   	bool "kexec file based system call"
> >   	select KEXEC_CORE
> >   	select BUILD_BIN2C
> > +	select HAVE_IMA_KEXEC if IMA
> >   	depends on X86_64
> >   	depends on CRYPTO=y
> >   	depends on CRYPTO_SHA256=y
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index bea5cdcdf532..ca0796ac4403 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -11,6 +11,7 @@
> >   #define SETUP_APPLE_PROPERTIES		5
> >   #define SETUP_JAILHOUSE			6
> >   #define SETUP_CC_BLOB			7
> > +#define SETUP_IMA			8
> >   #define SETUP_INDIRECT			(1<<31)
> > @@ -172,6 +173,14 @@ struct jailhouse_setup_data {
> >   	} __attribute__((packed)) v2;
> >   } __attribute__((packed));
> > +/*
> > + * IMA buffer setup data information from the previous kernel during kexec
> > + */
> > +struct ima_setup_data {
> > +	__u64 addr;
> > +	__u64 size;
> > +} __attribute__((packed));
> > +
> >   /* The so-called "zeropage" */
> >   struct boot_params {
> >   	struct screen_info screen_info;			/* 0x000 */
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index f267205f2d5a..9dac24680ff8 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
> >   		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> >   		/*
> > -		 * SETUP_EFI is supplied by kexec and does not need to be
> > -		 * reserved.
> > +		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> > +		 * to be reserved.
> >   		 */
> > -		if (data->type != SETUP_EFI)
> > +		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> >   			e820__range_update_kexec(pa_data,
> >   						 sizeof(*data) + data->len,
> >   						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 170d0fd68b1f..54bd4ce5f908 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
> >   }
> >   #endif /* CONFIG_EFI */
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
> >   static int
> >   setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >   		      unsigned long params_load_addr,
> > @@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >   	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> >   			efi_setup_data_offset);
> >   #endif
> > +
> > +	/* Setup IMA log buffer state */
> > +	setup_ima_state(image, params, params_load_addr,
> > +			efi_setup_data_offset +
> > +			sizeof(struct setup_data) +
> > +			sizeof(struct efi_setup_data));
> Here you could check image->ima_buffer_size and call setup_ima_state() only
> if it is non-zero.

setup_ima_state() has this check already.

> > +
> >   	/* Setup EDD info */
> >   	memcpy(params->eddbuf, boot_params.eddbuf,
> >   				EDDMAXNR * sizeof(struct edd_info));
> > @@ -403,6 +437,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
> >   				sizeof(struct setup_data) +
> >   				sizeof(struct efi_setup_data);
> > +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> > +		kbuf.bufsz += sizeof(struct setup_data) +
> > +			      sizeof(struct ima_setup_data);
> > +
> >   	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
> >   	if (!params)
> >   		return ERR_PTR(-ENOMEM);
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 249981bf3d8a..ab5e7a351845 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/dma-map-ops.h>
> >   #include <linux/dmi.h>
> >   #include <linux/efi.h>
> > +#include <linux/ima.h>
> >   #include <linux/init_ohci1394_dma.h>
> >   #include <linux/initrd.h>
> >   #include <linux/iscsi_ibft.h>
> > @@ -145,6 +146,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
> >   __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
> >   #endif
> > +#ifdef CONFIG_IMA
> > +static phys_addr_t ima_kexec_buffer_phys;
> > +static size_t ima_kexec_buffer_size;
> > +#endif
> > +
> >   /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
> >   int bootloader_type, bootloader_version;
> > @@ -335,6 +341,59 @@ static void __init reserve_initrd(void)
> >   }
> >   #endif /* CONFIG_BLK_DEV_INITRD */
> > +static void __init add_early_ima_buffer(u64 phys_addr)
> > +{
> > +#ifdef CONFIG_IMA
> > +	struct ima_setup_data *data;
> > +
> > +	data = early_memremap(phys_addr + sizeof(struct setup_data),
> > +			      sizeof(*data));
> > +	if (!data) {
> > +		pr_warn("setup: failed to memremap ima_setup_data entry\n");
> > +		return;
> > +	}
> Here if memory allocation fails, would kexec system call fail or would it
> only not add IMA buffer, but continue with the system call?

This is run in the context of the *new* kernel. Boot will continue, but
the IMA buffer will not be successfully passed across. Effectively that
puts us in the same situation as now; things like TPM PCRs will have
been updated, but we won't have the log showing us how we got to the
current state.

> > +	if (data->size != 0) {
> > +		memblock_reserve(data->addr, data->size);
> > +		ima_kexec_buffer_phys = data->addr;
> > +		ima_kexec_buffer_size = data->size;
> > +	}
> > +	early_memunmap(data, sizeof(*data));
> > +#else
> > +	pr_warn("Passed IMA kexec data, but CONFIG_IMA not set. Ignoring.\n");
> Is this warning message useful? Can we just inline (NOP) this function if
> CONFIG_IMA is not set?

It seems useful to me to know if the previous kernel is trying to pass
us IMA information but we're not configured for IMA, and it's not a lot
of overhead in terms of code in a path that's only actually executed if
we *are* passed the IMA kexec info.

> > +#endif
> > +}
> > +
> > +#if defined(CONFIG_IMA) && !defined(CONFIG_OF_FLATTREE)
> > +int __meminit ima_free_kexec_buffer(void)
> > +{
> ima_free_kexec_buffer() should be invoked if the previous kernel had passed
> the IMA buffer (i.e., CONFIG_HAVE_IMA_KEXEC is set). CONFIG_HAVE_IMA_KEXEC
> would be set only if CONFIG_IMA is set. Is the above check still required?

If we don't have IMA configured there's no point compiling this code in,
as there will be no callers of it. The OF_FLATTREE piece is to handle
the fact that the x86 platforms that use device tree (see previous
discussion in this thread about the fact there only seem to be 2 of
them, and they're both 32 bit) will end up needing to wire up the device
tree kexec passing if they want to use this functionality (and in fact
device tree passing across x86 kexec generally).

> thanks,
>  -lakshmi
> 
> > +	int rc;
> > +
> > +	if (ima_kexec_buffer_size == 0)
> > +		return -ENOENT;
> > +
> > +	rc = memblock_phys_free(ima_kexec_buffer_phys,
> > +				ima_kexec_buffer_size);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ima_kexec_buffer_phys = 0;
> > +	ima_kexec_buffer_size = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> > +{
> > +	if (ima_kexec_buffer_size == 0)
> > +		return -ENOENT;
> > +
> > +	*addr = __va(ima_kexec_buffer_phys);
> > +	*size = ima_kexec_buffer_size;
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> >   static void __init parse_setup_data(void)
> >   {
> >   	struct setup_data *data;
> > @@ -360,6 +419,9 @@ static void __init parse_setup_data(void)
> >   		case SETUP_EFI:
> >   			parse_efi_setup(pa_data, data_len);
> >   			break;
> > +		case SETUP_IMA:
> > +			add_early_ima_buffer(pa_data);
> > +			break;
> >   		default:
> >   			break;
> >   		}
> > diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> > index b9bd1cff1793..74fdd490f7c0 100644
> > --- a/drivers/of/kexec.c
> > +++ b/drivers/of/kexec.c
> > @@ -9,6 +9,7 @@
> >    *  Copyright (C) 2016  IBM Corporation
> >    */
> > +#include <linux/ima.h>
> >   #include <linux/kernel.h>
> >   #include <linux/kexec.h>
> >   #include <linux/memblock.h>
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 426b1744215e..ff4bd993e432 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -140,6 +140,11 @@ static inline int ima_measure_critical_data(const char *event_label,
> >   #endif /* CONFIG_IMA */
> > +#ifdef CONFIG_HAVE_IMA_KEXEC
> > +int ima_free_kexec_buffer(void);
> > +int ima_get_kexec_buffer(void **addr, size_t *size);
> > +#endif
> > +
> >   #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
> >   extern bool arch_ima_get_secureboot(void);
> >   extern const char * const *arch_get_ima_policy(void);
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 04971e85fbc9..c2f58d2e3a0e 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -441,8 +441,6 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >   				   unsigned long initrd_load_addr,
> >   				   unsigned long initrd_len,
> >   				   const char *cmdline, size_t extra_fdt_size);
> > -int ima_get_kexec_buffer(void **addr, size_t *size);
> > -int ima_free_kexec_buffer(void);
> >   #else /* CONFIG_OF */
> >   static inline void of_core_init(void)
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 13753136f03f..419dc405c831 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
> >   /*
> >    * Restore the measurement list from the previous kernel.
> >    */
> > -void ima_load_kexec_buffer(void)
> > +void __init ima_load_kexec_buffer(void)
> >   {
> >   	void *kexec_buffer = NULL;
> >   	size_t kexec_buffer_size = 0;
