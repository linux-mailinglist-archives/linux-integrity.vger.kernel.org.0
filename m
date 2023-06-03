Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE304721113
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Jun 2023 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjFCQCZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Jun 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQCW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Jun 2023 12:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FBECA;
        Sat,  3 Jun 2023 09:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE3860B55;
        Sat,  3 Jun 2023 16:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C41EC433D2;
        Sat,  3 Jun 2023 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685808140;
        bh=hbhcJ5+vvPHCu2gKyrTxiCQZ7fSTFNJM9grhrnn5tuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGnhST4IJztKxzCVRT90P4/F0w+b4KpmpzWT+8PmL3azyMo9KMAcM3qttHI/2JxyZ
         uWO6SIr3pVSl5fjgOssogoh6q/RYvyTkI7aTXeOPN6VnzOAHimQ2ZUNlCJ0G3E7BqA
         pQHUtEV9SqQb+fA+Fc+8+NTEaZzoVPlHFwgMHgvpUhDrD3gDTX9D4lxigkZMiwa8BO
         vntotnnwUDV3UAxJUAo6yipuuSU6HHbY97rXjt5+5CqrzFTsdIomunihWepHhe/GBx
         qynxR5Q4FVVPsvxStI1w31ZLlGH7KyySdkH95V4NQwhQakbx1S7ZkijGRy6Y0WlVxh
         XGtdCPnQfE10Q==
Date:   Sat, 3 Jun 2023 09:02:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
Message-ID: <20230603160208.GA677@quark.localdomain>
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
 <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
 <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
 <97fd9066-9afc-9faa-a604-46110ed1268c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97fd9066-9afc-9faa-a604-46110ed1268c@huaweicloud.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jun 03, 2023 at 12:41:00PM +0200, Roberto Sassu wrote:
> On 6/3/2023 2:02 AM, Linus Torvalds wrote:
> > On Fri, Jun 2, 2023 at 1:38 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > 
> > > The patch re-uses the allocation it already does for the key data, and
> > > it seems sane.
> > 
> > Ugh. I had to check that it was ok to re-use the key buffer, but it
> > does seem to be the case that you can just re-use the buffer after
> > you've done that crypto_akcipher_set_priv/pub_key() call, and the
> > crypto layer has to copy it into its own data structures.
> 
> Yes, we could not do it if the set_pub_key/set_priv_key methods use
> internally the passed pointer. I guess it depends on the methods, for RSA
> and ECDSA it seems fine (they copy to a different location).
> 
> The doubt comes because the buffer is freed after crypto_wait_req() and not
> after crypto_akcipher_set_*_key(), suggesting that it could be actually used
> during the crypto operation.
> 
> Rechecked the thread, and the suggestion to reuse the buffer and not append
> the signature and digest at the end was by Eric Biggers.
> 
> Eric, in light of this finding, should we still reuse the buffer?
> 

I don't think there was any "finding" here.  The setkey methods in the crypto
API aren't allowed to reuse the buffer they are passed, so the patch is fine.

- Eric
