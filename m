Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8622F307
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgG0Ovs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 10:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgG0Ovs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 10:51:48 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42FE2078E;
        Mon, 27 Jul 2020 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595861508;
        bh=yAzmB+WyBFm8HBunvOMK5AF4gvK+jkrR7N7IOJgigHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ElKpv8IyMH//JPgujpZF0SQHQ3cZRBSqE2EiW8EfdAwTjCcCZPfgZj4tSAICipdXG
         ZcU4Nz0jMs6m+hUTRpNX7OOpkdgam98JV8FhRxbUHVG8RSEfubJKkcI4kUNCr/1jxI
         OkY7mqMDBTQdDCqzIkwIITo861xfHTxlZwrG3/H4=
Message-ID: <1595861506.4841.121.camel@kernel.org>
Subject: Re: [PATCH v4 ima-evm-utils] extend ima_measurement --pcrs option
 to support per-bank pcr files
From:   Mimi Zohar <zohar@kernel.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 27 Jul 2020 10:51:46 -0400
In-Reply-To: <CAEjxPJ66--SytmNQpHF-DOkoWsE3ri-Ni6nA0k3YmY1fqU-0qQ@mail.gmail.com>
References: <20200727132110.5057-1-stephen.smalley.work@gmail.com>
         <1595859338.4841.116.camel@kernel.org>
         <CAEjxPJ66--SytmNQpHF-DOkoWsE3ri-Ni6nA0k3YmY1fqU-0qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-07-27 at 10:34 -0400, Stephen Smalley wrote:
> On Mon, Jul 27, 2020 at 10:15 AM Mimi Zohar <zohar@kernel.org> wrote:
> >
> > On Mon, 2020-07-27 at 09:21 -0400, Stephen Smalley wrote:
> >
> > > ---
> > > v4 updates the usage in the README and usage message, reduces MAX_NPCRFILE
> > > to 2 (for sha1 and sha256) and changes the buffer size to
> > > MAX_DIGEST_SIZE * 2 + 8 for the lines read from the pcrs file(s).
> > >
> > > One thing that is unclear to me is correct/expected usage of the
> > > --verify and --validate options to evmctl ima_measurement. For an
> > > appraisal of a remote attestation, when would one NOT want to use
> > > --verify (i.e. doesn't lack of --verify render the result insecure)
> > > and when would one want to use --validate (i.e. doesn't use of --validate
> > > render the result insecure)? And shouldn't the default in both cases
> > > be the more secure case (i.e. verify = 1, validate = 0)?  The naming of
> > > --validate is also confusing since one might expect it to mean
> > > to validate/check the result as opposed to ignore violations?
> >
> > Yes, agreed.  Thank you for reviewing and commenting on the code.
> >
> > While adding support for these features, originally in LTP and the
> > standalone version, they should be cleaned up.  Should "--verify" just
> > be dropped?
> 
> Unless there is some reason to not always verify during
> ima_measurement, I'd drop the option and just always do it.
> 
OK

> > Without a custom policy, with just the builtin
> > "ima_policy=tcb" policy, a few files are read while being opened for
> > write (e.g. audit, log, print files).  Perhaps rename "validate" to
> > something like "force-validate".
> 
> As long as there isn't a backward compatibility concern, that makes
> more sense to me. Or "ignore-violations". 

Even better.  I don't think there is a backwards compatibility is an
issue, as it was only added in 1.3.0.

> 
> > I forgot to add "evmctl boot_aggregate" to the README.  The supplied
> > pcrs could also be used to calculate the "boot_aggregate" value(s).
> 
> I guess that support is automatically picked up since nothing
> restricts usage of the --pcrs option to only ima_measurement and both
> call read_tpm_banks(), which includes the pcr file support.  So just a
> matter of updating the usage message and README?  That can be done as
> a separate patch IMHO.

Agreed.

Mimi

