Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA79722164
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjFEItl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEItk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 04:49:40 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C785CD;
        Mon,  5 Jun 2023 01:49:39 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q65ti-00GsWv-Lb; Mon, 05 Jun 2023 16:49:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 05 Jun 2023 16:49:06 +0800
Date:   Mon, 5 Jun 2023 16:49:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
Message-ID: <ZH2hgrV6po9dkxi+@gondor.apana.org.au>
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
 <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
 <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 02, 2023 at 08:02:23PM -0400, Linus Torvalds wrote:
>
> I absolutely abhor the crypto interfaces. They all seem designed for
> that "external DMA engine" case that seems so horrendously pointless
> and slow.  In practice so few of them are that, and we have all those
> optimized routines for doing it all on the CPU - but have in the
> meantime wasted all that time and effort into copying everything,
> turning simple buffers into sg-bufs etc etc. The amount of indirection
> and "set this state in the state machine" is just nasty, and this
> seems to all be a prime example of it all. With some of it then
> randomly going through some kthread too.

You're right.  Originally SG lists were used as the majority of
our input came from network packets, in the form of skb's.  They
are easily translated into SG lists.  This is still somewhat the
case for parts of the Crypto API (e.g., skcipher and ahash).

However, for akcipher the only user of the underlying API is the
file in question so I absolutely agree that forcing it to go through
an SG list is just wrong.

I'll change the underlying akcipher interface to take pointers
instead and hide the SG list stuff (along with the copying) inside
API.

In the mean time feel free to take this patch as it appears to be
correct and should keep things chugging along while we work on the
API.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
