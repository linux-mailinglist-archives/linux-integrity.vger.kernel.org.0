Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E57421E2
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjF2ISw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjF2ISF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 04:18:05 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CE35AF;
        Thu, 29 Jun 2023 01:12:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qs9rX0XNWz9xGn5;
        Thu, 29 Jun 2023 16:01:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB34+6xPJ1kmC3dAw--.43057S2;
        Thu, 29 Jun 2023 09:11:46 +0100 (CET)
Message-ID: <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com>
Subject: Re: [QUESTION] Full user space process isolation?
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
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
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Thu, 29 Jun 2023 10:11:26 +0200
In-Reply-To: <20230629021000.GA368825@mail.hallyn.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
         <20230629021000.GA368825@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwB34+6xPJ1kmC3dAw--.43057S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1xCry7WF1rZw15Cr1Dtrb_yoW7Gr15pF
        WqkFW5GFn8trs7CFZFqw4UGayFyrZ3JFW7Xrn3GryfZ34Y9FyIkrySkF13WFnIgrsY934j
        vrs8JrW2kan8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj4+H0QACss
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-06-28 at 21:10 -0500, Serge E. Hallyn wrote:
> On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
> > Hi everyone
> > 
> > I briefly discussed this topic at LSS NA 2023, but I wanted to have an
> > opinion from a broader audience.
> > 
> > 
> > In short:
> > 
> > I wanted to execute some kernel workloads in a fully isolated user
> > space process, started from a binary statically linked with klibc,
> > connected to the kernel only through a pipe.
> > 
> > I also wanted that, for the root user, tampering with that process is
> > as hard as if the same code runs in kernel space.
> > 
> > I would use the fully isolated process to parse and convert unsupported
> > data formats to a supported one, after the kernel verified the
> 
> Can you give some examples here of supported and unsupported data
> formats?  ext2 is supported, but we sadly don't trust the sb parser
> to read a an ext2fs coming from unknown source.  So I'm not quite
> clear what problem you're trying to solve.

+ eBPF guys (as I'm talking about eBPF)

File digests are distributed in a multitude of formats: RPM packages
provide them in RPMTAG_FILEDIGESTS, DEB packages in md5sum (now
sha256sum), containers I guess they have a manifest.

File digests would be used as reference values for IMA Appraisal and
IMA Measurement (to have a predictable PCR).

If we manage to write a tiny parser for RPM headers (I'm talking about
something like 200 lines) to extract the file digests, basically we
have all the information we need to do IMA Appraisal on current, past
and future RPM-based Linux distributions.

If we do the same for DEB (ok, well, when they switch from MD5 to
SHA256), we can support all DEB-based Linux distributions too.

On the opposite side, yes, we can change the RPM format, ask the
distributions to sign per-file. If it was that easy, we would not be
(still) waiting for the first distribution (Fedora 38) to support file
signatures since 2016, when the feature was proposed (sorry if it looks
like diminishing what Mimi and IBM proposed, I'm trying to convey the
idea of how difficult is to realize that architecture).

What about other formats? How long it could take for them to be adapted
to store file signatures?

Immediate support for IMA Appraisal is as far as looping into the RPM
header sections to obtain the data offset of RPMTAG_FILEDIGESTS and
converting the digests at that offset from hex to bin (we need also to
verify the PGP signature of the RPM header, but I would leave it for
later).

You probably also see how close we are to accomplish the goal. I'm open
to suggestions: if this idea of an isolated process doing the parsing
is not suitable, I could implement it in a different way.

So far I proposed:

- In-kernel parser (dangerous, not scalable)
https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/
- eBPF (no program signatures, not compliant with the LSM conventions,
  unsolved security issues)
https://github.com/robertosassu/diglim-ebpf/commit/693745cb388bca7354233cadae1fe2d23d47ff9d
- Isolated user space process (not enough isolation guarantees)
https://lore.kernel.org/linux-kernel//20230317145240.363908-1-roberto.sassu@huaweicloud.com/
https://lore.kernel.org/linux-kernel//20230425173557.724688-1-roberto.sassu@huaweicloud.com/

Thanks

Roberto

> > authenticity of the original format (that already exists and cannot
> > change).
> > 
> > Preventing tampering of the process ensures that the conversion goes as
> > expected. Also, the integrity of the binary needs to be verified.
> > 
> > 
> > List of wished data formats:
> > 
> > PGP: verify the authenticity of RPM/DEB/... headers
> > RPM/DEB/... headers: extract reference file checksums for
> >                     (kernel-based) file integrity check (e.g. with IMA)
> > 
> > 
> > Alternative #1:
> > 
> > Write the parsers to run in kernel space. That was rejected due to
> > security and scalability concerns. If that changed, please let me know.
> > 
> > 
> > Alternative #2:
> > 
> > Linux distributions could provide what the kernel supports. However,
> > from personal experience, the effort seems orders of magnitude higher
> > than just writing a tiny component to support the original format. And
> > there is no guarantee that all Linux distributions will do it.
> > 
> > 
> > Full process isolation could be achieved in this way:
> > 
> > process -> outside: set seccomp strict profile at process creation
> >                     so that the process can only read/write/close the
> >                     pipe and exit, no other system calls are allowed
> > 
> > outside -> process: deny ptrace/kill with the process as target
> > 
> > Anything else?
> > 
> > 
> > The only risk I see is that a new feature allowing to interact with
> > another process is added to the kernel, without the ptrace permission
> > being asked.
> > 
> > With the restrictions above, can we say that the code inside the
> > process is as safe (against tampering) to execute as if it runs in
> > kernel space?
> > 
> > Thanks
> > 
> > Roberto

