Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA575183CD
	for <lists+linux-integrity@lfdr.de>; Tue,  3 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiECMFn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 May 2022 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiECMFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 May 2022 08:05:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6531234;
        Tue,  3 May 2022 05:02:10 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Lsafc008207;
        Tue, 3 May 2022 05:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=fYXGZFN7ZxeteAf8JWIwevsVC7k3o/R2Z2ty2uOwwnU=;
 b=KQFRF8f5axQ48M+IQtx0FgS0bmiwHPnZbFneADaHCTelS3vo/6Vize5sIWj4l0vU2XM1
 1KhoAtrkyljN5sIOs/00wZW/TIeUl9wnDaheFpRbIFIQP3cl3/4j1J1rATj8G2+Xm54h
 +vXfqBBSwwwZjYkWDBmUqcdPcAd87zK4fjk= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs2uxye41-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 05:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbuLWgZbJSg8F+jOLDE2N/lavnrCdkUJyrc/FXuOQNe6apkr7hT0jlC/p2ADXXnlxgF2RcWIhgOrW4Fu/s8nB2tN7kxyvjtjtdi1u1FzVMS1I0OgLIUmo1dsV52+kYlx4BoRd5ihureF4ZM8NV/VQ/f/M/pWX4Nju4l2rB2n1NTPByvoGVT6nZADsS1cBtaqP3sAxZuYX5KCFraE82TeL7G9e0CFYEpOqpk9UFrjNpggofnxSaj8uYQp74pOldErRqdsiO2bM5V1F5zhFeI4yrpfpp7fO1u211kPT7RVAlXCW0DcFKmz29vbu5kdN6vtMVNIPZrWmgDO5tgWa0Wk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYXGZFN7ZxeteAf8JWIwevsVC7k3o/R2Z2ty2uOwwnU=;
 b=Dp5mRe34BWANz2RPqzg2VpHw15A9bHk9AANEkS8HD9P/mlXZe4ciZFuP62zQsI1coo7F8sXsL5NgSdbhiwcQPUz6FoJHeGcfl2prte+CsQb+OasphXVHWnJeddqYkAAsaC51uLN0dX/TeftcV8wtc8O0gIFSFdycXwlpDOKw7daJot07cTto9EM00F1PyYN+G7ptXGsGx3C/bd32fYA9BLuxnh8WR0AkVCDVC3cWk9rfRcfrM4Knn+B7sTm3gKQJIAhnLUXDlk7QSuu3zE8tsuheTQPdvjPMmCfJhaHh3SWD4nYHnkyaAlvbBwrrZZPRM2pYB+8B2fv0xX+BYOkA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB3097.namprd15.prod.outlook.com (2603:10b6:5:13d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 12:02:06 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 12:02:06 +0000
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
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYWY4Q62zi0Q79MUyPBeRhACU9Yq0HbX8AgAWqkgA=
Date:   Tue, 3 May 2022 12:02:06 +0000
Message-ID: <YnEZtisrvO0AhrAz@noodles-fedora.dhcp.thefacebook.com>
References: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <7d7fa18d396439d98e26890f647fffdc9e7d8b20.camel@linux.ibm.com>
In-Reply-To: <7d7fa18d396439d98e26890f647fffdc9e7d8b20.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc331ce-cda2-4846-1095-08da2cfcbea4
x-ms-traffictypediagnostic: DM6PR15MB3097:EE_
x-microsoft-antispam-prvs: <DM6PR15MB3097C2362FCD5AFC220DB85BC1C09@DM6PR15MB3097.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKUXIaqei1lyaUOY8iBDwvolyxWXq3iGytoFBE7TqKq4182e9EK8IODOTRf8Cvg9/1XOpGPD6evpOOrdGEUHzT/T0xDHYBWUvOA8JyPGn0dEm6KlecwPDwWewunZeQzknrpBGrYwhO7m/SYMsaY7rP7jhqxQRo7n65vP6kizafTl/A6YSijjnzmd1YnnZ1vA8/hs95mNUI+NcGnE/Zg8WPGUajiu1OWJbxiFjXQlVuMYYQ9PCoFRqmhh0JT7K5PeX3gE/LUBDCYPj/09LZlYCwuchXbPggaG5fseeHouPDyTvcLXGIasSi7s4z8xZWV0NI+KFkukWNKzI7R3ebDgFqxDCELTV+j6rAQ/2djPoe/hAhkJF71WKtLTyT5FTJk/WJl62cr7b4WiAKmXtFTagw3q3bEiyAxkdJLdLoNffBiyphlo7VaH6AV+QHAaTx8QoMfRkfx25vFcGsNR39g9APMR8F5RckIPF6j3i+g+qnsqm56Uu6a29WaIAiHdatRCmOdlpcdJ4mCO0oPh1Wt9ehExN594GUkf+QSTBSl/8f2h3hP21xO7gE/947+WQeIe5In89FFfAv2k12TMvm/p1oiYQlOBU/Ab0/YmOR2S9iQfuGKbxUTn2JBeY3KOKRHsbxVvUOleNh2MxTl2QGyPONxKxl7q7jq1yhc7GmQHczCQVBCpufos9j6XvZoXKgjLbokOdALfkSm+nhHAYRIwOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(54906003)(71200400001)(86362001)(38100700002)(2906002)(38070700005)(83380400001)(122000001)(6512007)(6506007)(26005)(9686003)(186003)(64756008)(66446008)(66476007)(508600001)(6486002)(76116006)(66946007)(316002)(4326008)(66556008)(8676002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pS5et29zEaSJ41XJjvjU2mRB4VanzqHAS+YLzo2NqCDNkZ3wetH05hfcRDal?=
 =?us-ascii?Q?/nxPDemdyvdBmEQ/3jI3tH5sC9urCN7ynmS4LsZ0UYaPKnE7CLFKuFakKG0V?=
 =?us-ascii?Q?uCQFtZsst7ppuLeqYAEUGJhKNJdc+iiWyFKmJRZSKrLWyfQJY/hnmwFEqxtV?=
 =?us-ascii?Q?nX9wWbzvTjVMVL0X5g9YlmVQXYRvI3aaZDqvc0i0YqvTYI+5OK875wKvJMua?=
 =?us-ascii?Q?1BSTLktDGSCLclZwWRN3xPUIZEl5FKy1hS0YZvAYMz2bAA/8nnq7NroKmYdf?=
 =?us-ascii?Q?H9LAp+SO/DTgYYK5hRZru1xsvSgG+TH51lb2GegcFJQUMB9lZlZjdlfwDhGD?=
 =?us-ascii?Q?RQfGfiy20UWhqo2zjbMLVoI1117QOd0AVJcabQRlzI3U45yLjgP7bTxmWzqC?=
 =?us-ascii?Q?oI7Tov0jkO05pUgMRE1LYoKbfZapPITKU1e2Vf3nyajUxHDiFzYfZM7tt0Rb?=
 =?us-ascii?Q?V9xxiLHTBHT5PLGb4zAI085ny0Qk3qQtxsRE9Nc4TVvwxXAlv1Yh6430Lu1J?=
 =?us-ascii?Q?3aXklIOXQGEX8PaqeysA15b9IkWpjYPoesE50jdC4cUdx4w8Y2aPsEPtzzGu?=
 =?us-ascii?Q?3LOHNfM4lFX+yFGAi4ivuG+OipIY+O29WVjEMkGNEl2sDrNecDBDrcJEjtCp?=
 =?us-ascii?Q?BR82jhHai5GdvQ37ghYOXZAAOTOkJPHFtLuGj4SpA0ASK4f92jSLHjlIXCuj?=
 =?us-ascii?Q?6cPGk/H+3PccXxTdiBm44GHBjCnCYXslxLob6XiLAktxNUtbt/Y8ljUNfRKa?=
 =?us-ascii?Q?36sHYmAjfDfzijchby+lwo0tooPYzl0J0bgz532ngeAAwVBKFMqQETdNyvfr?=
 =?us-ascii?Q?V1sl2Gb4pEK/BQiIK1mVzpuHv/LdOY5irrMIbcu11UvmU76capxmeka1jrxg?=
 =?us-ascii?Q?EqgX2FuIvpvWugJ7VluJiHhP5P49mG+EcKMXV79KR1/Td6vTAml77fsZx4yw?=
 =?us-ascii?Q?1knarxQHqHooq0DHCCd7Vr+V0VDJgu5C5YwOcpCdOx9MjlW9/vI+TOnGqTwu?=
 =?us-ascii?Q?I6zI/gujna7emOXSJ59F72WQFaqsWvBNLJslq92GhILuy28vnsbU+oRPw09b?=
 =?us-ascii?Q?iGUrSpZRXn64jniafe4nO65H/Q++BySfKd2n5L/76NpBmXC9mhOU34KCiErk?=
 =?us-ascii?Q?UFrIbNeU/F2yrN+clzOZ67GfGU+5qzpKdI9fkKmxyJs0bHWHrgF95ySubMhG?=
 =?us-ascii?Q?yi8B+zVLCI36sQXMjJg/LjFjc/AXyuTn0cq8mAOfLbFIuKvmU1YSUIU5xXk/?=
 =?us-ascii?Q?Pecxj/4gluMp/oasLmRAUNUZzvyK8+ZrWwtpHmBvdZ94s/7xMYEj8k2Ll0hh?=
 =?us-ascii?Q?dEmF2mwmbnQDP7MJRI1dq9YX58WKfxueGUzmJSpPZ0bsEDInwqPBlR1p91Gi?=
 =?us-ascii?Q?Qs3jiiR3xZIP7EW0tNd7vFieJ4e4TIUg8lh4acQ1wZMoDeziqTgky6+2GFfP?=
 =?us-ascii?Q?hv34t+SR9s8E6CGCq02PquiE/uP7Qkb5Dq9JRS2tWjm0K67Qufcqe0dQ2Qty?=
 =?us-ascii?Q?KjCx1hPppM5UbnhBeqRSPMN9wiyNkjXlKYoMrVTgBWKYNAxWGUX7j9PCK/HG?=
 =?us-ascii?Q?vQL2MthESK2S0psoP354zzulP04ZArmdiqHOJXOprXiNhRZ0lgaIWQ30fZ12?=
 =?us-ascii?Q?5X7da5aiZ+kVRDCBLVlwTspmNRaSPhMYdkXyb0kGeWPmbCn6LZxpwAHUh3I6?=
 =?us-ascii?Q?YrTxxU2yIsKk6+G6ijnMcE84IiZn2WtSsVD7f1nurHzPlz8PrqXXMVxgO430?=
 =?us-ascii?Q?hVO+u0YB6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3F8502A1178F7479008D8356D849C7F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc331ce-cda2-4846-1095-08da2cfcbea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 12:02:06.7994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uwktJo+hfh7RxSU+u7OCpIi0ctdQlYWrJqBnr9aGdOszrWF3RiBsrPXEoGWk217
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3097
X-Proofpoint-ORIG-GUID: BZwHVvDerSBZ3AhCRLc4H5cvrWeKztD0
X-Proofpoint-GUID: BZwHVvDerSBZ3AhCRLc4H5cvrWeKztD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_03,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 29, 2022 at 05:30:10PM -0400, Mimi Zohar wrote:
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 13753136f03f..419c50cfe6b9 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/kexec.h>
> > +#include <linux/memblock.h>
> >  #include <linux/of.h>
> >  #include <linux/ima.h>
> >  #include "ima.h"
> > @@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
> >  }
> >  #endif /* IMA_KEXEC */
> >  
> > +#ifndef CONFIG_OF
> > +static phys_addr_t ima_early_kexec_buffer_phys;
> > +static size_t ima_early_kexec_buffer_size;
> > +
> > +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> > +{
> > +	if (size == 0)
> > +		return;
> > +
> > +	ima_early_kexec_buffer_phys = phys_addr;
> > +	ima_early_kexec_buffer_size = size;
> > +}
> > +
> > +int __init ima_free_kexec_buffer(void)
> > +{
> > +	int rc;
> > +
> > +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> > +		return -ENOTSUPP;
> > +
> > +	if (ima_early_kexec_buffer_size == 0)
> > +		return -ENOENT;
> > +
> > +	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
> > +				ima_early_kexec_buffer_size);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ima_early_kexec_buffer_phys = 0;
> > +	ima_early_kexec_buffer_size = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> > +{
> > +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> > +		return -ENOTSUPP;
> > +
> > +	if (ima_early_kexec_buffer_size == 0)
> > +		return -ENOENT;
> > +
> > +	*addr = __va(ima_early_kexec_buffer_phys);
> > +	*size = ima_early_kexec_buffer_size;
> > +
> > +	return 0;
> > +}
> > +
> 
> Originally both ima_get_kexec_buffer() and ima_free_kexec_buffer() were
> architecture specific.  Refer to commit 467d27824920 ("powerpc: ima:
> get the kexec buffer passed by the previous kernel").  Is there any
> need for defining them here behind an "#ifndef CONFIG_OF"?

Commit fee3ff99bc67 (powerpc: Move arch independent ima kexec functions
to drivers/of/kexec.c) moved those functions to drivers/of/kexec.c as a
more generic implementation so that ARM64 could use them too.

I think for platforms that use device tree that's the way to go, but the
functions to generically set + get the IMA buffer for non device tree
systems were useful enough to put in the IMA code rather than being x86
specific. If you disagree I can move them under arch/x86/ (assuming the
x86 folk agree using setup_data is the right way to go, I haven't seen
any of them comment on this approach yet).

> > +#else
> > +
> > +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> > +{
> > +	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
> > +}
> > +#endif /* CONFIG_OF */
> > +
> 
> Only when "HAVE_IMA_KEXEC" is defined is this file included.  Why is
> this warning needed?

x86 *can* have device tree enabled, but the only platform I'm aware that
did it was OLPC and I haven't seen any of the distros enable it. I put
this in so there's a warning if we have CONFIG_OF enabled on x86 and
tried to pass the IMA log via setup_data. Can remove (or fold into the
x86 code if we go that way).

> >  /*
> >   * Restore the measurement list from the previous kernel.
> >   */
> > -void ima_load_kexec_buffer(void)
> > +void __init ima_load_kexec_buffer(void)
> >  {
> >  	void *kexec_buffer = NULL;
> >  	size_t kexec_buffer_size = 0;

J.
