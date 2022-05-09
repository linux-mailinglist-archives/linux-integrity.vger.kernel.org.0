Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDD5204AD
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiEISpU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiEISpS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 14:45:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F951595AC;
        Mon,  9 May 2022 11:41:21 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249ILb2G026338;
        Mon, 9 May 2022 11:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=usv8kPMXl4+KtapWLjLP2/jr4O1xV5aahUPWZCD+RQw=;
 b=pl/0UGbY/ZR4LqXcKHlhQXpQFWA6+VO/89Hy5XeCzbNVzzbTncYMKxNJdeAeXyH+lDqA
 XE/hayKjEovVMRdmFX33/XmNMYcBVgw7xSwQYLBNkEYA3hlfkMt2gKUrLqY9AUAFA0IT
 piLD3DqulIivbTb5nUUFSFuLXY/1QPU1NMI= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwr33jgkx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 11:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/tGT0mg2kQaRkB10WNCnGzSf4cWMIGVOW9OOG++xsGw82sjxg7VzRRxAuNgtguYrNCb72Vnk2jS+1y2AWqCQ5uO9Ce6q9BE8/VyeLEO6QKeI535ru06Oazd80rJouVLxgmmHH45IbE5iBEdADDa/d+zRNxuhc3Mf/AMvw1CNc1ig5sxJCODqIUDusMdEiaS7tmOktOnEuVX+xFcsTJ3/SdCInMCao1jav7eBNe6fB60fN02poslEXcGGk4DUSVNEzyqSUaJKcKTAfg+MFJwOI8+IGDUtR65RMDUUQfVwUsFFReDq8R9UEVzVWEZBmVSP/gPSRkbIWOH0gbqNS85nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usv8kPMXl4+KtapWLjLP2/jr4O1xV5aahUPWZCD+RQw=;
 b=Cppt4++Bl8jlzNw9qvnzsFglXNzfFv9diKwvXJZMEB9cb2v71gl3brfUM0VRDDsfCslLU45H4xqdX+jLBEDRtkkffFSnBljvsVaqlugU4uDlu24k4lsPydOjn6A6M+HtkH1v9pBYmxkyXgoyKpHxebFe0j4CHN8+aEmm5pBG6AsETI1y8nydGyRnUaYFm8KkWn7kLEYZDzjnxfgh9RsUe/k1dYCvyWPtd9cGp2DA/5F5smK6bG6KiL0uoHEnIutpbBPbWx5NIZ3a2662rIAuXKPIn0UxE/dLAMiz2qypETMR+GRbS6oLiD461pZ8BDXDXZdY5bOvgIEYau/0zxnl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by PH7PR15MB5426.namprd15.prod.outlook.com (2603:10b6:510:1fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 18:41:17 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:41:17 +0000
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
Thread-Index: AQHYWY4yqojcPM99qUKBDg6v3vLzMa0WbyIAgAAMsgCAAGptgIAABpuAgAAIwgA=
Date:   Mon, 9 May 2022 18:41:17 +0000
Message-ID: <YnlgTCyB2ciaD1so@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
 <0960C132-581C-4881-8948-C566657C3998@alien8.de>
 <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
 <YnlY87wm6WmQjs7m@zn.tnic>
In-Reply-To: <YnlY87wm6WmQjs7m@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b5fcfeb-adb7-487e-ab4f-08da31eb80ca
x-ms-traffictypediagnostic: PH7PR15MB5426:EE_
x-microsoft-antispam-prvs: <PH7PR15MB542683F451089CCAD059100FC1C69@PH7PR15MB5426.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKZJZCoKkIfXpkAU7MfvYeK17fGsbZ4/nqpuidRDuqbt3rc4RgIEKIqaTxiQ3r5GNHqqs6HUZ2k51z+hiImtURrOiZYWlQdVA1kxb5Wr9FPWeId61UJbzpCMGo1knDi+RV44frDi3IJi9FYlXWoOEBaujNuGnkfS3QPaKH4MAw2LZMn6sLuo2zJme7uRGr1hySb/KojQEJmO2fB+d5aFCVOu4Qt65nTiXpHiMWsCRXUG7AiAXxikCbRtaFBEcAC0ipHAhMr7fEyIIPuJQFzC26v48eoNe3qW8TWqu6MGhARmEmQhpxRJhxQk7DfZ09uNB7EIVxxoPvZg5c/DKzBNWKiKSrfaL8uCIyH09PAUNe5LrVVTsUHvS2mW0khyZGTrAvA3yvEU8y5rZOMqhgk5Au1ZvQvy+VXSWRsHfyO8FblwddHArA0O36vf8Zo+0GibkHJs2XZnzAXDYfjIyNIP00GW8i2XveAoiHRnEEQxRuPvHu+J3G25E1GB0p0VW305s+oF7WkJD2S6x2SLnOcTZqiPAqOEMHVRH8WDSiuasBU/VN65DLFRUNOgxConB7GFgBzPZrVAdmAuFsYUKf7/lAticO/wAsfklgybjXFG5nVeEVxB6pSEtM8bXrmnYHxfWXN+CKMrGBBNOX5dLcbPBKpV6lH6NTDilG01WVgVHu6NFTsuTMzGwd+IOdBmSC5XtM3WkYXnsU2kG9yk1Qy7fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(7416002)(508600001)(66946007)(38070700005)(54906003)(6916009)(316002)(8936002)(6506007)(9686003)(26005)(6512007)(8676002)(83380400001)(4326008)(64756008)(86362001)(6486002)(76116006)(66446008)(38100700002)(186003)(66476007)(91956017)(66556008)(122000001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F83e/CRYUWYsuQNxqsLu/92bc+iqFA8PBXTukXbiC8SZ5MkfbOn3jZYx7gvz?=
 =?us-ascii?Q?LPjofqmgcveDSvpFU8S25D7A23CfNvhO24rJgRUqVo3M2L1d/GETjvgd1k+k?=
 =?us-ascii?Q?TKIcyv3nFYNNVKJ0LijemwC42NuZ29Cu1Bt55Nz2D3WHj0Kg0PIp0oC07A5N?=
 =?us-ascii?Q?2SAAE86L5bgfQB3+I5tob7MlVIssrbaEZukzelISSwX6pm9owsaWTI301Wn4?=
 =?us-ascii?Q?BRF0P/ELq6m8iRiPauMbxZv0U656T8qWDaiJhPHKC1p1NfCJT9wnB1j1cM7+?=
 =?us-ascii?Q?8CycA5Kv0hMvVZB+cRHT1lzv8Sbh7HzP1Z383swYJgb6d5eO/hQUz9aRQyNj?=
 =?us-ascii?Q?Bd0LOCXDi3Xb/khhAivvpp4eU3MxpT7rqIaYKp1vhyc+7jwsAQOxGSRaS7q8?=
 =?us-ascii?Q?IjNiIxTQ5/o9tRrLYK7ijigkz9XDReZhXvK2w+9MBazUR6d7Zn9eBIh5qIXk?=
 =?us-ascii?Q?FZmv+hAVBX/WPj2F39gSJvtTdUWM+rxnnarPA7dZ74hBZgri8qKBu8zAg3fO?=
 =?us-ascii?Q?0R/+LUlL23orirDmjFy8nMlq2/8ot6Ax05pqc29vg58/DhqlWsQcGjFYXdz0?=
 =?us-ascii?Q?MDeD9TkqMi43ZMqHoq7rj6zgcVumd6VhcQE28N24vMsHgHR6RJeI57W6X4li?=
 =?us-ascii?Q?8yD/qiOhn8siOyPKGHMgT8KAS3tvE5yWzhvlnkFtFgSGcHrAbF9cTNEquaoC?=
 =?us-ascii?Q?Fh4aPVfZDJ7T/G5Sg6hGj+jEvE5twVhLjzDzxX31Ykx6aOJiCrZVtni8Q2dr?=
 =?us-ascii?Q?uhk6rCiNW9kD4VO3XIWuYHDcEyBL92BslyCNQjnJop5qSUtnuayo2sBBzSrD?=
 =?us-ascii?Q?NcBHVVkzZdQHfupf4mw9YxhbHdlfbf446J0sb65FqxU8ZQVZtKCyvaUtPJ10?=
 =?us-ascii?Q?yAwxx1MnehFo2NctrZWFHtO3Pi4JaUZIXzxsK760GLf209sSPVqEP+yUYqTU?=
 =?us-ascii?Q?tuMaOx05Vy9TBdW0q9j8WEvrpEIw8DJPghLwEHSF7FU83bpsOfukJoOwKFKb?=
 =?us-ascii?Q?5jeNo4sIhx6u7/xWSrmBUvthvGw+jpdL44r2t/hOfjhgCMwoc4+Xw3WNzyat?=
 =?us-ascii?Q?uRedmTnhSQYg7JK6caB7AYc7nlE+DdEFVNlVl7xSC7nmWIkBZ2LOMcVpap2I?=
 =?us-ascii?Q?MX+wLl3mztnCQdkMll0meUe4J9v7QSgLRLKzox9/uKkrJWAFaxy1IkN3O/hj?=
 =?us-ascii?Q?mfrOUGgcw0AzmLklN6VpntEj0LYZwcBhU5VvReWkgPyNk/rw0e8DcloaSWKc?=
 =?us-ascii?Q?BOrqZxAEisDK1hQv5jdNd0t3T31gnXv8F6WJcctWxPpgvUUCdeu/DHhuXL5l?=
 =?us-ascii?Q?fcqFkxUs6kqL+0JZR4eO63uK60BrcWueMMUF7dGE+b87vm5n/0+L2X+LJdCf?=
 =?us-ascii?Q?JKGybf/jEIhMDg+hNSPu9LXtCVVVVbjGSmnwIgQ89xlDUMXN4cEbE0D2H9ym?=
 =?us-ascii?Q?xvHHTZVX4eaBT1yuzscUdv1WNGm35ExZsnwWR5leXvzYho0McDPOuhXKqPok?=
 =?us-ascii?Q?SM8Y77+c62T1b5jMfe+J7Ls+35UsF0WhGAlc4uLMClaz27ySOOZKgHLqtS7A?=
 =?us-ascii?Q?mfVnCl54hqsKCqRGC0o4Y2e9JWyGzoKwNfSGNeu02otONbykkpgrjHBWSdzW?=
 =?us-ascii?Q?uhFkredvK9qq/CSC1ZuO/0k616NcmoXYcq8p8dRv9yAmS7+4pVbVpWq9X9XT?=
 =?us-ascii?Q?EnLywF8lLHtENX4iALR4o5F3uNevNxRXt4kL8CRBAuFGWCpviHvsD3aW1Riz?=
 =?us-ascii?Q?/V0ADYCAlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6C2ABE3CCEA764FBA07387155284801@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5fcfeb-adb7-487e-ab4f-08da31eb80ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 18:41:17.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POBNxfyilzTr3Wq8TvcVdtsEJ8+gey8CctdgoK1fCsGRGyGrL0nWNpYBGMxF0yfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5426
X-Proofpoint-ORIG-GUID: f5D-41B5BCmoZZAX118l_4MyvJ5nDA_1
X-Proofpoint-GUID: f5D-41B5BCmoZZAX118l_4MyvJ5nDA_1
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

On Mon, May 09, 2022 at 08:09:55PM +0200, Borislav Petkov wrote:
> On Mon, May 09, 2022 at 05:46:22PM +0000, Jonathan McDowell wrote:
> > Device tree on x86 doesn't seem to be a thing;
> 
> Not a thing? What does that even mean?

Let me rephrase more verbosely. Device tree on x86 seems to be a rarely
enabled config option that is only required on a couple of platforms and
lacks the same level of integration with the x86 boot process (compared
to PowerPC and ARM64) such that a) there's a lot more code that would
need to be written to even get to the point that it could be used in the
same manner for passing the IMA buffer as on other platforms and b) I'm
not sure whether or not it might introduce other issues due to this lack
of use/testing.

