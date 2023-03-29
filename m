Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5B6CD2B8
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC2HMp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjC2HMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 03:12:44 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D4199;
        Wed, 29 Mar 2023 00:12:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pmcw43PF3z9xHw6;
        Wed, 29 Mar 2023 15:03:32 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX6F7D5CNk8fLYAQ--.17663S2;
        Wed, 29 Mar 2023 08:12:14 +0100 (CET)
Message-ID: <e7faa6ebe2958184aeccadad51d18877577b225b.camel@huaweicloud.com>
Subject: Re: [PATCH v8 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 29 Mar 2023 09:11:59 +0200
In-Reply-To: <CAHC9VhRNWeZtxain_Hi-EfS49Vac8_vg7KRRyV4a9Sq3XPhZsg@mail.gmail.com>
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
         <20230314081720.4158676-5-roberto.sassu@huaweicloud.com>
         <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
         <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
         <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
         <CAHC9VhRNjvjMOF5KLM6BoGfk=QpEBs_ur_CgRdGL5R1bA-JAwg@mail.gmail.com>
         <8b63d00d8ac3f686e51889ea4fc8d83f8ecb300d.camel@huaweicloud.com>
         <CAHC9VhRaKtsM=CuNhDy0Kx0NGSUrVhG+MhwKnHiyJxfgUwx7nA@mail.gmail.com>
         <1e08006f9011efa48deaf656c358ca3d438b9768.camel@huaweicloud.com>
         <CAHC9VhRNWeZtxain_Hi-EfS49Vac8_vg7KRRyV4a9Sq3XPhZsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAX6F7D5CNk8fLYAQ--.17663S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4UAr48AFyUJFy5ArWrXwb_yoW8trW5pF
        4Ut3Wqkr4vqr42yr92ya18G3yrK39xtr4UXwn8tr1UZ34qgryfCF1xKF43uryDGrn2k3s0
        vrWYgry3W3ZxAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4tHZgAAsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-03-28 at 16:19 -0400, Paul Moore wrote:
> On Tue, Mar 28, 2023 at 3:47 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2023-03-27 at 17:02 -0400, Paul Moore wrote:
> > > On Mon, Mar 27, 2023 at 3:30 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Fri, 2023-03-24 at 17:39 -0400, Paul Moore wrote:
> > > > > On Fri, Mar 24, 2023 at 9:26 AM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > On Fri, 2023-03-24 at 11:18 +0100, Roberto Sassu wrote:
> > > > > > > On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > > > > > > > On Tue, Mar 14, 2023 at 4:19 AM Roberto Sassu
> > > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> ...
> 
> > > Okay, that's fair, but we could still pass the full xattrs array and a
> > > reference to the current count which could be both read and updated by
> > > the individual LSMs, right?
> > 
> > Yes, we could do.
> > 
> > > The issue is that the separate compaction stage is not something we
> > > want to have to do if we can avoid it.  Maybe we're stuck with it, but
> > > I'm not yet convinced that we can't make some minor changes to the
> > > LSMs to avoid the compaction step.
> > 
> > I liked more the idea that LSMs do what they are most familiar with,
> > get an offset in a security blob or, in this case, a starting slot in
> > the new_xattrs array, and write there.
> > 
> > v3 had the lsm_find_xattr_slot() helper, to get the starting slot, but
> > somehow I find it less intuitive.
> > 
> > Ok, if you prefer to avoid the compaction stage, I will rewrite this
> > patch.
> 
> My concern is having to look through the xattr array after each LSM
> has been run and in at least one case having to then do a memcpy() to
> keep the array packed.  There are some cases where there is no way to
> avoid all that extra work, but here I think we have the LSMs do the
> Right Thing with respect to packing the xattr array without overly
> burdening the individual LSMs.
> 
> Does that make sense?  It basically comes down to being smart about
> our abstractions and both selectively, and carefully, breaking them
> when there is a reasonable performance gain to be had.

Yes, ok, it is a good approach.

Thanks

Roberto

