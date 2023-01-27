Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5567DEC5
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjA0H5n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 02:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0H5m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 02:57:42 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A06C127;
        Thu, 26 Jan 2023 23:57:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P38qQ5kHkz9xtnS;
        Fri, 27 Jan 2023 15:49:38 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBH8w7hg9Nj7+fOAA--.2015S2;
        Fri, 27 Jan 2023 08:57:28 +0100 (CET)
Message-ID: <36d25da9b9b6aa004311e083a67bc44f3edcf05c.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 27 Jan 2023 08:57:17 +0100
In-Reply-To: <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
         <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
         <5a2b46ef-71de-03f5-3d4d-ef6834a33971@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBH8w7hg9Nj7+fOAA--.2015S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF15GF4kXF1kGFyxKw1UGFg_yoW8JrW3pF
        Z3XayY9FsrtF1xCryIkw1UXryY9a1xJ34UX3s5uw1Y93ZxZF1vk3y8tF47WrWUAr95Xa97
        ZFWUKFW7Aw12yFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4goKAABs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-26 at 17:25 -0500, Stefan Berger wrote:
> 
> On 1/26/23 11:38, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add tests to ensure that, after applying the kernel patch 'ima: Align
> > ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> > checks the protections applied by the kernel and not those requested by the
> > application.
> > 
> > Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> > the MMAP_CHECK_REQPROT hook checks the protections requested by the
> > application.
> 
> below LGTM
> 
> How do you tell the user that the patches need to be applied for the test to
> succeed and not worry about it when the patches are not applied?

Uhm, I agree. I should at least write a comment as for EVM portable
signatures, and maybe display a message in the test logs.

> > Test both with the test_mmap application that by default requests the
> > PROT_READ protection flag. Its syntax is:
> > 
> > +
> > +check_mmap() {
> > +	local hook="$1"
> > +	local arg="$2"
> > +	local test_file
> > +	local fowner
> > +	local rule
> > +	local result
> > +	local test_file_entry
> > +
> 
> you can write them all in one line: 'local test_file fowner rule result test_file_entry'

Ok.

Thanks

Roberto

