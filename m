Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF15607B9
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiF2Rt6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2Rt5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 13:49:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C576363;
        Wed, 29 Jun 2022 10:49:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25THPOIP025016;
        Wed, 29 Jun 2022 10:49:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=lOwrPvHjgM6r/xHmZXagGcX0LHK0Bm0J9lgLPTS9Ocs=;
 b=byZSx+lL/T/VTwD2d2V0m3gj9jbShZUDulBirgsjvhVDmQhacfRcyvu8feUa2zBpjhIX
 dlugj6QfGFL64L9gBQiNCBnpmtY0XfdeBrtHZRcrXc1DV5GUzcptVar9K50T3PxbKann
 L49flsKYqAa2O3c/rgJ5Esz98byNXtNj51k= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0691fvdx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 10:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqQ+iv3PcNgnvRa7ImXiJ6fr1PY2yfF8pxUbVP3+hrgGxzDhRmeYWGkF8LHwlrWqh3vUhSbC+x3GiKmMM7QxRERTK6/vU3I+bmcp6z3h/ch7NGmj0ea9LsXoSBZKcRMKpu87vmI97r4CDnvw2wdAUWXt/As7UJn+scklqrxiqPtPayhukSUuXHnXSAE26hjtCT4FO+5GdEgVN5WlfV8kwjDTZEmRbmp/xF3YivX6QLoVpkrBLAsiFFLDO3fiBc6dLrXIjztmlDV/PVARuc4H7YW3dtNlLGGIgty0aK3ELpAGh66W2ikX5LntOBT26xgmH/MzF7iGo4BVxX3Fx07jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOwrPvHjgM6r/xHmZXagGcX0LHK0Bm0J9lgLPTS9Ocs=;
 b=AJ+btZKpdsTVFBL1AkQtfQaSpXeOCCrssNUkgivqJBfPeYSJVECjBHe5EwkbIweKbCCX6JLAX88pP/2F5zBHAZppRLro8MltWA8r+AC1U/mUsR2bdfWKwFCjbRHBJ4C4E+YNnKqUMDdM8HuEJLvHzTWjoe6x18q8qBVcX9G+52rETsw7W6wIaz/450MlfxoVQe5stDT4HbdBp35nPLXeUclHXwTA3gM6OThqsI43OPz/kCKWOFai9tFwE5CcjUssbeI8KgyJeldnXhcZEvkB75OtXM2i6oJ1C1yha711AKeUhYiuob2IRmbZZ+5kW+jXzcymkaQqBb92zsy5HxAVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MW2PR1501MB2138.namprd15.prod.outlook.com (2603:10b6:302:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 17:49:53 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 17:49:53 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] of: Correctly annotate IMA kexec buffer functions
Thread-Topic: [PATCH] of: Correctly annotate IMA kexec buffer functions
Thread-Index: AQHYi53+57Uf9qOfm0WoCzCAOs74RK1maiiAgAA/3YA=
Date:   Wed, 29 Jun 2022 17:49:53 +0000
Message-ID: <YryQvUtupEgn+vO1@noodles-fedora.dhcp.thefacebook.com>
References: <202206291039.yGgljGbx-lkp@intel.com> <YrwPjnxBk3Xyuakg@zn.tnic>
 <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
 <YrxbK4IsYb6yls5d@zn.tnic>
