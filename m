Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9511F732BE3
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjFPJdw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbjFPJdd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 05:33:33 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D52D7B;
        Fri, 16 Jun 2023 02:33:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QjDF023yCz9yMKd;
        Fri, 16 Jun 2023 17:21:40 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAHzlQALIxkAhhBAw--.16600S2;
        Fri, 16 Jun 2023 10:31:55 +0100 (CET)
Message-ID: <e213b58defcce0b49ee57cb27df591310eb09fd3.camel@huaweicloud.com>
Subject: Re: [PATCH] fsverity: improve documentation for builtin signature
 support
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Luca Boccassi <bluca@debian.org>
Cc:     fsverity@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Victor Hsieh <victorhsieh@google.com>
Date:   Fri, 16 Jun 2023 11:31:38 +0200
In-Reply-To: <20230616021707.GA87129@sol.localdomain>
References: <20230615230537.30429-1-ebiggers@kernel.org>
         <CAMw=ZnR69AhMMQUOwKv9RtP85JzxQhMGO3yzyeEagWxaGiPAZg@mail.gmail.com>
         <20230616021707.GA87129@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAHzlQALIxkAhhBAw--.16600S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr17XFyxJF1rKFy7Ww1ftFb_yoW3ZF43pF
        WSkF45Kwn5Jr18Arn2v3WI9rWFy3yrXw45Wrn8JrWFy3Z8urnFvr4I9F4rua98CrykGw4j
        vrWaqFyq934DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4rCAgACs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-06-15 at 19:17 -0700, Eric Biggers wrote:
