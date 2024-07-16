Return-Path: <linux-integrity+bounces-3144-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419E933204
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E817B1F24F71
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CB19E7F7;
	Tue, 16 Jul 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jYXhLk8H";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jYXhLk8H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9819DF73;
	Tue, 16 Jul 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158334; cv=none; b=AdJhQBeOObMetFRNDZUn204mAiRKX1lsO496XMNgevUwS+js2mrjCf7egf7FfXVN9TZNNRNYHCz2n5CHItzLD2h5ZSTB1BEoknsTqlQkoObS9L459cf9sPiCtpE6KMOZGSjARNVXFV4Ql8i2AsSv+ERpFvqGgvkAgCKLFi6xfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158334; c=relaxed/simple;
	bh=IvPKY2AKdeIjYesoTf4e3qGdCbngas8wRYH5EbuL9tQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFrYLEUAnVrOAI0p/nhMSNpNUjwxyV8fQMoPVyhWW0EWRbykRYqXDjBjRHAUR3vngW/fFZKJac6WwXHHmnWiZc6O8RrrYV7F9CLyRvswZw9ecB2HdLziBrR8hnfcYhLuvytnh5ucnlbgGlb6ZBrv6TF9bp01vdhKCPK7iXx7CAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jYXhLk8H; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jYXhLk8H; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721158329;
	bh=IvPKY2AKdeIjYesoTf4e3qGdCbngas8wRYH5EbuL9tQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=jYXhLk8HtxnkZuEJD+hT86S263hywt4t1j815ljKSl7sUImFHLgeA4qUNrvt1EGa+
	 6jTGTXOeewlpLMCCzv57WpsiCUR6R4Xdrs6JtgqPKfaorriCRNu1b1zGXkdMC6tjxf
	 /5Veorce13yb1FNM2aG6IoY6tMrgJ0PU5o9WEJOw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 495F91286849;
	Tue, 16 Jul 2024 15:32:09 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Xi3ExQViFz9s; Tue, 16 Jul 2024 15:32:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721158329;
	bh=IvPKY2AKdeIjYesoTf4e3qGdCbngas8wRYH5EbuL9tQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=jYXhLk8HtxnkZuEJD+hT86S263hywt4t1j815ljKSl7sUImFHLgeA4qUNrvt1EGa+
	 6jTGTXOeewlpLMCCzv57WpsiCUR6R4Xdrs6JtgqPKfaorriCRNu1b1zGXkdMC6tjxf
	 /5Veorce13yb1FNM2aG6IoY6tMrgJ0PU5o9WEJOw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2E16512867FA;
	Tue, 16 Jul 2024 15:32:08 -0400 (EDT)
Message-ID: <36ceafb1513fac502fdfce8fb330fc6e18db47ce.camel@HansenPartnership.com>
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells
	 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 16 Jul 2024 15:32:06 -0400
In-Reply-To: <20240716185225.873090-1-jarkko@kernel.org>
References: <20240716185225.873090-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-16 at 21:52 +0300, Jarkko Sakkinen wrote:
[...]
> Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-
> buf.c does manage its state. It is easy to grep that only piece of
> code that actually uses the field is tpm2-sessions.c.
> 
> Address the issues by moving the variable to struct tpm_chip.

That's really not a good idea, you should keep counts local to the
structures they're counting, not elsewhere.

tpm_buf->handles counts the number of handles present in the command
encoded in a particular tpm_buf.  Right at the moment we only ever
construct one tpm_buf per tpm (i.e. per tpm_chip) at any one time, so
you can get away with moving handles into tpm_chip.  If we ever
constructed more than one tpm_buf per chip, the handles count would
become corrupted.

James


