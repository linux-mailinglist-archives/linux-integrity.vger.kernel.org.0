Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7E55AF75
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 08:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiFZGSJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 02:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiFZGSJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 02:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D71CB1FA;
        Sat, 25 Jun 2022 23:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CEB610FB;
        Sun, 26 Jun 2022 06:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB5C3411D;
        Sun, 26 Jun 2022 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224287;
        bh=zZYSU8gslVRru78DctdKqo9B5aQthNmHzWz6doljCQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOJt+FyxOyBkAzGh1aMGZhEurBeRFOPNveMuMhKen/8epYYDToXJaIPm/vuSlulrX
         ZohXz9+kjsML9FTpng3N8xv9L27jJMJv0EKeIhrFYoOGksXH8UuL0IqQd3ojH1MQTx
         HCy2Xv6Ox60fF3OL3atF9geqbOGvA50JMrPq9YvhLmhfiVyda1+T+9GpuMZguGVDco
         VdlvPucz9b6nYSnuxphWuDNGSQwPz3FJdG5RnvXuVJ5tcjcUomQGHuPfLqoENlp+2+
         ocY+CeDQOgULMOCjwr/heplQ7m2iT3dKkQUGlMsq6SFkQLOYm9Nm8CNTv0E4ZmDIl7
         8riw2h+pZaRsQ==
Date:   Sun, 26 Jun 2022 09:18:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: increase timeout for kselftests
Message-ID: <Yrf6HJgvuIHXyqrj@kernel.org>
References: <20220510111607.22984-1-johannes.holland@infineon.com>
 <YnvSwJxOg+IZxrxz@kernel.org>
 <51a14f28-ce94-ade9-6512-a265f7b32dfb@infineon.com>
 <YovniXv6ATJ/vpt6@kernel.org>
 <4832efdf-f2a7-7b0c-4477-088772c962c0@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4832efdf-f2a7-7b0c-4477-088772c962c0@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 20, 2022 at 04:45:45PM +0200, Stefan Mahnke-Hartmann wrote:
> 
> 
> On 23.05.22 21:59, Jarkko Sakkinen wrote:
> > On Fri, May 20, 2022 at 03:28:42PM +0200, Stefan Mahnke-Hartmann wrote:
> >>
> >> On 11.05.22 17:14, Jarkko Sakkinen wrote:
> >>> On Tue, May 10, 2022 at 01:16:08PM +0200, Johannes Holland wrote:
> >>>> Due to CreatePrimary commands which need to create RSA keys of
> >>>> increasing size, the timeout value need to be raised, as well.
> >>>> Default is 300s.
> >>>>
> >>>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> >>>> ---
> >>>> A timeout of anything below 600s still lead to occasional timeouts for
> >>>> me. Therefore, I propose 600s as a new value. 
> >>>>
> >>>>  tools/testing/selftests/tpm2/settings | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>  create mode 100644 tools/testing/selftests/tpm2/settings
> >>>>
> >>>> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
> >>>> new file mode 100644
> >>>> index 000000000000..919bc3803f03
> >>>> --- /dev/null
> >>>> +++ b/tools/testing/selftests/tpm2/settings
> >>>> @@ -0,0 +1,2 @@
> >>>> +timeout=600
> >>>> +
> >>>> -- 
> >>>> 2.34.1
> >>>>
> >>> Could cope but I did not get why it needs to be raised.
> >> The TPM2 SpaceTest testsuite currently creates 8 primary RSA 2k keys + 1 for
> >> setup. Generating a RSA2k key can take up to ~1-2 minutes on some of our TPMs.
> >> => 2x9 = 18 minutes. In the kernel we even define a duration timeout for rsa2k
> >> keygen of 5 min per key! (TPM2_DURATION_LONG_LONG = 300000) => up to 45 minutes
> >> would be "acceptable".
> >>
> >> However since the average key generation time is much faster, a value of ~10
> >> minutes should be fine enough.
> >>
> >> The reason why you did not experience this yet on your test system is either
> >> because PTT TPMs are faster in that respect and/or some TPMs implement pre-gen
> >> mechanisms for key generation, (or just plain luck)
> >>
> >> BR, Stefan
> >>
> >>> BR, Jarkko
> > I think this is ok.
> >
> >
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > BR, Jarkko
> >
> Hi Jarkko,
>  
> Just curious. I can't see this patch was added to linux-next. Was I
> expected to do something more to it?
>  
> Kind regards
> Stefan

Couple of things:

- Send to selftests maintainer:
- "selftests/tpm2" instead of "tpm:"

BR, Jarkko
