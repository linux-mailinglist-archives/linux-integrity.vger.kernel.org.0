Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA03C31FE97
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 19:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBSSLE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 13:11:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229607AbhBSSLD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 13:11:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JI3iZ3190477;
        Fri, 19 Feb 2021 13:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=J7UWlaf9kMo+UKARDNZDIBFXIQD2zBBRv3Q3Imq3uPs=;
 b=YHAxmcQ/7S+SVSRxKsQ7TGtwdBcw+GCzTIDi+ySAP7qhbhq6p9cSojuymYnvat8/mf+4
 YhsNWSfcod4NzY03WGgMzXpmjXBrrc7NOScsS3cVxyO+yPdZn2JzhmoAMC8v3noCUoW6
 oYnYnMOpnHAZ//dqt+MoIGfvinI/zd64GZ8eGMRBTTnH/fa78Bh+ZX/A0v06g0lVVWm/
 hGSjiqse0Jz+QKeocjWYeXzCXdeiWq5xKk4bUrYw9fCL4VTCHt4NERI+3CfmdrlNh2dP
 ujp1dfNRw8Ew2fjDzhvpJ4llVkUUzvvyzwgjGeMoC1t7Etl+4lsT/ffwXN5w0R5CzcgQ fw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36thye0qj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 13:10:03 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JI89ls019718;
        Fri, 19 Feb 2021 18:10:02 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 36p6dab3fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:10:02 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JIA1I928770680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 18:10:01 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E99C6059;
        Fri, 19 Feb 2021 18:10:01 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD248C6057;
        Fri, 19 Feb 2021 18:09:56 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.174.98])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Feb 2021 18:09:56 +0000 (GMT)
References: <20210218223305.2044-1-nramas@linux.microsoft.com>
 <c6490f6a126a2f10e3e3445b51ea552a26f896a9.camel@linux.ibm.com>
 <8b8c0b70-c7ab-33f3-b66c-9ea03388497b@linux.microsoft.com>
 <87k0r4yi4s.fsf@manicouagan.localdomain>
 <3ca0aa87-ca83-8024-4067-c2382a360db9@linux.microsoft.com>
 <CAL_JsqJiRV5xShOgso0PH2pFhv-yozay58i1uGQC0dJCVxkJPA@mail.gmail.com>
 <98a061d1-05ea-eff2-5c5c-a59f491fe924@linux.microsoft.com>
 <CAL_Jsq+R-zOT581_W0Ar5H58rfPnGiWeetoF_b+BaW7er22bPA@mail.gmail.com>
 <6a197963deb8e44c71384ea9b89d7f3f13c947bf.camel@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] of: error: 'const struct kimage' has no member named
 'arch'
