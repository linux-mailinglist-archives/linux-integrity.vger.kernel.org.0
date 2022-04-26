Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064151048C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiDZQyj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbiDZQxc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 12:53:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBFF419BF;
        Tue, 26 Apr 2022 09:48:34 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQQg4015363;
        Tue, 26 Apr 2022 09:48:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ESDj8ljsYPN/SzqhJ84FQheoFDEhBszaVWHqDY9YjIg=;
 b=iK/DiTiUFm2JyEKz615BmuQ+JyeOsCvMqaEblhhGxMC/eN4lWgH/xdWQtGxuaFNx/pZC
 W0pHYAzn6/i3XPQTocobqHU4PdNbqjjHCUhIBugZuU6AYCsmLk3tucF5MiD3jImBmAFH
 KL3nBr63QYVo4znfITiFtO13VJNzz/afqMo= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fp6f9cm6j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 09:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyGGK48GaUeyPNaQPqJ9C8zS1zj6wGF6JnE2rtQChpTz4mF8zvkpe0nbmX8CPZoufbXzeX+7VMvjxkY72HuBkzz3xAzpo2mZW7qD1akHjtlrUgWOjUJvcx26fN/eCDO78kvOTMJvAsor9kseqbmjHQWS1RRQbHQzGwrANyu32RpI+26qFMxuJGYpC01ORZZL0//iA4tmlCbKFgZKLHe1rIOpzLQAeWkyzVTa7lOiI9c+pAOAtUmnIA2rkMdbwGe+EcsNorVtWTnYKxuePj6Xc057hot14CK9exhOXiIkS76dnI+q7z2IExR7MGpAOmdl0fu9kGlVKeiPqNTPXCr9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESDj8ljsYPN/SzqhJ84FQheoFDEhBszaVWHqDY9YjIg=;
 b=UaCEZjImLYnXxyI1VHm+NVCIzk27wZF0TLgFr+A7vqO2R57IChoHwYpxLkJq955yY+r2IfyGMMDQBfTvG54b/CUedGNBFXXVlHkKJk3Z8d9okhMHZQZRFzKO1gLIAZKn31U4q0IiGG5Sg+rrnKStD5KERl9Dqare96Hz2w0nVKTAIwW9R/Wg/Lhxu0vR5fT7t89pvUm21Al37aedhCz1zWZkVJlx5AEMeMnaapsHzJGd0buF4Rn12SXZV2vt9lIR5paeNo2gxNFuwvmdIvmE/MdD0ffIUfAvZrrHTDjG5o/ky7II6nBrjbNPeW7MpgSmoThF1HlNIoITaKexZxu7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by PH0PR15MB5120.namprd15.prod.outlook.com (2603:10b6:510:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 16:48:31 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 16:48:31 +0000
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
Thread-Index: AQHYVk//Rm0WwwIkeUGnwDIT6Grq2q0A1peAgAFJh4CAABxEgIAAMeMA
Date:   Tue, 26 Apr 2022 16:48:30 +0000
Message-ID: <YmgiWpHWH6K1feyt@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
 <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
 <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
In-Reply-To: <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9114db21-32c8-4d29-8a29-08da27a49868
x-ms-traffictypediagnostic: PH0PR15MB5120:EE_
x-microsoft-antispam-prvs: <PH0PR15MB5120414352A5E1F611BFEFD6C1FB9@PH0PR15MB5120.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l40xHzUa78ZnvGb7sus8Ole+KJafm84Rb+d60sxWVKfhRccH/Vdk3/noDMqEAxXiZENyDkrWYM6bqg1dCv5C/OCKPZW+yUX1ilq1xuPbuMZjiykBVZS0bxHxx3MkrPqvVIW9mLsRoRMPOMwfwGVZu9oRYItkQJfaePtgB7PQEz+3IJ5B+hU34uh/ltA7ul5KZc4r0TfhXF2xvBz87uALbpl0FHKh5OmDq2dckucMKRGCjQwBTM55U177DPfR1Y7Iu3eWB7KUah7ZuKsZkLbRbM0pFdKIDFe91qkHnSONO1uR4agQqfKhkSaql1llI34VTIutTs/X2Dpv7p/yZP20zNsgJhyS4a9+UCwXauCcAZo2U6x7N7OVcQUJgC/0eKqq4OqhT+nHJTTjFo+vwcUdNoHkp8CE6VVO39xHNB6ObInZ5hY6AuJ95pdK0LNydIkHTTMRHsxTSPeBRUD/ZeaFjldj43cdDNjJM1Wa2zKQxcL5wOrgZRVSQ6YW6nE8LIJ72Yse9XLqtpRMrcoKbPlY/oE/X96BYow8PM5a4PGSO3U9nZvh7UOle7EVveMTt804SIOBsDX7S8qXVHMwtCEucd4j7VeDm5m7pSzEiVnsp/nFKZjGGx+zybQ22QzoRiLuA+RnuJ7dg3Kt5N5BDYS06Dp3pAkWk4MAwfApSYcUuj9i1rp7FshwH1BBdswVJe0MTrpaJKpgDAPvxQ5qju5PeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6512007)(71200400001)(66476007)(91956017)(54906003)(2906002)(76116006)(4326008)(122000001)(33716001)(38100700002)(38070700005)(6506007)(6916009)(86362001)(8676002)(316002)(66556008)(64756008)(66946007)(26005)(83380400001)(186003)(6486002)(508600001)(5660300002)(7416002)(66446008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zzUTNlxp+CNwypAZIp8DTexl7RWz7r4MG0KjIn0TpoNvq02nn0kiY/sWRu2n?=
 =?us-ascii?Q?Hnzgg70p0AQ6vrR8CMsX9QE6GSOe4WMjOW+w0MQ7Sdk1LKtbwJ+cWMgC4Mhr?=
 =?us-ascii?Q?ELA81OccpUWLgp9/+h7Slk7fNOIdq9IzFBqFUihBRPBB3DTaW2JzrCs0abAP?=
 =?us-ascii?Q?Dvynl9iYdDYZeJOS8Nqe6JnAaxFhVxkCzfuh76RJUjAeTGfC8BN7TrVXGXm4?=
 =?us-ascii?Q?RABRXvJc1YiO3gnzxUQw12ntYRjxpJ+O+inOa1zZDHfrbPoEPIQH76cM7JTG?=
 =?us-ascii?Q?ASRErp3B+0lubzhf0X9JXoW7NznN5gdV8Z74xtCrS81pFXEhT7tj5i/kTmb6?=
 =?us-ascii?Q?PH8MtmVzOG5vo88E2l1bPn8TNmq19YkhA+/We/vMbb1GMzTEYjv4f2K4UdYM?=
 =?us-ascii?Q?3iXTHVtIi4N4hMd54GMubSvCrZF2ofzyl+7Hb0J8VveZ1kCFxfGFysN6t2y4?=
 =?us-ascii?Q?dZjlN/Cp3GoUD5hMcIGLZXnQDevH5GZYDDBRziiCDTonFuum894Aet65xWcg?=
 =?us-ascii?Q?CqG/OkqH+qEjIirVHcfTqRFawTlYGUubPEmq0Sl+oWMAPfFwLFIhxFmnW8B8?=
 =?us-ascii?Q?AxvPQdGjXmT6agPSB1oPQ1g+gzEurZ/vnFH44Qdu/mO2QKB1Y5aAMkuh/uvk?=
 =?us-ascii?Q?pWH0HgI4rLE9gd2hkH3y69d8k9lBopnEeLF/dI71rYzLZ+U8V7yGwDr1fM0F?=
 =?us-ascii?Q?GoYRr+wKPP/JnJZeXehrLlpzgVBkyICHLVF/5qT12AlyhJB1slzICoy0RJmO?=
 =?us-ascii?Q?uQvCYbKNpONQlFNjbCpFmoFWpv4nWNizuF1T4Dss2B/yYBcxrQyuOfKJPpTX?=
 =?us-ascii?Q?rz8NLMVOIq3zbFnmGooMSlhg/69a92WbVbKLvOWrp3VszWy7Lml4q/c3DvpW?=
 =?us-ascii?Q?2zsQxZYAMO4nNa5CNaMRoJb5DxzZdNdJQIksj9tjVlNNXXLdpSllcMG7/jAs?=
 =?us-ascii?Q?8F8BGWn1T6kxnELQzFvFY2s9pI4JEIyJU343vlmucaQAzH4Syu2q9c/muNKM?=
 =?us-ascii?Q?DE3Dd1QhJ4phXcVug5JBXkbV0A5+M8ivSHgj0ok/76qV/m08X2WcFct//usB?=
 =?us-ascii?Q?bGcokSnLq8lA9sVPZaN/qID+U0QbIeveVx8WuYFZ+o+qU52NXjKweNNcDWfQ?=
 =?us-ascii?Q?a0Evy8QYT1feCRaXTR0QJqPh5kSatVnow2bxn7YU0/9uE/+ZtfYb2dKrG96T?=
 =?us-ascii?Q?/HWhckb6gYNqNgUYgecMN7zmUkK+udjXs4ye0gJCrQ7r4mvqeGQrzX+igdzr?=
 =?us-ascii?Q?IypKALBNdRmt4+4GEafSzwYXsmlpB1oia16JVjDEzdq5uoZ8VZBoAlJ4sxYV?=
 =?us-ascii?Q?W3BIAKhPE4UAMBRHa/qbmFIRS1rsAl/bIv1e7JASqPNecVOrqlP124Q3sdNy?=
 =?us-ascii?Q?FvWHFjsnImE4H6X3VAwKb4amkUx37kUw9Pze8t1q3fKw5XaOnlZJpQjW/Ax6?=
 =?us-ascii?Q?Eiu0lHorB+lQrz1U5cYvhT2See32m2Fu2vY7a26Gx+pdjOiVj/iREvLTp1f5?=
 =?us-ascii?Q?tH9EpI2RLEYioc6kGkvkeiuhpQNNT9RjhG9Ia+Q4YViiR5pGzLStVHWfFNkn?=
 =?us-ascii?Q?cECDaIGauDaoRb+Y/KMFdle4XiiK4KTMCwWpVQPMnfXCoMaoUJrIS2He6bdG?=
 =?us-ascii?Q?xTuJw1kATHrFifXsvspMgN9EDKxX2kgE040/vDI2jSNTAsNpsY+sZf/yFR4L?=
 =?us-ascii?Q?usTvydAuHAx/UXI4AyN+lopoE/dZWSIcmIuCgbBiv5kR6BuNBgxvyK14AQ2Y?=
 =?us-ascii?Q?OUWQwBrQgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9244233BC5B92C4FB5734B562001CED5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114db21-32c8-4d29-8a29-08da27a49868
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 16:48:31.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6wMV02Ai6hLOVUDoFLyOCbqudfnYAH5dYFUHBXWTT2GLtLf1Sdx7yQMH10rOm6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5120
X-Proofpoint-ORIG-GUID: rruNIQ0RDMfw5equIb3UtNTUJ3fmhSL2
X-Proofpoint-GUID: rruNIQ0RDMfw5equIb3UtNTUJ3fmhSL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 09:49:53AM -0400, Mimi Zohar wrote:
> On Tue, 2022-04-26 at 12:08 +0000, Jonathan McDowell wrote:
> > On Mon, Apr 25, 2022 at 12:29:17PM -0400, Mimi Zohar wrote:
> > > Hi Jonathan,
> > > 
> > > On Fri, 2022-04-22 at 13:50 +0000, Jonathan McDowell wrote:
> > > > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > > > may verify the IMA signature of the kernel and initramfs, and measure
> > > > it. The command line parameters passed to the kernel in the kexec call
> > > > may also be measured by IMA. A remote attestation service can verify
> > > > a TPM quote based on the TPM event log, the IMA measurement list, and
> > > > the TPM PCR data. This can be achieved only if the IMA measurement log
> > > > is carried over from the current kernel to the next kernel across
> > > > the kexec call.
> > > > 
> > > > powerpc and ARM64 both achieve this using device tree with a
> > > > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > > > device tree, so the IMA infrastructure is extended to allow non device
> > > > tree platforms to provide a log buffer. x86 then passes the IMA buffer
> > > > to the new kernel via the setup_data mechanism.
> > > > 
> > > > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > > 
> > > FYI, after applying, building, and booting a kernel with this patch,
> > > "kexec -s -l /boot/vmlinuz-5.18.0-rc4+ --reuse-cmdline --
> > > initrd=/boot/initramfs-5.18.0-rc4+.img" properly loads the kernel, but
> > > "kexec -s -e" fails to reboot, at least on a test laptop even with only
> > > the "boot_aggregate" measurement record.
> > > 
> > > Without enabling CONFIG_IMA_KEXEC, kexec boots properly.
> > 
> > Thanks for giving it a try. At a guess your laptop is booting with
> > EFI, whereas for my testing I was using qemu with legacy BIOS. I've
> > managed to reproduce the issue with qemu+OVMF and isolated the mistake
> > in the setup data calculation I made when EFI is involved. If you have
> > time can you try with the below on top of the original patch?
> 
> Thank you!  With the change, as expected there are two "boot_aggregate"
> records in the measurement list.  With a custom policy, the measurement
> list verifies.

Excellent, thanks for verifying. I'll get the fixed v2 out.

...
> FYI, the builtin "ima_policy=tcb" results in measurement violations.  
> Normally, the measurement list can still be verified using the evmctl
> "--ignore-violations" option.   For some reason with the "tcb" policy, 
> the measurement list doesn't verify even with the "--ignore-violations" 
> option after kexec.  I assume this is a result of additional
> measurements being added after the kexec load, which aren't being
> carried across kexec.

I believe with "tcb" things like the subsequent exec of kexec to
actually do the reboot will end up measured, and as the kexec buffer is
static it won't include that.

Also there's an issue about the fact that we measure the kexec pieces
even if we don't actually do the kexec; there's no marker that confirms
the kexec took place. It's separate to this patch (in that it affects
the device tree kexec infrastructure too) but it's conceivable that an
attacker could measure in the new kernel details and not actually do the
kexec, and that's not distinguishable from the kexec happening.

One approach might be to add a marker in the kexec ima buffer such that
if it's not present we know the kexec hasn't happened, but I need to
think through that a bit more.

J.
