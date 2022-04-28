Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AD51316A
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Apr 2022 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiD1KoN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Apr 2022 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiD1KoL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Apr 2022 06:44:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2353B6F4AA;
        Thu, 28 Apr 2022 03:40:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SA3ur4032321;
        Thu, 28 Apr 2022 03:40:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=4lZge/zvhD+hV6kss9z5AY6EX5NCYcM12xRADgKBjr4=;
 b=qR6ub8IJIySDQJAbLKyEbz+WX1yOeO8FCIDWZdenOhrhn2uaxZtpjArbTEjpNdUtviIo
 /b+AKvq4HkNio9jt6F7aCXcQI//o3y+Bua4knC7cMsaJD2WdrsU3rinpi+tys4ytQ5rz
 KNLo6ll95tIH2XiyzL6L3ckdKgyuWbpkbuM= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqf18b1nr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 03:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXk2B0XFa6keTm6Rld/U9Ouja/vhQb6YPhJ0/i5QpiYw9513NTp+fUDODRmLKQ2fAAeZHwEK/Zf0iOo+6hYBIs8aIP+KH6mAS9FB38DNugHiTM9t11Qw2xVmHu2MfAVma8kqyRfSYXPj/eGGMGVIyGE8SQnwTw/v2IpQRtA7SjMAB/G74M3PcHPZEFYmfW/88yAd5W9hAbnVAyVPnop3w4fSK3PYQVv5CRw6exnSu+cSdpJTq1ammfLWUOWmqNutSpRgBiBRuWVWBMkusgDQA24DyuQpal4dGwGFfu4pSG2PJW74lUuk0C6g8CuOf05iuWrclOo1fM/fAawlFO3+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lZge/zvhD+hV6kss9z5AY6EX5NCYcM12xRADgKBjr4=;
 b=VFynJ8c0KoEF1U8EaPLDHthN0zx4Ug6022N/qU1yDOvAxxBVnkhtwFJmNXlfWMe3ILXn1htFwfCAk1xToLkfQtP41R/oZEqako3SiDSsb+6VAtJq8GwyKnbvOlTxvit/v9FMavZA3TLDeZ/6Os0pI/MFKfuHpQfT+FjBcBmb3OIB5VBllnsIYqoo+lxF29/zxQKPI/EBrtcHpJAqKag+fvx28/rxJpOvEmiyKH6lfLDDhPjFFpxtlFgi19UAsYwxKF8iBASGmJHK/oxh7dlATjLKUpRTEu5lIcAv00nn+sKVOWLfOiR6rl0t4g9Wvl+8E9IROjI+Hwf48FUVZORQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BY3PR15MB4915.namprd15.prod.outlook.com (2603:10b6:a03:3c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 10:40:52 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 10:40:52 +0000
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
Thread-Index: AQHYVk//Rm0WwwIkeUGnwDIT6Grq2q0A1peAgAFJh4CAABxEgIAAMeMAgAAXEACAAqbYgA==
Date:   Thu, 28 Apr 2022 10:40:52 +0000
Message-ID: <YmpvJ5JziMS+M3j+@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
 <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
 <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
 <YmgiWpHWH6K1feyt@noodles-fedora-PC23Y6EG>
 <06a1242830ddb84c52cd77e548c71d40a0eb5e63.camel@linux.ibm.com>
In-Reply-To: <06a1242830ddb84c52cd77e548c71d40a0eb5e63.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edf22dcc-eda5-486f-4433-08da2903910c
x-ms-traffictypediagnostic: BY3PR15MB4915:EE_
x-microsoft-antispam-prvs: <BY3PR15MB4915FA4B3F93373092EEFCE2C1FD9@BY3PR15MB4915.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXLBX7DldDftSehU4aqhuLvdFjlzsD2g6j2jgFGVqLIAXW/oS7vyz4GJWUbAAq8N5taU6qvNjy06ozU8u4dV4Z+8098DuZptbX+j8kI4GV4R4y5101diTdlnY3evuhn+PlnKvBVISxr3e0H9/wSeu5kDQCSrkwdG0y9EnqNQwBZueOWUm46gOdUYTodb5/VKwuug3RUH6f/n7loOpIb0FWShhwFBesWCv76sK0PsnhoZG0Y2jgFcu+YYvawycQJlhiOVDtChBCK/Gqfs23hdmPN+9NVN+nLBruxceE783UYJ0mpEPWLxU2qGMLor0w4ZJrMJnUMhltTm5H7jXQlE8+rVKU0L63KJbTEib5A0+QZfe2IjLWK4cxHYHyofaX0/2CAYE5sh35AONnrX90MsseftD7NA20e0Lo62rXJ6wJG5aIKalsraY4Admf3cJTcV8peOONT4WObQrQ4rT1xX0fjUTgflyG3fOubnOA75uvFNE3bIfGqnrc4fMVsX24tz7fd7jyXzgJIxjuJUVpqFIQZazHfSCQyfrhwx8s1FtbRIecgIG7QITDbru1Ui50C+yj/IhsJWJkwCVX80EjlOE9ReUE8EgFfLL92qESIvSIIcm70raY/8OQC+BUEtH17J5EeLJlO7qGAkEhuio/jhP+TVU7Xd7gjRhbt+S+5enyXgBGWkwUSkYOoke6LuuMAAPRYSNP0rCYQBSQZI3E6uEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(508600001)(71200400001)(86362001)(122000001)(26005)(6506007)(9686003)(6512007)(38070700005)(38100700002)(2906002)(76116006)(66556008)(33716001)(186003)(316002)(91956017)(5660300002)(66946007)(7416002)(8936002)(6916009)(54906003)(66446008)(64756008)(8676002)(4326008)(66476007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8pNyiOM9cgZIaBJFyOEKeTIlhOEVrUyP0x1P3qcVG3Q+qCMYlIjIHXdMEW6W?=
 =?us-ascii?Q?pkiyHdqd+4s9J6evhJ/5DBDVsEhvyk1px0/kJegPti5UqYnOxo6/IguCKqJD?=
 =?us-ascii?Q?0ItRHqdXd6LZLh5X062ELLJLWgXs30ZimPQbK0b+zip+HEylimqGz2f6DuyQ?=
 =?us-ascii?Q?79NtdTl3JDLc+aTtvqD2FlWa/rSEGPJwQC4lwcxMNs3ckANuro0ASTC9+k3i?=
 =?us-ascii?Q?GBD57Yz6TGK0B4q5UsL0N/Nmpwx7HvZqgpa36rHb8V0OV5ts0GHMAskJAdv3?=
 =?us-ascii?Q?yBvGLInPyYT+SUOmGcvyhX0GI3dz3tOcp6l0qt4KvZfiAhRg7oc37d+mvYJR?=
 =?us-ascii?Q?I9tzEd8Dyii34V0zbELs0pXMOeww2+EM7otHurHFRVGPJgD5SrKTmvKJkLTY?=
 =?us-ascii?Q?eQnQRae+CKq9pSRZIcGJs4RvqLEtubdiuvLk+v/wYBLMybmFoDCWYcEZQb+L?=
 =?us-ascii?Q?Q70FGf4vxrfndovYsHVNpVmIoStl8SMhst2TRRxeKptLrNBBbgrktNxGOgZ5?=
 =?us-ascii?Q?omlSQaJ5jYjSOT9rNHltIOLjf/tnavghfW8bXOCMTIWmTI1wMXMRswmDiXiP?=
 =?us-ascii?Q?5iLYtrFqaZx+bmla3llAbxP4OB45b+EDZgJiLuBAyx+UVURS5/gUEOO0hON2?=
 =?us-ascii?Q?7BrinIoV6lm5fzc+4aFinb+6ry1AON7BTPeDcO+yTlMMH/JDRdhCCz5zR1Ry?=
 =?us-ascii?Q?8Kp2vT/HAxDFTps++Gp+FkCxlRTj6VnjgSCQKqfEebphgT4DUhI2EgqOvOUR?=
 =?us-ascii?Q?YMLuHP9o1b/rCamYu5qRvzHWCRQaBIHeZmOvNDyQ3N5SMk3eQpZIVnM1QAt2?=
 =?us-ascii?Q?rrpFH6Rr+NmTIIXqO6Rq2RbF4xTODULtUMEFf0LzdwenGDDkd1tRSHfbG3vQ?=
 =?us-ascii?Q?FXK6RETH0D8/9SnEdPhKBm6TxFNm1Xu+bsL2gR0jSCMn5e5oKkH5+M4QmHf1?=
 =?us-ascii?Q?DPRnVmGwnx8qSknkXjTdz7JdNeqsWaXN0SUd39VfPJ7hzRJpVrMGc9xaMP4C?=
 =?us-ascii?Q?A4JhYgxF0xGUr+90zr2nNzCsHpuWTNxSaob0N4KLct4TIMck8Qvw9l2Nmmdv?=
 =?us-ascii?Q?c8p7BA2x1pOrGWGmEF1ntxEth7t2ynPKDxEJAfUbGa4iM0i8nApe1587QIaS?=
 =?us-ascii?Q?ayssamRRHnk6aU1kzpmWbSdJs5/Qob4ZtEBLBxRbWifBVWsj9fpLh4ZzmZ6m?=
 =?us-ascii?Q?iIqVF6JpgY0SKhjEQukM3Ej/eZ0ei8WxDFnM+Elaw/G+4SFDVHTDL5b5m9G1?=
 =?us-ascii?Q?1MtjezlDVIfbD82oChRkWb5JW+B11gml3bfvo1RYZwLFw+vRg/P3JQPgqHeK?=
 =?us-ascii?Q?c9mUsm6CPHAzPxjHxlvDuhp1qdpSrVKREgio/YzekelF1y2fQ62GpdAC0fyf?=
 =?us-ascii?Q?6ZHpYNkw/9ICS4AIjGgP2jPdwv9IPw++bndITBEp7Q90RDWK61qpmEfw6BpZ?=
 =?us-ascii?Q?athxXwHvhwHWUCVXkglKUCsiOTFwSEivCaDbhtklP4kg9XieLp8Psfu3Z6lI?=
 =?us-ascii?Q?/LdEN2LSH6XETxOoF8AfTZH7b/eRSAoUFUa0nIGH10180p4jIqSXDIfADXud?=
 =?us-ascii?Q?wuXp76vuyIbkSwzkj/hzuaGoYfo0oMFdndE2eXXfWFi8sNXWKAYc9E3+lQpd?=
 =?us-ascii?Q?Z6KXYenp1YXB7EbEbLEeJs9jh2X+0ZST3hpnRZ7zIZqsNZSdQBOju27p9hRs?=
 =?us-ascii?Q?XUhVfvUo4FpRLsfu3qXfJi75JfsY9k82MXcLx1hxnaUMwQUwanUn2CzSf8Vl?=
 =?us-ascii?Q?s3xuy4yoLQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CC751F435B93843A55CB02254A95A21@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf22dcc-eda5-486f-4433-08da2903910c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 10:40:52.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TCWkRJ1+53//tmJjZLhEuasOCOMg+oxmjY1c/3B2BuQ4bASaApeNu5WLN7hlS/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4915
X-Proofpoint-ORIG-GUID: E-6e0f9TS6k3leH5ymep_TzOqjaUciEI
X-Proofpoint-GUID: E-6e0f9TS6k3leH5ymep_TzOqjaUciEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_01,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 02:10:58PM -0400, Mimi Zohar wrote:
> On Tue, 2022-04-26 at 16:48 +0000, Jonathan McDowell wrote:
> > Also there's an issue about the fact that we measure the kexec pieces
> > even if we don't actually do the kexec; there's no marker that confirms
> > the kexec took place. It's separate to this patch (in that it affects
> > the device tree kexec infrastructure too) but it's conceivable that an
> > attacker could measure in the new kernel details and not actually do the
> > kexec, and that's not distinguishable from the kexec happening.
> > 
> > One approach might be to add a marker in the kexec ima buffer such that
> > if it's not present we know the kexec hasn't happened, but I need to
> > think through that a bit more.
> 
> I'm not quite sure what you mean by "we measure the kexec pieces".  The
> kexec file load syscall calls kernel_read_file_from_fd() to read the
> kernel image into a buffer.  The measurement record included in the IMA
> measurement list a hash of the buffer data, which is exactly the same
> as the hash of the kernel image.
> 
> The kernel kexec self tests only do the kexec load, not the execute. 
> For each kexec execute you'll see an additional "boot_aggregate" record
> in the IMA measurement list.  At least for the moment I don't see a
> need for additional marker.

You're right, of course. I'd missed the fact we measure the
boot_aggregate into IMA_MEASURE_PCR_IDX on boot, so although we'll
update PCRs related to the kexec on load the IMA PCR won't get updated
until we've actually done the reboot. So no need for anything extra.

J.