> We have arch/x86/kernel/devicetree.c which adds some minimal devicetree
> support.
> 
> > none of the distros I regularly use enable CONFIG_OF for x86, I can
> > only find 2 32-bit x86 platforms that actually select it and none of
> > the plumbing for kexec on x86 ties in device tree.
> 
> And? That can get changed and enabled and so on.
> 
> > I agree for platforms that make active use of device tree that's the
> > appropriate path, but it doesn't seem to be the case for x86.
> 
> I'm not sure what you're aim here is?
> 
> You want to pass that IMA measurement to the kexec kernel with minimal
> changes, i.e., change only the kernel?

I'd like to be able to take an internal kernel buffer and pass it to the
newly kexeced kernel, yes. I'd like that to be possible with the
kexec_file_load() path, which allows for things like kernel signing,
which I believe precludes providing the data from user space.

> Why can't distros be also changed to use devicetree for the IMA
> measurement, like the other arches do? Why does x86 need to do it
> differently?

> We also pass info to the kexec kernel by reading it from sysfs
> and having kexec tools pass it to the kexec-ed kernel, see
> Documentation/ABI/testing/sysfs-firmware-efi-runtime-map

AFAICT kexec passes EFI details using SETUP_EFI, which is what I
modelled the SETUP_IMA support on
(1fec0533693cd74f2d1a46edd29449cfee429df0). In the old syscall variant
the kexec tools do read /sys/firmware/efi/runtime-map and create a
setup_data entry of type SETUP_EFI, in the new file based kexec that is
done inside the kernel in a similar fashion to what I've done with
SETUP_IMA.

> So is there any particular reason/pressing need to pass the measurement
> with setup_data?

I'm not tied to setup_data but given the concerns I raise above with
device tree on x86 and the need to handle this in the kernel it seemed
like a reasonable first approach. You seem to be saying it's not and
either adding the device tree infrastructure or doing a command line
hack would be preferable?

J.
