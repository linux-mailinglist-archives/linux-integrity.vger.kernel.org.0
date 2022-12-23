Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D8654C6D
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Dec 2022 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLWGZp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Dec 2022 01:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWGZo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Dec 2022 01:25:44 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA04E5;
        Thu, 22 Dec 2022 22:25:41 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p8bUa-009jLe-9h; Fri, 23 Dec 2022 14:25:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Dec 2022 14:25:16 +0800
Date:   Fri, 23 Dec 2022 14:25:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [v2 PATCH] lib/mpi: Fix buffer overrun when SG is too long
Message-ID: <Y6VJzBcN3LvY5j60@gondor.apana.org.au>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
 <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
 <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
 <Y6IbWA5aZeBnn4n2@gmail.com>
 <Y6Kthn+rIUnCEJWz@gondor.apana.org.au>
 <Y6NySck5p/DXhSUJ@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6NySck5p/DXhSUJ@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 21, 2022 at 12:53:29PM -0800, Eric Biggers wrote:
>
> That's fine, I guess.  One quirk of the above approach is that if the last
> needed element of the scatterlist has a lot of extra pages, this will iterate
> through all those extra pages, processing 0 bytes from each.  It could just stop
> when done.  I suppose it's not worth worrying about that case, though.

Ideally this should be handled in the sg_miter interface, IOW,
it should allow us to cap the SG list at a certain number of bytes
as opposed to a certain number of entries.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
