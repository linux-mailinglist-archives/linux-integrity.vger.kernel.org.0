Return-Path: <linux-integrity+bounces-261-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ED87FBCD0
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF66BB21889
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D435ABA2;
	Tue, 28 Nov 2023 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A417D1BE
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 06:34:55 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C89C41311; Tue, 28 Nov 2023 08:34:53 -0600 (CST)
Date: Tue, 28 Nov 2023 08:34:53 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [PATCH v5 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for sized
 buffers
Message-ID: <20231128143453.GA44257@mail.hallyn.com>
References: <20231121223130.30824-1-jarkko@kernel.org>
 <20231121223130.30824-9-jarkko@kernel.org>
 <20231128034802.GA33794@mail.hallyn.com>
 <2de19a94132c6277cd754bc10eaf5df6a57f4434.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2de19a94132c6277cd754bc10eaf5df6a57f4434.camel@linux.ibm.com>

On Tue, Nov 28, 2023 at 07:24:16AM -0500, James Bottomley wrote:
> On Mon, 2023-11-27 at 21:48 -0600, Serge E. Hallyn wrote:
> > On Wed, Nov 22, 2023 at 12:31:20AM +0200, Jarkko Sakkinen wrote:
> [...]
> > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> > > b/security/keys/trusted-keys/trusted_tpm2.c
> > > index bc700f85f80b..97b1dfca2dba 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > @@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> > >                       struct trusted_key_payload *payload,
> > >                       struct trusted_key_options *options)
> > >  {
> > > +       off_t offset = TPM_HEADER_SIZE;
> > > +       struct tpm_buf buf, sized;
> > >         int blob_len = 0;
> > > -       struct tpm_buf buf;
> > >         u32 hash;
> > >         u32 flags;
> > >         int i;
> > > @@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> > >                 return rc;
> > >         }
> > >  
> > > +       rc = tpm_buf_init_sized(&sized);
> > > +       if (rc) {
> > > +               tpm_buf_destroy(&buf);
> > 
> > It won't really hurt, but at the moment if tpm_buf_init_sized()
> > returns non-zero, then it must be returning -ENOMEM, and
> > tpm_buf_destroy(&buf) is not needed, right?
> 
> No ... buf was initialized further up in the original code (you seem to
> be confusing buf and sized ...

You're right, I was.  Thanks.

>  they're two separate allocations).  We
> can't return from here without destroying it otherwise we'll leak a
> page.
> 
> James

