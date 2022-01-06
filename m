Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3666B486A58
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 20:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiAFTM1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 14:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243214AbiAFTM0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 14:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC3C061245;
        Thu,  6 Jan 2022 11:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5624C61DCB;
        Thu,  6 Jan 2022 19:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C00DC36AEB;
        Thu,  6 Jan 2022 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641496344;
        bh=RGMv3c9RtszLnGP6345icCZo//PR8+VuUHeUFkETDa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOSgw1dnM0uVygK+NMI4M8LLbRBZ5BTKeTzzdQ32KBoPiRSDEbuwKn6ebhwu6Tyk9
         QoyZB3aJkSa0jSMuqCEryxMZScv6CXJ1Pw14gnPss9L461GgUy2vDSKHKAWTECSxgm
         r4/4+twfA0hH0XFs9XryOkyrbjcQkUHgvJTigQ6AcQPmDOxtLbuGqjgiVHWKy2Wo/C
         8p3d1wHzzvnIOCT3TOn0KkrgIwklrubKXYWkd/+zLnqItvmWyZqoi8wBpwl3qscy9P
         RSEVYGsMOOaQP85lj3XX2PbmDDKi7+0dVccluXbqg4g73IkyWmzJEWePyOfLBeTvbc
         pn57Ci36JRPUA==
Date:   Thu, 6 Jan 2022 21:12:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
Message-ID: <Ydc/E3S2vmtDOnpw@iki.fi>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
 <YcGVZitNa23PCSFV@iki.fi>
 <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 04, 2022 at 04:56:36PM +0100, Mickaël Salaün wrote:
> 
> On 21/12/2021 09:50, Jarkko Sakkinen wrote:
> > On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
> > > Hi Jarkko,
> > > 
> > > Since everyone seems OK with this and had plenty of time to complain, could
> > > you please take this patch series in your tree? It still applies on
> > > v5.16-rc5 and it is really important to us. Please let me know if you need
> > > something more.
> > > 
> > > Regards,
> > >   Mickaël
> > 
> > I'm off-work up until end of the year, i.e. I will address only important
> > bug fixes and v5.16 up until that.
> > 
> > If any of the patches is yet missing my ack, feel free to
> > 
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Thanks Jarkko. Can you please take it into your tree?

I can yes, as I need to anyway do a revised PR for v5.17, as one commit
in my first trial had a truncated fixes tag.

/Jarkko
