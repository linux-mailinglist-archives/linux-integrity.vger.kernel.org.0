Return-Path: <linux-integrity+bounces-1951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBA8942BC
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16381F267A8
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3670433DA;
	Mon,  1 Apr 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="s2MQWiGd";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="s2MQWiGd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD7BA3F;
	Mon,  1 Apr 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990538; cv=none; b=FloOn+6IGpJnDFD1y4MLa0xginzbg8hKynqbZQavvDty02qWA+jQZmHj2vCse9YQ0IpPzU/CbHc+COJW00VGx7uuFHwM4Iip7ZTbEf+chCDIA+NHoyXaGSw7zSP0XstaW/AALCl1OZg/9alRfFWLlspeEEs4ui7VeeqVNE6lAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990538; c=relaxed/simple;
	bh=nC5bQepZL/kfPhWTLVF3NNhuEiA/OQAhaVN9Ci6p5iA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mvxFwRv0hwovmXQB9zweEbx+uH9P6MZgPv3Q0vBHiX9ov8Ej/CuzHAyy1DxJR2Yegnyx4oStUZVOfjuMKT8iz+aI+I/bTpgD0apOHmVZtoDbxqF93Jm5lIZOoGLmK6e0X7TCq7x0sxiR9SETrVUF4ovx+PwmqaYufGzpmoITQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=s2MQWiGd; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=s2MQWiGd; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711990536;
	bh=nC5bQepZL/kfPhWTLVF3NNhuEiA/OQAhaVN9Ci6p5iA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=s2MQWiGddjmprxg4UpxGMFqImd9uo+c2s9viMu0WUWq4Jc0ZlijzdC/aP/bsw0rL4
	 3aLh4iVMraX/sFtkcs3W3nrVAMGRuxlIgZbTZhfvMdaDJo15o9Kz+XpBFpKqUT9tgi
	 i+DRNsHLM2Xpn1QTw45HsCpdgkRM2Fz7HYhi8KLE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5FF111285D9D;
	Mon,  1 Apr 2024 12:55:36 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FVigLAtsKj-v; Mon,  1 Apr 2024 12:55:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711990536;
	bh=nC5bQepZL/kfPhWTLVF3NNhuEiA/OQAhaVN9Ci6p5iA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=s2MQWiGddjmprxg4UpxGMFqImd9uo+c2s9viMu0WUWq4Jc0ZlijzdC/aP/bsw0rL4
	 3aLh4iVMraX/sFtkcs3W3nrVAMGRuxlIgZbTZhfvMdaDJo15o9Kz+XpBFpKqUT9tgi
	 i+DRNsHLM2Xpn1QTw45HsCpdgkRM2Fz7HYhi8KLE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 935BB12819FC;
	Mon,  1 Apr 2024 12:55:35 -0400 (EDT)
Message-ID: <b60d9761e6afdb483c35949eb4184330f42b9dcc.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: =?ISO-8859-1?Q?Gabr=EDel_Arth=FAr_?= =?ISO-8859-1?Q?P=E9tursson?=
	 <gabriel@system.is>, linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, Ard
	Biesheuvel <ardb@kernel.org>
Date: Mon, 01 Apr 2024 12:55:33 -0400
In-Reply-To: <ad409aa8834c37d7bfe2666e03520dd777afd288.camel@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
	 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
	 <ad409aa8834c37d7bfe2666e03520dd777afd288.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-04-01 at 10:19 -0400, James Bottomley wrote:
> So I'm not really sure how to solve this.  At the moment the kernel
> doesn't use permanent handles for keys, but it should and it should
> follow what all of the industry is doing for interoperability (i.e.
> zero size points), which means the NULL primary should also follow
> it.

Actually, it turns out this is already solved by the TCG.  The template
we're using is the correct one (zero size points).  Apparently they
regretted their earlier decision to zero fill and issued this guidance:

   2.2.1.2.2 EK Template
   
   An EK Template is stored in an NV Index as a TPMT_PUBLIC structure
   marshaled as described in the TPM 2.0 Library Specification [1]. The
   default EK Templates are defined in annex B. The EK Template NV Index
   MUST be Populated if non-default values are used. It SHOULD be Absent
   if default values are used.
   
   The EK Template unique field buffer size(s) SHOULD be zero.
   
But since they can't revoke the previous guidance, we now have two
templates defined: the L one which has the old n bytes of zeros and the
new (and recommended) H one which has zero size unique field.

https://trustedcomputinggroup.org/resource/http-trustedcomputinggroup-org-wp-content-uploads-tcg-ek-credential-profile-v-2-5-r2_published-pdf/

So in other words, we're doing the later correct thing and there's no
problem.  I'll update the ASN.1 draft

https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html

to state that we MUST use the H template to remove any ambiguity

James


