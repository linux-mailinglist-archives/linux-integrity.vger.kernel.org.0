Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC6681683
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjA3Qgk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjA3Qgj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 11:36:39 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524BC3B0F5
        for <linux-integrity@vger.kernel.org>; Mon, 30 Jan 2023 08:36:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P5DBg5RxLz9xHvY
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 00:28:27 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBXKmEB8tdj5kbbAA--.8820S2;
        Mon, 30 Jan 2023 17:36:22 +0100 (CET)
Message-ID: <b927056b10cfe491ab4c289a2fc0961d99d96556.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 30 Jan 2023 17:36:09 +0100
In-Reply-To: <a275b9b5c0b24beda4398358728ca17e33ca9707.camel@linux.ibm.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
         <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
         <420799029373c9e0feae4eb21ca27b7253494591.camel@linux.ibm.com>
         <c5b46ac1e81b60aefebcf81dabe9e5a911a259a4.camel@huaweicloud.com>
         <a275b9b5c0b24beda4398358728ca17e33ca9707.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBXKmEB8tdj5kbbAA--.8820S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xury3trW5tF4Dtw15CFg_yoW8Arykpa
        yfJa15Kr4Dt3W8AFn7Kw10vw1ay3yrAa4DXrn8Cr1jyanIgr1Fyr4xKwnY9ayq9F4kXFy3
        Ar409asxJFWUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4hIxgAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 11:26 -0500, Mimi Zohar wrote:
> On Mon, 2023-01-30 at 15:02 +0100, Roberto Sassu wrote:
> > On Mon, 2023-01-30 at 08:28 -0500, Mimi Zohar wrote:
> > > [Trimmed Cc list, since this is an ima-evm-utils discussion.  Adding
> > > Petr.]
> > > 
> > > On Fri, 2023-01-27 at 08:57 +0100, Roberto Sassu wrote:
> > > > On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> > > > > How do you tell the user that the patches need to be applied for the test to
> > > > > succeed and not worry about it when the patches are not applied?
> > > > 
> > > > Uhm, I agree. I should at least write a comment as for EVM portable
> > > > signatures, and maybe display a message in the test logs.
> > > 
> > > This is a generic problem that needs to be addressed.  FYI, LTP
> > > addressed it by introducing "struct test_tag" in commit ca2c76990
> > > ("lib: Add support for test tags").
> > 
> > One idea could be to list all the patches the group of tests is going
> > to check, and add an argument to expect_pass and expect_fail to specify
> > the indexes of patches required for the test. We print the required
> > patches in an error message.
> 
> It's not clear to me what is meant by "group of tests".   Is this at
> the granularity of the test - portable signatures, fsverity,
> boot_aggregate, etc?  Or, is this at a new grouping of tests?

Sorry, it wasn't clear. I meant all the tests defined in a test script.

The idea is to associate a list of array indexes with each test
(argument of expect_pass() or expect_fail()). The indexes refer to the
PATCHES variable.

Theoretically, you could also define PATCHES in a common script, called
by all test scripts, and specify indexes of that array in the test
scripts.

I already have a patch, I could send it. Maybe it is more clear.

Roberto