In-Reply-To: <YrxbK4IsYb6yls5d@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e5192c0-baad-4f51-a4cc-08da59f7c5e5
x-ms-traffictypediagnostic: MW2PR1501MB2138:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaCO3z03gMMdaYwgt0cuMu8/E2UobNBdagZrVVsR/jf/8q7MSW5NndZAW8b91s4natRiZ1gyznTjyunYsTHWzbCxYgDrGjgh7oKAm5S56saCiTCXwqbWcbi8QiuWgaervvYDygYg4P4sWAspVjGeeDqh8X3XZfk8Al9ioULiwDlylLgXYPUgkNPxBAUgSWMixBi7gMPWuZvSgw9wE+b7GNmosYpTg5AxAbel3hBbW+txL9L+gBPV28w4Jq+FSXRaCC4Os6pyz5Q0fKEJ7Z3rqNUJdvX0+MGX92lMBo9kXDtsrSz7IlUNOAA6BcSeYgx3zbjiUtOLCDpbarnjU5/Dpinuc+rUQBwHc4xl9clMBjRYeTZPTwJ4LOJE3RiZxqLe/arejxByRQqQ5OE6FIdAt8lssu5g91DpAk9uu/sfMKg73Fd6Rve9wo2pd0d8KTzeTkkUaCorJTpbMOQZ2jcvLRItfkEyqT3LyY2/h5bWnSaCtK+J9+PHfE1WYORy8EO/pxTWGdTq5OtyrQVworkYNCUyNX77it3fS9c4hdJtD9a0zYmDX2dceuTyIrosym9idBRZPjZEun9pj8pNAZPyMbJ02ixBcQ1qThP9F26GECkOELS3S14uaxzmAcY0Pu2efkRFwvpMoguP92nrQ9TE/7/b/Cqu0z4RkAo4hze6tBjqzYovhXGdqK+6gVGsH1NA9+TMKZhBMDxWv56CEu+RdwpllTOC2Wqbf3Mtn3+pSlP41FcCi7VIV1iMlzPb6oHqsA79E6Gv5+S7DJExaozC22o+bMoaajmUbj7H7/UbWHAWao2FobushtnI9Isj6TW96a7pLkxIs0aQUWEfCrFr+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(7416002)(5660300002)(64756008)(8936002)(478600001)(76116006)(6916009)(4326008)(66556008)(66446008)(66946007)(54906003)(316002)(38100700002)(71200400001)(2906002)(122000001)(86362001)(66476007)(186003)(6506007)(26005)(6486002)(8676002)(6512007)(91956017)(41300700001)(9686003)(38070700005)(83380400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqRfJmrHwRgObcAjiNaVlQxzDganonTLZciS4lxrwHsp9QoQA3d+U9PdQtJw?=
 =?us-ascii?Q?YeeN+d0gKMAMuY2iQbBTOoPNhnyUlA6a1GJQkL4z++R84NOd+bVuEUhiWFHw?=
 =?us-ascii?Q?+W+iGdTc1Yz2/+sOkKuBj4js+LuIDIdBHia+9mgWyBA3F0PzceITZ0rKb5Cj?=
 =?us-ascii?Q?fIyZXm23nFUJ4YFQJ8cQt/MgRrdOZhQHzavU59yetO3hypF+W2MncSqcHkkT?=
 =?us-ascii?Q?HZn+o1GanR4k25wIudsAWbfijMyc1LZTNQK98+hFrQVvEbQ5nZuNws9hZhfJ?=
 =?us-ascii?Q?qLIHcyriNAcKqUK9nyv1gkI/SKkkALWOGm9fQacKBtIAgZDv4NBTts7bzZj3?=
 =?us-ascii?Q?AqOM03Qc9YRFqr8Hr6lnLItWK3l95a5VR30wnSK/zs3sFnP2YF94V0MWiula?=
 =?us-ascii?Q?xE5m9ufhIjqC2hbkE4xvBLbB/X4kHgcwrS1Jgf11BLtjtKHHXrH99csbXw8W?=
 =?us-ascii?Q?R7lQn3ZtoRt8ICoLcz4Vh79aYwxtqAAIXv9sc9eWp8YUaryENqKaWvIpMHJh?=
 =?us-ascii?Q?5AkFwL+aizSfltXumfR1nhSc5lZZLNmtgzhow9rAs28xl6iPRWrI7WSuCF9M?=
 =?us-ascii?Q?TlzrVswvTNrXdAgFNTzc67+CmSW9wIqxgdkGUlgnxp9etNkniRYDe+E+amCr?=
 =?us-ascii?Q?Wzvq3X6bHiKZuma0BJqTv9ppvJDYI5dLIu4Z2HfhQYmUHljUyIo2PQ3/nIzT?=
 =?us-ascii?Q?pYo2e2yejIcxfFUKxyDbQs9svgsI/ZaqBMwTLzEBEIXoTHcI/gkm6Rj4bpwC?=
 =?us-ascii?Q?6wDUW5H63Mcoy7DydnXaZyugwjALzvRCTt9xVcP+bBCQBURT26i5bD/ULRP+?=
 =?us-ascii?Q?fBmd3YthvLyLJg/s9Lz0T+56JDnkc+JRjvOv7n+sl3gLSdVQKlkZ1PLe2K4I?=
 =?us-ascii?Q?OEb1jMXPtUIkZ+BIeXwpFiG48gfRKRpg5JFDW9mGfXoN73uDOGZ62m/5qwea?=
 =?us-ascii?Q?kpJHbouo9SHH8VYK1SLgHpwfuH6h9iJbSI+nFsf4S39ITvrW+4ZUdxjFb1Pi?=
 =?us-ascii?Q?xS+RoI0hmWz4+j6qcpI2/ChTITsGPisHIy1eKWCocjRXfXbbNFW5L/S9w1pP?=
 =?us-ascii?Q?YExHii/yuXHICptpUNRfeNqylKdF6SyyF4kqlwr7TZwV2oh1dPUyL97RR6bY?=
 =?us-ascii?Q?TCUmzPqci0PWC6GIvUwSxugHvZ31MwUkpos3aJju4YzmyCnKqEJOzAZuOgAs?=
 =?us-ascii?Q?Nibq8F2xwe9BLHiVxzTRDCjoxAj7I5jFZWXJ8jKb9EM+WHclbF9rxx9l9oxW?=
 =?us-ascii?Q?GVu6twBcs6xcCazyDgPdz/161qT8NqdPNjgxd54DCUtTOU0EzxDWZp72KfUv?=
 =?us-ascii?Q?M4zLgAzy3E8pJW4dgCAkGMhcrDu8DAb7YIoNXrmcJH5G/90N7SNs2bG2CGSL?=
 =?us-ascii?Q?JhlhnXb4aYDeSUS8odkW0C4g33Y0penqLq2rCUNu4dXNeFC5s1Tlk+8ziBeo?=
 =?us-ascii?Q?bgb9B7OXk4wV4GgvuP+7B7fB7YgyQh7KiSuq8b6abuQH8MeaSbzDsbwM1W5m?=
 =?us-ascii?Q?bn0Q/j0ySspt7aJwJugibVX51l5GTIFwOsqr0f3IG42PSp3z0a1T+LnhrDT2?=
 =?us-ascii?Q?nyOKqGoTTr9WwseNDJbVWeVp9btnm/OqKy8cS46w?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEF843EE23EF17499CFEA0C245CB1925@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5192c0-baad-4f51-a4cc-08da59f7c5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 17:49:53.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuNjCu74Oi5sTvw0R4Rz4iboFaiZ/JS6ckeWl8Ts0w1Lz7KlYN0A7Z5720NFYABP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2138
X-Proofpoint-GUID: XeYELAAUdWMxkqWugNMlHTYfgnpBjjtO
X-Proofpoint-ORIG-GUID: XeYELAAUdWMxkqWugNMlHTYfgnpBjjtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_18,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 29, 2022 at 04:01:15PM +0200, Borislav Petkov wrote:
> On Wed, Jun 29, 2022 at 09:52:50AM +0000, Jonathan McDowell wrote:
> > Below is on top of what was in tip; I can roll a v7 if preferred but
> > I think seeing the fix on its own is clearer.
> 
> Yes, and you don't have to base it on top because, as I've said, I've
> zapped your other patch there.
> 
> Once IMA folks are fine with that fix of yours I can take both, if they
> wish so.

I'll roll a v7 collapsing them together and moving to __init as per
below.

> > ima_free_kexec_buffer() calls into memblock_phys_free() so must be
> > annotated __meminit.
> 
> Why __meminit?
> 
> The very sparse comment over it says:
> 
> /* Used for MEMORY_HOTPLUG */
> #define __meminit        __section(".meminit.text") __cold notrace \
>                                                   __latent_entropy
> 
> so how does ima_free_kexec_buffer() have anything to do with
> MEMORY_HOTPLUG?
> 
> It calls memblock_phys_free() which is __init_memblock.
> 
> Now __init_memblock is defined as
> 
> #define __init_memblock __meminit
> 
> for some CONFIG_ARCH_KEEP_MEMBLOCK thing so I guess that is the
> connection.
> 
> But then the couple other functions which call into memblock are all
> __init...
> 
> IOW, I probably am missing something...

I think the answer is that __meminit (or __init_memblock) works out as
the minimum required annotation, because memblock_phys_free() has that
annotation, but having looked closer at the call stack all of the usage
is under ima_init() which is marked __init, so it's more appropriate to
use that and discard the code after boot. There's no need for the ima
related functions to stay hanging around in the case memory hotplug is
enabled, because it's purely a boot time mechanism for passing the
buffer over a kexec boundary.

J.
