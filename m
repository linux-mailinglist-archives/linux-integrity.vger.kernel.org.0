Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E116C6817
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Mar 2023 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCWMVz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Mar 2023 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCWMVi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Mar 2023 08:21:38 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4627D73
        for <linux-integrity@vger.kernel.org>; Thu, 23 Mar 2023 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679574033;
        bh=kYLZN8L512l8O3JwSJz8bPf2xfvhTMgM0pomg73LtYE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WcBRsCK/432+mSzWZA/sXHq18+3OoRd/YcczomDmy815OblGXL65NbrM38oyYSq+C
         g0RSo51cbAKfAxEk3fsvjAvfInLBv+ui578Gqr8bP+cvt2BC0jzD9JRz0frW8sBYGo
         V4PMtTkfiptwF0jSTsENlirrKOoL2009K8ms3L3Y=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 11E2C1285E12;
        Thu, 23 Mar 2023 08:20:33 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PCrML0fDYFWH; Thu, 23 Mar 2023 08:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679574032;
        bh=kYLZN8L512l8O3JwSJz8bPf2xfvhTMgM0pomg73LtYE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MYI15VqRinh4Pck4hcOW/BVVDDgrE0y6YmF/ez16okyCDCdekqnqoRpsU+u/8Azeg
         bknDIYD3YBd+iOWvPHfLNXkLYZZv9Bi7HWutMM3gnJZwVq50uLw3zfaAx3dAAu7DFD
         o276Df/45FSDnDj8TcnJO/+e5fXEn6lJbOH6lc1o=
Received: from [153.66.160.227] (unknown [153.66.160.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E70931281E14;
        Thu, 23 Mar 2023 08:20:31 -0400 (EDT)
Message-ID: <2a8671aaae43738f45f7812a9e0d93a99c5ebc69.camel@HansenPartnership.com>
Subject: Re: tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Date:   Thu, 23 Mar 2023 08:20:29 -0400
In-Reply-To: <20230320134721.w7rcpk7ecbqvxrtg@kernel.org>
References: <de3ee520780be213c421685805c751dcda0754df.camel@HansenPartnership.com>
         <5cf966e97f9a0fabdf8d3b5a0cbae90abe484813.camel@HansenPartnership.com>
         <20230320134721.w7rcpk7ecbqvxrtg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-03-20 at 15:47 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 20, 2023 at 07:22:52AM -0400, James Bottomley wrote:
> > On Mon, 2023-03-20 at 07:15 -0400, James Bottomley wrote:
> > > The test for the AMD fTPM problem, which just went in, actually
> > > uses the wrong function template for request_locality().  It's
> > > missing an argument so the build breaks:
> > > 
> > > drivers/char/tpm/tpm-chip.c:568:8: error: too few arguments to
> > > function ‘tpm_request_locality’
> > >   ret = tpm_request_locality(chip);
> > >         ^~~~~~~~~~~~~~~~~~~~
> > > drivers/char/tpm/tpm-chip.c:43:12: note: declared here
> > >  static int tpm_request_locality(struct tpm_chip *chip, int
> > > locality)
> > >             ^~~~~~~~~~~~~~~~~~~~
> > > 
> > > Fix this by requesting zero locality.
> > 
> > Actually, this is a bad interaction with the non-upstream patch to
> > run the kernel in locality two to allow key policy to distinguish
> > kernel release from user space release, which goes back to the
> > debate over hibernation keys.  I'll carry it separately until (or
> > if ever) we get a resolution on how to do this.
> 
> BTW, do you have a newer version of
> 
> https://lore.kernel.org/linux-integrity/20230216201410.15010-1-James.Bottomley@HansenPartnership.com/
> 
> I'm planning to flush testing queue as I have now more bandwidth
> for TPM and keyring (actually I'm looking RISC-V fTPM's at work).

Hopefully next week.  I'm on a business trip and conference this week,
so most of my cycles have been going into that and converting the TPM2
engine to a provider, but I'm back home next week and the provider
conversion is pretty much done.

Regards,

James

