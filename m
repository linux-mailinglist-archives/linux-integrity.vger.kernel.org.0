Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3C2F81BF
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 18:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbhAORLJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 12:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733189AbhAORLJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 12:11:09 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC908C0613C1;
        Fri, 15 Jan 2021 09:10:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 218F41280055;
        Fri, 15 Jan 2021 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610730627;
        bh=xRezMHxeSl+GO5HaRdmwnmMXlQPWEuyHU3WuQttC27Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=M0N6HV1gj4oLueTDraK9xEGp4+oVVGfxCI1eXGlsrd/bshdcnu6dxSg95khxrnEra
         5jEojYVxEpYQpte/3pde2rdJb0rW9R4vuTWMExT1GyGz8s2kK3RM1U/Dzw6zSoSRz+
         HJQYT0SMSwsoX2WSWDSQEYnmh6uf9JfIIE+d9HXE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tUA6MTpo-UTL; Fri, 15 Jan 2021 09:10:27 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C6A6D128005D;
        Fri, 15 Jan 2021 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610730627;
        bh=xRezMHxeSl+GO5HaRdmwnmMXlQPWEuyHU3WuQttC27Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=M0N6HV1gj4oLueTDraK9xEGp4+oVVGfxCI1eXGlsrd/bshdcnu6dxSg95khxrnEra
         5jEojYVxEpYQpte/3pde2rdJb0rW9R4vuTWMExT1GyGz8s2kK3RM1U/Dzw6zSoSRz+
         HJQYT0SMSwsoX2WSWDSQEYnmh6uf9JfIIE+d9HXE=
Message-ID: <d80ad831d970e1c0828c8eb44ff5359bf07474b5.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Greg KH <greg@kroah.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 09:10:25 -0800
In-Reply-To: <YAE8fjt/lfYmEZxc@kernel.org>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
         <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
         <X//55I26mxVQKKOE@kroah.com>
         <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
         <YAE8fjt/lfYmEZxc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-15 at 08:55 +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley wrote:
> > On Thu, 2021-01-14 at 08:59 +0100, Greg KH wrote:
[...]
> > > Please use sysfs_emit() and sysfs_emit_at() for new sysfs files.
> > 
> > Hey these interfaces were added after this patch began life.  But
> > looking at sysfs_emit_at() I've got to say "aah ... don't you guys
> > ever read rusty's guide to interfaces?" an interface which takes in
> > an absolute page position but returns a relative offset to the
> > position it took in is asking for people to get it wrong.  You
> > should always be consistent about uses for inputs and
> > outputs.  Basically the only way you can ever use sysfs_emit_at in
> > a show routine is as
> > 
> > offset += sysfs_emit_at(buf, offset, ...);
> > 
> > because you always need to track the absolute offset.
> > 
> > It looks like we already have a couple of bugs in the kernel
> > introduced by this confusion ...  return sysfs_emit() vs return
> > sysfs_emit_at() being the most tricky ...
> 
> How is using sysfs_emit() different from using snprintf() for the
> caller, ignoring the added safety measures? I'm new to this API.

Using the sprintX variants you maintain a cursor pointer, so they all
look like

char *cursor = buf;

...

cursor += sprintX(cursor, "...", ...

...

return cursor - buf;

So the input is a relative cursor and the output is the additional
offset.  I'm not claiming it's the best interface but it is hard to get
wrong, just that if we're going to force a new interface we should make
it much better.

with sysfs_emit_at you use an offset "cursor" but it's hard to know
without reading the function how to do it because the return is
relative rather than absolute.  To have an interface it would be hard
to misuse, I think the best way would be to take a pointer to the
offset and adjust it after use, so

sysfs_emit_at(buf, &offset, ...);

That way it returns void so you can't use it in place of 

return sysfs_emit()

And you don't have to worry about whether the return is absolute or
relative because it adjusts the pointer for you.

The whole point about Rusty and interfaces is that if you are going to
invent new interfaces you should make them easy to get right and hard
to misuse.  A function you can't figure out how to use until you read
the source is about 2/10 on the rusty scale:

https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

James


