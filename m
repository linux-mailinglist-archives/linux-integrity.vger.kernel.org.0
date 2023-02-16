Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08823698E71
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 09:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBPIQk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 03:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBPIQk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 03:16:40 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CBF23850
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 00:16:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHSHV45Hzz9xFQK
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 16:08:06 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHHGNM5u1jgMYkAQ--.44907S2;
        Thu, 16 Feb 2023 09:16:19 +0100 (CET)
Message-ID: <006bceba21b205f862d92a50c7095397f30d1b9e.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com
Date:   Thu, 16 Feb 2023 09:16:07 +0100
In-Reply-To: <8c65e64026e33caf6cf756c616f3effe249cae4b.camel@linux.ibm.com>
References: <20230214210035.585395-1-pvorel@suse.cz>
         <Y+1gTC0cjCo6Aw0v@pevik>
         <8c65e64026e33caf6cf756c616f3effe249cae4b.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBHHGNM5u1jgMYkAQ--.44907S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF18Zw15tFyxWFyxZw4Utwb_yoW5Xr4kpr
        Wv9FWxKr48tFyDAw1xJr4Ivw40yrZ5Ary5JryrAw18Ga45J3Z7tF4IyF45WrWDGw1DAryS
        vFZrtryjgr4kAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4kKuQAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-15 at 18:19 -0500, Mimi Zohar wrote:
> Hi Petr,
> 
> On Wed, 2023-02-15 at 23:44 +0100, Petr Vorel wrote:
> > Hi Mimi,
> > 
> > > Tested:
> > > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413
> > 
> > Thanks for merging this.
> 
> I actually pushed out the patches to "next-testing" to make sure it
> works.  In doing so, I dropped a couple of Roberto's patches, which
> aren't quite ready and one of mine as well.  In general, I'm not sure
> pushing patches out to "next-integrity" should be considered "merging"
> quite yet.  In this case, your patches are fine.  (Perhaps there needs
> to be a better work flow.)
> 
> > My test was working:
> > https://github.com/pevik/ima-evm-utils/actions/runs/4177976359
> 
> Yes, I saw.
> 
> > But the same code now fails for Fedora.
> > I wonder what exactly is wrong now:
> > https://github.com/mimizohar/ima-evm-utils/actions/runs/4188686859/jobs/7260231106
> > https://github.com/pevik/ima-evm-utils/actions/runs/4188761663/jobs/7260289846
> 
> The UML kernel built properly, but for some reason the fsverity and
> portable_signature tests aren't finding it.

It could be this (in the logs):

There exist one or more cache(s) with similar key but they have
different version or scope.

I would try:

enableCrossOsArchive: true

after:

      uses: actions/cache@v3
      with:
        path:
        key:

for every step using the cache.

Cache version is a hash generated for a combination of compression tool
used (Gzip, Zstd, etc. based on the runner OS) and the path of
directories being cached.

Maybe there was some change from the time the kernel and signing key
were cached.

Roberto

> > FAIL: fsverity
> > ==============
> > 
> > which: no fsverity in (../src:../fsverity-utils:/github/home/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
> > dd is /usr/bin/dd
> > mkfs is /usr/sbin/mkfs
> > blkid is /usr/sbin/blkid
> > e2fsck is /usr/sbin/e2fsck
> > tune2fs is /usr/sbin/tune2fs
> > evmctl is ../src/evmctl
> > setfattr is /usr/bin/setfattr
> > ./functions.sh: line 90: ../linux: No such file or directory
> > =================================
> >  Run with FAILEARLY=1 ./fsverity.test _cleanup_env cleanup
> >  To stop after first failure
> > =================================
> > PASS: 0 SKIP: 0 FAIL: 1
> > 
> > FAIL fsverity.test (exit status: 1)
> > 
> > FAIL: portable_signatures
> > =========================
> > 
> > evmctl is /__w/ima-evm-utils/ima-evm-utils/tests/../src/evmctl
> > ./functions.sh: line 90: ../linux: No such file or directory
> > ./functions.sh: line 90: ../linux: No such file or directory

