Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60873A371
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jun 2023 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjFVOpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jun 2023 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjFVOoY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jun 2023 10:44:24 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB52708;
        Thu, 22 Jun 2023 07:44:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qn2qB6Gy2z9xFr8;
        Thu, 22 Jun 2023 22:31:02 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHTQngXZRkeCaRAw--.29682S2;
        Thu, 22 Jun 2023 15:42:54 +0100 (CET)
Message-ID: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
Subject: [QUESTION] Full user space process isolation?
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
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
        Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 22 Jun 2023 16:42:37 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDHTQngXZRkeCaRAw--.29682S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xtw1rXFyUGF4UJF13urg_yoW8Zw1fpF
        9akFZ8GFn5GF429as7Wr48J3yrurZ3Xay3Gr9rKry3X34Y9Fy2yry3t3WrXF1DKrsY9a4j
        vwsxtrWjya1DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7
        UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj4sbAQABs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi everyone

I briefly discussed this topic at LSS NA 2023, but I wanted to have an
opinion from a broader audience.


In short:

I wanted to execute some kernel workloads in a fully isolated user
space process, started from a binary statically linked with klibc,
connected to the kernel only through a pipe.

I also wanted that, for the root user, tampering with that process is
as hard as if the same code runs in kernel space.

I would use the fully isolated process to parse and convert unsupported
data formats to a supported one, after the kernel verified the
authenticity of the original format (that already exists and cannot
change).

Preventing tampering of the process ensures that the conversion goes as
expected. Also, the integrity of the binary needs to be verified.


List of wished data formats:

PGP: verify the authenticity of RPM/DEB/... headers
RPM/DEB/... headers: extract reference file checksums for
                    (kernel-based) file integrity check (e.g. with IMA)


Alternative #1:

Write the parsers to run in kernel space. That was rejected due to
security and scalability concerns. If that changed, please let me know.


Alternative #2:

Linux distributions could provide what the kernel supports. However,
from personal experience, the effort seems orders of magnitude higher
than just writing a tiny component to support the original format. And
there is no guarantee that all Linux distributions will do it.


Full process isolation could be achieved in this way:

process -> outside: set seccomp strict profile at process creation
                    so that the process can only read/write/close the
                    pipe and exit, no other system calls are allowed

outside -> process: deny ptrace/kill with the process as target

Anything else?


The only risk I see is that a new feature allowing to interact with
another process is added to the kernel, without the ptrace permission
being asked.

With the restrictions above, can we say that the code inside the
process is as safe (against tampering) to execute as if it runs in
kernel space?

Thanks

Roberto

