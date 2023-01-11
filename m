Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA67665E32
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jan 2023 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjAKOmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Jan 2023 09:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjAKOmI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jan 2023 09:42:08 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E33BE18
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673448126;
        bh=eGSLvFjGUCKoU2BrpXI+AvuZZrdjpjWmB314kjGedzo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Gdq4rA+7KZC4rp9ZVjH6IMNAHc/oVd9KBeyvP3c+E5AdjkMrfxRbevlEWc4HRiCvI
         lyFGox5Ey+SbwIstWUBt8guaQLtTTqsKAejgwPjDA8ofT6Y3dAM4kvsNN/uy9pU4vT
         7ZU+4tn7ZvNTt+p1dVmxnSSwndcCflL7jSA7UVgs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 968EC1280D54;
        Wed, 11 Jan 2023 09:42:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lmWsRkvCZ8zf; Wed, 11 Jan 2023 09:42:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673448126;
        bh=eGSLvFjGUCKoU2BrpXI+AvuZZrdjpjWmB314kjGedzo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Gdq4rA+7KZC4rp9ZVjH6IMNAHc/oVd9KBeyvP3c+E5AdjkMrfxRbevlEWc4HRiCvI
         lyFGox5Ey+SbwIstWUBt8guaQLtTTqsKAejgwPjDA8ofT6Y3dAM4kvsNN/uy9pU4vT
         7ZU+4tn7ZvNTt+p1dVmxnSSwndcCflL7jSA7UVgs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EB60312804A6;
        Wed, 11 Jan 2023 09:42:05 -0500 (EST)
Message-ID: <9f1ddfbf6838e1fa29de3ebd8e447cddc88f875f.camel@HansenPartnership.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 11 Jan 2023 09:42:04 -0500
In-Reply-To: <CAFftDdpus-TyHg4iOHFH9Ph4bkD5rW8zUtjaXoc6SbvwS+6JgA@mail.gmail.com>
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
         <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
         <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
         <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
         <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
         <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
         <a763fdc8e247e217b5efe860be4aebccb708b245.camel@HansenPartnership.com>
         <CAFftDdrnoc7zsxqLGuGDVK9fh1xh3E3dT2+9rKm7BPr114ZjFA@mail.gmail.com>
         <CADg8p94cniETuUFYBw5tOYxBOSMwjYxYZ6Q-bp=WgYvH-e=U_g@mail.gmail.com>
         <119b5fbe23c8ded539b03cb19e5e9107c8189580.camel@HansenPartnership.com>
         <CAFftDdpus-TyHg4iOHFH9Ph4bkD5rW8zUtjaXoc6SbvwS+6JgA@mail.gmail.com>
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

On Wed, 2023-01-11 at 07:50 -0600, William Roberts wrote:
> On Wed, Jan 11, 2023 at 6:31 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Wed, 2023-01-11 at 17:49 +0530, Sughosh Ganu wrote:
[...]
> > 
> > > [  217.219048] tpm tpm0: A TPM error (2328) occurred unsealing
> > 
> > Error 2328 is TPM_RC_REFERENCE_S0 - the 1st authorization session
> > handle references a session that is not loaded
> > 
> > So it looks like the session is still context saved, pointing to an
> > error in the toolkit.
> > 
> 
> Yes, this jogged my memory that we talked about implementing this
> between Imran (The other main developer) and I. If we don't context
> save in the tool, both tpm2-abrmd and in-kernel will flush the
> handle.
> 
> I think the cleanest option would be to add a --wait-for-sighup
> option where the tool sleeps until sighup is delivered. For scripts,
> folks could just lunch it in the background, grab the handle output
> and then kill -s sighuhp %1 or whatever.

I don't think that would work: The in-kernel resource manager will
context save the session while the userspace program isn't using the
TPM (so that's while a TPM device read/write is active), so even if you
hold the process running or even the /dev/tpmrm0 fd open, the session
won't be in a state to pass into the kernel.  What you really have to
do to get this to work is to bypass the resource manager because you're
trying to share a session between two otherwise separately managed uses
of the TPM.

Using a session constructed elsewhere is a security problem anyway
because you can't share nonces, so the policy patches that stalled a
year or so ago fixed this by allowing the kernel itself to construct
the policy session, so you didn't have to pass in the handle:

https://lore.kernel.org/linux-integrity/20210521004401.4167-1-James.Bottomley@HansenPartnership.com/

James

