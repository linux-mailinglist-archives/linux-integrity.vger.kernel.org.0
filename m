Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE182346573
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhCWQiH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233341AbhCWQhi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86C77619BA;
        Tue, 23 Mar 2021 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616517457;
        bh=F0RNyMp7cP3rnm5zp/DHoRIIjkF9eqcuKX3YzbT1oog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJM4vOPk8Lhk7zhhpT7mP0jxL2n2YUgV8uMOihiufT7EqlXOhTJ+Pe+CyCDWrH59a
         wczrfZD3OW6m0ILzJC6kSkwB2uUlh7+RFgz/NLlksJbX7GzPEo8WZbGEvjiP+7pbAx
         galyIYrqfcYsyv1qaQyVgjKhJutbe14Vejll/hKJw+MqimF//YW6Me/9rU3cW8lbUW
         RYuVKZfTOXR5Lw6c9Pcd63ei9xAhIWQp4RXCA3X3elQYMw98kLRJtxky4fP97lTIqH
         t6Gg1IKntBPazZbLxqmYmZVF+pPxtuaH7PfL8JucNC3JoDRMhq6t3Fr5F6vSeXdLF2
         GR3r2RB47qlJw==
Date:   Tue, 23 Mar 2021 18:37:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Enuta <paulenuta@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
Message-ID: <YFoZNM+Na7VXaYTz@kernel.org>
References: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
 <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
 <YFlNwaLhuwPiIzYF@kernel.org>
 <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
 <YFoWlT7D/4Su49xE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFoWlT7D/4Su49xE@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 23, 2021 at 06:25:59PM +0200, Jarkko Sakkinen wrote:
> On Tue, Mar 23, 2021 at 07:51:53AM +0200, Paul Enuta wrote:
> > Hi,
> > it happens with 5.10.25-v7l (latest mainline in Raspberry PI OS) and
> > in my test it started with 5.10.0-v7+.
> > 5.4.83-v7+ was OK.
> > Problems occur on fresh and clean installs with kernel versions above 5.10.
> > This quick fix solves:
> > --- tpm-chip.c.orig 2021-03-22 17:43:05.433433496 +0000
> > +++ tpm-chip.c 2021-03-22 18:22:52.000000000 +0000
> > @@ -101,6 +101,11 @@
> >  {
> >   int ret;
> > 
> > +    if (!chip->ops) {
> > +            pr_err("%s: Avoiding NULL ops pointer\n", __func__);
> > +            return -EIO;
> > +    }
> > +
> >   tpm_clk_enable(chip);
> > 
> >   if (chip->locality == -1) {
> > 
> 
> Please try with the actual mainline. We don't care about RPi kernel.

AFAIK you can compile BuildRoot for RPi and try vanilla mainline with that.
I cannot provide any support for that but at least it is a build target.

/Jarkko
