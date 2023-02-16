Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE7698E7A
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 09:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBPISu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 03:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBPISm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 03:18:42 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5DB2886B
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 00:18:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHSKw2N1hz9xGZF
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 16:10:12 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn9FrL5u1jW8gkAQ--.44744S2;
        Thu, 16 Feb 2023 09:18:25 +0100 (CET)
Message-ID: <4f8b0ace51c149178a1eedc1fc335aea6ac3f35b.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 16 Feb 2023 09:18:15 +0100
In-Reply-To: <d09e5c3b35ff101a19598e73e65a623be484e147.camel@linux.ibm.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
         <d09e5c3b35ff101a19598e73e65a623be484e147.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn9FrL5u1jW8gkAQ--.44744S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry7uFyxAFyfKFW3GFW8Crg_yoW8AF4fpF
        W8Ka4YkFs0gry2yr1xKa1UXFy0yr4kJay3Xr95Gr1Yva98Jr48KrW3Grs8Was5Cr4qgayS
        vrZYkrW5Gw1DWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4UN8gAAsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-15 at 18:39 -0500, Mimi Zohar wrote:
> On Tue, 2023-02-14 at 16:22 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add ima_policy_check.awk to check for possible overlapping of a rule being
> > added by a test with the existing IMA policy (policy replacement by IMA at
> > the first policy load is not taken into account).
> > 
> > ima_policy_check.awk expects as input the rule to be added, followed by the
> > IMA policy.
> > 
> > It returns a bit mask with the following values:
> > - 1: invalid new rule;
> > - 2: overlap of the new rule with an existing rule in the IMA policy;
> > - 4: new rule exists in the IMA policy.
> > 
> > Values can be individually checked by the test executing the awk script, to
> > determine what to do (abort loading, print a warning in case of overlap,
> > avoid adding an existing rule).
> > 
> > The bit mask allows the test to see multiple statements regarding the new
> > rule. For example, if the test added anyway an overlapping rule, it could
> > also see that the policy already contains it at the next test execution,
> > and does not add it again.
> > 
> > Since ima_policy_check.awk uses GNU extensions (such as the or() function,
> > or the fourth argument of split()), add gawk as dependency for the CI.
> > 
> > Finally add ima_policy_check.test, to ensure that the awk script behaves as
> > expected.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Roberto, I dropped a couple of your patches from the "next-testing"
> branch, assuming the "Introduce expect_pass_if() and expect_fail_if()" 
> and this patch are prerequisites for the "Add tests for MMAP_CHECK and
> MMAP_CHECK_REQPROT hooks" patch.

Yes, I send the latter after the former two are in the repo.

Thanks

Roberto

