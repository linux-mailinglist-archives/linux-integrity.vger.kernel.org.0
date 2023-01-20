Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8E675E3C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jan 2023 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjATTnU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 14:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTnT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 14:43:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4A5866C;
        Fri, 20 Jan 2023 11:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 357ED62060;
        Fri, 20 Jan 2023 19:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A22C433EF;
        Fri, 20 Jan 2023 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674243797;
        bh=azOg0MIqYgKZS8GLqeUG5CB0Bpkb5f04dnPdSV/ttvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJs5IIjiYFj4SGVJPv2J6v/Ih37u+/uQw4RC/a0I0rzUz5tHk1RwstedXglHB5mcq
         P/z6F0ielD3/03MV6vnDM5xeQjG/mhVTwyCwSVtLiQ052Zc7Eqd6NIRF55KbpMkt19
         r9VrSgIqRHdVLoTP0fRcPvd2bj4xgw9vqWvWsDrjHBhlfdLCytEA0BUzKVIoiqDz8u
         IYC+RJAfx2kbJQjfdErbudYKt9VUswCRCifRspnBhjpAwyKkmVSIBmjllQALPwirIJ
         fuTSMPABDmcde5kZJB2WsOXzydFd8SZYL6DWoGoEDZ3ljL1iJYhdni9rMMCRReQwMm
         WneOTKnP9/J9Q==
Date:   Fri, 20 Jan 2023 11:43:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] public_key: Add a comment to public_key_signature struct
 definition
Message-ID: <Y8ru09KeMwwaU/IS@sol.localdomain>
References: <20221207105430.248613-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhRSLh9y7KBCOhpvK2cwPmhyMr2dudhjcsEZ-Qmovi86Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRSLh9y7KBCOhpvK2cwPmhyMr2dudhjcsEZ-Qmovi86Nw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 20, 2023 at 02:21:04PM -0500, Paul Moore wrote:
> On Wed, Dec 7, 2022 at 5:55 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > public_key_verify_signature() calls sg_set_buf() to set the signature and
> > digest for the signature verification.
> >
> > As sg_set_buf() requires the buffer to be in physically contiguous memory,
> > see commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in
> > linear mapping"), mention that in a comment for the signature and digest
> > fields of the public_key_signature structure.
> >
> > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  include/crypto/public_key.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This seems especially important considering the BUG_ON that could be triggered.
> 
> David, are you going to pick this up?
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> > diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> > index 68f7aa2a7e55..6d623e063034 100644
> > --- a/include/crypto/public_key.h
> > +++ b/include/crypto/public_key.h
> > @@ -37,8 +37,8 @@ extern void public_key_free(struct public_key *key);
> >   */
> >  struct public_key_signature {
> >         struct asymmetric_key_id *auth_ids[3];
> > -       u8 *s;                  /* Signature */
> > -       u8 *digest;
> > +       u8 *s;                  /* Signature (in physically contiguous mem) */
> > +       u8 *digest;             /* Digest (in physically contiguous mem) */
> >         u32 s_size;             /* Number of bytes in signature */
> >         u32 digest_size;        /* Number of bytes in digest */
> >         const char *pkey_algo;
> > --
> > 2.25.1

This patch has been superseded by
"KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()"
(https://lore.kernel.org/r/20221227142740.2807136-1-roberto.sassu@huaweicloud.com).

- Eric
