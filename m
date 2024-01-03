Return-Path: <linux-integrity+bounces-632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B182307E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B71F24827
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59871B271;
	Wed,  3 Jan 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gWCw3mQJ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Wz0rT/Tu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC81B263;
	Wed,  3 Jan 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704295537;
	bh=n0AJvSexgMYO3TgfVhhQyYYBCi5F61sWEo1LByDNED8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gWCw3mQJBJdX5QGT1+s9zEm7/MIFsoaXnwnmDLeZFh5xCtDAOTOhJZ66xQNqbRfnh
	 8MP/V6ySUCHEERGQX/lfsPH+djZ/CuYijPukIP/kX3VLWBoGKbeSnAr/THVGJsgRbl
	 7xBz5TK0AX7Uz+a8LpyL5CUVDytyPSa6b3LFnK0g=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2EEAD1286D2B;
	Wed,  3 Jan 2024 10:25:37 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6Yn3O-zwKl_n; Wed,  3 Jan 2024 10:25:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704295536;
	bh=n0AJvSexgMYO3TgfVhhQyYYBCi5F61sWEo1LByDNED8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Wz0rT/Tu9MXbjvNW0+lUOBvLXEkRx83xWdyqQpUlSBTeLlGZKACVkO7ySDR2Z40By
	 ZEdhmQwvpJjI31pQsb1Vb9Nzz8prpRmx91u2YyhnjG4u6QJICCE2YxX4LZkNfFAdry
	 rWZWkfDwgGviT57d55C719ekDZuYW6PKozct0SkQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 266E51286AD1;
	Wed,  3 Jan 2024 10:25:36 -0500 (EST)
Message-ID: <781fbe99d89ca573f9f6b77b29371bafa283d2b6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 12/20] tpm: Add NULL primary creation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 03 Jan 2024 10:25:34 -0500
In-Reply-To: <CY561MZ9UH2Z.3PMLA57T4GKD2@suppilovahvero>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
	 <20240102170408.21969-13-James.Bottomley@HansenPartnership.com>
	 <CY561MZ9UH2Z.3PMLA57T4GKD2@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-03 at 17:11 +0200, Jarkko Sakkinen wrote:
> > +       u8 ec_point_x[EC_PT_SZ];
> > +       u8 ec_point_y[EC_PT_SZ];
> 
> And also prefix these similarly with hmac.

This isn't in itself an HMAC; it's the public point of the P-256 key
derived from the null seed (effectively it's a public key).  It's used
to exchange secret information with the TPM, like a salt for the HMAC
sessions but it's a thing in its own right (and is bound to the null
name).  I suppose null_key_x/y is better.

James


