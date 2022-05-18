Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B450352B7D5
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiERKmJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiERKmI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 06:42:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5AA3A18A;
        Wed, 18 May 2022 03:42:06 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I731Qt031643;
        Wed, 18 May 2022 03:42:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=sHWxQKZ0iOQIyu7RWDMZmR6u2sXR3enGwbh8QCPTPwQ=;
 b=OVz+uoltUACBTNP6M1iK2etOt5KCgrHQQDA6BcqDGe74lzSVtb6i09vk6dRtJ+Xx4GVU
 NKE20e9nG9Hq0Pq7KCZAw+mMDsj0askcQVtRDLjh61W3PIpVJ7HBsX/w+4BXVadeMBpL
 QM/ho1MqQc909sLQHnpTqrXU1T0pu6y2/Hc= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4frt5h1u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 03:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCCNbuiB+3j6s4pmLZKBpc+BxActQDhwOAfsLJk4RonWGpKhlOuXjfWms25jj5prGcBGYfn/09cxpNHm6QRUWrMdDBU2gszG9d63111c05KAspZsyxo0cy4Fg3yqGfcYh0muOFCxw6JZatoMJWHa7+dcXKdy9QmnAol8C7C2s7StiG5gFKr99Ovx8sQfQEq7GgkWnpxbF0sMWdPv/QGhnNRlIDoSrjQCuJ15JWMZgfkMxOstCFeekU1Vk9kstoCxomUdvPiyt99+V0D2a3tidQH96oJY55G0PJuKmzsMRjr0i4NAYp7mp7lMiG2hvNAT09zG38njGaRR2n/k6ZmFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHWxQKZ0iOQIyu7RWDMZmR6u2sXR3enGwbh8QCPTPwQ=;
 b=YvXE1bIZnorYylkEvsJJAKu1ykSXG31lbRJ6X2gdqYYX8rh+HMD8gpmwe8K2O+DcGyaYXT2YNqJfsET8r0V6xAqJJHfUtwAGR3pj/thrMcenvCU6SEJKkpmgyNDv1B1louOEoGBtpkvm/k7PLjMJfebVhcdUN5hkSEPSLOwE6gUqSUu9+nnAA49YWfIEiG79odLpgLmBzbNWCYlxqMgWxJ1alhG/mMnsKPHOWqZfSABJIbnLZBciMuX5s+gtvlQjn5FAAcTf4y3FhgnSnEiEcCQCWKKyzbS88W9b0Lh+gXAKJE2i2OavbdUT14oVMbXJ8+OHr2ZrRM+uGNoLPhU/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BN8PR15MB2676.namprd15.prod.outlook.com (2603:10b6:408:c9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 10:42:03 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%7]) with mapi id 15.20.5273.013; Wed, 18 May 2022
 10:42:03 +0000
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
Thread-Index: AQHYZhzxVqT3nOkmWUWyxVUnnMcrja0dDuyAgASUV4CAAbUegIABInwA
Date:   Wed, 18 May 2022 10:42:03 +0000
Message-ID: <YoTM3jU6PcfEsNkL@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8bffb420-46d9-eb57-a944-b2389570f88d@linux.microsoft.com>
 <YoJqg/MUkQS4pDMh@noodles-fedora.dhcp.thefacebook.com>
 <08651a15-14d8-236e-7e13-a22d50f17f4e@linux.microsoft.com>
