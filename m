Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35A3621C7
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Apr 2021 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbhDPOJm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Apr 2021 10:09:42 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39982 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244335AbhDPOI7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Apr 2021 10:08:59 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 302AA64A; Fri, 16 Apr 2021 09:08:26 -0500 (CDT)
Date:   Fri, 16 Apr 2021 09:08:26 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: fix a couple error pointer dereferences
Message-ID: <20210416140826.GA21299@mail.hallyn.com>
References: <YHaG+p5nlOXQFp1n@mwanda>
 <20210414140734.GB11180@mail.hallyn.com>
 <CAFA6WYOfy0mtM071GoSjeARRNWJ7ozJdZNsNa4v0ba=TxFnE8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOfy0mtM071GoSjeARRNWJ7ozJdZNsNa4v0ba=TxFnE8g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 16, 2021 at 06:15:58PM +0530, Sumit Garg wrote:
> Hi Serge,
> 
> On Wed, 14 Apr 2021 at 19:37, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, Apr 14, 2021 at 09:08:58AM +0300, Dan Carpenter wrote:
> > > If registering "reg_shm_out" fails, then it is an error pointer and the
> > > error handling will call tee_shm_free(reg_shm_out) which leads to an
> > > error pointer dereference and an Oops.
> > >
> > > I've re-arranged it so we only free things that have been allocated
> > > successfully.
> > >
> > > Fixes: 6dd95e650c8a ("KEYS: trusted: Introduce TEE based Trusted Keys")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  security/keys/trusted-keys/trusted_tee.c | 24 ++++++++++--------------
> > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > > index 2ce66c199e1d..45f96f6ed673 100644
> > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > @@ -65,7 +65,7 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> > >       int ret;
> > >       struct tee_ioctl_invoke_arg inv_arg;
> > >       struct tee_param param[4];
> > > -     struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> > > +     struct tee_shm *reg_shm_in, *reg_shm_out;
> >
> > I don't have this file (trusted_tee.c) in my tree and there's no lore
> > link here to previous what threads this depends on.  Based on the
> > context I can't verify that reg_shm_in will always be initialized
> > before you get to the free_shm_in label.
> >
> 
> You can find trusted_tee.c here [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/tree/security/keys/trusted-keys/trusted_tee.c

Thanks.  Looks good then :)
