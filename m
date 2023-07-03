Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA04745FDE
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGCP34 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCP34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 11:29:56 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B90E49;
        Mon,  3 Jul 2023 08:29:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QvqMP4pDYz9xs5V;
        Mon,  3 Jul 2023 23:18:57 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnp0486aJkHmAEBA--.51047S2;
        Mon, 03 Jul 2023 16:29:17 +0100 (CET)
Message-ID: <ab8e68962feba9f16ed0a715d46ed003da61cfe8.camel@huaweicloud.com>
Subject: Re: [QUESTION] Full user space process isolation?
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Mon, 03 Jul 2023 17:28:57 +0200
In-Reply-To: <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
         <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDnp0486aJkHmAEBA--.51047S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rZF4UGryUCw1kGFWDtwb_yoW5Gr43pF
        W3Kr43Cr1DtFnakay8Zw1xua4F9393AFy3GryDGrnxZa4DKF1xur10ga1a9F1qqrZ29w1Y
        qrWqy34jkw4DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
        UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4+ywgABsN
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-03 at 17:06 +0200, Jann Horn wrote:
> On Thu, Jun 22, 2023 at 4:45 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > I wanted to execute some kernel workloads in a fully isolated user
> > space process, started from a binary statically linked with klibc,
> > connected to the kernel only through a pipe.
> 
> FWIW, the kernel has some infrastructure for this already, see
> CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
> example in net/bpfilter/.

Thanks, I actually took that code to make a generic UMD management
library, that can be used by all use cases:

https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/

> > I also wanted that, for the root user, tampering with that process is
> > as hard as if the same code runs in kernel space.
> 
> I believe that actually making it that hard would probably mean that
> you'd have to ensure that the process doesn't use swap (in other
> words, it would have to run with all memory locked), because root can
> choose where swapped pages are stored. Other than that, if you mark it
> as a kthread so that no ptrace access is allowed, you can probably get
> pretty close. But if you do anything like that, please leave some way
> (like a kernel build config option or such) to enable debugging for
> these processes.

I didn't think about the swapping part... thanks!

Ok to enable debugging with a config option.

> But I'm not convinced that it makes sense to try to draw a security
> boundary between fully-privileged root (with the ability to mount
> things and configure swap and so on) and the kernel - my understanding
> is that some kernel subsystems don't treat root-to-kernel privilege
> escalation issues as security bugs that have to be fixed.

Yes, that is unfortunately true, and in that case the trustworthy UMD
would not make things worse. On the other hand, on systems where that
separation is defined, the advantage would be to run more exploitable
code in user space, leaving the kernel safe.

I'm thinking about all the cases where the code had to be included in
the kernel to run at the same privilege level, but would not use any of
the kernel facilities (e.g. parsers).

If the boundary is extended to user space, some of these components
could be moved away from the kernel, and the functionality would be the
same without decreasing the security.

Or, new features that are too complex can be partially implemented in
kernel space, partially in user space, increasing their chances to be
upstreamed.

Roberto

