Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC6741DF7
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 04:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF2CKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jun 2023 22:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjF2CKF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jun 2023 22:10:05 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B71FEB;
        Wed, 28 Jun 2023 19:10:02 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 479A1579; Wed, 28 Jun 2023 21:10:00 -0500 (CDT)
Date:   Wed, 28 Jun 2023 21:10:00 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
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
Subject: Re: [QUESTION] Full user space process isolation?
Message-ID: <20230629021000.GA368825@mail.hallyn.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
> Hi everyone
> 
> I briefly discussed this topic at LSS NA 2023, but I wanted to have an
> opinion from a broader audience.
> 
> 
> In short:
> 
> I wanted to execute some kernel workloads in a fully isolated user
> space process, started from a binary statically linked with klibc,
> connected to the kernel only through a pipe.
> 
> I also wanted that, for the root user, tampering with that process is
> as hard as if the same code runs in kernel space.
> 
> I would use the fully isolated process to parse and convert unsupported
> data formats to a supported one, after the kernel verified the

Can you give some examples here of supported and unsupported data
formats?  ext2 is supported, but we sadly don't trust the sb parser
to read a an ext2fs coming from unknown source.  So I'm not quite
clear what problem you're trying to solve.

> authenticity of the original format (that already exists and cannot
> change).
> 
> Preventing tampering of the process ensures that the conversion goes as
> expected. Also, the integrity of the binary needs to be verified.
> 
> 
> List of wished data formats:
> 
> PGP: verify the authenticity of RPM/DEB/... headers
> RPM/DEB/... headers: extract reference file checksums for
>                     (kernel-based) file integrity check (e.g. with IMA)
> 
> 
> Alternative #1:
> 
> Write the parsers to run in kernel space. That was rejected due to
> security and scalability concerns. If that changed, please let me know.
> 
> 
> Alternative #2:
> 
> Linux distributions could provide what the kernel supports. However,
> from personal experience, the effort seems orders of magnitude higher
> than just writing a tiny component to support the original format. And
> there is no guarantee that all Linux distributions will do it.
> 
> 
> Full process isolation could be achieved in this way:
> 
> process -> outside: set seccomp strict profile at process creation
>                     so that the process can only read/write/close the
>                     pipe and exit, no other system calls are allowed
> 
> outside -> process: deny ptrace/kill with the process as target
> 
> Anything else?
> 
> 
> The only risk I see is that a new feature allowing to interact with
> another process is added to the kernel, without the ptrace permission
> being asked.
> 
> With the restrictions above, can we say that the code inside the
> process is as safe (against tampering) to execute as if it runs in
> kernel space?
> 
> Thanks
> 
> Roberto