In-reply-to: <6a197963deb8e44c71384ea9b89d7f3f13c947bf.camel@linux.ibm.com>
Date:   Fri, 19 Feb 2021 15:09:54 -0300
Message-ID: <87blcgx72l.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Fri, 2021-02-19 at 11:43 -0600, Rob Herring wrote:
>> On Fri, Feb 19, 2021 at 10:57 AM Lakshmi Ramasubramanian
>> <nramas@linux.microsoft.com> wrote:
>> >
>> > On 2/19/21 6:16 AM, Rob Herring wrote:
>> > > On Thu, Feb 18, 2021 at 8:53 PM Lakshmi Ramasubramanian
>> > > <nramas@linux.microsoft.com> wrote:
>> > >>
>> > >> On 2/18/21 5:13 PM, Thiago Jung Bauermann wrote:
>> > >>>
>> > >>> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
>> > >>>
>> > >>>> On 2/18/21 4:07 PM, Mimi Zohar wrote:
>> > >>>>
>> > >>>> Hi Mimi,
>> > >>>>
>> > >>>>> On Thu, 2021-02-18 at 14:33 -0800, Lakshmi Ramasubramanian wrote:
>> > >>>>>> of_kexec_alloc_and_setup_fdt() defined in drivers/of/kexec.c builds
>> > >>>>>> a new device tree object that includes architecture specific data
>> > >>>>>> for kexec system call.  This should be defined only if the architecture
>> > >>>>>> being built defines kexec architecture structure "struct kimage_arch".
>> > >>>>>>
>> > >>>>>> Define a new boolean config OF_KEXEC that is enabled if
>> > >>>>>> CONFIG_KEXEC_FILE and CONFIG_OF_FLATTREE are enabled, and
>> > >>>>>> the architecture is arm64 or powerpc64.  Build drivers/of/kexec.c
>> > >>>>>> if CONFIG_OF_KEXEC is enabled.
>> > >>>>>>
>> > >>>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> > >>>>>> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
>> > >>>>>> Reported-by: kernel test robot <lkp@intel.com>
>> > >>>>>> ---
>> > >>>>>>     drivers/of/Kconfig  | 6 ++++++
>> > >>>>>>     drivers/of/Makefile | 7 +------
>> > >>>>>>     2 files changed, 7 insertions(+), 6 deletions(-)
>> > >>>>>>
>> > >>>>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> > >>>>>> index 18450437d5d5..f2e8fa54862a 100644
>> > >>>>>> --- a/drivers/of/Kconfig
>> > >>>>>> +++ b/drivers/of/Kconfig
>> > >>>>>> @@ -100,4 +100,10 @@ config OF_DMA_DEFAULT_COHERENT
>> > >>>>>>             # arches should select this if DMA is coherent by default for OF devices
>> > >>>>>>             bool
>> > >>>>>>     +config OF_KEXEC
>> > >>>>>> +  bool
>> > >>>>>> +  depends on KEXEC_FILE
>> > >>>>>> +  depends on OF_FLATTREE
>> > >>>>>> +  default y if ARM64 || PPC64
>> > >>>>>> +
>> > >>>>>>     endif # OF
>> > >>>>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> > >>>>>> index c13b982084a3..287579dd1695 100644
>> > >>>>>> --- a/drivers/of/Makefile
>> > >>>>>> +++ b/drivers/of/Makefile
>> > >>>>>> @@ -13,11 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>> > >>>>>>     obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>> > >>>>>>     obj-$(CONFIG_OF_OVERLAY) += overlay.o
>> > >>>>>>     obj-$(CONFIG_OF_NUMA) += of_numa.o
>> > >>>>>> -
>> > >>>>>> -ifdef CONFIG_KEXEC_FILE
>> > >>>>>> -ifdef CONFIG_OF_FLATTREE
>> > >>>>>> -obj-y     += kexec.o
>> > >>>>>> -endif
>> > >>>>>> -endif
>> > >>>>>> +obj-$(CONFIG_OF_KEXEC) += kexec.o
>> > >>>>>>       obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>> > >>>>> Is it possible to reuse CONFIG_HAVE_IMA_KEXEC here?
>> > >>>>>
>> > >>>>
>> > >>>> For ppc64 CONFIG_HAVE_IMA_KEXEC is selected when CONFIG_KEXEC_FILE is enabled.
>> > >>>> So I don't see a problem in reusing CONFIG_HAVE_IMA_KEXEC for ppc.
>> > >>>>
>> > >>>> But for arm64, CONFIG_HAVE_IMA_KEXEC is enabled in the final patch in the patch
>> > >>>> set (the one for carrying forward IMA log across kexec for arm64). arm64 calls
>> > >>>> of_kexec_alloc_and_setup_fdt() prior to enabling CONFIG_HAVE_IMA_KEXEC and hence
>> > >>>> breaks the build for arm64.
>> > >>>
>> > >>> One problem is that I believe that this patch won't placate the robot,
>> > >>> because IIUC it generates config files at random and this change still
>> > >>> allows hppa and s390 to enable CONFIG_OF_KEXEC.
>> > >>
>> > >> I enabled CONFIG_OF_KEXEC for s390. With my patch applied,
>> > >> CONFIG_OF_KEXEC is removed. So I think the robot enabling this config
>> > >> would not be a problem.
>> > >>
>> > >>>
>> > >>> Perhaps a new CONFIG_HAVE_KIMAGE_ARCH option? Not having that option
>> > >>> would still allow building kexec.o, but would be used inside kexec.c to
>> > >>> avoid accessing kimage.arch members.
>> > >>>
>> > >>
>> > >> I think this is a good idea - a new CONFIG_HAVE_KIMAGE_ARCH, which will
>> > >> be selected by arm64 and ppc for now. I tried this, and it fixes the
>> > >> build issue.
>> > >>
>> > >> Although, the name for the new config can be misleading since PARISC,
>> > >> for instance, also defines "struct kimage_arch". Perhaps,
>> > >> CONFIG_HAVE_ELF_KIMAGE_ARCH since of_kexec_alloc_and_setup_fdt() is
>> > >> accessing ELF specific fields in "struct kimage_arch"?
>> > >>
>> > >> Rob/Mimi - please let us know which approach you think is better.
>> > >
>> > > I'd just move the fields to kimage.
>> > >
>> >
>> > I think Mimi's suggestion to use CONFIG_HAVE_IMA_KEXEC for building
>> > drivers/of/kexec.c would work and also avoid the bisect issue if we do
>> > the following:
>> 
>> That seems wrong given only a portion of the file depends on IMA. And
>> it reduces our compile coverage.
>  
> I agree with you this is the wrong solution.  Lakshmi's patch
> introduced a new option to prevent other arch's from including kexec.o,
> which is the same functionality as CONFIG_HAVE_IMA_KEXEC.  I'm just not
> sure what the right solution would be.

I think Rob's suggestion of just moving the elf_load_addr,
elf_headers_sz fields (and for consistency, elf_headers as well even though it
isn't used in tihs file) from kimage_arch to kimage.

The downside is that these fields will go unused on a number of
architectures, but it's not worth complicating the code just because of
it.

The patch to do that would have to go before "of: Add a common kexec FDT
setup function". That should be enough to preserve bisectability for all arches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
