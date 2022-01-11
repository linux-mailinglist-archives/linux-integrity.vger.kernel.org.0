Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902AB48A586
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 03:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiAKCXK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 21:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbiAKCXK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 21:23:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BCC06173F;
        Mon, 10 Jan 2022 18:23:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9069B81072;
        Tue, 11 Jan 2022 02:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD8C36AF6;
        Tue, 11 Jan 2022 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641867787;
        bh=JyqbfYNquf+Vez3GrKXe6HPwUfZVZKDoU7Ty1P57FDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1Iv1Bm9O/gZlCKOIx4r26zI4Q/ElUS2W1q6+0P7tzB4XalOpeuPUXU2Keq/TAi9I
         Ajoh3TDclN3BngCeOAYgXfXq/4gHUpNLAdx8hgOrCd/GXTWXRmrIfqn9nbw5/VQOfx
         /UJLRjbliVwufU45V+NgUKnYealfpnEe0RKzYdFfOhT2tzEvhcytioRrP8Ynhe6JUD
         YTVrhqhXMSRUFDO+QMDgzkATOr0/x0cwDATRHTfXir8iUWKKdJl659XWq74KRYEsJG
         XcFbyKSRH0XQqRNoB0uGhreu7kKeHAgupSaUxSi5RmycxP6X/OsvRN4MM09FaRbaPc
         YvFAIEt2IpNYw==
Date:   Tue, 11 Jan 2022 04:22:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <YdzqADeSwTc0egkw@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com>
 <YdmX2/BabFk2bNAv@iki.fi>
 <4ba63271bdf06fa8ae98c5cbd60d7b91bdbe75f7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba63271bdf06fa8ae98c5cbd60d7b91bdbe75f7.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 09, 2022 at 06:49:23AM -0500, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Sat, 2022-01-08 at 15:55 +0200, Jarkko Sakkinen wrote:
> > On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> > > load_certificate_list() parses certificates embedded in the kernel
> > > image to load them onto the keyring.
> > > 
> > > Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> > > function)" made load_certificate_list() a common function in the certs/
> > > directory. Now, export load_certificate_list() outside certs/ to be used
> > > by load_platform_certificate_list() which is added later in the patchset.
> > 
> > Also, please describe the specific use it will be used. Patchset is not
> > a valid cross-reference in this context.
> 
> The specific usecase scenario is described in the cover letter.  Is
> that what you're looking for?

You cannot refer to "a patch set" in the long description. It's by all
practical means a dead ref after some years. The commit messages are
meant for commit log to help to understand the history of changes.
This does not do that job. Neither a cover letter helps with this.

/Jarkko
