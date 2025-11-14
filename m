Return-Path: <linux-integrity+bounces-7626-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3DAC5C9CC
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Nov 2025 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33AB4342144
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Nov 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F302FBDE9;
	Fri, 14 Nov 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QaPy5p1e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36B30FC36
	for <linux-integrity@vger.kernel.org>; Fri, 14 Nov 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116258; cv=none; b=C0z0BFwkn/7CkL8j1jcNKBkMs8d3/oYRphTSpicMOe/n17XUnTkffsa4ZLZ44P6tguEbHZwVA58uW5bDXr6mivbyCuGZ1qCuVyGyAUWiGMNM0784mdTJ9RjD696Zz+BEVAyf7keNuhV/UA3GQt5ByrhBXvZt9vVQHdBLlaAKtDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116258; c=relaxed/simple;
	bh=wN3/8RgeZcaLwmHshZdOIoQfrJtLJQkqD+OboamYqfk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y445r2nZlzRvYvDt8RjbcOm+xzHjiWj/UHUGxI1dJPelGrNy5/IVnvcc3Kzv7I4gIz+p6y9ZnzCfcau02oUWtvGlVy5q5FDSep8ydfoXG+dwgKGDHKEEY4SKjMvpaFYjrwPnIEnK/lU43s1OqtQRFpBw837Sqd9EkyPJ7ix5PX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QaPy5p1e; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763116250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2qM6eDrcKqDXJMkFJ1xGKhxIyX3KERDuEZB9kx7Z/8=;
	b=QaPy5p1ej8Xeg/mO/iCLz7Sizp3OiTY2mvGzJ3e6YRghD7lBDmnIbrYQht8Q8/T5NPcgBJ
	8nkYkN1iatcMTB46IIcN+PcDS4MfI95juqw7Y6Uw2X203K0YPbeey4XHxncDuA82BLcba/
	gqYixPF2QxRQKZ+89J191m0wlrUe8K4=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] KEYS: encrypted: Replace deprecated strcpy and improve
 get_derived_key
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251114093445.0ec74428@pumpkin>
Date: Fri, 14 Nov 2025 11:30:15 +0100
Cc: Eric Biggers <ebiggers@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-hardening@vger.kernel.org,
 linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F9F1AD7-135E-43F4-9A46-BD5A60DA0921@linux.dev>
References: <20251113215546.136145-1-thorsten.blum@linux.dev>
 <20251114093445.0ec74428@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi David,

On 14. Nov 2025, at 10:34, David Laight wrote:
> On Thu, 13 Nov 2025 22:55:45 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>=20
>> strcpy() is deprecated; use the safer strscpy() and use its return
>> value, the number of bytes copied, instead of calling strlen() on the
>> destination buffer again. String truncation can be ignored since
>> 'derived_buf' is guaranteed to be large enough.
>>=20
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> [...]
>=20
> I'm not sure this is an improvement, but has this code ever been =
correct?
> The buffer passed to sha256 is either:
> 	"AUTH_KEY"'\0'master_key
> or
> 	"ENC_KEY"'\0'master_key
> For short master_key the buffer is HASH_SIZE bytes and padded with =
zeros (ok).
> However for long master_key the length is calculated using "AUTH_KEY" =
so
> there is an additional trailing '\0' in the "ENC_KEY" case.

I removed the trailing '\0' in v1, but since Eric pointed out that it
changes the sha256 hash, I reverted it in v2.

Thanks,
Thorsten


