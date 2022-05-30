Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A145376DA
	for <lists+linux-integrity@lfdr.de>; Mon, 30 May 2022 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiE3IkO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 May 2022 04:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiE3IkL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 May 2022 04:40:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01243643F;
        Mon, 30 May 2022 01:40:10 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24TN21aM031704;
        Mon, 30 May 2022 01:40:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=NlEdmC7NYjImbryESYTte73yqxxjFGoz/o3chQPvE1M=;
 b=JvryfsOuaTGWwKVPUr0NTMgYeDXe7apAvldbG9ibBuUK+pX7bO6Z+jd3WbESe7iEp2ss
 D0mgNzJsT2+TlgCjlPLmY++KT4Wj1SuaV6OVqbQiuli97QgfAKn5LSoMGCeyJKBjWKh/
 aTJ2VTOSFrUiziNkKmdzcDFM/VtelUGp1f0= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbhfwf2dm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 01:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU+/o5lHZoqEUduRL33B/II633vGaH47Z6jAvdZIxktGnBTAOqqITqVVWdY/uytEIWrLN/TKWGEjY7Wil43R1IAXwDg+uHXjCvL+yEBp3hXpnKTUv4t9rxhYloAhGooNMHbkI5dKEsjK+x+J7N4KIL8MFJzfvIwSDlr1n2Ajj9Wh4ga0chMsftnrsdJBsVP3ZRWnPIAc1r58rM/yhXdqR4Grb9jVjPKnaPfxKJZGnMksReU1Rj+ca0UkMPP/8ft8fHhEn8DymSAf+C2IlMlai3edH9lzAKQPsa/KyaYzBrJdUOJFqgi7Ug86OcMCvnQj+Uyme+BKxibPLs9Z8LUYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlEdmC7NYjImbryESYTte73yqxxjFGoz/o3chQPvE1M=;
 b=VwpzWiCBOEgJX7B9nr7JVP9seEvPyaext7nrklGTS+z0uLYIIOs+BzYhYBZ5ujIGJrbfYaT3spPx6AETg7vkWtdST6IG2LI8Vs3J9Sn6JioQlsMCGFwBft7dKfDUPCUmIT3U3z3MgAnEh+XSzI7BR+lUmTARIjkqmGMsdrtJ3KSYBnzCVWiVkJvS2Xil6mgYLFHcWXyD8TgjtPjrl48Uyg2MDFC2sM+Lg+A3wxEBq6EhEVACPcd0iQvuQ464pdymV3bueMrd9bolisCj4si6hfvqJGkYFDXNWlDCT/IRggctqK3c7AKVPj8sbMlUMVVQIu0vaUELp3INWhYc0RrOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB2604.namprd15.prod.outlook.com (2603:10b6:5:1a4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 08:40:07 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 08:40:07 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Topic: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Thread-Index: AQHYZhzxVqT3nOkmWUWyxVUnnMcrja0kvxAAgBJ2aAA=
Date:   Mon, 30 May 2022 08:40:07 +0000
Message-ID: <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
In-Reply-To: <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee13072-e550-439d-a99f-08da42180051
x-ms-traffictypediagnostic: DM6PR15MB2604:EE_
x-microsoft-antispam-prvs: <DM6PR15MB26043B80B72E20534C308A1AC1DD9@DM6PR15MB2604.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtyDKdvZ9NSTtcq9jEA2H5tUNocPa0B0FUjbhH5UBz7gWKgtXLAZqwb+y+TjVogXpwb6IhC/eMDibwp5ynOnQaEkP4aMY0jqSk/+xnEPzGMJ4xr+pw4Ci/UFtah+OeFg+O/E8TwWmotMVD8xtv5HR4vD19QMes2J3F8Gsn+gLOMkRsQwhuY5oDiLWbleGZsC2UXvariEB0aixAwgTRcAEwwNPUvLPtTBKjVF9srOM4uSnmlIqf4716TdD9OKyMxtxaMvl0aVUo/GYdT1VXwzap27Ta/SPnXbRAukWM5d3u3AjPTJv/UsHqk82r1pZA9VrzMq2K+W8e8Q1hvrvulHHYq3Xs1wvo5bZvayBhdT+QDzQp3Bi0/6chYCzyQgAKCfW6dbBl0jIKr4pfMFYl3O3QdAXLCv0stugBuax66rx43TXtA9Y74ksyoUbTu5AYHWgerESFx7dOWL6EyKEPo6caUbNZZONe51Gjo0/kauGrZSm2YoWNW0RdQk635G2sjE1S38J4BeJcHJxwPcTMvR0/kTLlV8gT+sprnXT4ANJCrug+dU7zhq8rGheSg+q13onpKZqKoIsFECvJqivU7mbZZbI2EJuhqdlb+MJQHUYyqnaKFkEzUWTn+nTGhrb5XRAxlDnLM/JRll1qzEfa0ubLDWzyQ6KOQJrW8PpxIj4Uhl3lJi4wBYVenJVfq1qwat+33GgEUhKkNviThzLkRxyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(2906002)(38100700002)(26005)(9686003)(38070700005)(83380400001)(122000001)(186003)(4326008)(8676002)(8936002)(5660300002)(7416002)(508600001)(76116006)(91956017)(86362001)(64756008)(66446008)(66946007)(54906003)(6916009)(66556008)(66476007)(6486002)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ruYMGRswEA3+0ZnEEQUv60M0HRrI4DFWvQzBUKEQXj1xIDx3lEzjJTznHuq5?=
 =?us-ascii?Q?X0/ErLtlc/Ix3uy5qk048G0o9WV+voxe+al8pkJu4OZAlW36HgBWUJBnWwWd?=
 =?us-ascii?Q?X22B8fXb50nXWda6oIYY2AtnEz+xr0PNADgkc5RpxYJzgKy9KTB7zhKenNqh?=
 =?us-ascii?Q?5A2l7UZGryAnPGz7Srhwu4CEZoSHZk/LakvJNVBezygQjULRFLH1N81rTQG0?=
 =?us-ascii?Q?bEz1JURasszxMWh50yQbh4xvsj9JlKwW2Zyo3YuU0qWfVOJU+UlRKUf3LqDF?=
 =?us-ascii?Q?GtoSW0Xi+nQbPItjUhKfrN9YmS00Aadsy/w0YX8SV808aMDqIbf5kyRUHX8j?=
 =?us-ascii?Q?bNgw0iTSRCqfZcv0Fina1EQXsHds+hKCuXUXm6RCCoxYor0LFPyj8zwfDC22?=
 =?us-ascii?Q?zTNsYBgOS5OK1PozxAtUDXVO5m/rVeO5M93GUQlyA/3mdEsN6c4w7YueRU8c?=
 =?us-ascii?Q?nHyFij/Hbe8VKY7VyObJJ3+ccTrY5AEE5/hVKd4JlNvAGBGIax6Ub1l1yzAX?=
 =?us-ascii?Q?NKY7MS9RnblcxdwpEtJ0VnsIcdaIJkCJBp3AkcjdFMN4hnMs1zeL6qTjGnTt?=
 =?us-ascii?Q?mcPv0M+o+HRjYAtwSbPOBs2luWvl0uHVX3ywhJSnyuZ7aIb1i5B4aqUtAnwa?=
 =?us-ascii?Q?87DwxIASqqguRMyK+Qd1CAn9KXkXdWMiL+EtGerdFYOUttfrUZBrNeusOWRm?=
 =?us-ascii?Q?Eu6NdRg2yK37ITankA41RGStxStEr1zgaFr/iEgAG21oFWDNubNhqUE3wWpy?=
 =?us-ascii?Q?j/u5qtoS+lz8pHriG9DoEwXOfq8VTCc8aN2BoyijtXUpv59Repg+baBDNrp+?=
 =?us-ascii?Q?4S4pYB9JCb8BB+C2F8mdw0aEkjHkMi3bq9nsLoBDttKT5vtLqUtGLZYqnOCC?=
 =?us-ascii?Q?bSG7p52G7T49cx7oq8rkOCiD+ANbwcj77t2xDiicrhBo6QFe1KPVn8v29WZZ?=
 =?us-ascii?Q?CmPOIRd1Blo8CuKGjD27mpDtqEmqUh7ERuZH2wnXven4rkbSMzR+gCaqtZw4?=
 =?us-ascii?Q?sxdfroqonkqZhD/sD6ghgdL3EzZ6UQ68wg5vD/QV8ebAUVXx/WL7yoM3Mc7v?=
 =?us-ascii?Q?vl6YV66So5Azl0zJC5gTGEGyyVH78LEBtwkhdGlUN9wWhBkbk1fMQjAXCA/y?=
 =?us-ascii?Q?ffXWF6HD4PPXXCHiOLE0kHK5bjfo6Pn0NyQt4t2BUNRrGVUwE1Z75oMEHALj?=
 =?us-ascii?Q?D5d9QR/cqRfdqDto9fhH9d2mznYbP4l6gQFKEbxmrlmyx4IfJlNXwYAL39tu?=
 =?us-ascii?Q?MnnK0D8bV7sFTmcKg3u2cEN+nzJnXCuYeFSu4veowcjn+YuilhClAxmhNk32?=
 =?us-ascii?Q?M3MOjFvcMF+6Zog3D4TpR8ynOB6obdrHh8WCUr+p4GUEJdj6NWSvNdlo6GuM?=
 =?us-ascii?Q?MqNtzL3C8n6ldvaAc3GcBcLaOrg6bJi026QY+C8XWbjTlD/06tN66flWM1yZ?=
 =?us-ascii?Q?n0h/BIejSvrc62X2YAiFRGAx7jt+6q+2piALdDkz/hp31c1ti8oBdI0Lhl2A?=
 =?us-ascii?Q?W8euGzXMxsQ0vWdfjvqtLzxEAS+zV0PyXvy8FSsbPngIsa+AISUG/tejWjGy?=
 =?us-ascii?Q?2z+WJanDOm3jYn7XWbvB7nNP3WqFyVc5NpJcB9Qb5Ajbf8FMljF5zVjDjAPh?=
 =?us-ascii?Q?ywoSorFAgVMSmE5TmfP3a8q9GTuCojIPTysAfwel/YYptAeayx/PRj14KSox?=
 =?us-ascii?Q?F7JiJT3zip54ETomXRCqD2Bea9d8F2BuXqlTtTlJnikq7j3ARp8fA0r1KQ8n?=
 =?us-ascii?Q?KQ9PWqTy5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <635819A1C704204980F829A6257BD003@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee13072-e550-439d-a99f-08da42180051
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 08:40:07.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wwr9wZQwZfB/XeZcQHHz1lW34W8cvNdcMbh57maWS8DAaIrbaTduObd3nxhaRxd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2604
X-Proofpoint-GUID: XpXUBTNMTUtCfDRv1xQVC5qgW0LVwwwU
X-Proofpoint-ORIG-GUID: XpXUBTNMTUtCfDRv1xQVC5qgW0LVwwwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_02,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Borislav,

I don't think there are any outstanding review comments for me to deal
with on this, so is it safe to assume it'll get picked up at some point
once the merge window calms down?

On Wed, May 18, 2022 at 10:43:32AM -0400, Mimi Zohar wrote:
> On Thu, 2022-05-12 at 16:25 +0000, Jonathan McDowell wrote:
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
> 
> Not from using "setup_data" perspective,
> 
> 	Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>  # IMA function
> definitions
> 
> thanks,
> 
> Mimi

Thanks,
J.
