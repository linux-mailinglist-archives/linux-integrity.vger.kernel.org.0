Return-Path: <linux-integrity+bounces-381-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A49809671
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Dec 2023 00:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2206D28227B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Dec 2023 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D66481CD;
	Thu,  7 Dec 2023 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sfQlU7fR";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sfQlU7fR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1901712;
	Thu,  7 Dec 2023 15:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701990584;
	bh=KwrMq1zMkBIFmnhDzQZkZwok6AmAwj7GIyZcFY+4+NU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=sfQlU7fRE6BfbsNMaMf63xTzhM8sOqXK9tivgUsI/qc7A3ai6M0GBDyUuSyN02/7N
	 g8uEDsWYWq+ZgFfG2kuTP2fFmpjUWDb3fs0YnFZ28hxAU4xZNJnh1D3UcOhz9mUj/9
	 mWRbaFLYfLAriE3z3i6GVgfqG8owfmSwQCYGFM0s=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C5250128014F;
	Thu,  7 Dec 2023 18:09:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fhuTcLSG1pLQ; Thu,  7 Dec 2023 18:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701990584;
	bh=KwrMq1zMkBIFmnhDzQZkZwok6AmAwj7GIyZcFY+4+NU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=sfQlU7fRE6BfbsNMaMf63xTzhM8sOqXK9tivgUsI/qc7A3ai6M0GBDyUuSyN02/7N
	 g8uEDsWYWq+ZgFfG2kuTP2fFmpjUWDb3fs0YnFZ28hxAU4xZNJnh1D3UcOhz9mUj/9
	 mWRbaFLYfLAriE3z3i6GVgfqG8owfmSwQCYGFM0s=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1251C1280087;
	Thu,  7 Dec 2023 18:09:43 -0500 (EST)
Message-ID: <f63ce1f09f7fe2b4ca421ff72d6553c5f7d354fc.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 12/17] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 07 Dec 2023 18:09:41 -0500
In-Reply-To: <CXHTVYW17UB6.MR6RH0TMDIX3@suppilovahvero>
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
	 <20231127190854.13310-13-James.Bottomley@HansenPartnership.com>
	 <CXHTVYW17UB6.MR6RH0TMDIX3@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2023-12-07 at 06:52 +0200, Jarkko Sakkinen wrote:
> On Mon Nov 27, 2023 at 9:08 PM EET, James Bottomley wrote:
> > Add session based HMAC authentication plus parameter decryption and
> > response encryption using AES. The basic design is to segregate all
> > the nasty crypto, hash and hmac code into tpm2-sessions.c and
> > export a usable API.  The API first of all starts off by gaining a
> > session with
> > 
> > tpm2_start_auth_session()
> > 
> > which initiates a session with the TPM and allocates an opaque
> > tpm2_auth structure to handle the session parameters.  The design
> > is that session use will be single threaded from start to finish
> > under the ops lock, so the tpm2_auth structure is stored in struct
> > tpm2_chip. Then the use is simply:
> > 
> > * tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
> >   handles
> > 
> > * tpm_buf_append_hmac_session() where tpm2_append_auth() would go
> > 
> > * tpm_buf_fill_hmac_session() called after the entire command
> > buffer
> >   is finished but before tpm_transmit_cmd() is called which
> > computes
> >   the correct HMAC and places it in the command at the correct
> >   location.
> 
> Split each exported function into a separate patches. This too big
> chunk of diff to be reviawable, i.e. it is impossible to give 
> reviewed-by in this form. I think I've commented this also throughout
> the series, and it has not been changed.

Um, you mean you mentioned it once and I explained that the API is
unitary so logically it does belong in one patch and you didn't mention
it again?

> There needs to be a patch per each exported API function so that they
> can be looked into detail. This patch does not align with submission
> guidelines in the form it is either.

There's no length limit on patch sizes, just the recommendation to keep
the changes logical.  One patch per API is actually illogical and
contrary to the guide because the APIs come in sets, so you'd miss the
logical reviewability with that split.  I suppose what I could do is
split it into three logically complete API sets: 1) primary creation;
2) session start/end 3) rest of the session HMAC helpers.  That would
give three patches of 400-600 lines each.

James


