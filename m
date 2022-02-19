Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE134BC83A
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Feb 2022 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiBSLmV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Feb 2022 06:42:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiBSLmV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Feb 2022 06:42:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AAB32078;
        Sat, 19 Feb 2022 03:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4650CB8013C;
        Sat, 19 Feb 2022 11:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D30C340EB;
        Sat, 19 Feb 2022 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645270919;
        bh=42N0kSNDN/I0l7uNeWq1bWt0szwT7gCbE5fdpr8yCWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3O2Mbkpy5TFqAygEu87Dvm9J87aB8FAFvYPSkE9DLHzRQlZXkAlWApSkQQZaFgEB
         L7jszgblHHH1L7JJkforHcFZ1JF0KCGZZifWtslRWx0DiUcBvShfihcgZI4qViffbd
         lFcKrpPkZ4X6Tv3yILibtkxjXDNyudmM44Q0NRt40XQFBugcE3Zk8Wx8flsPYcquN9
         btlLaJmoCSDzGgbHEnOj4/SZJVMq5rGGoc7oKv2UtbLINzm3E2uYd0qHeD5NPhMdoL
         n4gyWmC6Wk1UZMXw3VAsPWZ7eZIWvFMLnLllPTyk+FcpqyUZA8plxckNOLRlTnifdr
         3XFtUZubEZoYg==
Date:   Sat, 19 Feb 2022 12:42:30 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
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
Message-ID: <YhDXpq8YDhxg0RLW@iki.fi>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
 <YcGVZitNa23PCSFV@iki.fi>
 <5030a9ff-a1d1-a9bd-902a-77c3d1d87446@digikod.net>
 <Ydc/E3S2vmtDOnpw@iki.fi>
 <YddADJJNLDlQAYRW@iki.fi>
 <86c5010e-a926-023a-8915-d6605cfc4f0a@digikod.net>
 <e4707df2-ecc2-0471-87fc-c54e774fe315@digikod.net>
 <Yg6o/ARtOIwuBFsW@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yg6o/ARtOIwuBFsW@iki.fi>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 17, 2022 at 08:58:57PM +0100, Jarkko Sakkinen wrote:
> On Mon, Jan 31, 2022 at 12:33:51PM +0100, Mickaël Salaün wrote:
> > 
> > On 07/01/2022 13:14, Mickaël Salaün wrote:
> > > 
> > > On 06/01/2022 20:16, Jarkko Sakkinen wrote:
> > > > On Thu, Jan 06, 2022 at 09:12:22PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue, Jan 04, 2022 at 04:56:36PM +0100, Mickaël Salaün wrote:
> > > > > > 
> > > > > > On 21/12/2021 09:50, Jarkko Sakkinen wrote:
> > > > > > > On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
> > > > > > > > Hi Jarkko,
> > > > > > > > 
> > > > > > > > Since everyone seems OK with this and had plenty of
> > > > > > > > time to complain, could
> > > > > > > > you please take this patch series in your tree? It still applies on
> > > > > > > > v5.16-rc5 and it is really important to us. Please
> > > > > > > > let me know if you need
> > > > > > > > something more.
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > >    Mickaël
> > > > > > > 
> > > > > > > I'm off-work up until end of the year, i.e. I will
> > > > > > > address only important
> > > > > > > bug fixes and v5.16 up until that.
> > > > > > > 
> > > > > > > If any of the patches is yet missing my ack, feel free to
> > > > > > > 
> > > > > > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > 
> > > > > > Thanks Jarkko. Can you please take it into your tree?
> > > > > 
> > > > > I can yes, as I need to anyway do a revised PR for v5.17, as one commit
> > > > > in my first trial had a truncated fixes tag.
> > > > 
> > > > Please check:
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > > 
> > > > /Jarkko
> > > 
> > > Great, thanks!
> > 
> > Hi Jarkko,
> > 
> > I noticed your commits https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=3ec9c3a0531ac868422be3b12fc17310ed8c07dc
> > are no more referenced in your tree. Is there an issue?
> 
> This must be some sort of mistake I've made. I'll re-apply the patches.
> Sorry about this.

OK now the patches are in and will be included to the next PR. I fixed
merge conflicts caused by 5cca36069d4c ("certs: refactor file cleaning")
in "certs: Check that builtin blacklist hashes are valid" so please
sanity check that it is good.

BR, Jarkko
