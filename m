Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A27247D6
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjFFPe1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbjFFPeY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 11:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A510FB;
        Tue,  6 Jun 2023 08:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E9A62FFF;
        Tue,  6 Jun 2023 15:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96738C433EF;
        Tue,  6 Jun 2023 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065660;
        bh=FIBx38UvitOwB7dOa2hrmXarQRDdRvqYPxCX+aT0u0g=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=PR8lBP/9TFiRYT3wR3bALbpa+xhSUMdnDIvAfVFU9AvivYrZ7ealChxFaJ93oVJWk
         eKg7uifDugGiHW2eWSUpOe1nxSB5G+ghpleqz74bixZDfG1R7SD61dI2SQ6qz4vl6R
         tt8wmfTMaCd2sn5pxM98QfkXwxR7InOr0A+3FzFyPR21uZfWGs47XActwXn7zc1JYV
         bMAD5I1zrVXKkmzmUCwFNMTRzSdFdP3hUeRZuQYd7zpQU4LyLePRQfJlvf9Wy6WZ0t
         EH+5+S+mEPR3aUDswGj8WerHfPvQ81oj94DpN8CUwRbQHiuWyuY2rcAO+9kbzZsKyo
         adRg07I3MPqwg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 18:34:17 +0300
Message-Id: <CT5OE5VZA7D7.3B7C6CK27JIK1@suppilovahvero>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v4 06/13] tpm: add buffer function to point to returned
 parameters
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
 <d5c86f6f-6854-c649-d2a9-8090cc7d74cd@linux.ibm.com>
 <CSCLXUWIMPCG.D6K372YA1HMK@suppilovahvero>
 <be5c726340a32914d0f79b38b015c0a8ea4a7780.camel@HansenPartnership.com>
In-Reply-To: <be5c726340a32914d0f79b38b015c0a8ea4a7780.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 6, 2023 at 5:09 AM EEST, James Bottomley wrote:
> On Wed, 2023-05-03 at 14:31 +0300, Jarkko Sakkinen wrote:
> > On Tue May 2, 2023 at 5:09 PM EEST, Stefan Berger wrote:
> > >=20
> > >=20
> > > On 4/3/23 17:39, James Bottomley wrote:
> > > > Introducing encryption sessions changes where the return
> > > > parameters
> >=20
> > s/Introducing/Introduce/
> >=20
> > Commit messages should always be in the imperative form.
>
> "Introducing" in this sentence is a gerund (verb used as a noun); it
> can't be changed to an imperative because it's not being used as a
> direct verb in the sentence (that honour goes to "changes", which also
> can't be made imperative because the gerund is the subject).  I can
> reword it like this if you want the sentence to begin with an
> imperative (and get rid of the gerund before Linus bites my head off
> again for using obscure grammatical constructions):
>
> "Replace all instances of &buf.data[TPM_HEADER_SIZE] with a new
> function tpm_buf_parameters() because encryption sessions change
> where the return parameters are located in the buffer since if a
> return session is present they're 4 bytes beyond the header with those
> 4 bytes giving the parameter length.  If there is no return session,
> then they're in the usual place immediately after the header."

I'm planning to write a small (RFC) patch set just for the tpm_buf
portion because it is the part that does not work for me. What builds
on top of that looks decent, or will converge to decent.

I have some ideas that have building up in my head so I'll just dump
that as source code and see if that works for you (or not).

BR, Jarkko
