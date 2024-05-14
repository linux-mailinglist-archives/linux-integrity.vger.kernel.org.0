Return-Path: <linux-integrity+bounces-2390-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942478C57BA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FB228557B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4E145335;
	Tue, 14 May 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="piHCb5b/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kziy3ax8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7601448FA;
	Tue, 14 May 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695879; cv=none; b=Eg4tmcb7wGy3uaj3ZSkVvlRD/RkLCcVUEBiiD+dIIbiMBonTAfzdntmyiMMFibKP0EZhPQ9y/mGojF8Y+sesrgQ/G1YJahPm7l1nfBJDH7JU9E1vdSfzoycmFp9gQh4E11jwrbadjuCOO42WOGjBqefmHqzduQZ8jbaz2iBS3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695879; c=relaxed/simple;
	bh=r2Nahr78aiF4tYkW2zYCQNncVvwBxFAGr+UJ6/ZGIpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CrpA+40uF/ymOTsa01lMp+3UgDPErTLJUeFFazpRyCMqJ8yutl20d/n5NfXcAm+WmUM20Sk3L2moSw2RPna0YdRKZHTn3h0bDwS1kTTp042JOCzqYLeAQsr3ESak2WP6JiAL2N0Rd/PqXuuq56MgZvMPeJ8luDTZLkNRpo7eBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=piHCb5b/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kziy3ax8; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715695876;
	bh=r2Nahr78aiF4tYkW2zYCQNncVvwBxFAGr+UJ6/ZGIpQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=piHCb5b/FbG2smVbhene+15kh7ccoAWtS0G1EBGOXMvkKz3H+P17VYYbce7LNU36R
	 Sfkh62GBisH1D/e1Nv1e1vm5lmzMJrYHFLlaRWHRGM4v0PBUVSJZ/6xLEC6wAIcgv3
	 69Yzt56BlomtSbofrZ0YqStcBc8iH2YwMVeyd9Tk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F3D361286A24;
	Tue, 14 May 2024 10:11:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id bzeQuPRiwXnQ; Tue, 14 May 2024 10:11:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715695875;
	bh=r2Nahr78aiF4tYkW2zYCQNncVvwBxFAGr+UJ6/ZGIpQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kziy3ax8L7uocRtXywqUBFk1VaQX82be3dHcg8Pj/W39cUuGMHZAUICRLO4GWdrbV
	 nQ9VrRis55hVDLdW502b9Pf/X5UAVNmGrRUIbVL8hXLFs3OXG5865se3L5XB6AqE8i
	 rW9AcgLO4o6Pt+zHhNfb6tzF0x/E+WFxNUJ5z69Y=
Received: from [172.21.4.27] (unknown [50.204.89.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BCCA31286A09;
	Tue, 14 May 2024 10:11:10 -0400 (EDT)
Message-ID: <b53f9fa263e65cd6b23677d9f7a385e5eb85cfdd.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Ben Boeckel <me@benboeckel.net>, 
 Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul
 Moore <paul@paul-moore.com>,  James Morris <jmorris@namei.org>,
 serge@hallyn.com, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Date: Tue, 14 May 2024 08:11:06 -0600
In-Reply-To: <CALrw=nFOh0=TXGx-z_oTkLWshVU_AfGRQzcC3zxVTzcRbuRqQQ@mail.gmail.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
	 <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org> <ZjY-UU8pROnwlTuH@farprobe>
	 <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>
	 <D10YYQKT9P1S.25CE053K7MQKI@kernel.org>
	 <CALrw=nFLa5=bPbYKijNsEo0Kk77_TEpdPmPe3CJ3VJqGNMmBeg@mail.gmail.com>
	 <44cd50b60a0a4e376d01544d25187556b8badf94.camel@HansenPartnership.com>
	 <CALrw=nFOh0=TXGx-z_oTkLWshVU_AfGRQzcC3zxVTzcRbuRqQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-14 at 10:50 +0100, Ignat Korchagin wrote:
> On Mon, May 13, 2024 at 11:33 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Mon, 2024-05-13 at 18:09 +0100, Ignat Korchagin wrote:
> > [...]
> > > TPM derived keys attempt to address the above use cases by
> > > allowing applications to deterministically derive unique
> > > cryptographic keys for their own purposes directly from the TPM
> > > seed in the owner hierarchy. The idea is that when an application
> > > requests a new key, instead of generating a random key and
> > > wrapping it with the TPM, the implementation generates a key via
> > > KDF(hierarchy seed, application specific info). Therefore, the
> > > resulting keys will always be cryptographically bound to the
> > > application itself and the device they were generated on.
> > 
> > So I think what confuses me is what the expected cryptographic
> > secrecy properties of the derived keys are.  I get they're a KDF of
> > seed and deterministic properties, but if those mixing values are
> > well known (as the path or binary checksum cases) then anyone with
> > access to the TPM can derive the key from user space because they
> > can easily obtain the mixing parameters and there's no protection
> > to the TPM keyed hash operation.
> > 
> > Consider the use case where two users are using derived keys on the
> > same system (so same TPM).  Assuming they use them to protect
> > sensitive information, what prevents user1 from simply deriving
> > user2's key and getting the information, or am I missing the point
> > of this?
> 
> You are correct: it is possible, but in practice it would be limited
> only to privileged users/applications. I remember there was a push to
> set a 666 mask for the TPM device file, but it is not how it is done
> today by default.

No, it's 660, but in consequence of that every user of the TPM is a
member of the tpm group which, since TPM use from userspace is growing,
is everyone, so it might as well have been 666.  In other words relying
on access restrictions to the TPM itself is largely useless.

>  Also I think the same applies to trusted keys as well, at least
> without any additional authorizations or PCR restrictions on the blob
> (I remember I could manually unwrap a trusted key blob in userspace
> as root).

Well, that's correct, but a TPM key file without policy still has two
protections: the file itself (so the key owner can choose what
permissions and where it is) and the key authority (or password)
although for the mechanical (unsupervised insertion) use case keys tend
not to have an authority.

> It would be fixed if we could limit access to some TPM ops only from
> the kernel, but I remember from one of your presentations that it is
> generally a hard problem and that some solution was in the works (was
> it based on limiting access to a resettable PCR?). I'm happy to
> consider adopting it here as well somehow.

Well, that was based on constructing a policy that meant only the
kernel could access the data (so it requires PCR policy).

In addition to the expected secrecy property question which I don't
think is fully answered I did think of another issue: what if the
application needs to rotate keys because of a suspected compromise? 
For sealed keys, we just generate a new one an use that in place of the
old, but for your derived keys we'd have to change one of the mixing
values, which all look to be based on fairly permanent properties of
the system.

James


