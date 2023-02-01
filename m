Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D756686B1D
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjBAQGz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 11:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjBAQGy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 11:06:54 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96243929;
        Wed,  1 Feb 2023 08:06:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P6RRV004pz9xrpt;
        Wed,  1 Feb 2023 23:58:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXmAMJjtpjxPjlAA--.13383S2;
        Wed, 01 Feb 2023 17:06:40 +0100 (CET)
Message-ID: <ff1283334591794172247d1db68290769c716865.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 01 Feb 2023 17:06:23 +0100
In-Reply-To: <f4c90a817018756398de7ab24d7e5068747de2b2.camel@linux.ibm.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
         <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
         <6a98beea4607a9684789e862b4182dfdf3bec8de.camel@linux.ibm.com>
         <f4c90a817018756398de7ab24d7e5068747de2b2.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwAXmAMJjtpjxPjlAA--.13383S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xtryrWFykury5uFWxJFb_yoW5Xr43pF
        Z3Xa4qkFs8XF10y34Ika18ZrWFyr4xt3yUXryDWry0kwn8tFn29r43JFW5urykCr4Sk3Zr
        ZF48K347uw4jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4hoGgABsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-01 at 08:48 -0500, Mimi Zohar wrote:
> On Tue, 2023-01-31 at 19:00 -0500, Mimi Zohar wrote:
> > On Tue, 2023-01-31 at 18:42 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add tests to ensure that, after applying the kernel patch 'ima: Align
> > > ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> > > checks the protections applied by the kernel and not those requested by the
> > > application.
> > > 
> > > Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> > > the MMAP_CHECK_REQPROT hook checks the protections requested by the
> > > application.
> > > 
> > > Test both with the test_mmap application that by default requests the
> > > PROT_READ protection flag. Its syntax is:
> > > 
> > > test_mmap <file> <mode>
> > > 
> > > where mode can be:
> > > - exec: adds the PROT_EXEC protection flag to mmap()
> > > - read_implies_exec: calls the personality() system call with
> > >                      READ_IMPLIES_EXEC as the first argument before mmap()
> > > - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
> > >             to PROT_READ
> > > - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
> > >                     writable mapping
> > > 
> > > Check the different combinations of hooks/modes and ensure that a
> > > measurement entry is found in the IMA measurement list only when it is
> > > expected. No measurement entry should be found when only the PROT_READ
> > > protection flag is requested or the matching policy rule has the
> > > MMAP_CHECK_REQPROT hook and the personality() system call was called with
> > > READ_IMPLIES_EXEC.
> > > 
> > > mprotect() with PROT_EXEC on an existing memory area protected with
> > > PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> > > hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> > > a file with a writable mapping.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Nice!   Including some comments, or at least the test assumption, would
> > help simplify reviewing the code.
> 
> An example of a test assumption, or background information, for the
> "mprotect" test is described in the ima_file_mprotect() function
> comment:
> 
>  * Files can be mmap'ed read/write and later changed to execute to circumvent
>  * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
>  * would be taken before i_mutex), files can not be measured or appraised at
>  * this point.  Eliminate this integrity gap by denying the mprotect
>  * PROT_EXECUTE change, if an mmap appraise policy rule exists.

Ok, I added the description to each test. Will send the new patch
shortly.

Roberto

