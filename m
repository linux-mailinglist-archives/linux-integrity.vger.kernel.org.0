Return-Path: <linux-integrity+bounces-5858-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14735A86CF0
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5104B19E7566
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F501AAA29;
	Sat, 12 Apr 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEYjPeMv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AF13AD1C;
	Sat, 12 Apr 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744461462; cv=none; b=MefrgieLCp/IVhdqTn+jRe2mWbRH6dmOzeDZbX+KvTrg2vg+BTd6UkBjhqfViYA4NOjVSUOVYG81l1fVCL8KLaXMimQSdEDsA2JzxhDBcxOGslyrObPG0vJm5c63ozwDqxnLJbnLYzsobmAMAh7GFEOhvrPC6MBBTQcj9wv5hYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744461462; c=relaxed/simple;
	bh=fOGXIw38PUOHJKV0F6WquPMgfDGZFeQX2oI1bRa1HC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXUIkc/HTXMvEgJ9Lht3wLPxu7f2P6Q5TbHdues5k7JMIEB5+OjOD/pvy5nMnfi8/KGVY6ZUt99v2ss3IbfFfcT9ypbuIpdAcYW+tyIuOSsxQg3f0+1W7o1vWf2EVkFRT0SQtouIq99LCR2aV/n04r6jbeJJ2/komnTe7Zdiauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEYjPeMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D845C4CEE3;
	Sat, 12 Apr 2025 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744461462;
	bh=fOGXIw38PUOHJKV0F6WquPMgfDGZFeQX2oI1bRa1HC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEYjPeMvBSt+rLN924k4lLe2NkHbwOKtkoDg4Erh7tNcIvqAM/C5e1rzkNwrpz6OG
	 ZTFYQuG1Tk8pj3OIEk+Y4X+SnUjbXDZ2GIM1rBqiahsnxH1m+v0cLgyEw/DUt78aTk
	 TTvCeSdhBY5LDkBV9X+NlL3MaVJ+vm7BCvqG3QMfVeeQuN2os44HAVT6mkU5CLhxCT
	 5CbmMQyLWjlWr6PPFWT7uKaTaZWlXm4D5d72UJyDPpryBzNRPpABimXU5qhQ4NGHUN
	 Js80Qi4F7C+xgsFC89YkUy96V3ORZW4AzHWSDgMRmgXBCTD6TAzwy3XHDlR3wDMcBV
	 Pw3QUhI2ZwWlg==
Date: Sat, 12 Apr 2025 15:37:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8] KEYS: Add a list for unreferenced keys
Message-ID: <Z_pekdyz0CI4qW93@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
 <2426186.1744387151@warthog.procyon.org.uk>
 <Z_l9f45aO3CqYng_@kernel.org>
 <Z_nCLHD33VR3un3O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_nCLHD33VR3un3O@kernel.org>

On Sat, Apr 12, 2025 at 04:30:24AM +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 11, 2025 at 11:37:25PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 11, 2025 at 04:59:11PM +0100, David Howells wrote:
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > > +	spin_lock_irqsave(&key_graveyard_lock, flags);
> > > > +	list_splice_init(&key_graveyard, &graveyard);
> > > > +	spin_unlock_irqrestore(&key_graveyard_lock, flags);
> > > 
> > > I would wrap this bit in a check to see if key_graveyard is empty so that we
> > > can avoid disabling irqs and taking the lock if the graveyard is empty.
> > 
> > Can do, and does make sense.
> > 
> > > 
> > > > +		if (!refcount_inc_not_zero(&key->usage)) {
> > > 
> > > Sorry, but eww.  You're going to wangle the refcount twice on every key on the
> > > system every time the gc does a pass.  Further, in some cases inc_not_zero is
> > > not the fastest op in the world.
> > 
> > One could alternatively "test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) &&
> > !refcount_inc_not_zero(&key->usage))" without mb() on either side and
> 
> Refactoring the changes to key_put() would be (draft):

I'll post a fresh patch set later :-) Deeply realized how this does not
make sense as it is. So yeah, it'll be a patch set.

One change that would IMHO make sense would be

diff --git a/security/keys/key.c b/security/keys/key.c
index 7198cd2ac3a3..aecbd624612d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -656,10 +656,12 @@ void key_put(struct key *key)
                                spin_lock_irqsave(&key->user->lock, flags);
                                key->user->qnkeys--;
                                key->user->qnbytes -= key->quotalen;
+                               set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
                                spin_unlock_irqrestore(&key->user->lock, flags);
+                       } else {
+                               set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
+                               smp_mb(); /* key->user before FINAL_PUT set. */
                        }
-                       smp_mb(); /* key->user before FINAL_PUT set. */
-                       set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
                        schedule_work(&key_gc_work);
                }
        }


I did not see anything obvious that would endanger anything and reduces
the number of smp_mb()'s. This is just on top of mainline ...

BR, Jarkko

