Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AF2F872B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 22:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbhAOVHA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 16:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbhAOVG7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 16:06:59 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34FC061757;
        Fri, 15 Jan 2021 13:06:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ED2F112808A8;
        Fri, 15 Jan 2021 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610744778;
        bh=v4pOuNxd7XaulOW1xCJ7p0Cq+YoWHHqbQrU3e3ssInQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vxaZn98AD1AecZoTxW9Jf66NN7lZEHv52EDXe8sYZKRBZ9XpJtVaj6/td6/VuNgNM
         1jiv2eZ+uaSUg/f/mqm9sn+UvJYuOLVGmTdi3doEMMlVamHRsjr71Hpz1BaFJm5eTh
         UWaDdzkYcyhR+Pe32j6yWiuBAav8monlp2WFqrXw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tcEx5im2ctlW; Fri, 15 Jan 2021 13:06:18 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71D9F128089B;
        Fri, 15 Jan 2021 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610744778;
        bh=v4pOuNxd7XaulOW1xCJ7p0Cq+YoWHHqbQrU3e3ssInQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=vxaZn98AD1AecZoTxW9Jf66NN7lZEHv52EDXe8sYZKRBZ9XpJtVaj6/td6/VuNgNM
         1jiv2eZ+uaSUg/f/mqm9sn+UvJYuOLVGmTdi3doEMMlVamHRsjr71Hpz1BaFJm5eTh
         UWaDdzkYcyhR+Pe32j6yWiuBAav8monlp2WFqrXw=
Message-ID: <f29d24f5170ad12cd40ef2352755ddff399983f8.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Joe Perches <joe@perches.com>, Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:06:17 -0800
In-Reply-To: <23f4bef1fa549f6576aab4f115576601e9f58eaf.camel@perches.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
         <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
         <X//55I26mxVQKKOE@kroah.com>
         <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
         <YAGeez8OZWDXugTW@kroah.com>
         <eb2acffef1368c48b3ca2d85105ef73b31797fe7.camel@HansenPartnership.com>
         <7a245c854925c8619eeb02aab6ff32bbccc92ed9.camel@HansenPartnership.com>
         <23f4bef1fa549f6576aab4f115576601e9f58eaf.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-15 at 12:48 -0800, Joe Perches wrote:
> On Fri, 2021-01-15 at 10:07 -0800, James Bottomley wrote:
> > On Fri, 2021-01-15 at 09:26 -0800, James Bottomley wrote:
> > > On Fri, 2021-01-15 at 14:54 +0100, Greg KH wrote:
> > > > On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley
> > > > wrote:
> > > [...]
> > > > > It looks like we already have a couple of bugs in the kernel
> > > > > introduced by this confusion ...  return sysfs_emit() vs
> > > > > return
> > > > > sysfs_emit_at() being the most tricky ...
> > > > 
> > > > Hm, Joe, you did the conversion to these functions (and wrote
> > > > the
> > > > api), care to review this?
> > > 
> > > A cursory glance tells me that summary_show in 
> > > drivers/infiniband/hw/usnic/usnic_ib_sysfs.c has a problem, I
> > > think the last = should be +=
> 
> No, it's correct and overwriting what would otherwise be a trailing
> space.

The last two lines of summary_show() are

   len = sysfs_emit_at(buf, len, "\n");

   return len;

So that always returns 2: the length of "\n", rather than the length of
everything you just put into buf, which is what sysfs attributes are
supposed to return.

James


