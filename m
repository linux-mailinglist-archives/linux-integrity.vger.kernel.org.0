Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD74A93FD
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Feb 2022 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiBDG2b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Feb 2022 01:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBDG2a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Feb 2022 01:28:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB8C061714;
        Thu,  3 Feb 2022 22:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77903B82FF0;
        Fri,  4 Feb 2022 06:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC95C004E1;
        Fri,  4 Feb 2022 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643956107;
        bh=QaFOZ+4F9bVAF26M1HaVC5kjbiVDzIfY69jkftb6Kao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9ngHE683pVzCGLDEjg491rrD5f6vfgfZUE06M7/XMoPJEmYmGSHLSU9NmKeeAOtw
         uyHttVx16YZbBlN9iAmOdfYLBCbstjpUytRpE6jy+BP8WAf6kzrDZKENykhFdNrFEM
         j2xP2uhqLJyBld79JNy4sQzvZGhg4+h/uM8Jc9q56sHW7sSbd0SU/K+q5nBddJ19NE
         aKCWCl7FrlSaqGYeC263P60on+RXOp9sRjfXBj5Egt7bMmrvn+Cch/R05SmqGuxGeL
         joZglMI26btTOAKwxwTzpMfo5GmjefOEWnot7IusAJjMCei9lt6Peo1/BQ48k8dVou
         PHMFm7gKDSSUg==
Date:   Fri, 4 Feb 2022 08:27:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     Martin Ross <mross@pobox.com>, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jmorris@namei.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        serge@hallyn.com, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Message-ID: <YfzHb9K5wZciy5um@iki.fi>
References: <CA++MVV3Jse4WZ-zr-SUWQz3Gk_dByU6JduVfUkvQNW+jgm9O4Q@mail.gmail.com>
 <YfFe9+XDPDIdSqF1@iki.fi>
 <YfFf8fvsDm8lQJgJ@iki.fi>
 <CAKoutNsaHNriobnsQ1X0Qfs=K+YN3JvfhTBnQqPL01AvjRm5EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKoutNsaHNriobnsQ1X0Qfs=K+YN3JvfhTBnQqPL01AvjRm5EA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 26, 2022 at 03:56:44PM -0500, Yael Tiomkin wrote:
> On Wed, Jan 26, 2022 at 9:51 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 04:47:22PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Jan 18, 2022 at 01:26:05PM -0500, Martin Ross wrote:
> > > > Hi Jarkko,
> > > >
> > > > I have been working with Yael on this project so I thought I might add
> > > > a bit of background here around the use case that this series of
> > > > patches is trying to address.
> > > >
> > > > At a high level we are trying to provide users of encryption that have
> > > > key management hierarchies a better tradeoff between security and
> > > > availability.  For available and performance reasons master keys often
> > > > need to be released (or derived/wrapped keys created) outside of a KMS
> > > > to clients (which may in turn further wrap those keys in a series of
> > > > levels).  What we are trying to do is provide a mechanism where the
> > > > wrapping/unwrapping of these keys is not dependent on a remote call at
> > > > runtime.  e.g.  To unwrap a key if you are using AWS KMS or Google
> > > > Service you need to make an RPC.  In practice to defend against
> > > > availability or performance issues, designers end up building their
> > > > own kms and effectively encrypting everything with a DEK.  The DEK
> > > > encrypts same set as the master key thereby eliminating the security
> > > > benefit of keeping the master key segregated in the first place.
> >
> > Mainly this part (would be enough to explain why it is there).
> >
> > BR, Jarkko
> 
> Hi Jarkko,
> 
> As for the commit message, WDYT about the following:
> 
> KEYS: encrypted: Instantiate key with user-provided decrypted data
> 
> For availability and performance reasons master keys often need to be
> released outside of a KMS to clients. It would be beneficial to provide a
> mechanism where the wrapping/unwrapping of DEKs is not dependent
> on a remote call at runtime yet security is not (or only minimally) compromised.
> Master keys could be securely stored in the Kernel and be used to wrap/unwrap
> keys from userspace.
> 
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to inject and encrypt user-provided
> decrypted data.
> 
> 
> I want to make sure we're on the same page before publishing a new version.
> 
> Thanks,
> Yael

It looks really good.

/Jarkko
