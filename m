Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41268D3E5
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBGKRR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 05:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGKRQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 05:17:16 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CB22016;
        Tue,  7 Feb 2023 02:17:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P9zP50dcBz9v7Hy;
        Tue,  7 Feb 2023 18:08:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgUJeJjjRf9AA--.25523S2;
        Tue, 07 Feb 2023 11:17:00 +0100 (CET)
Message-ID: <d6efb292273eee6caff9afc8b64e42984a3ae517.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v5] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 07 Feb 2023 11:16:45 +0100
In-Reply-To: <cd21f0d2a65f9673a0abe7f0a7219d5f1fe55911.camel@linux.ibm.com>
References: <20230203125637.2673781-1-roberto.sassu@huaweicloud.com>
         <cd21f0d2a65f9673a0abe7f0a7219d5f1fe55911.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBnMVgUJeJjjRf9AA--.25523S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fZr4xAF45AFyxtFW8WFg_yoW5Jr4kpF
        Z3Xas0kFs5JF1Ik34Ikay8Xr4Fvw4xtayUJ34DA340k3ZxXFn2kr43JFW3urykGrs5Wwnr
        ZF43t3yUuwnFkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj4Sq1gAAsO
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-02-06 at 08:20 -0500, Mimi Zohar wrote:
> On Fri, 2023-02-03 at 13:56 +0100, Roberto Sassu wrote:
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
> > 
> > Test both with the test_mmap application that by default requests the
> > PROT_READ protection flag. Its syntax is:
> > 
> > test_mmap <file> <mode>
> > 
> > where mode can be:
> > - exec: adds the PROT_EXEC protection flag to mmap()
> > - read_implies_exec: calls the personality() system call with
> >                      READ_IMPLIES_EXEC as the first argument before mmap()
> > - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
> >             to PROT_READ
> > - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
> >                     writable mapping
> > 
> > Check the different combinations of hooks/modes and ensure that a
> > measurement entry is found in the IMA measurement list only when it is
> > expected. No measurement entry should be found when only the PROT_READ
> > protection flag is requested or the matching policy rule has the
> > MMAP_CHECK_REQPROT hook and the personality() system call was called with
> > READ_IMPLIES_EXEC.
> > 
> > mprotect() with PROT_EXEC on an existing memory area protected with
> > PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> > hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> > a file with a writable mapping.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thanks, Roberto.  Other than the one comment below, it looks good.
> 
> > +
> > +if ! awk '$0 ~ /^(measure|appraise)/ && $0 !~ /fsuuid=/ && $0 !~ /fowner=/ { exit 1 }' < /sys/kernel/security/ima/policy; then
> > +	echo "${CYAN}IMA policy rules without fsuuid= and fowner=, cannot continue due to possible interference with the tests${NORM}"
> > +	exit "$SKIP"
> > +fi
> 
> The test should be limited to just MMAP_CHECK and MMAP_CHECK_REQPROT
> policy rules.
> 
> +if ! awk '$0 ~ /^(measure|appraise)/ && $0 ~ /func=MMAP_CHECK/ && $0 !~ /fsuuid=/ && ...

Oh, yes. Better.

Thanks

Roberto

