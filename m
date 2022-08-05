Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60D58A5B4
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Aug 2022 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiHEFnp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Aug 2022 01:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiHEFno (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Aug 2022 01:43:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E21F2FE;
        Thu,  4 Aug 2022 22:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A08E2B82415;
        Fri,  5 Aug 2022 05:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE069C433D6;
        Fri,  5 Aug 2022 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659678218;
        bh=1HJkSxaQIfror+WhaJCtN4BMtV9g8NfPqEcBfmtC67c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fhJWX3yWoFEY7nZzseb1CMVnAGJ7khb0OCTEuMfAdRosCE0Q/cVulAlC7b5lBGuS6
         t/K2NPVnEKZGFg+ogHETceyuFafOdcTIn2KR/g7qIl2GhHDoLmXaoDOHCpn+1x7uW5
         2EmpRAVHMT1bxF2HB9mfl7yvlE7JdW5L14KzE5QAzCA13YiNLFBS0kFtm2A3Yb9uGE
         wyYASRwu0UBgr/OkBp1qvRy8PVOEEmR4jMcDKEbvovI1hv/8Fg9BPfgkxRNMopkMlU
         KDV2XL4Hml34lPAApL/3HNNF1hDlaF8FU5DgdTh7v6uSkyOgNET3HVk+mqEjXTV+4r
         NkxJl8PLM2XWQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v5.20
References: <20220803210228.158993-1-jarkko@kernel.org>
        <87pmhgikhk.fsf@kernel.org>
        <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
Date:   Fri, 05 Aug 2022 08:43:30 +0300
In-Reply-To: <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
        (James Bottomley's message of "Thu, 04 Aug 2022 08:01:53 -0400")
Message-ID: <87czdfi6t9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2022-08-04 at 09:35 +0300, Kalle Valo wrote:
>> Jarkko Sakkinen <jarkko@kernel.org> writes:
> [...]
>> > M...rten Lindahl (1):
>> >       tpm: Add check for Failure mode for TPM2 modules
>>=20
>> Some encoding problems in the name? At least my Gnus didn't show them
>> correctly.
>
> My mail tool correctly renders the '=C3=A5' character, and lore has it to=
o:
>
> https://lore.kernel.org/all/20220803210228.158993-1-jarkko@kernel.org/
>
> So I think you have a local UTF-8 translation problem.

Odd, I haven't noticed any UTF-8 problems in my setup but Gnus/Emacs is
known to be picky. After some more investigation I noticed this in
Jarkko's email:

Content-Type: text/plain; charset=3Dy

I admit I'm not up to par with the latest cool stuff but that charset
can't be valid, right? :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
