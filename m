Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775CC689224
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 09:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBCIYd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 03:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjBCIYL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 03:24:11 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF4D25BA5;
        Fri,  3 Feb 2023 00:22:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P7T1l5Hx2z9v7Hy;
        Fri,  3 Feb 2023 16:13:31 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXmAP_w9xjc2TtAA--.17044S2;
        Fri, 03 Feb 2023 09:21:28 +0100 (CET)
Message-ID: <d6c331029bb47fa7a4e574a66b28cf7c96edd5b0.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v4] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 03 Feb 2023 09:21:16 +0100
In-Reply-To: <805425ab66a004b110cf0c33423ba5a4247c5cb4.camel@linux.ibm.com>
References: <20230202135131.2445816-1-roberto.sassu@huaweicloud.com>
         <fbac5d34fee2c3d4bbf036c06252fd0671577558.camel@linux.ibm.com>
         <ae83bc62a798180281b2bcf6a469e97586d2af7c.camel@huaweicloud.com>
         <805425ab66a004b110cf0c33423ba5a4247c5cb4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAXmAP_w9xjc2TtAA--.17044S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1rCw43AFWxuw4UKr1kAFb_yoWDKrbE9r
        1j9rykCr9xGrs7Gwsxt398Jw4DKr4qvr1rKw47Xw42ywn8ZFs3Ars09rna9wn3Gr90qasx
        CrWrXF9Yv3sF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj4R-pQACs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-02 at 15:40 -0500, Mimi Zohar wrote:
> On Thu, 2023-02-02 at 17:23 +0100, Roberto Sassu wrote:
> > > > +   if (ptr == MAP_FAILED) {
> > > > +           ret = ERR_SETUP;
> > > > +           if (argv[2] && !strcmp(argv[2], "exec_on_writable") &&
> > > > +               errno == EACCES)
> > > > +                   ret = ERR_TEST;
> > > > +
> > > 
> > > FYI, on an older distro kernel, the mmap fails and results in following
> > > without any explanation.
> > > 
> > > Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "exec")
> > > Unexpected exit status 1 from test_mmap
> > > 
> > > With some additional debugging, I'm seeing:
> > > Failed mmap() /tmp/tmp.4gD2UjSvC4/tmp.PlzUEm09hO, err: -13 (Permission
> > > denied)b
> > 
> > Uhm, ok. Which kernel is failing?
> 
> I'm able to reproduce the error on a next-integrity or next-integrity-
> testing kernel, by running the tests multiple times.  The error doesn't
> occur the first time running the test, but subsequent times.

Ops, yes. The problem was that the fowners of the measure and appraise
rules were shared. Will not work, unless the files used in the measure
tests are signed too.

Roberto