In-Reply-To: <08651a15-14d8-236e-7e13-a22d50f17f4e@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a747dc-c6f4-4fd3-b0df-08da38bb0bcf
x-ms-traffictypediagnostic: BN8PR15MB2676:EE_
x-microsoft-antispam-prvs: <BN8PR15MB2676866C662F398AF13863B3C1D19@BN8PR15MB2676.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwMUA5DtW7UFMjgAyDcWIstW1ATKYMzpB6CiIzLc9ITKUjTtduTXCdPKDS0VHqu1JjX3vhgA4LuiJ27X9sTf1sEeFeuvYBMyDbBs3UzdY3QEMWnlFEwi5quA9i3QICNYVqxyYZkSGNTZIUkhy3G4N9U4lRjExSqJZA5tIJ/I6dd7KrAWYQdQ/g20Pklx9ZDZmb+3avSge8wCgW978hDsdF2TzdaERwVZanu7wzNTrQKNPjFJmsz7yXXlgQbGYFbnPnOBv8zwbU4Wsa/WQJeeaPkK9QeF7sP8h7vDHHspV3IpubLHgxAv7pWzLvuBPT/rLpdC9iSaPjLy6Sg9gZos7XB6/q9C+IilLnkBucMoIJytpEUItUDBz8AAGuP7CnXO30ekyF1w3L5XGnfGhGIrqixCz5ozcR8w7I+MZinWFPf0r5yxvz6TXlPLJjnWVe7X5F+W6HwsZf0iO5EKT3OF4NmpaXFLUlHvgeKXENWK56h4N2r0s8NEAr1VuK9pBJ3iZOu9pNXqDgKxWbOtZjnrM/QGF9xyMuxMZcG/o41hy0QDpwu0x/F2hxamf0sxgfxhbXuuYIV5iV63Yfqz2qU2sSc8OH1mGvOnJFmpADYWFlc0ci/2diFv2xpnGfdhyY1Uw/0EPj3yyLgRC7//NzKzRGTS6O8hlvuRJcgoT5Nwri++Tlzu0Taln7gCWw0JwCgbcKomAz35OHuDHVN65yMA1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(91956017)(4326008)(83380400001)(8676002)(86362001)(54906003)(9686003)(6506007)(26005)(71200400001)(122000001)(38100700002)(316002)(76116006)(6916009)(66476007)(38070700005)(66556008)(66446008)(64756008)(66946007)(7416002)(6486002)(2906002)(186003)(8936002)(508600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZX/HvPP3ZgGVXV7ujtxsoHeCVSWPkI/7JMes3k3smoeGWLyibITYrAfDRPpy?=
 =?us-ascii?Q?kUdPjzHk6X3T+kQDpP9UixaikO4cRxjRfz+qDApT3Bf3U+uOa+e13F7/7BzD?=
 =?us-ascii?Q?E/+SSBVhMQMk3bs3DdgJe6exWFN0C7UAjJ3knPlmNjTQgWf0CQpiQ+O+LHz7?=
 =?us-ascii?Q?OeYSIzxsDhLPeyOX5xmkH/I6RdSndtuV1Q3ztKr7m4FJVNNUHcw9jP3sSZOs?=
 =?us-ascii?Q?V2OlBW83xmq7wzWe+/snSZTw1sj0/rtFgEKqHoSqtr+kX8TSKy9sKgtzIB91?=
 =?us-ascii?Q?EHclPeGrClnILYTDe3rxHv5EIgVSImUdjHxaE5kwOZSMQlFl/7Nq3PBvzj1L?=
 =?us-ascii?Q?Qtp19yh3hfe4LUkUsWhxrcS8WPKLT1KAkPhkiqsWzjSEGBOwPoAOaz7kS0+L?=
 =?us-ascii?Q?Q7EhNyzVuoutIPQjF77PZsDx9cx99/LXipUSMsS6+uSv0So7eClrKVqzI2a+?=
 =?us-ascii?Q?VSziYGVcoQw88Hq4QJ56kHit5PlyYc/DFVKhDurP+gMe9u/B46KWhi1FI1Kn?=
 =?us-ascii?Q?FHHnnDkgwaBUZwNYqySGp3S3qlLXk/Dbu8nyL8pCyPyhGgi4A+/YLwXx7FGp?=
 =?us-ascii?Q?xLxBnuafrOlcc3WQb7IpjwX/qv9ifMW7Bp4OzodeAYgNs+gUxXpKOhvdvxH/?=
 =?us-ascii?Q?3e7SGUDyYsojAP+cUrxmRGEx9qB1fgB1QoLtK94NsuqUTI9vGTYI5UiPt95f?=
 =?us-ascii?Q?P7aRoYKcuYR+nXXnA8s3vptZdoDkes03phVdo79/7wPVti61zfEeu/E5ZJK/?=
 =?us-ascii?Q?72c0nn2bxvl5ABX1/oBsmTi6rYPUgbOU0jmoeJDcU6IDwELLex8AvfSXwwIJ?=
 =?us-ascii?Q?nfeMhzCaOiv3UEv06Srw0yft+5zUBZDOqs5HgFyU2P5Dw6VHO/vuIv5Uki2X?=
 =?us-ascii?Q?o3KvFKOek9pz74/grire9pYX4r4wk24Mh8e3Fid6UWcK6WDbr1XjwaHYyHnY?=
 =?us-ascii?Q?SRTWOaiLMtVHxTCInPSe8/E82zEnRp/t6HkLPLtlAOvIroFbJDoyQRsEPmMC?=
 =?us-ascii?Q?b/GMHM2g1JYfbpuTSlyHIP0ziQDaR/obJ0pymBO6lCdsBML5yR7HCZ9OCZ8i?=
 =?us-ascii?Q?/as0aUaFlajzYd3JpEHhT1nsVMvBRMrVMp6zii1tCWfvqBZMMlXJ7zmGKSPj?=
 =?us-ascii?Q?iCLSi2IKpkmhzzZCOthizDIVbvA4Wy3nxk2zlqkjg03tTT7hhLXYMpF7+OYo?=
 =?us-ascii?Q?jP3s//nOGJ0i84MJlXWhmT6C8jXFomWp9m9/zBSutoXjcsU/uLcL0FOGo3fn?=
 =?us-ascii?Q?GqBpLTnIpuOQLpdwTUb96EVBeNcMa69DUrwhtfVoZRR/OqGn6l7uY8bZ2r+f?=
 =?us-ascii?Q?VNWsAEvovhcPTVVPO3vvuMUGbZt82KdFPZbnCTcagHbwui+ouxRfXDOWdudF?=
 =?us-ascii?Q?krWpEbEWBkupyN4T42bDCTiKuo8d+m4SVnEg9sVPRnegw1CaMKzApqJbTdaB?=
 =?us-ascii?Q?vtp96kxxNmW8U/bQXkl9zaETmJOKPKWtVfwqnpNl0dBIxGfhB8ivTL7AfyA4?=
 =?us-ascii?Q?GjrhKlf2aJLYb12caRmVH2EjQRbEDH/n//55cWVm0uO0RQY0dPM5YkJ+eIiR?=
 =?us-ascii?Q?Q+c/b983L7AOxYSK002y//5TPY2B3GG1A1a6AJRUZ2mFngjBG2QY1xEna37X?=
 =?us-ascii?Q?1ZHtZNMcjsE/giY1VHEZngwE2tq4hxWKJ2JId+hoqs1aJulNOc2azBhW8P4e?=
 =?us-ascii?Q?uSQzQwMAXYHYCRp1wiepDHUd/k+MaDxzkmDG59V+4EokCHrDN2SuA9cStRnr?=
 =?us-ascii?Q?uIqB+daDbg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5534527EE5F18C448076658D7489F8D5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a747dc-c6f4-4fd3-b0df-08da38bb0bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 10:42:03.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPg/zEPgmcjz2cFQt7MHTArxu2/YWDQkxC/138HZoD9VNpsdfNhs67+k64wp4XMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2676
