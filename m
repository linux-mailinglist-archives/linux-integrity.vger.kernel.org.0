Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40CF520F58
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbiEJIG4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiEJIGu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 04:06:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F940A36;
        Tue, 10 May 2022 01:02:53 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249MUoSH032607;
        Tue, 10 May 2022 01:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=lI3k4IsQDHTVKEBjqm/VnyOVp4VWkbT5lY9VfZ5/0sA=;
 b=p6IdWouRK1W1r+qsVX4qnGO/pWbeHoWLN+EPXl6e+L6IDtvUe2Gd52fLm5gjcUuBKKFw
 ePCSIbzYIweJYXEGR5UQvnJSFARntqRawPLmasD0mFLXnDCpfsxvNqB4LeI4xbyBJ9Gz
 9FRglF3Rp4vFalYnBTH25JF27cHCDfqTQYQ= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwp9xxb11-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 01:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfBqq0yPsGdoHTM768lJmGjwFifZUQJnJ/F1aVBq66tMsmysEwpBn3ytCezS6VXY4yry0OxhXvcm8DsOvzo4v0QDVg2qO2OJKeNvL/N9pfuJnwKMwZMpr0peYjEgb26ebVckQNjDGokJ5HB71e1sakfwnWIAfXjjZtyGA2/xa8g2uz2s4DpADvaiS2l/YNwnQ8iZUnPLrlMMK2RArTjtF4Imv3HRWryXmOFFLHdAEKTv/JdGKZWih7oFuQ8He6v231VoN3S/z5zIKBRrwb8/8i7VUFWAFNvNmhpdeJ0GVLzjvCWhBluxDOunnkyFs18kJnGDN/eSKIN2UNjjvrNsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI3k4IsQDHTVKEBjqm/VnyOVp4VWkbT5lY9VfZ5/0sA=;
 b=Zj1Z6fXwOSw7ResYidB3kvOMCoDbeDvLQipbxuZ4DOwnYE6onc07Wv1vOXmblAF31bmsLar3X6FXhPHibWHT8wdncXI/XTZmmU+i1OkmJDKb6dcG5zd8dLAgtjpED4CGtaiJt4nKIEttn647yFhMfNK2sS2W702SuLUlN4MoBa3Yc3LShaobGXGlkhn1NBG67EL14AoV9ZsdwBVtlTqU5Fdiq+nYTG8aINwSCisbO0ogojInWqZ3+OSpkrgw0sgBNuVSZl9IxKChvtM5GnGnStpsV5eVk7SA3Ntl2nHGpQzHRKATd+ar4Fw+w2OrSitf6Uup+PGy4lr+HptVve/aXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BY3PR15MB5090.namprd15.prod.outlook.com (2603:10b6:a03:3cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 08:02:50 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 08:02:50 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Topic: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Thread-Index: AQHYWY4yqojcPM99qUKBDg6v3vLzMa0WbyIAgAAMsgCAAGptgIAABpuAgAAIwgCAABCKAIAAz2mA
Date:   Tue, 10 May 2022 08:02:50 +0000
Message-ID: <YnocKdTRRHVIpf4t@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
 <0960C132-581C-4881-8948-C566657C3998@alien8.de>
 <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
 <YnlY87wm6WmQjs7m@zn.tnic>
 <YnlgTCyB2ciaD1so@noodles-fedora.dhcp.thefacebook.com>
 <YnluLIEN9HH+QvrD@zn.tnic>
In-Reply-To: <YnluLIEN9HH+QvrD@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4f964b8-b118-4749-25fd-08da325b7a69
x-ms-traffictypediagnostic: BY3PR15MB5090:EE_
x-microsoft-antispam-prvs: <BY3PR15MB50905570007BA77FFF17A02CC1C99@BY3PR15MB5090.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dz1hm5JcIJSVru6ThUpSy8sfWk+rDhLsDDetQNt2EzDXZSShvquDLxBBoiLYYZdvpynZgrk3ebW1v7c88udXmuLZhvrJDwqHkXCgBVHuRe00Dl84LXDhHXLFy0gwKnVVXVBHNL4tJ5WJQn/y9iK4ySsFKUY2N6SUgVBAN74pgNk2w80Bp696VBU9nYcY/eTihPeZU5kpJ9ClAP5vQYnoJ2XP3Dn0HorjmnGg2GnxirQ7pBRBI8sii7rnBhAzp3ip19bL6XNHk76AnACtXCauF87bxFW9C8aOnZy/Dz1GA/8cwLpCvat7oe+aBv1SGz07EsTba5jeznpOf8XeLxEbjHtFpHZcuDadmCGtSacZTebka2+w7wpcQJhmhWHD25pH+hZt+3IDsE0LAlH5dk36Fkv90Cp2wSVbY83KmiUDWXKwBFKqnubZyg5apkXUV7Sw/2MEnLBbPnBd+xLyN5OaqaDm3zvVc387JhNkOzcI/j6ZmwAiwPtZYbVSWkcFw+SRRSTTBsak53SULhB16MGGW5axFFhAignwx8BKgfCC6XUKkC6jrBuFemmnYFRzogji4CozgKQWTNtFv9DPiYg0FrJleMxG7ydSWYmDuw8zbysG8r5oRL33Hnj1Qn4oxSFSm1qtbyRoY/RXCFIzok+UEHzA2fMlwLi7XEHTDxysq8XNHBfZPqGS3CezicqYImMkkGZhSO8dOO0mjyUOQtBqaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(66446008)(6506007)(6512007)(2906002)(76116006)(7416002)(8936002)(91956017)(9686003)(8676002)(4326008)(64756008)(5660300002)(86362001)(26005)(66556008)(66476007)(66946007)(6486002)(38100700002)(38070700005)(122000001)(54906003)(186003)(316002)(83380400001)(6916009)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oD4OZuuEjNQhhOuaLKTkTmGL8zDoGgoSldcKqEImqaRFAGuPAvV34kYwceTe?=
 =?us-ascii?Q?tuVwdw94VejFv+Ci+RE+XNjMsbGz5UI8JNwpMHbe7BzLjN67LHz/0nCzQXaJ?=
 =?us-ascii?Q?OX0Ccw+uxJtniIfEqS/L7bnjZF8jklOBl3OTR2PIeVbRSxszQTfC9XHRICJv?=
 =?us-ascii?Q?/0C+gfVnYVSqxTCAUu0+Vik2KkZ5N73Cqw5qJF7WsTJMk3D29LOcz2T9/dxp?=
 =?us-ascii?Q?nV2T7MdTdDZKkTSWOKdOhVsF1RtJJByU22dvD19QPPe6Mp/BOI5ZIqWQC9aT?=
 =?us-ascii?Q?9wdmyXrC+jR1i5DvmQkGW/eAlepf6A0KFXitqbLxaGKbx3gYOKJJsvNcl9Hd?=
 =?us-ascii?Q?sJsuJkK8RFENF9RcJO+JSPVKHxD8WuIbQDz+vIhEimfHKAi8mINp+nGZkgy+?=
 =?us-ascii?Q?tymqCAiYp3Q8dcM9deT/iCvLHqy+zYbhEO5MEoAiZXvlZkN+0GCoiI4CONW1?=
 =?us-ascii?Q?LjZqwn/j+EFwQyfaMQW556xtZhUr1HSIP1mcTWU+QyOg8s/lJ3roUpKF+WxE?=
 =?us-ascii?Q?jGPSYA1kQYOlUzHAJGUQSaFZM/BTAqgWz23jwJrs8lpaP8WXfqWTrOsvOnO7?=
 =?us-ascii?Q?HU4z+dVgXnhudsgbBq3NzIhmB15c6m3REZXSi1jYgwaWd7hdxXiVNOwGBfJn?=
 =?us-ascii?Q?Zzg8Ah4unkqF856w1AQhCmL86vyBoarRpInpEfMy22fizs+uIwC5l07kTIVK?=
 =?us-ascii?Q?m782in2cflLGOM0HYsTk0LKR05DewBrgX8gTDSedgImIilHyxVSa8uhiS8xs?=
 =?us-ascii?Q?mkORjc9F4SD9XoAcg8k5BAh66HZX8Xao7q9MMm6xhnjxr4CqEpQi4ykCPgjA?=
 =?us-ascii?Q?/ppl/Qlk0z8aCfHwI/wybohOyHDwsYxC7SbTCC59OfWH0J/54gV96Xf82A8y?=
 =?us-ascii?Q?9Pgp7WgvAS0G8pGwsYC5iiVwYjD+i33xoINceiHnotc2cEiILFg5TDNqRJ7U?=
 =?us-ascii?Q?QjAcIx+KIRbVtgn9rEqDT5wHbMZYAp7YJKo2DkU2A1kYpzVtas2cHDKtKNKC?=
 =?us-ascii?Q?cIcoUL3GrFYiNjrBmPTtln4KnP8GPgVJq06wjz9/D9GYdwe3YFMLRmmtpiMO?=
 =?us-ascii?Q?SIc0Ni+7z2xb3tGLpq7PQi7SzbRkH9Fo0obErTvbzEustLkWxhAbn6GxQzLz?=
 =?us-ascii?Q?g0uYN7qh0pVXkbObjmxCCDh5hWDTKMK7jQNIyejh0LHVSTSFLvmXiuyUInnb?=
 =?us-ascii?Q?v7Av7ktyQc1hLunwaQmp5qkzKz4eHR7JgaYBjZW3jVa2renMZ+IVze6Sxs6s?=
 =?us-ascii?Q?znRv2HnxOjXl6scuSK+uyQMhcv0B8AkLWeygVnU9Li3uIgs8u82GWAc/H6KS?=
 =?us-ascii?Q?Mr3+048lNQdAYwMmOlBH99ljga/024MnVP7FC+1A0KWKR8tU0YkSru0GaAbV?=
 =?us-ascii?Q?OsNkXe06aQOxl3BaWiFT2kyxKt7qrVBDzdYtZ2lGaZizF7bceNqZAjBqrTdc?=
 =?us-ascii?Q?J0sYeSlWc8/FZHzTFkclEyJi3+XBGPf+r6eVvHzS86DimfgGtxgACjjGp4Ym?=
 =?us-ascii?Q?byCruV55yuYdQXGzms6AsCTH/SGrjaFsiAEj13Brz/1pSLQzoksh9HFG1eBF?=
 =?us-ascii?Q?YvpDH7SWaBtjmsAHCAQBvnCOhUxrw6y6sOX7KfUVicgY+JoksaajuNtT46Jr?=
 =?us-ascii?Q?Od2ZVu200jKBNjK+ybxOEQT5UeuwkG/pGO9tjebEbP3SH/I00ov9ML0DlgAC?=
 =?us-ascii?Q?K/EeT8ucmLp7AQN8ow+ejga0tqt6jqHThdAAHKQYOtsOuyvABx1gM0jhHTAu?=
 =?us-ascii?Q?uyXG5hvnAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C580C9EE4C6CC489B0012AD1730B25C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f964b8-b118-4749-25fd-08da325b7a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 08:02:50.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yjm6kzK3LXDnZkzwJA/e257jSL6HUh2ryeexL7KXqeTBuPe9Kxj1uM3gPH4Yodkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5090
X-Proofpoint-GUID: dAoQbdLwWiIegPPOWhEVn-qWw0CCR5m1
X-Proofpoint-ORIG-GUID: dAoQbdLwWiIegPPOWhEVn-qWw0CCR5m1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 09:40:28PM +0200, Borislav Petkov wrote:
> On Mon, May 09, 2022 at 06:41:17PM +0000, Jonathan McDowell wrote:
> > I'm not tied to setup_data but given the concerns I raise above with
> > device tree on x86 and the need to handle this in the kernel it seemed
> > like a reasonable first approach. You seem to be saying it's not and
> > either adding the device tree infrastructure or doing a command line
> > hack would be preferable?
> 
> All I'm doing is asking more questions to make you give more details as
> to why you wanna do it this way. I'll take a detailed look tomorrow but
> it looks ok from a quick glance.

That's reasonable, thanks for taking the time to do so. I realised
another problem with the command line approach is that this is a flow
involving attestation and potentially signing across the kexec boundary,
so if the command line changes every time due to the memory address we
pass the IMA buffer in then we have to recalculate the expected PCR etc
values for every kexec after we've done the user space buffer
allocation, rather than being able to do so once + offline in advance
for a particular kexec across multiple machines.

J.
