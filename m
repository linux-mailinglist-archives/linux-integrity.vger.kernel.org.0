Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF55203C2
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiEIRuW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiEIRuV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 13:50:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856C483B7;
        Mon,  9 May 2022 10:46:26 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249Ek1FO002591;
        Mon, 9 May 2022 10:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=i/lCVF6fcoFe5hDGMdQQKhRagdIpjJCUYM7rUySDq78=;
 b=VPezwVtGuNZk6/3fPgotNsSAXRPYZ952WjxG8a21aFMBBgvX2Z+ODIR1ggcQDqkk6Hke
 6sl2LOPPLk44A4q+X5oYr91yGHsYB8ubO7FQSyMxz3X0NMkIUNwsnH3qO+IWJekRpH4s
 TQjX7KngXGVizDdFIJTMIkeSuT9VL0befxo= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpfmtc14-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 10:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWEf9bTFehomkEdIThyVuNMPxRxqFzHQF8/s5WnHz4iJdQ/wfFb5FguOVIjl5TPA95pyP7BYeAJnvlRz7WMXIErk94wLpXCcqvq/BH+BHBUErmdcsw1RprRbD+YMUeNFAGZMrvLEhQPXx9voBENg7N44s1k6oo+e1G/ExcCQGLFyNSML1eDDtpkNMOOp3rkFxHD0R8Jb8tYJDKjrO9KT58wBJFd+QxBFvfyOE/3ePPmu4Mpk9vzcEXkkQHI4LVo1Q5dDn6KkJubaLtAdT/xt8Wv5k9LRKUuvgW04oxAi4hZlIvK+e3TWJ3tVxdj2y1yns4z3aFpEaeAn7eYincCNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/lCVF6fcoFe5hDGMdQQKhRagdIpjJCUYM7rUySDq78=;
 b=YEgjdwKz4Y0w0dN6h5d8YrSoN4xg7717KMnv+wCO9wHxr4nKmPbHrkFIkfPSIhuRyFakJxDkKkx4v57ybReUvfl9y7xq9WObh6aYMzF1zffvbuSYkSBq+2rmwLOczpFLNYmDSe3meHPjbTicTJGJD65jazFkLN2/UX4ye6uCy8/d3j8EDCrt1VfyNpUZmmD2AgGusr2eyY80C8t6rQ2mWDzeul5DyfR5zupnqcSvxRZHK6pQXoHCRCmT4mT2SQDvfEqMPHOiw9oYat7V3YAVufryFdV6xxFhoF0voHAiI+2g6473CmvYivZlZlVG99il8WYkLoCjb798sCX/A+RsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB2825.namprd15.prod.outlook.com (2603:10b6:5:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 17:46:22 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 17:46:22 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Boris Petkov <bp@alien8.de>
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
Thread-Index: AQHYWY4yqojcPM99qUKBDg6v3vLzMa0WbyIAgAAMsgCAAGptgA==
Date:   Mon, 9 May 2022 17:46:22 +0000
Message-ID: <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
 <0960C132-581C-4881-8948-C566657C3998@alien8.de>
In-Reply-To: <0960C132-581C-4881-8948-C566657C3998@alien8.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d5634f-c3bd-4656-2c6a-08da31e3d4ba
x-ms-traffictypediagnostic: DM6PR15MB2825:EE_
x-microsoft-antispam-prvs: <DM6PR15MB28252481AA920A9C02E41E8DC1C69@DM6PR15MB2825.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xz9BDLsoLtE9YtldtY1e3+m5J1qJy/TPFS6a7gPWnX3sgHloToeKOJfA1tChndi/DEKHYF2GmKteMAgApnz9t4lMmIPlH6yyma2i481SmDGmvTr+p2Qm6XeIlY+zlTlgb25MirKC9eX3W0N4tx611fnkkDhKjdg0kBGG5YzMUo4Po0QDfE+ng5cUTUaRNrDwm2cSih6i+oTQ4P9XDaygOpsVtA+80owvCGNxH4DY0pDOae2v31q+uqeZKlkl3CpZxuEbiXLpmN+7Md1MuEiJvZl69Cz4CzjK1KtAq1T6L7z5/sTrUcpJGsAs1r6ZFVJGUT5neWH8o0oX9mf/8rr94bArRmh5nFWhQtdTPbgnk0qp/29tLxPZy5j0+a9m9zzgsXxmiAZxlPPtRbcQQGGgB0qJsRjPObvykz7iY/hgvf6z07c6MnlC7liX3q0euFz8AOXdDbj3TxvI4GDoy5cqNbjaCtifpv1QtNv0dOL8TX9058xpWaIorFvkx2LTCGfgNxtMDhMoVORZCooNO7jAVs0CBvXTw8VJPC5jkgm3AHBMHPv+m0PGcCMgxdaqbNAPE05v5Gd+Biz59JqwiX3p6NZRCYUxQoks2UNaEZVVef6fY9K0FehuLuK19b4+slARSR94gu1FKCK440Y+WQoSfBIZu5TVC6CajGvIouktJd+o2/Dh229SydhwUgqT2V9aGe5f2YZFCX1F+QvQgvMezA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(71200400001)(508600001)(6486002)(6512007)(316002)(6506007)(53546011)(86362001)(186003)(2906002)(5660300002)(7416002)(122000001)(4744005)(91956017)(54906003)(66446008)(76116006)(66946007)(4326008)(66556008)(66476007)(8676002)(64756008)(6916009)(38100700002)(38070700005)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5NB+xx4eBJGiNEakf6ed5AvfAeP22SWCzpYLur8vMso/iajdEU8k3SNV+LXZ?=
 =?us-ascii?Q?6PpJidb357jNniwQcv7t6bUCsg9m9C7DOS0MpryIBMxxInMwQw1DgzFBMFa8?=
 =?us-ascii?Q?6K1xheHTHn9BpRXt20GLrSFkwbM7rUNvBlWqbiyw0IJKWGIx0N37gNwFA9Mo?=
 =?us-ascii?Q?PdKxsxuwKINVssBwLPirLAW8TOT0nYZ/DbcjJ97+MKHbTzWju7rGYRdGjV2M?=
 =?us-ascii?Q?ZO62edlkaqCu4IIvDpprMJCv4fmIDGQ48YHWbthSD3TW0FQYC7cfPyWeyEg3?=
 =?us-ascii?Q?i3KJJa17RDRYiPJxFXoiimZOU1BOf+mXPVduTFXqdUVBPttvb8SZ0xp2hf8M?=
 =?us-ascii?Q?iR2Cluspw/YpXVpQlPvfv9QdHopIQBZpGhthp7+dbBMjeqJO6L3aFB6FZZNt?=
 =?us-ascii?Q?sd1kpGyp9CmFX4Yf4v3BNXwPMHNjjB54Z5JG7baY8+dfAikQF4X4ge60pKRw?=
 =?us-ascii?Q?JRxkCTxaggQLp6IH9Uex4UtgOC7vt8QtJMNw1jVChp8+amx2TITAWI+sVWXf?=
 =?us-ascii?Q?KE7gfSBhCuvJQR6sjJWvAAZC1nB4/KHVrkKPblx4DaTHPc6BSFj5n9E5rgvO?=
 =?us-ascii?Q?HTY0YcLCWMOxGXIYjcQXu05vmDrHS85kdkb/yuOyQ0waACvWtgXzhzJXXLJd?=
 =?us-ascii?Q?WTNdwVI+oPYu2giM8mPtJgQ/3C7yopp8ETTUBJLFcq7GCXSBEix5PXUEK5c8?=
 =?us-ascii?Q?ez+kKZAXTxoXfEAp/XOoDkvRT+RY0PgnDLz1W88UeOFKjUPFRLg9xQr6IrBz?=
 =?us-ascii?Q?cQLoxt91NDWL0bA9oSElFwv0aLeTGNSuzelOx5OnT5AJqrf4eDpvZNzdyhnr?=
 =?us-ascii?Q?ffYqWbxG3M6rRCuoc0O07+L2qukFtlsLWNRLjo4BAWgp99E9zIH0zHBtvkrw?=
 =?us-ascii?Q?KMfNID4c1CTAV2SuaJfgIgyd4dH/0YB9EItJbO9N1ow/HPTTbSNYXGDKkV46?=
 =?us-ascii?Q?jbU6MhKj91kRboG3t4BgidC3iVBsdyejuH6UqKPMpM4wfZQXpSNQhQ7d+BTR?=
 =?us-ascii?Q?/G+fC8iWLAan2EfNLWxRgC/fLVCQwkYyUQkddyImNuiKIweFDQjw6CeGsaid?=
 =?us-ascii?Q?KRNTSWIZa5epyh2d3ADYljAGkjTdzKVz23+U72/dfqIc8+DBAqasA2BUr5Ru?=
 =?us-ascii?Q?Vi8tv1Y4rwBpZ5eKo4+fhKK3aewCMoVJaBaQJBzuUpNAZ1321pMtyaolCnEs?=
 =?us-ascii?Q?GaaP9ZR2Oal2Ib22PaSan+fenjzO9hQgLPpOzLXGaUSeZuOIXjrDBBIjssJK?=
 =?us-ascii?Q?7N5zesr689KdUNIgdUGr8JkA7BpH4Mu7UV2uAldehAsWlr8AGIWT/qm8O4V1?=
 =?us-ascii?Q?FMWQh84F/zvvMjbKjz17/Br4sg4oOWYnc2m7nS2v0L4itRc11eBuvyOxsilL?=
 =?us-ascii?Q?tzXxFGIld8gydvbwLJ62PMsTlAz1RfsDhONq3lDYlFDDmp7Us/z1mXGo2DWz?=
 =?us-ascii?Q?FJM0X65O8qRkUy9wP0TAzwL83DFmRs24YXyT7Ro2yJKAURe8xN846PT6ij5/?=
 =?us-ascii?Q?abu4lXBOTXZPuUt5ylNJVk0R+HMQDZui0UlZEYJD6ve7NpYry510WvbMwmpp?=
 =?us-ascii?Q?zCnQFbL/5/AyMYhMnDSIU2jsbmaQUgn5YuFpF/xkyVx8SrjDiKy4t8R7tU92?=
 =?us-ascii?Q?M3BuQznVagrkWul960a4DmDDF5ra2H65nUKxFU9zzqPCYWiRTMNdsz+efW6o?=
 =?us-ascii?Q?l4w0SDowxS3dHituRPCUzrAIVPtF0bHlv40MpLwPfzQ3IBMSPNqPhMRBqA2S?=
 =?us-ascii?Q?mJyfujtItg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE715D2563BAEB49999DCDE446E626D5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d5634f-c3bd-4656-2c6a-08da31e3d4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 17:46:22.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gnkZt1k0uU9UAhxKZyi5k2qj93JYNcA0ebB4tQRHbCSumDoATxG2EgpTcruSoEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2825
X-Proofpoint-ORIG-GUID: CYxnl5smo-JDtgAx8CbfK2oYgVoLZTYO
X-Proofpoint-GUID: CYxnl5smo-JDtgAx8CbfK2oYgVoLZTYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_05,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 11:25:22AM +0000, Boris Petkov wrote:
> On May 9, 2022 10:40:01 AM UTC, Jonathan McDowell <noodles@fb.com> wrote:
> >> powerpc and ARM64 both achieve this using device tree with a
> >> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> >> device tree
> 
> What's wrong with making x86 use the same devicetree node(s)?

Device tree on x86 doesn't seem to be a thing; none of the distros I
regularly use enable CONFIG_OF for x86, I can only find 2 32-bit x86
platforms that actually select it and none of the plumbing for kexec on
x86 ties in device tree. I agree for platforms that make active use of
device tree that's the appropriate path, but it doesn't seem to be the
case for x86.

J.