X-Proofpoint-GUID: c3ITtEyajwm8r_lra6BQgTALR372PsgW
X-Proofpoint-ORIG-GUID: c3ITtEyajwm8r_lra6BQgTALR372PsgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 17, 2022 at 10:19:45AM -0700, Lakshmi Ramasubramanian wrote:
> 
> > > > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > > > index 170d0fd68b1f..54bd4ce5f908 100644
> > > > --- a/arch/x86/kernel/kexec-bzimage64.c
> > > > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > > > @@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
> > > >    }
> > > >    #endif /* CONFIG_EFI */
> > > > +static void
> > > > +setup_ima_state(const struct kimage *image, struct boot_params *params,
> > > > +		unsigned long params_load_addr,
> > > > +		unsigned int ima_setup_data_offset)
> > > > +{
> > > > +#ifdef CONFIG_IMA_KEXEC
> > > > +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> > > > +	unsigned long setup_data_phys;
> > > > +	struct ima_setup_data *ima;
> > > > +
> > > > +	if (!image->ima_buffer_size)
> > > > +		return;
> > > > +
> > > > +	sd->type = SETUP_IMA;
> > > > +	sd->len = sizeof(*ima);
> > > > +
> > > > +	ima = (void *)sd + sizeof(struct setup_data);
> > > > +	ima->addr = image->ima_buffer_addr;
> > > > +	ima->size = image->ima_buffer_size;
> > > > +
> > > > +	/* Add setup data */
> > > > +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> > > > +	sd->next = params->hdr.setup_data;
> > > > +	params->hdr.setup_data = setup_data_phys;
> > > > +#endif /* CONFIG_IMA_KEXEC */
> > > > +}
> > > > +
> > > >    static int
> > > >    setup_boot_parameters(struct kimage *image, struct boot_params *params,
> > > >    		      unsigned long params_load_addr,
> > > > @@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> > > >    	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > > >    			efi_setup_data_offset);
> > > >    #endif
> > > > +
> > > > +	/* Setup IMA log buffer state */
> > > > +	setup_ima_state(image, params, params_load_addr,
> > > > +			efi_setup_data_offset +
> > > > +			sizeof(struct setup_data) +
> > > > +			sizeof(struct efi_setup_data));
> > > Here you could check image->ima_buffer_size and call setup_ima_state() only
> > > if it is non-zero.
> > 
> > setup_ima_state() has this check already.
> 
> Yes - I noticed that.
> I was just suggesting a minor optimization - avoid making this function call
> if IMA buffer is not present.
> 
> > 
> > > > +
> > > >    	/* Setup EDD info */
> > > >    	memcpy(params->eddbuf, boot_params.eddbuf,
> > > >    				EDDMAXNR * sizeof(struct edd_info));
> > > > @@ -403,6 +437,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
> > > >    				sizeof(struct setup_data) +
> > > >    				sizeof(struct efi_setup_data);
> > > > +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> > > > +		kbuf.bufsz += sizeof(struct setup_data) +
> > > > +			      sizeof(struct ima_setup_data);
> > > > +
> > > >    	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
> > > >    	if (!params)
> > > >    		return ERR_PTR(-ENOMEM);
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index 249981bf3d8a..ab5e7a351845 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -11,6 +11,7 @@
> > > >    #include <linux/dma-map-ops.h>
> > > >    #include <linux/dmi.h>
> > > >    #include <linux/efi.h>
> > > > +#include <linux/ima.h>
> > > >    #include <linux/init_ohci1394_dma.h>
> > > >    #include <linux/initrd.h>
> > > >    #include <linux/iscsi_ibft.h>
> > > > @@ -145,6 +146,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
> > > >    __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
> > > >    #endif
> > > > +#ifdef CONFIG_IMA
> > > > +static phys_addr_t ima_kexec_buffer_phys;
> > > > +static size_t ima_kexec_buffer_size;
> > > > +#endif
> > > > +
> > > >    /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
> > > >    int bootloader_type, bootloader_version;
> > > > @@ -335,6 +341,59 @@ static void __init reserve_initrd(void)
> > > >    }
> > > >    #endif /* CONFIG_BLK_DEV_INITRD */
> > > > +static void __init add_early_ima_buffer(u64 phys_addr)
> > > > +{
> > > > +#ifdef CONFIG_IMA
> > > > +	struct ima_setup_data *data;
> > > > +
> > > > +	data = early_memremap(phys_addr + sizeof(struct setup_data),
> > > > +			      sizeof(*data));
> > > > +	if (!data) {
> > > > +		pr_warn("setup: failed to memremap ima_setup_data entry\n");
> > > > +		return;
> > > > +	}
> > > Here if memory allocation fails, would kexec system call fail or would it
> > > only not add IMA buffer, but continue with the system call?
> > 
> > This is run in the context of the *new* kernel. Boot will continue, but
> > the IMA buffer will not be successfully passed across. Effectively that
> > puts us in the same situation as now; things like TPM PCRs will have
> > been updated, but we won't have the log showing us how we got to the
> > current state.
> I think it is better to treat this error as a critical failure.

That's going to crash the entire system, because it's after we've
started execution of the new kernel. Given that the failure mode will
result in the lack of the logs, but not incorrect TPM PCRs, that seems a
bit extreme.

J.
