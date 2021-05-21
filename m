Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2038CAD4
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEUQTV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhEUQTU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 12:19:20 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C9C061574;
        Fri, 21 May 2021 09:17:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 261EA1280200;
        Fri, 21 May 2021 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621613877;
        bh=Oais6YJwVYhdqdoC7WH95gn3lhhc7UB2zycxHVUAlwg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Rve+hgfVCsCKJoFvPtrUPsPVGmHo592uCxszWndxCg5TJB+wgcFxUZkWyBKFIhOUh
         IIYZmH7zzAJECG1PLOAIkND4KA4RMON5NqJiLer5vZ2z88IwXuNgz5qwyBKk+i8vF/
         uSsOlPgBQ1OxUAyc+S4Nz601sf6ER4XPZ/SR/VLk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wOIM1MqAhv9C; Fri, 21 May 2021 09:17:57 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AD3E912801E6;
        Fri, 21 May 2021 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621613877;
        bh=Oais6YJwVYhdqdoC7WH95gn3lhhc7UB2zycxHVUAlwg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Rve+hgfVCsCKJoFvPtrUPsPVGmHo592uCxszWndxCg5TJB+wgcFxUZkWyBKFIhOUh
         IIYZmH7zzAJECG1PLOAIkND4KA4RMON5NqJiLer5vZ2z88IwXuNgz5qwyBKk+i8vF/
         uSsOlPgBQ1OxUAyc+S4Nz601sf6ER4XPZ/SR/VLk=
Message-ID: <9244313e34910f17664a6a0320e5b96b4e80d56d.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] Trusted Key policy for TPM 2.0
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Date:   Fri, 21 May 2021 09:17:56 -0700
In-Reply-To: <d440aa20d268b1a231d9a6ba641b23aa45ae7cb6.camel@infradead.org>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
         <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
         <57728f2272f26b8ca9e58a8fdac112ec0440e9f6.camel@HansenPartnership.com>
         <646c272b64912d9d5c9c3c7fdc304ad01772365c.camel@infradead.org>
         <25e874bfd1d33ebd2dc774b9ab2d47285a2f4d07.camel@HansenPartnership.com>
         <d440aa20d268b1a231d9a6ba641b23aa45ae7cb6.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-21 at 17:12 +0100, David Woodhouse wrote:
> On Fri, 2021-05-21 at 08:55 -0700, James Bottomley wrote:
> > On Fri, 2021-05-21 at 16:22 +0100, David Woodhouse wrote:
[...]
> > > We should probably define not just the ASN.1 format but also a
> > > URI scheme for referencing objects in NVRAM. A TPMv2 version of 
> > > https://datatracker.ietf.org/doc/html/draft-mavrogiannopoulos-tpmuri-01
> > > might be a good idea.
> > 
> > I'm not so sure ... the keys are files not tokens and the pkcs11
> > URI doesn't have a file pointer.  I suspect the correct way to
> > represent them would be to fully represent the key in the URI,
> > which sounds like a length explosion.
> 
> Not files, and definitely nothing to do with PKCS#11.
> 
> I meant a URI for referring to keys which are in NVRAM. The kind you
> currently use the '//nvkey:' prefix for.
> 
> We should standardise that form, as a URI, so that users can take
> that same URI to *any* application and expect it to work. That's
> what https://tools.ietf.org/html/draft-mavrogiannopoulos-tpmuri-01
> was doing, for TPMv1.2.

I'm not so sure we want to encourage that.  The persistent handle space
is really limited in TPM 2.0.  We just ran into a real world situation
where the TPM ran out after a handful.  It was an application that
loaded files into persistent handles ("because it's easier") and then
made use of them ... we're currently fixing it not to use persistent
handles because it doesn't need to.

James


