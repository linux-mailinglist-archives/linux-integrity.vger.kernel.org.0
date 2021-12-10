Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFF4709CF
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhLJTLS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJTLS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:11:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B9C061746
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 11:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E81ACE2945
        for <linux-integrity@vger.kernel.org>; Fri, 10 Dec 2021 19:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40617C00446;
        Fri, 10 Dec 2021 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163259;
        bh=gC89+kJQhjwxkELJm48rMpESyqOZ6Uw8TvDUqc1Grco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrcfvR1Q8Rxq6qm5kLpzySZWzb6HNhFunXRxf1j5LE6K2nl+nr2dr5Ppdq85/JJSc
         IL/gj5KOVHiSd+UVfbb1unzJsErzze0/tspWudTzQCCllONH9TIHVcUiwKqAsCabPV
         yWY754yyMbO3EaJEPqIjLxrQFw7OMHLu5IjsQKVNCRDQWlr/ITHxpi9QqFhy0h470O
         FPqW67PGB2EriC7aXMmGXNDWsGPR1XJqkz+IhMjOQpV2kbbtL5tngvletkD9kgzpXE
         DELUvWkjq9fXmGw0pSDsghBfc631VIL+70obnv/dBWcvbFPMYYyYWawh3qF/XiZXl4
         PD2EnqH0q6XzA==
Date:   Fri, 10 Dec 2021 11:07:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] Instantiate key with user-provided decrypted data.
Message-ID: <YbOleSuhV6ME4/mk@sol.localdomain>
References: <20211210143531.1948911-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210143531.1948911-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 10, 2021 at 09:35:31AM -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. To support encryption of
> user-provided decrypted data, this patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data>.

What is the use case for this feature?

Also, please send this to all the relevant mailing lists and people.  Notably,
you didn't send this to the keyrings mailing list.  Try running
./scripts/get_maintainer.pl on the patch file.

Please also test patches before sending them.  This one doesn't even compile.

- Eric
