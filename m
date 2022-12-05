Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B478642B0A
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Dec 2022 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiLEPId (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Dec 2022 10:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiLEPIK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Dec 2022 10:08:10 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89691DF12
        for <linux-integrity@vger.kernel.org>; Mon,  5 Dec 2022 07:07:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NQmvw15yvz9v7Gd
        for <linux-integrity@vger.kernel.org>; Mon,  5 Dec 2022 23:01:16 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnG_g5CY5j0APAAA--.56046S2;
        Mon, 05 Dec 2022 16:07:43 +0100 (CET)
Message-ID: <a9df6b39a29c9c0671b75c121d520673cdd830c2.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Experimental fsverity.test related GA CI
 improvements
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 05 Dec 2022 16:07:09 +0100
In-Reply-To: <20221205144447.4mtmteolbvcabzzp@altlinux.org>
References: <20221201002654.2238906-1-vt@altlinux.org>
         <7db27896916a944d8e4a212cad23865166ceb9f4.camel@linux.ibm.com>
         <20221205144447.4mtmteolbvcabzzp@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnG_g5CY5j0APAAA--.56046S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kGr13WFWDGF1UAryDtrb_yoWrWry8pa
        y5KFyjkr4kXF1UAw1SgF1fuayYy3s3JFW5GF1kJw48Ja98X3WDtr1IgF4avasFvrn3Wr4F
        vay0vFy2gw1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj4JPDQAAsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-12-05 at 17:44 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Dec 05, 2022 at 08:39:32AM -0500, Mimi Zohar wrote:
> > On Thu, 2022-12-01 at 03:26 +0300, Vitaly Chikunov wrote:
> > > From: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > This does not make fsverity.test working on GA CI, though.
> > > 
> > > - `--device /dev/loop-control' is required for losetup(8) to work.
> > > - `--privileged' is required foo mount(8) to work, and this makes
> > >   `--security-opt seccomp=unconfined' redundant.
> > > - GA container does not have `/sys/kernel/security' mounted which is
> > >   needed for `/sys/kernel/security/integrity/ima/policy'.
> > > - Enable `set -x` in CI as the logs is everything we have to analyze on
> > >   failures.
> > > 
> > 
> > Agreed, even with these changes the fsverity test will not be executed,
> > but skipped.
> > 
> > However, the reason for them being skipped is totally different than
> > prior to this patch.   Once the distros have enabled both fsverity
> > support and are running a recent enough kernel with IMA support for
> > fsverity, the fsverity test should succeed.
> > 
> > So the problem isn't the GitHub actions architecture or the fsverity
> > test itself, but the lack of IMA kernel support for it.  In addition to
> > the ima-evm-utils distro tests, there needs to be a way for testing new
> > kernel integrity features.  Roberto's proposed ima-evm-utils UML patch
> > set downloads and uses a UML kernel for this purpose.
> > 
> > Unless someone can recommend a better alternative, a single UML
> > "distro" test could be defined and would be executed if a UML kernel is
> > supplied.   Additional UML tests could be specified.
> 
> Just as an idea. I did some CI testing for LKRG on GA,
>   https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.yml
>   https://github.com/lkrg-org/lkrg/blob/main/.github/workflows/docker-boot.sh
> 
> It's possible to boot in QEMU system created in Docker (alas without
> KVM as GA does not support it). But this will install distribution's kernel.
> So it would need to find distribution with the appropriate kernel.

Uhm, yes. It is an option, but I guess it requires to build the image
you want to boot the virtual machine with.

Until now, the UML kernel was more than sufficient to test a new
functionality or bug fixes.

> Also, GA have cache functionality, so there could be dependent job
> to build the kernel with required options and then save it into a cache
> (to save time, bandwidth, and CPU resources).

Yes, automatizing this step would be better. Currently, I have two
separate repos for the kernel and ima-evm-utils. I build the kernel
first, to create a release (kernel binary + signing key) and then ima-
evm-utils, which fetches the kernel to test. I do these two steps
separately, but I guess you can launch a kernel build from ima-evm-
utils.

> And another possibility is, instead of using Docker it's possible to use
> cloud images that many distributions have, and then same as with docker
> (install or build kernel, save into cache and use in next CI runs).
> Never tried this method myself. AFAIK this will require to use cloud-init
> to set up system on first boot.

One cool thing about the UML kernel approach is that the script detects
if it exists, and if not runs the test in the current environment. The
modifications to support both I guess are not too invasive.

Another thing that I like about this approach is that I can launch the
UML kernel several times in the same script, and each time I execute
different tests (useful for example if you need a specific EVM mode, as
you cannot go back).

That could be done with the virtual machine approach too, passing the
necessary environment variables. It could however require some effort
(I'm using UML kernels in Github Actions for a while).

These are the two tests for the latest patch set I developed:

https://github.com/robertosassu/linux/actions/runs/3591117649
https://github.com/robertosassu/ima-evm-utils/actions/runs/3590837109

Roberto