> Hi Luca,
> 
> On Fri, Jun 16, 2023 at 02:10:35AM +0100, Luca Boccassi wrote:
> > On Fri, 16 Jun 2023 at 00:07, Eric Biggers <ebiggers@kernel.org> wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > fsverity builtin signatures (CONFIG_FS_VERITY_BUILTIN_SIGNATURES) aren't
> > > the only way to do signatures with fsverity, and they have some major
> > > limitations.  Yet, more users have tried to use them, e.g. recently by
> > > https://github.com/ostreedev/ostree/pull/2640.  In most cases this seems
> > > to be because users aren't sufficiently familiar with the limitations of
> > > this feature and what the alternatives are.
> > > 
> > > Therefore, make some updates to the documentation to try to clarify the
> > > properties of this feature and nudge users in the right direction.
> > > 
> > > Note that the Integrity Policy Enforcement (IPE) LSM, which is not yet
> > > upstream, is planned to use the builtin signatures.  (This differs from
> > > IMA, which uses its own signature mechanism.)  For that reason, my
> > > earlier patch "fsverity: mark builtin signatures as deprecated"
> > > (https://lore.kernel.org/r/20221208033548.122704-1-ebiggers@kernel.org),
> > > which marked builtin signatures as "deprecated", was controversial.
> > > 
> > > This patch therefore stops short of marking the feature as deprecated.
> > > I've also revised the language to focus on better explaining the feature
> > > and what its alternatives are.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > > 
> > > This patch applies to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
> > > 
> > >  Documentation/filesystems/fsverity.rst | 176 ++++++++++++++++---------
> > >  fs/verity/Kconfig                      |  16 +--
> > >  fs/verity/enable.c                     |   2 +-
> > >  fs/verity/open.c                       |   8 +-
> > >  fs/verity/read_metadata.c              |   4 +-
> > >  fs/verity/signature.c                  |   8 ++
> > >  6 files changed, 139 insertions(+), 75 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> > > index ede672dedf110..e990149cfdf5c 100644
> > > --- a/Documentation/filesystems/fsverity.rst
> > > +++ b/Documentation/filesystems/fsverity.rst
> > 
> > Most of the patch looks fine, two notes:
> > 
> > > +- Trusted userspace code.  When the accesses to a file happen in a
> > > +  well-defined way, userspace code can authenticate the file's
> > > +  fs-verity digest before accessing the file.  This can be done by
> > > +  verifying a signature of the fs-verity file digest using any
> > > +  userspace cryptographic library that supports digital signatures.
> > > +  Consider using `libsodium
> > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_
> > > +  or `Tink <https://developers.google.com/tink/digitally-sign-data>`_.
> > > +  Other options include OpenSSL, JCA, and libgcrypt.
> > 
> > This should at least mention something like "depending on whether the
> > threat model allows trusting userspace with such tasks", because it is
> > by no means guaranteed that it is the case.
> 
> Sure, that's why it says "Trusted userspace code", but I can make it clearer.
> 
> > > +- fs-verity builtin signatures are in PKCS#7 format, and the public
> > > +  keys are in X.509 format.  These data formats are complex and prone
> > > +  to vulnerabilities, so parsing them is preferably done in userspace.
> > > +  (fs-verity builtin signatures were made to use these formats because
> > > +  other kernel subsystems, such as the module loader, unfortunately
> > > +  used these formats already.)  Most cryptographic libraries also
> > > +  support working with raw keys and signatures, which are much
> > > +  simpler.  For example, consider using `libsodium
> > > +  <https://libsodium.gitbook.io/doc/public-key_cryptography/public-key_signatures>`_.
> > > +
> > > +  IMA appraisal, which supports fs-verity, does not use PKCS#7, so it
> > > +  partially avoids this issue as well (though it does use X.509).
> > 
> > The kernel makes extensive use of PKCS7, it's the foundation of the
> > trust chain with secure boot (and kernel modules as noted) after all,
> > among other things, so this description looks very out of place as
> > part of the same project. Readers might be led to believe that using
> > secure boot or signed modules is useless, or worse, dangerous, and
> > that it's better not to, and I'm quite sure that's not something we
> > want.
> > 
> 
> Unfortunately just because PKCS#7, X.509, and ASN.1 is being used does not mean
> it is a good idea.  Have you read the kernel code that implements these formats?
> A few years ago I went through some of it.  Here are some of the bugs I fixed:
> 
>     2eb9eabf1e86 ("KEYS: fix out-of-bounds read during ASN.1 parsing")
>     624f5ab8720b ("KEYS: fix NULL pointer dereference during ASN.1 parsing [ver #2]")
>     e0058f3a874e ("ASN.1: fix out-of-bounds read when parsing indefinite length item")
>     81a7be2cd69b ("ASN.1: check for error from ASN1_OP_END__ACT actions")
>     0f30cbea005b ("X.509: reject invalid BIT STRING for subjectPublicKey")
>     54c1fb39fe04 ("X.509: fix comparisons of ->pkey_algo")
>     971b42c038dc ("PKCS#7: fix certificate chain verification")
>     29f4a67c17e1 ("PKCS#7: fix certificate blacklisting")
>     437499eea429 ("X.509: fix BUG_ON() when hash algorithm is unsupported")
>     4b34968e77ad ("X.509: fix NULL dereference when restricting key with unsupported_sig") 
> 
> 971b42c038dc is noteworthy; it turned out the kernel did not properly verify
> certificate chains in PKCS#7 messages.  That was fundamentally a PKCS#7-specific
> security bug that was directly caused by the complexity that is specific to
> PKCS#7.  Simple signatures do not have certificate chains.
> 
> I hope the code is in slightly better shape now.  But I really haven't looked at
> it in several years.  In any case, the fact is that these formats are complex,
> which causes bugs.  I don't think we should be trying to pretend otherwise.

That is a quite extensive explanation why is not a good idea to parse
key/certificates in the kernel.

Actually, I tried to address that with this patch set:

https://lore.kernel.org/linux-kernel//20230425173557.724688-1-roberto.sassu@huaweicloud.com/

The idea was to develop an asymmetric key parser to forward the key
material from the kernel to a user space process for parsing, and get
back a well formatted key (basically the same fields of struct
public_key).

Maybe that would not work for X.509 certificates, as they are
extensively used in kernel code, but for simpler formats like PGP,
maybe. And the mechanism is interchangeable. If you want to support
another key format, you need to change only user space.

The challenge is if the user space process makes some security
decisions, like for key expiration, etc. I thought that we could
enforce strong isolation of that process by denying ptrace on it, but
it is still work in progress...

Roberto

> As for under what circumstances these risks are worth taking anyway, it's an
> interesting question.  Part of my concern is actually about people who don't
> actually use any of these integrity/authenticity oriented kernel features at
> all.  They are getting no benefit from them, and we don't want to create
> problems for them.  But, by CONFIG_FS_VERITY_BUILTIN_SIGNATURES being in their
> kernel config, their system is potentially opened up to exploits by
> FS_IOC_ENABLE_VERITY(malicious_pkcs7_signature).  Or just by
> CONFIG_X509_CERTIFICATE_PARSER being in their kernel config, their system is
> potentially opened up to exploits by sys_add_key(malicious_X509_certificate).
> They could eliminate this risk by disabling these kernel config options.
> 
> So I think that mentioning the risks of processing these data formats in the
> kernel is useful.  Though it maybe should be made clear that attack surface
> mainly comes from these features being configured into the kernel, not whether
> they're actually being used.
> 
> - Eric

