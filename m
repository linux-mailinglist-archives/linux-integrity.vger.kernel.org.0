Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247EA38CA76
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhEUP5A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 11:57:00 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:40290 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231638AbhEUP47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 11:56:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3ABD912802C9;
        Fri, 21 May 2021 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621612534;
        bh=LRTs9CtkZhKndoQkgYFa4soNDsQJlJBxZekFibco8HI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=altsaLn+LgqtCtPU4y3FoT9q7AgrsbJ/lJJHy6Mq/+q/zm8ANRhsWey7IG1j/1oj2
         FF5Oblx2ml+YVbl15SkIzO52v+vY8E7RnoYXYknmvXQmblqLDc+yj4PdeYmFLGoL4f
         UFD8G11ZNnByEBhJoVnAmrFKQ7d2U9l7c8HYYO9o=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uBdq4_15n8eE; Fri, 21 May 2021 08:55:34 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C181012802BC;
        Fri, 21 May 2021 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621612534;
        bh=LRTs9CtkZhKndoQkgYFa4soNDsQJlJBxZekFibco8HI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=altsaLn+LgqtCtPU4y3FoT9q7AgrsbJ/lJJHy6Mq/+q/zm8ANRhsWey7IG1j/1oj2
         FF5Oblx2ml+YVbl15SkIzO52v+vY8E7RnoYXYknmvXQmblqLDc+yj4PdeYmFLGoL4f
         UFD8G11ZNnByEBhJoVnAmrFKQ7d2U9l7c8HYYO9o=
Message-ID: <25e874bfd1d33ebd2dc774b9ab2d47285a2f4d07.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] Trusted Key policy for TPM 2.0
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Date:   Fri, 21 May 2021 08:55:32 -0700
In-Reply-To: <646c272b64912d9d5c9c3c7fdc304ad01772365c.camel@infradead.org>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
         <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
         <57728f2272f26b8ca9e58a8fdac112ec0440e9f6.camel@HansenPartnership.com>
         <646c272b64912d9d5c9c3c7fdc304ad01772365c.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-21 at 16:22 +0100, David Woodhouse wrote:
> On Fri, 2021-05-21 at 07:28 -0700, James Bottomley wrote:
> > On Fri, 2021-05-21 at 14:48 +0100, David Woodhouse wrote:
> > > On Thu, 2021-05-20 at 17:43 -0700, James Bottomley wrote:
> > > > Now that the ASN.1 representation of trusted keys is upstream
> > > > we can add policy to the keys as a sequence of policy
> > > > statements meaning the kernel can now construct and use the
> > > > policy session rather than the user having to do it and pass
> > > > the session down to the kernel.  This makes TPM 2.0 keys with
> > > > policy much easier.
> > > > 
> > > > The format of the policy statements is compatible with the
> > > > openssl_tpm2_engine policy implementation:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> > > > 
> > > > And the seal_tpm2_data command in the above can be used to
> > > > create sealed keys (including with policy statements) for the
> > > > kernel.
> > > 
> > > I'd love to see that format properly defined and documented
> > > instead of just a reference to another implementation.
> > 
> > Well if you want to help me write an RFC, I can try to submit it.
> 
> The xml2rfc tool makes it fairly easy.

XML and easy ... there's two words you don't often see in a sentence
...

> See https://github.com/dwmw2/ietf-cert-best-practice for a template;
> in Appendix B there is an example of specifying an ASN.1 format.

OK, I'll add it to 

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

But I'll be expecting patches ...

> We should probably define not just the ASN.1 format but also a URI
> scheme for referencing objects in NVRAM. A TPMv2 version of 
> https://datatracker.ietf.org/doc/html/draft-mavrogiannopoulos-tpmuri-01
> might be a good idea.

I'm not so sure ... the keys are files not tokens and the pkcs11 URI
doesn't have a file pointer.  I suspect the correct way to represent
them would be to fully represent the key in the URI, which sounds like
a length explosion.

If you really want to use PKCS11 for TPM keys, I've actually got an
engine exporter for any openssl engine key:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl-pkcs11-export.git/

So you can refer to them with standard PKCS11 URI components instead of
making your own up.  I use it for TPM keys in firefox for instance.

James


