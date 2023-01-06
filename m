Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6447660A13
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Jan 2023 00:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjAFXHo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 18:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjAFXHX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 18:07:23 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E1848C7
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 15:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673046441;
        bh=mIthU9c3zj9xl1liW+MF7UkCZEp01AqlKuinZGELToI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YuxoapSarkUPh7xMQhLppAAYsaZIglqruRpjHmLFGhsAQlVfGvpiSU9NtU5Z5rgmD
         FTQfiLA8D4gWxGdo9HZ4GGVPdHVFA2l/ouGVNfAyrTZPKVhJBvDGV8hwgdbBjxjgsq
         DwJvub/ArfB8XPx//363iQl4JEPMrfHChvnFS+NU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 65BE81285D21;
        Fri,  6 Jan 2023 18:07:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7b1_sigD9UK; Fri,  6 Jan 2023 18:07:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673046441;
        bh=mIthU9c3zj9xl1liW+MF7UkCZEp01AqlKuinZGELToI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=YuxoapSarkUPh7xMQhLppAAYsaZIglqruRpjHmLFGhsAQlVfGvpiSU9NtU5Z5rgmD
         FTQfiLA8D4gWxGdo9HZ4GGVPdHVFA2l/ouGVNfAyrTZPKVhJBvDGV8hwgdbBjxjgsq
         DwJvub/ArfB8XPx//363iQl4JEPMrfHChvnFS+NU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BF65F12819F6;
        Fri,  6 Jan 2023 18:07:20 -0500 (EST)
Message-ID: <a763fdc8e247e217b5efe860be4aebccb708b245.camel@HansenPartnership.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     William Roberts <bill.c.roberts@gmail.com>,
        Ken Goldman <kgold@linux.ibm.com>
Cc:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        linux-integrity@vger.kernel.org
Date:   Fri, 06 Jan 2023 18:07:18 -0500
In-Reply-To: <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
         <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
         <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
         <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
         <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
         <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-01-06 at 16:23 -0600, William Roberts wrote:
> On Fri, Jan 6, 2023, 15:55 Ken Goldman <kgold@linux.ibm.com> wrote:
> > 
> > On 12/28/2022 5:48 PM, James Bottomley wrote:
> > > The main thing you have to do is connect to the TPM not through
> > > the
> > > resource manager so the policy session survives multiple commands
> > > 
> > > export TPM_DEVICE=/dev/tpm0
> > 
> > Just FYI, as James says, command line utilities interact with the
> > resource manager.  When I want to run command line programs through
> > the
> > resource manager, I use a proxy to keep the /dev/tpmrm0 session
> > connected.
> > 
> > https://github.com/kgoldman/ibmtss/blob/master/utils/tpmproxy.c hol
> > ds an
> > open source proxy.
> > 
> 
> If you need to do this in production that tpmproxy allows anyone to
> connect to it. So while it's open it would circumvent the permissions
> on /dev/tpmrm0. You can just use tpm2-tools, which uses contexts and
> avoids this problem.

The specific issue with this is that using contexts, no-one could
figure out a way to pass the session into the kernel:

https://lore.kernel.org/linux-integrity/CADg8p94kTNkoByjLhEij3KkigLxhwU8PxnO82cRaO0Ejh7T3Zg@mail.gmail.com/

How should this be done?

James


