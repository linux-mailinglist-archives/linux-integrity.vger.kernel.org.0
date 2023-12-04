Return-Path: <linux-integrity+bounces-340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F78035CA
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66463281050
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC912575C;
	Mon,  4 Dec 2023 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GhipdyHj";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GhipdyHj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA92D8;
	Mon,  4 Dec 2023 06:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701698582;
	bh=2b//NLk8jXCbNhLsacwLmy/UWk0mqeE9FybjCAyaP9w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GhipdyHj9T7uyks7QxER6NkkUCaluqzw4wD73VSgWf/5+ZJCo6a8U0iiCygqJ5Mzi
	 ktw2mXdvNzDVhBZxVWc21eOPT8i86K8o52R45jMrjbOudnEG4RJPBJsr0aFYTqyBVt
	 TYcyfXWm8i8EfF7jGTMVD8mE7nje24J3CHWK40bg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8D4D01281733;
	Mon,  4 Dec 2023 09:03:02 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ohh-kBnQjBSD; Mon,  4 Dec 2023 09:03:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701698582;
	bh=2b//NLk8jXCbNhLsacwLmy/UWk0mqeE9FybjCAyaP9w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GhipdyHj9T7uyks7QxER6NkkUCaluqzw4wD73VSgWf/5+ZJCo6a8U0iiCygqJ5Mzi
	 ktw2mXdvNzDVhBZxVWc21eOPT8i86K8o52R45jMrjbOudnEG4RJPBJsr0aFYTqyBVt
	 TYcyfXWm8i8EfF7jGTMVD8mE7nje24J3CHWK40bg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C93E61281000;
	Mon,  4 Dec 2023 09:03:01 -0500 (EST)
Message-ID: <95222bc8dfe97bc85bcf0c022920bdce659d10fd.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 09:02:58 -0500
In-Reply-To: <113aa55fcdd8167e6cd87b88f0beeef743bc740e.camel@linux.ibm.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
	 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
	 <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
	 <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
	 <113aa55fcdd8167e6cd87b88f0beeef743bc740e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-12-04 at 08:59 -0500, Mimi Zohar wrote:
> On Mon, 2023-12-04 at 08:53 -0500, James Bottomley wrote:
> > On Mon, 2023-12-04 at 08:43 -0500, Mimi Zohar wrote:
[...]
> > > Is there a way of not degrading IMA performance without disabling
> > > HMAC encryption/decryption?
> > 
> > Well, perhaps we should measure it.  My operating assumption, since
> > extend is a simple hash, is that most of the latency of extend is
> > actually in the LPC (or i2c or whatever) bus round trip.  To do
> > HMAC, you have to have a session, which adds an extra command and
> > thus doubles the round trip.
> 
> Agreed getting some statistics would be beneficial.  Instead of
> creating a session for each IMA extend, would it be possible to
> estable a session once and re-use it?

Not really.  Sessions are fairly cheap to establish, so there's not
much work the TPM has to do, so context save/restore would still have
the same doubling of the bus round trip.  Keeping a session permanently
in the TPM would avoid the second round trip but be visible to all the
users and highly undesirable (would impact the number of sessions they
could create).

James


