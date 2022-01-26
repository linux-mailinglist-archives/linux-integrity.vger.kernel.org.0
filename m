Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099C849CCA6
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiAZOrm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:47:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59566 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiAZOrm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:47:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC470B81E4D;
        Wed, 26 Jan 2022 14:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E56C340E3;
        Wed, 26 Jan 2022 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208459;
        bh=PvgdKDY6x/qQEODxXtw3/fdzN/Ym+5XzciPDitqd/AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFrBbe9UuBszBggW1IeTSkoFLoEId1G342h3kpYhtjBcZwepj3wiGy/GZCfmU7b3S
         +dIBoDEZT0sgO48R3eWHrN79Pg7RMX5vGt5sctZMIoTPo4EI1DJasGwg/oOnlHISQ+
         Ewep9+DYxCdu0cYW5qE1EaidUBzSiqfwUcZtVoZpU7Y8Ql+9ttwKXFeYvphAzTLvG8
         bZKk5o1OSwXKS2ecxKzSzC2kv1ms/x1g82/L+naPIDCpjhcSWBZPX5sNUEUVYn48T8
         kQoUr/k3o7HPIW5qQipjt3RymhOF3b/VVDH1EzOTT4Y+sNHfQRx69P5J0GuQMBPQZ3
         DOPd9mN9UI6KQ==
Date:   Wed, 26 Jan 2022 16:47:19 +0200
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
Message-ID: <YfFe9+XDPDIdSqF1@iki.fi>
References: <CA++MVV3Jse4WZ-zr-SUWQz3Gk_dByU6JduVfUkvQNW+jgm9O4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA++MVV3Jse4WZ-zr-SUWQz3Gk_dByU6JduVfUkvQNW+jgm9O4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 18, 2022 at 01:26:05PM -0500, Martin Ross wrote:
> Hi Jarkko,
> 
> I have been working with Yael on this project so I thought I might add
> a bit of background here around the use case that this series of
> patches is trying to address.
> 
> At a high level we are trying to provide users of encryption that have
> key management hierarchies a better tradeoff between security and
> availability.  For available and performance reasons master keys often
> need to be released (or derived/wrapped keys created) outside of a KMS
> to clients (which may in turn further wrap those keys in a series of
> levels).  What we are trying to do is provide a mechanism where the
> wrapping/unwrapping of these keys is not dependent on a remote call at
> runtime.  e.g.  To unwrap a key if you are using AWS KMS or Google
> Service you need to make an RPC.  In practice to defend against
> availability or performance issues, designers end up building their
> own kms and effectively encrypting everything with a DEK.  The DEK
> encrypts same set as the master key thereby eliminating the security
> benefit of keeping the master key segregated in the first place.
> 
> We are building a mechanism to  create a security boundary in the
> kernel that allows these master keys to be stored in the kernel and
> used to wrap/unwrap keys via less trusted user processes.  The other
> goal here is to eliminate the complexity and statefulness required to
> do this today which would be to create a trusted daemon or process on
> the machine.  Concretely this means that since the user process will
> not have the master key the system designer has better options.  One
> obvious advantage is that any core dumps or code injection attacks
> won't be able to trivially grab the master key from the process or the
> linux keyring.  Once in the kernel this functionality can be
> transparently integrated into user space crypto libraries that have
> existing key management functionality.
> 
> Hope this helps and happy to answer any further questions!
> 
> M

Thank you.

It indeed does. I think it is a good explanation. Maybe the way to move
forward would be bring this context at leat a bit to the documentation
update?

/Jarkko

