Return-Path: <linux-integrity+bounces-8658-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNGeGuqjoGk9lQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8658-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 20:50:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F461AEAD6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82756307722A
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFE44CADF;
	Thu, 26 Feb 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvx7lbcq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56531436379;
	Thu, 26 Feb 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135098; cv=none; b=t//2425Qu6qHtgUw+6jZs2kPjDUJKISYiunzqcDFEBnwRSS0vSIx46inrTabgWsfPI4rjgTHIr/5uHPT7gMXt+fLQbHZY5AZ3o/EELrPazA8d6byxKI10tIlDenuiBPgvgZLXCBJzJykAKSXVwiBnJQZgocx2LxqQMpnd8mdLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135098; c=relaxed/simple;
	bh=UG450D5WGyfY+2w/1tUOfXSUM7WzFWBCfyTF4YNVzAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqI3g7uvHaV0JSfQSMctSiai89jbj9GNsCbNxb6IX1Vkjp9BSukuxJtKX50m79g1EZU+P8WWQLvR266ZOhsTbAXp3xp7taERFK5IRRK2l5QzARvAXsg6dDhgaLOXhOuFMya+aYyeAzPYS0xceFTQYs0tVSGOHJAsClQREtMlReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvx7lbcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B3C116C6;
	Thu, 26 Feb 2026 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772135098;
	bh=UG450D5WGyfY+2w/1tUOfXSUM7WzFWBCfyTF4YNVzAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvx7lbcqikj8cTH0HVZQfyrj9ZdK4BZRa2DoB5hE/i2W5/aQz4LZ2kWOzqoYSGmNg
	 IEbnLf2bdj+ifUoxvq0OIInKqq3iyWi0JKfPqygbjlZKYwsz3++pu2Rd2NWRcMFggt
	 sHW30HimMCPptoRCGS2/RpIPCRpOzQAPS2N2F7EoMYTTL8Tph3/Mebnz0bp9BhCr2X
	 WCJc4QY9S3AchAKu/NIs+m4kzT51Up3jdNiaXohV3ypbXWU3RHMxzIN3NQupMl9pX8
	 9yE/2ibC1Bhj2N9WodnoSlIbBy/QOLmEvhbFF1ngVwN+tfAbAm9PnLUJLUPoS4JaA+
	 E3nkHem7j/rvA==
Date: Thu, 26 Feb 2026 11:44:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Simo Sorce <simo@redhat.com>, Coiby Xu <coxu@redhat.com>,
	Johannes =?iso-8859-1?Q?Wiesb=F6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
	dhowells@redhat.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	roberto.sassu@huawei.com, zohar@linux.ibm.com,
	michael.weiss@aisec.fraunhofer.de
Subject: Re: IMA and PQC
Message-ID: <20260226194406.GG2251@sol>
References: <aYHznG6vbptVOjHQ@Rk>
 <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
 <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
 <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
 <20260226165819.GA2251@sol>
 <969c74f3-81ed-442c-87dd-381274a642a7@linux.ibm.com>
 <20260226183248.GE2251@sol>
 <13ebe763-dcaf-4379-b9a7-82d06fd0fdb3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ebe763-dcaf-4379-b9a7-82d06fd0fdb3@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8658-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13F461AEAD6
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:21:41PM -0500, Stefan Berger wrote:
> 
> 
> On 2/26/26 1:32 PM, Eric Biggers wrote:
> > On Thu, Feb 26, 2026 at 12:22:32PM -0500, Stefan Berger wrote:
> > > > I see that IMA indeed never upgraded full file hashes to use
> > > > 'struct ima_file_id'.  Building a new feature that relies on this seems
> > > > like a bad idea though, given that it's a security bug that makes the> IMA
> > > protocol cryptographically ambiguous.  I.e., it means that in IMA,
> > > > when the contents of some file are signed, that signature is sometimes
> > > > also valid for some other file contents which the signer didn't intend.
> > > 
> > > You mean IMA should not sign the digest in the ima_file_id structure but
> > > hash the ima_file_id structure in which this file digest is written into
> > > (that we currently sign) and sign/verify this digest? And we would do this
> > > to avoid two different files (with presumably different content) from having
> > > the same hashes leading to the same signature? Which hashes (besides the
> > > non-recommended ones) are so weak now that you must not merely sign a file's
> > > hash?
> > > 
> > > The problem with this is that older kernels (without patching) won't be able
> > > to handle newer signatures.
> > 
> > IMA needs to sign the entire ima_file_id structure, which is indeed what
> > IMA already does when it uses that structure.  (Well, actually it signs
> > a hash of the struct, but that's best thought of an implementation
> > detail of legacy signature algorithms that can only sign hashes.  For a
> > modern algorithm the whole struct should be passed instead.)  Just IMA
> > uses that structure only for fsverity hashes, which is a bug that makes
> > the IMA protocol ambiguous.  It needs to use ima_file_id consistently,
> > otherwise a signed message sometimes corresponds to multiple unique file
> > contents even without a break in the cryptographic hash function.
> 
> Before we jump into making changes on this old stuff I think it's good to
> understand the underlying problem and the likelyhood of signatures
> validating different data, such as a file and fsverity data. How likely is
> this?
> 
> Assuming a strong hash I suppose that is not a concern with RSA because here
> the digest is padded and then directly encrypted with the private key. Upon
> verification (pub key decrypt) we would unpad and memcmp the digests.
> 
> Again, assuming a strong hash: With ECDSA NIST P256 for example we have a 32
> byte signature. With a SHA512 being used for hashing for example we would be
> doing a projection of a 64byte hash space to a 32byte signature space with.
> Just by this projection of a much larger space into a smaller space
> signatures that validate multiple input data could be a problem. One 'easy'
> case where signatures for different input data is the same (not exactly the
> same due to nonce involved the signature is verifyable), albeit unlikely, is
> that there could be different input data for the SHA512 that lead to the
> same 32bytes prefix, which is then used after truncating the sha512 to the
> first 32 bytes for the ECDSA signature, and this then leads to a signature
> that is verifyable for different input data. So that's the 'simple' case at
> least for this thought experiment for a non-expert.
> 
> Now what should still be difficult to do is given a file and a hash-to-use
> that you can create fsverity content that leads to a hash that in turn leads
> to a NIST-P256 signature that can be used for signature verification(s) of
> the file and the totally different fsverity data. Is this a problem that is
> as difficult to solve just as finding different input data for a hash that
> leads to the same digest?

There's no differentiation between a 'struct ima_file_id' that
*represents* the contents of some file, and a file whose contents are
*equal to* that 'struct ima_file_id' and that uses a full-file hash.  In
both cases the same key and message are used for signing and verifying.

This means that every time a file is signed using the ima_file_id
scheme, it also implicitly signs some other file contents, which an
attacker can freely replace the file with.  Similarly, every time a file
that happens to be a valid ima_file_id is signed using the older scheme,
it also implicitly signs the contents that the ima_file_id correspond
to, which the attacker can freely replace the file with.  In either
case, no collision in the cryptographic hash function is required.

It's simply a broken protocol.  To fix this, IMA must only support
signatures that use the ima_file_id scheme.

Of course, that will require making them support full-file hashes and
not just fsverity hashes.  If I recall correctly, this was actually part
of the original design of the ima_file_id-based signatures.  It's
unclear why the implementation is still incomplete.

- Eric

