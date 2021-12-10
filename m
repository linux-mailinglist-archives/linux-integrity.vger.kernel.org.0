Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A33E470DAB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 23:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhLJW1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 17:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhLJW1w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 17:27:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4604EC061746
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 14:24:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A3DACE2BA3
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 22:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DC4C00446;
        Fri, 10 Dec 2021 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639175053;
        bh=W8KqO1cE2o5uQrRJUeUUqxz6D97A/EFHg0yDfUi9UOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/A1qEYE1uhsi4ArSD+dg/vk97CPbgkqMk7iVkVM8TqDHAaOvir0hOsmGzBygJTmt
         orQNfzYFz9uaPC3jgiDkBhCUDvbluQrArPQldSq5ewxc1qrzUn/tFQnEcVIhGMZvWL
         zjxqQ/sq68k+D9xBs1jpATbTTeJRgCKAty0RilZJZawO5Kc87Md3XPB/I41TpIffwy
         DqhBH3jmqan15O+Xsxx0d/9fKfEct7V9dFP1LZzVZuxM2Iw0JfZwb+F5xxaZ1Kh9a4
         DbCDi54bXpQaw3gsYI+rVDJLTzb5aNTx15vwWvXTKODgajjlQbgu2FlpKn4AU7ceoc
         8kQO0jE7EeuzQ==
Date:   Fri, 10 Dec 2021 14:24:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] Instantiate key with user-provided decrypted data.
Message-ID: <YbPTiwNicyavD+Rm@sol.localdomain>
References: <20211210143531.1948911-1-yaelt@google.com>
 <YbOleSuhV6ME4/mk@sol.localdomain>
 <CAKoutNvnhE+DZW3cS6KG-C2jEH4LE+9cSnCkUcL2adfcXWaKDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKoutNvnhE+DZW3cS6KG-C2jEH4LE+9cSnCkUcL2adfcXWaKDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 10, 2021 at 02:17:43PM -0500, Yael Tiomkin wrote:
> On Fri, Dec 10, 2021 at 2:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Fri, Dec 10, 2021 at 09:35:31AM -0500, Yael Tiomkin wrote:
> > > The encrypted.c class supports instantiation of encrypted keys with
> > > either an already-encrypted key material, or by generating new key
> > > material based on random numbers. To support encryption of
> > > user-provided decrypted data, this patch defines a new datablob
> > > format: [<format>] <master-key name> <decrypted data length>
> > > <decrypted data>.
> >
> > What is the use case for this feature?
> >
> > Also, please send this to all the relevant mailing lists and people.
> > Notably,
> > you didn't send this to the keyrings mailing list.  Try running
> > ./scripts/get_maintainer.pl on the patch file.
> >
> > Please also test patches before sending them.  This one doesn't even
> > compile.
> >
> > - Eric
> >
> 
> Hi,
> 
> Apologies for having missed additional relevant mailing lists.
> I sent a previous email asking to disregard this patch and have since sent
> out a fixed version which does compile.

I don't see your "email asking to disregard this patch".  Did you send it in
plain text?  The Linux kernel mailing lists don't accept non-plain-text email.

Also, the second version isn't marked as "[PATCH v2]" like would be expected.
So it looks like a duplicate rather than a new version.

Can you make sure you've read Documentation/process/submitting-patches.rst?

- Eric
