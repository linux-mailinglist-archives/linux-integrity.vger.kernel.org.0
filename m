Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CC49CCB7
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiAZOvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiAZOvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:51:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E330C06161C;
        Wed, 26 Jan 2022 06:51:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09C7AB81E7D;
        Wed, 26 Jan 2022 14:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18344C340E3;
        Wed, 26 Jan 2022 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208709;
        bh=BfQsXByWn3JPY8Qa8YYeS8YTm9L6z6Xi8uDKWKMdcTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5boXbX3q7PqM2UoCgFfeo2u+ew8eGGSDD9fxHU7SLeU3CWEDEWgwrdZGo02DuIp1
         IE1ty/vEuN3NdeMhzEO/6QveRLK4h925gAo7fECGgf64JDSP8FPggspq7wwEJw2rPJ
         j4IyhPyZ3M1ksdu49nUVtyYgIRiCTovwaAfN0CHNGq5Xq0akMaHvIs0bpGXYJFeMdq
         75tS+GWtlzZyYbyH4E/03QQeaYnfjydQ8LrygjE16//PRocrvgXkbG2Y+q2DnWWWuV
         +oYvXMHyprUaxYrYBpW4rPtuiw7V060p6YEIMdLaHVtYPkgurBTNv0cz4HRhRtNyS5
         u83gh5E2PvZ0g==
Date:   Wed, 26 Jan 2022 16:51:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Martin Ross <mross@pobox.com>
Cc:     corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        Yael Tiomkin <yaelt@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Message-ID: <YfFf8fvsDm8lQJgJ@iki.fi>
References: <CA++MVV3Jse4WZ-zr-SUWQz3Gk_dByU6JduVfUkvQNW+jgm9O4Q@mail.gmail.com>
 <YfFe9+XDPDIdSqF1@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFe9+XDPDIdSqF1@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 26, 2022 at 04:47:22PM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 18, 2022 at 01:26:05PM -0500, Martin Ross wrote:
> > Hi Jarkko,
> > 
> > I have been working with Yael on this project so I thought I might add
> > a bit of background here around the use case that this series of
> > patches is trying to address.
> > 
> > At a high level we are trying to provide users of encryption that have
> > key management hierarchies a better tradeoff between security and
> > availability.  For available and performance reasons master keys often
> > need to be released (or derived/wrapped keys created) outside of a KMS
> > to clients (which may in turn further wrap those keys in a series of
> > levels).  What we are trying to do is provide a mechanism where the
> > wrapping/unwrapping of these keys is not dependent on a remote call at
> > runtime.  e.g.  To unwrap a key if you are using AWS KMS or Google
> > Service you need to make an RPC.  In practice to defend against
> > availability or performance issues, designers end up building their
> > own kms and effectively encrypting everything with a DEK.  The DEK
> > encrypts same set as the master key thereby eliminating the security
> > benefit of keeping the master key segregated in the first place.

Mainly this part (would be enough to explain why it is there).

BR, Jarkko
