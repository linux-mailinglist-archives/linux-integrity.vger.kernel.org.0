Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2A6FE6D9
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjEJWGt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJWGn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 18:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A0E5B;
        Wed, 10 May 2023 15:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4B0636BC;
        Wed, 10 May 2023 22:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E50C433D2;
        Wed, 10 May 2023 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683756401;
        bh=1bDzh6ersOGJxndFvMhrxZnGrOK+34QUS3Ly6iZ4gk4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=sYyVUBEPapnvu/0Xegq9d7+1bb7lPbJhI8bdEd4srxvx9w45LIAa0NdwhjGadgeJT
         1g9D/CmE/CAFuvp4rqI/GvPgMukEvMBAhEFmJkFAJZqWKW+Fzq7tyYs6xdsO0ENkeE
         W9zvGVpohwt8IfPK5tiSj1SDoZC6fWnYsuHki1kQftb+p48E3HainY5OGj+PHZGxBJ
         v7ONaJShZK+xrUywCftVp1g/Ky3kDwZM/LC/YC33lWdg0PhdjWzn1snsQujtB0pDUV
         theFABnmlOfi3zGQQexwodkBszjw2zD7qaBcw+t1e+k72qEYpO90E0dg1DgzpUL21f
         QimqqcmQDFDEA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:06:38 +0300
Message-Id: <CSIXTV2FQIYD.19JPFRH4D22Y1@suppilovahvero>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>
Subject: Re: [PATCH v2 0/2] Fix TPM 1.2 resume
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Vlastimil Babka" <vbabka@suse.cz>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230502011558.10743-1-jarkko@kernel.org>
 <6b03aaf5-2017-a0c9-9c84-c8ee2aa4ba0e@suse.cz>
In-Reply-To: <6b03aaf5-2017-a0c9-9c84-c8ee2aa4ba0e@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 2, 2023 at 10:37 AM EEST, Vlastimil Babka wrote:
> On 5/2/23 03:15, Jarkko Sakkinen wrote:
> > During TPM 1.2 resume, the first PCR read operation used inside
> > tpm1_do_selftest() fails. Fix the bugs preventing resume from working.
>
> Thanks for fixing this, unfortunately I can no longer test the fix as I'v=
e
> got a new laptop since when I was hitting the bug on the older one.

I don't think these fixed make things worse, and I could reproduce
the bug locally, so I'll put them to my PR :-)

BR, Jarkko
