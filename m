Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2E632382
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Nov 2022 14:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKUNaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKUNaJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 08:30:09 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A6BEAF6;
        Mon, 21 Nov 2022 05:30:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NG7PD32hrz9v7Yb;
        Mon, 21 Nov 2022 21:23:12 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwC36fU6fXtjYTSBAA--.27697S2;
        Mon, 21 Nov 2022 14:29:40 +0100 (CET)
Message-ID: <ad7bfa59a3a89ccad52574e2f9fb8965dbaa1620.camel@huaweicloud.com>
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 21 Nov 2022 14:29:20 +0100
In-Reply-To: <fb3f423a-a56e-b6ed-d1e7-476605d607f8@schaufler-ca.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
         <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
         <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
         <3ffb9bb4ab203b5e0459c3892ded4ae0cd80458b.camel@linux.ibm.com>
         <fb3f423a-a56e-b6ed-d1e7-476605d607f8@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwC36fU6fXtjYTSBAA--.27697S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryrtF43Ww48ZF1UArWfuFg_yoW8Cw4fpF
        WUA3Wj9F4kJr47A34Iqr4ruw4a9rWrGayDXFn8Gr1jyFs0qrn3ZrWSvFy5uFy7W395t3yv
        qa1jva43Ar98AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj4GrBQACsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-18 at 09:31 -0800, Casey Schaufler wrote:
> On 11/18/2022 7:10 AM, Mimi Zohar wrote:
> > On Fri, 2022-11-18 at 10:14 +0100, Roberto Sassu wrote:
> > > > > +static int security_check_compact_xattrs(struct xattr *xattrs,
> > > > > +                                     int num_xattrs, int *checked_xattrs)
> > > > Perhaps the variable naming is off, making it difficult to read.   So
> > > > although this is a static function, which normally doesn't require a
> > > > comment, it's definitely needs one.
> > > Ok, will improve it.
> > > 
> > > > > +{
> > > > > +    int i;
> > > > > +
> > > > > +    for (i = *checked_xattrs; i < num_xattrs; i++) {
> > > > If the number of "checked" xattrs was kept up to date, removing the
> > > > empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
> > > > to support multiple per LSM xattrs?
> > > An LSM might reserve one or more xattrs, but not set it/them (for 
> > > example because it is not initialized). In this case, removing the gaps 
> > > is needed for all subsequent LSMs.
> > Including this sort of info in the function description or as a comment
> > in the code would definitely simplify review.
> > 
> > security_check_compact_xattrs() is called in the loop after getting
> > each LSM's xattr(s).  Only the current LSMs xattrs need to be
> > compressed, yet the loop goes to the maximum number of xattrs each
> > time. Just wondering if there is a way of improving it.
> 
> At security module registration each module could identify how
> many xattrs it uses. That number could be used to limit the range
> of the loop. I have to do similar things for the forthcoming LSM
> syscalls and module stacking beyond that.

Yes, blob_sizes.lbs_xattr contains the total number of xattrs requested
by LSMs. To stop the loop earlier, at the offset of the next LSM, we
would need to search the LSM's lsm_info, using the LSM name in
the security_hook_list structure. Although it is not optimal, not doing
it makes the code simpler. I could do that, if preferred.

Roberto

