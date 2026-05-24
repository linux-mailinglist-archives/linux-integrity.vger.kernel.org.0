Return-Path: <linux-integrity+bounces-9654-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOhsIzKHE2rFCwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9654-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:18:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DC5C4BFD
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC733009149
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782F37B3F1;
	Sun, 24 May 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT0ORmQh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178202F8E81;
	Sun, 24 May 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664686; cv=none; b=M4KMtKI3g3BrPymYWYJDzVcI7F1tL2yZqbpLqVAg7pJRq+3yh5Bx0Q9NB6ZUKv/VEL2UnMqGPF78lkOeSOXt+Kjpp61vaKlZaMsKmnUwXkdXvNdTXwAjDGdQBX5zdX0m9r9IaFtY459PTRj/+ZdGbNykwL6NBT/V1Xu5uHST9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664686; c=relaxed/simple;
	bh=YJhg6GOqfyRedY5GFa5yafRycTGCF64EpHZC5q7jRUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLeNZxhzl+v7Qrgg+oTFn+xOk0n/XtGX3+wvD1zdNVpp25SehGnF41udTEayc5JgJ6dsj0n6WsskihijhzBi7TrGaC8+98WDHRWfKDYFseOyAU6ywOX6m2C6w0ehs13NHDdG+DHTdAZdiy1m/qHStPVPbxU+dh+uLMbWWHigOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT0ORmQh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 248DA1F000E9;
	Sun, 24 May 2026 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779664684;
	bh=1xKIl/BuAuJsq4s2VZpmIoNUIWA260ZKZNWVIohy8/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hT0ORmQhFD00JDG5rjED9RwJyvhDpVhAoSRhyuD7Zmgdox8/45CLciCiffcc8e5SA
	 zOoipZJe6mLbCUK1ABJj7/0VWlzt8BXeiIwjoNyq9lbSphGiaxUUr52b4r7+1KdceM
	 RYAhtBtNtyll1Ojd/7Rb1z6KT9aKvMU7bbWEENFlqd5rhe999C3CWC0jJSjPA2xb8R
	 myNOAJzuINvbtmXXNLNilOShBa5P+Fv5PU6Zg+gj/w+sqSPWq/UWL0FG/UibnGbazM
	 BDmkZf+uJwUHholZuiQBjhL/z5Fv2/6M7axWSjou9xV8X7LU9e6U/Jaa253wP1WEyd
	 /y9Y7m04vew3A==
Date: Mon, 25 May 2026 02:18:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]
Message-ID: <ahOHKJOllqX5dxym@kernel.org>
References: <20260524051519.3708075-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524051519.3708075-1-jarkko@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9654-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E97DC5C4BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 08:15:11AM +0300, Jarkko Sakkinen wrote:
> This series introduces key type for operating with asymmetric keys using
> a TPM2 chip.
> 
> Change Log
> ==========
> 
> v8:
> - Reset patch change logs given the overhaul of the code and patches.
> - Have only single new subkey type.
> - Make key type only use TPM operations.
> - Use TPM2_Sign for both ECC and RSA keys.
> - Align key descriptions with other key types.
> 
> Previous versions
> =================
> 
> * v7: https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/
> * v6: https://lore.kernel.org/linux-integrity/20240528035136.11464-1-jarkko@kernel.org/
> * v5: https://lore.kernel.org/linux-integrity/20240523212515.4875-1-jarkko@kernel.org/
> * v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
> * v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
> * v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
> * v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
> * Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
> 
> 
> Jarkko Sakkinen (3):
>   lib/asn1_encoder: Add asn1_encode_integer_bytes()
>   crypto: Migrate TPMKey ASN.1 objects from trusted-keys
>   keys: asymmetric: tpm2_asymmetric
> 
>  crypto/Kconfig                            |    7 +
>  crypto/Makefile                           |    6 +
>  crypto/asymmetric_keys/Kconfig            |   17 +
>  crypto/asymmetric_keys/Makefile           |    1 +
>  crypto/asymmetric_keys/tpm2_asymmetric.c  | 1096 +++++++++++++++++++++
>  crypto/tpm2_key.asn1                      |   11 +
>  crypto/tpm2_key.c                         |  150 +++
>  include/crypto/tpm2_key.h                 |   46 +
>  include/linux/asn1_encoder.h              |    3 +
>  include/linux/tpm.h                       |   10 +
>  lib/asn1_encoder.c                        |   62 ++
>  security/keys/trusted-keys/Kconfig        |    2 +-
>  security/keys/trusted-keys/Makefile       |    2 -
>  security/keys/trusted-keys/tpm2key.asn1   |   11 -
>  security/keys/trusted-keys/trusted_tpm2.c |  119 +--
>  15 files changed, 1421 insertions(+), 122 deletions(-)
>  create mode 100644 crypto/asymmetric_keys/tpm2_asymmetric.c
>  create mode 100644 crypto/tpm2_key.asn1
>  create mode 100644 crypto/tpm2_key.c
>  create mode 100644 include/crypto/tpm2_key.h
>  delete mode 100644 security/keys/trusted-keys/tpm2key.asn1
> 
> -- 
> 2.47.3
> 

Oops, I deleted the subject line, it was unintentional :-)

BR, Jarkko

