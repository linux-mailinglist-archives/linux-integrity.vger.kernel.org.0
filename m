Return-Path: <linux-integrity+bounces-2381-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B388C499F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 00:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353B71F226DB
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048E39FD6;
	Mon, 13 May 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QHc/v/Dd";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QHc/v/Dd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6B4F883;
	Mon, 13 May 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639625; cv=none; b=QjbwMaujx0Z8msN0frV7H+4S2UJ1vc0q7rXAyb0CJS4P+EM17vgISJMy/mUx/cBXR7p6s71URsu3MwtBPo1lHKHMh24OU7XvU80aRBJ25uL6fL7TNZuAA4dKvMH7qqIDDYbzkR38DeEr5o9cbJnUTfKiGQY2t2ts5geOCmITyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639625; c=relaxed/simple;
	bh=VCTPQ8CjvvoriPIr3qUhR8Tme9pCRlLe8w6LPLPTQXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=si/4xDCs924q8ecBruKhHzCaVK/rQK/XcvES9Ia+OUeSZdenJEegQALliVm/V+RaUobKBCwatelXBQ0SxyHmtmhLH14uWLIHzj91Kkljl0zpvtQPxMFqQTkkw1QBmnLUGk3TKHnL3Vu4ItunskWBZOgxWr8T785BIvJ31dlNxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QHc/v/Dd; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QHc/v/Dd; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715639622;
	bh=VCTPQ8CjvvoriPIr3qUhR8Tme9pCRlLe8w6LPLPTQXo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QHc/v/DdsDmJ2xXElFQP7TWQ+IsfpUeTJ1RtWB5BUu5tMwochUlZUVWw5ARQa72U6
	 mJx29a5MeI0nQr8rXU89ZlYbgWhG9ElFNKBEj23oOf4KHjQ/CMcbxXZUPpf/hCcNjT
	 kFW+oHVeg8oBIVTh24wPlxtu7ZwNojnZX4/e7kgk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6392612868FA;
	Mon, 13 May 2024 18:33:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id EGxPfShCTr4e; Mon, 13 May 2024 18:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715639622;
	bh=VCTPQ8CjvvoriPIr3qUhR8Tme9pCRlLe8w6LPLPTQXo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QHc/v/DdsDmJ2xXElFQP7TWQ+IsfpUeTJ1RtWB5BUu5tMwochUlZUVWw5ARQa72U6
	 mJx29a5MeI0nQr8rXU89ZlYbgWhG9ElFNKBEj23oOf4KHjQ/CMcbxXZUPpf/hCcNjT
	 kFW+oHVeg8oBIVTh24wPlxtu7ZwNojnZX4/e7kgk=
Received: from [172.21.4.27] (unknown [50.204.89.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9FDBD12868BA;
	Mon, 13 May 2024 18:33:41 -0400 (EDT)
Message-ID: <44cd50b60a0a4e376d01544d25187556b8badf94.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ignat Korchagin <ignat@cloudflare.com>, Jarkko Sakkinen
 <jarkko@kernel.org>,  Ben Boeckel <me@benboeckel.net>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Date: Mon, 13 May 2024 16:33:40 -0600
In-Reply-To: <CALrw=nFLa5=bPbYKijNsEo0Kk77_TEpdPmPe3CJ3VJqGNMmBeg@mail.gmail.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
	 <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org> <ZjY-UU8pROnwlTuH@farprobe>
	 <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>
	 <D10YYQKT9P1S.25CE053K7MQKI@kernel.org>
	 <CALrw=nFLa5=bPbYKijNsEo0Kk77_TEpdPmPe3CJ3VJqGNMmBeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-05-13 at 18:09 +0100, Ignat Korchagin wrote:
[...]
> TPM derived keys attempt to address the above use cases by allowing
> applications to deterministically derive unique cryptographic keys
> for their own purposes directly from the TPM seed in the owner
> hierarchy. The idea is that when an application requests a new key,
> instead of generating a random key and wrapping it with the TPM, the
> implementation generates a key via KDF(hierarchy seed, application
> specific info). Therefore, the resulting keys will always be
> cryptographically bound to the application itself and the device they
> were generated on.

So I think what confuses me is what the expected cryptographic secrecy
properties of the derived keys are.  I get they're a KDF of seed and
deterministic properties, but if those mixing values are well known (as
the path or binary checksum cases) then anyone with access to the TPM
can derive the key from user space because they can easily obtain the
mixing parameters and there's no protection to the TPM keyed hash
operation.

Consider the use case where two users are using derived keys on the
same system (so same TPM).  Assuming they use them to protect sensitive
information, what prevents user1 from simply deriving user2's key and
getting the information, or am I missing the point of this?

James


