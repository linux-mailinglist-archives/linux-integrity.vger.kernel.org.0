Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC7680B0C
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 11:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjA3Kht (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 05:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjA3Khs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 05:37:48 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07275170C;
        Mon, 30 Jan 2023 02:37:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P54Df4Wx4z9xFPt;
        Mon, 30 Jan 2023 18:29:38 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHDQnlnddjABXcAA--.26027S2;
        Mon, 30 Jan 2023 11:37:33 +0100 (CET)
Message-ID: <08ad72c3ddebb829acd66697c14e9bb5fadc6f97.camel@huaweicloud.com>
Subject: Re: [PATCH v3 2/2] ima: Introduce MMAP_CHECK_REQPROT hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 30 Jan 2023 11:37:17 +0100
In-Reply-To: <89a7cc7efe1545e18c9af6c3ec53468d6f528a7a.camel@linux.ibm.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-2-roberto.sassu@huaweicloud.com>
         <89a7cc7efe1545e18c9af6c3ec53468d6f528a7a.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHDQnlnddjABXcAA--.26027S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15JrWDJFyfWF1DurWrAFb_yoW8AF13pF
        W8Ca4kKa1vqF15Arnagw17ZayrG393Kw1UXryDA34UZrs8XF9Y9r4S9FWYgFyIkr1kCw1Y
        vrZ8Kayfuw4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj4hCEwABsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2023-01-29 at 09:52 -0500, Mimi Zohar wrote:
> On Thu, 2023-01-26 at 17:38 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Commit 98de59bfe4b2f ("take calculation of final prot in
> > security_mmap_file() into a helper") caused ima_file_mmap() to receive the
> > protections requested by the application and not those applied by the
> > kernel.
> > 
> > After restoring the original MMAP_CHECK behavior with a patch, existing
> > systems might be broken due to not being ready to handle new entries
> > (previously missing) in the IMA measurement list.
> 
> Is this a broken system or a broken attestation server?  The
> attestation server might not be able to handle the additional
> measurements, but the system, itself, is not broken.

Ok, wasn't clear. I meant attestation server. The system itself is not
broken.

> "with a patch" is unnecessary.

Ok.

> > Restore the original correct MMAP_CHECK behavior instead of keeping the
> 
> ^ add missing comma after "behavior"
> 
> > current buggy one and introducing a new hook with the correct behavior. The
> > second option 
> 
> ^ The second option -> Otherwise,
> 
> > would have had the risk of IMA users not noticing the problem
> > at all, as they would actively have to update the IMA policy, to switch to
> > the correct behavior.
> > 
> > Also, introduce the new MMAP_CHECK_REQPROT hook to keep the current
> > behavior, so that IMA users could easily fix a broken system, although this
> > approach is discouraged due to potentially missing measurements.
> 
> Again, is this a broken system or a broken attestation server? 
> 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Otherwise, the patch looks good.

Ok, will make the changes.

Thanks

Roberto

