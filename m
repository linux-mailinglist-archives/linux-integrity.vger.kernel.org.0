Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB309735BCE
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jun 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFSQA1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFSQA0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 12:00:26 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915F18D
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jun 2023 09:00:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlDjK4RBGz9xGhR
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jun 2023 23:49:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXgzp+e5Bk6fBlAw--.22815S2;
        Mon, 19 Jun 2023 17:00:05 +0100 (CET)
Message-ID: <ed09ea43b7ea7365001d11518f660f1a58038396.camel@huaweicloud.com>
Subject: Re: [PATCH v3 ima-evm-utils 2/4] Restore correct HMAC calculation
 for directories
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 19 Jun 2023 17:59:54 +0200
In-Reply-To: <3afdbf3f-a08f-bf00-5583-140eb786dcb3@linux.ibm.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
         <20230616192358.314906-3-roberto.sassu@huaweicloud.com>
         <3afdbf3f-a08f-bf00-5583-140eb786dcb3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXgzp+e5Bk6fBlAw--.22815S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1ktF4UJFW8JF1rCw48Zwb_yoW8ArWkpa
        18W3WfGFsYgr17GFnxtanrX347WayvgF45Xr4Du34DuwnxWwn2gFyxtF43Was5Jw4fGr4S
        v3ZF9ry7Wa1DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj47tJgAAs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-19 at 11:54 -0400, Stefan Berger wrote:
> 
> On 6/16/23 15:23, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for
> > directory signing") removes fetching the inode generation for directories.
> > 
> > While directories might not be signed, EVM currently calculates the HMAC on
> > them, including the inode generation.
> > To keep user space and kernel space aligned, reenable fetching the inode
> > generation for directories, and add again the comment that the inode
> > generation cannot be obtained for special files.
> 
> The user wouldn't notice anything, right?

Probably not. This is just to verify that the HMAC is correct on
directories.

If it is possible to set the HMAC, that would mean that the HMAC on
directories is invalid. But 'evmctl hmac' is just for debugging
purposes.

Thanks

Roberto

> > Fixes: Commit 6ecb88352886 ("evmctl: Remove left-over check S_ISDIR() for directory signing")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   src/evmctl.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index c24261cf0e6..7a3ffd7c823 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -1229,7 +1229,11 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
> >   		goto out;
> >   	}
> >   
> > -	if (S_ISREG(st.st_mode)) {
> > +	if (S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) {
> > +		/*
> > +		 * We cannot at the moment get generation of special files..
> > +		 * kernel API does not support it.
> > +		 */
> >   		int fd = open(file, 0);
> >   
> >   		if (fd < 0) {
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

