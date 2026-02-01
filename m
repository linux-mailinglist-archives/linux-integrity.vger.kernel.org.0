Return-Path: <linux-integrity+bounces-8400-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAwiMbjTf2mjyAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8400-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 23:29:12 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93AC7649
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E82C30056C5
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3282C08D1;
	Sun,  1 Feb 2026 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGPdnvNo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960F226CF7;
	Sun,  1 Feb 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984948; cv=none; b=RMnNrwDPNFYxbK8z1iOvwlj+xeJZuoQGr9jSM9scWpdFqltI1i2I8vErjflWd8h9DGQtfSOaPjv6mEiGcuaOBULhHrLW3GnrZSdC1pq7eatYDNWI2VN0EmW9cQJQHV4kiVWsI52vc/xLp/SAiL5JOx+Qt4LMufQ9iFPgf3L6WFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984948; c=relaxed/simple;
	bh=DxXTUd2sVNIlf9nm0i+s4NtR8Hl+nkM+Cwtr/R7+iTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+TlyND6ByQ0dVID27E1QCjziAfv7KMWcOHbj7DPjn2SGV6c86NWZHec4edLjgh3odzg9jW+30SDEyXGrV4UD2e6m8DcdqvwYLI5rzcRs4+uPQGlQRnGoC1yyvzvPdGEKaa9WAx0jgfFzPOzpY9cJtydfbILuAj8y/WeACEKL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGPdnvNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730B0C4CEF7;
	Sun,  1 Feb 2026 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769984947;
	bh=DxXTUd2sVNIlf9nm0i+s4NtR8Hl+nkM+Cwtr/R7+iTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGPdnvNokhVj+bbB6U2HTakzEQs77Eyc+70jNzgOcQSCdfQqtZVP2S13HH2JdSqvI
	 iiJ1Y0MHxXi9fkxF1/sxXDH8OFXKQ9hIgGY+/T+AzAg2cSqD9g/Id231r+pE3GgolW
	 oFBdb8DbL7XwUR5wpCundArK6kJ7sPkYNHhLvCrN9Bktw2ilWGCCe2gnbrDF4ioVGW
	 7jjGdJgaanmc7+qN7t20BJs9TMTFY57dFq9FqN39kf6UAZsUc6xJRMxJXvFBr3IbQa
	 kUO+0nawWrDdPzjg9Qu+zn49Bvg6iM5P9jbOOvi0vbHIFcZtM0xst3mPnDyM+KHCkY
	 dk1PHcxOZWEsg==
Date: Mon, 2 Feb 2026 00:29:04 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 6/6] docs: trusted-encryped: add PKWM as a new trust
 source
Message-ID: <aX_TsBNTMvvsM_bt@kernel.org>
References: <20260201135930.898721-1-ssrish@linux.ibm.com>
 <20260201135930.898721-7-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201135930.898721-7-ssrish@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,hansenpartnership.com];
	TAGGED_FROM(0.00)[bounces-8400-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A93AC7649
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 07:29:30PM +0530, Srish Srinivasan wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> Update Documentation/security/keys/trusted-encrypted.rst and Documentation/
> admin-guide/kernel-parameters.txt with PowerVM Key Wrapping Module (PKWM)
> as a new trust source
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

And you are free to take 5/6 and 6/6 to a pull request if you prefer
that route.

> ---
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  .../security/keys/trusted-encrypted.rst       | 50 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1058f2a6d6a8..aac15079b33d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7790,6 +7790,7 @@ Kernel parameters
>  			- "tee"
>  			- "caam"
>  			- "dcp"
> +			- "pkwm"
>  			If not specified then it defaults to iterating through
>  			the trust source list starting with TPM and assigns the
>  			first trust source as a backend which is initialized
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index eae6a36b1c9a..ddff7c7c2582 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -81,6 +81,14 @@ safe.
>           and the UNIQUE key. Default is to use the UNIQUE key, but selecting
>           the OTP key can be done via a module parameter (dcp_use_otp_key).
>  
> +     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
> +
> +         Rooted to a unique, per-LPAR key, which is derived from a system-wide,
> +         randomly generated LPAR root key. Both the per-LPAR keys and the LPAR
> +         root key are stored in hypervisor-owned secure memory at runtime,
> +         and the LPAR root key is additionally persisted in secure locations
> +         such as the processor SEEPROMs and encrypted NVRAM.
> +
>    *  Execution isolation
>  
>       (1) TPM
> @@ -102,6 +110,14 @@ safe.
>           environment. Only basic blob key encryption is executed there.
>           The actual key sealing/unsealing is done on main processor/kernel space.
>  
> +     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
> +
> +         Fixed set of cryptographic operations done on on-chip hardware
> +         cryptographic acceleration unit NX. Keys for wrapping and unwrapping
> +         are managed by PowerVM Platform KeyStore, which stores keys in an
> +         isolated in-memory copy in secure hypervisor memory, as well as in a
> +         persistent copy in hypervisor-encrypted NVRAM.
> +
>    * Optional binding to platform integrity state
>  
>       (1) TPM
> @@ -129,6 +145,11 @@ safe.
>           Relies on Secure/Trusted boot process (called HAB by vendor) for
>           platform integrity.
>  
> +     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
> +
> +         Relies on secure and trusted boot process of IBM Power systems for
> +         platform integrity.
> +
>    *  Interfaces and APIs
>  
>       (1) TPM
> @@ -149,6 +170,11 @@ safe.
>           Vendor-specific API that is implemented as part of the DCP crypto driver in
>           ``drivers/crypto/mxs-dcp.c``.
>  
> +     (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
> +
> +         Platform Keystore has well documented interfaces in PAPR document.
> +         Refer to ``Documentation/arch/powerpc/papr_hcalls.rst``
> +
>    *  Threat model
>  
>       The strength and appropriateness of a particular trust source for a given
> @@ -191,6 +217,10 @@ selected trust source:
>       a dedicated hardware RNG that is independent from DCP which can be enabled
>       to back the kernel RNG.
>  
> +   * PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
> +
> +     The normal kernel random number generator is used to generate keys.
> +
>  Users may override this by specifying ``trusted.rng=kernel`` on the kernel
>  command-line to override the used RNG with the kernel's random number pool.
>  
> @@ -321,6 +351,26 @@ Usage::
>  specific to this DCP key-blob implementation.  The key length for new keys is
>  always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>  
> +Trusted Keys usage: PKWM
> +------------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen [options]" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +    options:
> +       wrap_flags=   ascii hex value of security policy requirement
> +                       0x00: no secure boot requirement (default)
> +                       0x01: require secure boot to be in either audit or
> +                             enforced mode
> +                       0x02: require secure boot to be in enforced mode
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
> +specific to PKWM key-blob implementation.  The key length for new keys is
> +always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
>  
> -- 
> 2.47.3
> 

BR, Jarkko

