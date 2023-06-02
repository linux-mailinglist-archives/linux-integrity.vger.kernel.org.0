Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8087202F7
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjFBNRp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbjFBNRn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 09:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48A1BF;
        Fri,  2 Jun 2023 06:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10A960AFA;
        Fri,  2 Jun 2023 13:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F4CC4339B;
        Fri,  2 Jun 2023 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685711848;
        bh=CInoerTKBnBUZSQxIaNEVQDeNoX7/i2ioK07Gv2O9gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCLCCxSae8cEwIUuHuhKNSkUsPjlnDWb0cyYQx35ffax02SumdK8NwlmvnfkoSHXN
         7YNRde62Edqw60Y3vx8CS2ZyXgVvJFtJTReCFzs7VbxdbvzrZwCrxLKdgKHJMGY19o
         +cwKwAKStcBa6qavpL0M6W0iRmmLJLBBZDVT+fom+ZuzO11YvgO5qMA+syRuqlpr0b
         BPW8IOT5PYh0D5YzAbJV+4mQzEvqr78AifVZQQk52g4M3SY0hf88jn/XXSJKXYS6am
         W2R1QDA99w+qftLtly7nwZOpSKC2+/qzb2sNR3vgynyazESBGsesxz2PV5DdlmKlaC
         Y7y6g+Ocz+BSg==
Date:   Fri, 2 Jun 2023 06:17:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in
 public_key_verify_signature()
Message-ID: <20230602131724.GA628@quark.localdomain>
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
 <20221227142740.2807136-3-roberto.sassu@huaweicloud.com>
 <fd161de5-61ce-94bf-96cf-65965115f981@linux.ibm.com>
 <62078920aa02c2912beeb33511fdf6636365e6c8.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62078920aa02c2912beeb33511fdf6636365e6c8.camel@huaweicloud.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 02, 2023 at 11:17:04AM +0200, Roberto Sassu wrote:
> On Thu, 2023-06-01 at 17:00 -0400, Stefan Berger wrote:
> > 
> > On 12/27/22 09:27, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > mapping") checks that both the signature and the digest reside in the
> > > linear mapping area.
> > > 
> > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > stack support") made it possible to move the stack in the vmalloc area,
> > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > adjacent pages.
> > > 
> > > Always make a copy of the signature and digest in the same buffer used to
> > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > buffer allocated with kmalloc() is in the linear mapping area.
> > > 
> > > Cc: stable@vger.kernel.org # 4.9.x
> > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > 
> > I just ran into an issue with OpenBMC on ARM where EVM ECDSA signature verification failed due to invalid hashes being passed to the ECDSA signature verification algorithm. This patch here resolved the issue.
> > 
> > Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.
> 
> I did multiple attempts to have the patch included, but I didn't have
> any luck with the maintainers (David, Jarkko).
> 
> It would be awesome if any maintainer picks it.
> 
> Thanks!
> 

As the maintainers are ignoring this patch, you could try the "maintainers of
last resort" (Andrew Morton or Linus Torvalds).

- Eric
