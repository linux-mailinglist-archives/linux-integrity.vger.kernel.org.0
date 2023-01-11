Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DEF665B68
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jan 2023 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAKMb4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Jan 2023 07:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjAKMbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jan 2023 07:31:55 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67AB861
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 04:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673440311;
        bh=K2SrTZ2r5dWIl2/ABLM2PArwStki+hm6aNQy+aQoyoo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=KIDQPE1PVPglCQ3oJHBmf534RQtQCSwN0pWYNbbI61vHO7poyGyXP3l2jJP890hyO
         5Ub1K3nnGPCHSdGRYIrNnKn9HZtQnrpNLjP11sKa5rbZwjc4dHR4dy1vSjDzYgVKyP
         XOFkseA5nul72UhZ0mveP1T6nUvk5kO5xIPqnkz8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3883E1286425;
        Wed, 11 Jan 2023 07:31:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rraNwYsXgwkx; Wed, 11 Jan 2023 07:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1673440310;
        bh=K2SrTZ2r5dWIl2/ABLM2PArwStki+hm6aNQy+aQoyoo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=TE215Hl+OAGOoRmSoco1E4xGAQCydcJx2DOKxHLq12PZGy2mrA7ZCDCwTkjpMcBs1
         0/3Mm7vEER1KkALII8Pi73ZkZIZ226tsYdu/iQtvIv1rhWdiXSgGYgSWsoFspZIysa
         Nrtd3CT3nzTG5x3dveSHLDPfCX90OhLmCeVVCyhg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 76CB01286409;
        Wed, 11 Jan 2023 07:31:50 -0500 (EST)
Message-ID: <119b5fbe23c8ded539b03cb19e5e9107c8189580.camel@HansenPartnership.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        William Roberts <bill.c.roberts@gmail.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
Date:   Wed, 11 Jan 2023 07:31:49 -0500
In-Reply-To: <CADg8p94cniETuUFYBw5tOYxBOSMwjYxYZ6Q-bp=WgYvH-e=U_g@mail.gmail.com>
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
         <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
         <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
         <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
         <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com>
         <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
         <a763fdc8e247e217b5efe860be4aebccb708b245.camel@HansenPartnership.com>
         <CAFftDdrnoc7zsxqLGuGDVK9fh1xh3E3dT2+9rKm7BPr114ZjFA@mail.gmail.com>
         <CADg8p94cniETuUFYBw5tOYxBOSMwjYxYZ6Q-bp=WgYvH-e=U_g@mail.gmail.com>
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

On Wed, 2023-01-11 at 17:49 +0530, Sughosh Ganu wrote:
> On Sat, 7 Jan 2023 at 04:43, William Roberts
> <bill.c.roberts@gmail.com> wrote:
[...]
> > tpm2_sessionconfig prints the raw handle for this purpose. I think
> > we added it when someone specifically needed the raw handle  to
> > pass to the kernel.
> 
> I tried getting the raw handle using the tpm2_sessionconfig command
> on the context file, and I did get the session handle. The session
> digest also matches the policy digest that was used at the time of
> the trusted key creation. However, when I pass the session handle
> value through the policyhandle parameter for the key loading
> operation, the unsealing fails.
> 
> I run the following commands for the key load operation.
> 
> # tpm2_startauthsession -S session.ctx --policy-session
> # tpm2_policypcr -S session.ctx -l sha256:10
> # tpm2_sessionconfig session.ctx  <--- Running this gives me the
> session handle.
> # keyctl add trusted kmk-trusted "load `cat kmk-trusted.blob`
> keyhandle=0x81000001 hash=sha256 policyhandle=0x03000000" @u
> 
> [  217.219048] tpm tpm0: A TPM error (2328) occurred unsealing

Error 2328 is TPM_RC_REFERENCE_S0 - the 1st authorization session
handle references a session that is not loaded

So it looks like the session is still context saved, pointing to an
error in the toolkit.


> [  217.222214] trusted_key: key_unseal failed (-1)
> add_key: Operation not permitted
> 
> After running these commands, I get the above error. I am able to get
> the key unsealing work with the tss commands from IBM that James had
> highlighted earlier.
> 
> -sughosh
> 
> > 
> > https://github.com/tpm2-software/tpm2-tools/blob/8cbc4bbaebc4fa135e35dabd6d9ab36ac05eb72b/tools/tpm2_sessionconfig.c#L66
> > 
> > Apologies for any HTML, I have no idea what Gmail on Android does,
> > I have no plaintext option. Yes there are other mail clients, and
> > yes I think they all suck :-p
> > 

The kernel lists discard email with html parts, which is why none of
the rest of us saw this except that there was a reply.

James

