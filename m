Return-Path: <linux-integrity+bounces-8641-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAT2OEeOoGkokwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8641-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 19:17:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 887EF1AD75B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27A9336B564
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6E3603EF;
	Thu, 26 Feb 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcFxLOPy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BC3603C4;
	Thu, 26 Feb 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125151; cv=none; b=bxvqR8/tIMiO6d27OHiLvWBqv1I+CJ/UFCRqrJjuZJ/PFAQi0RWVTSXcD3b0Ck7EbMYyAvvxmH8/patHKh+ebl1BTkHTeo0ATXnn65cPYu15tQIgBI/dvq4EY2OVZUAgnW7jVh7URBaFDmGgRC7vvqCIJxY9qcyYFi+GV08KldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125151; c=relaxed/simple;
	bh=oJDJEbAWxgLYmkQ6DTSv5PS50Mjko22LLF5USPQEs4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmI6gsjSHHWU2dYbF/K43r0biWkPQ1PY903e3FVwFcla9hL8rZ9MU5bgpDYcih/1xcsMsjvXOwzsf1cawAzKk1U6iGChEvln83VkdlVejZaAPUDM8+BkbSd6HV2ne9i7jLViQolrm8hiewbxTiZugpukT7/7MKbpsMN7F79jLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcFxLOPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F38C19423;
	Thu, 26 Feb 2026 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772125150;
	bh=oJDJEbAWxgLYmkQ6DTSv5PS50Mjko22LLF5USPQEs4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcFxLOPyCG0NK2anWiba2L+HDKVAX4IsndXWrCIDCSL8ZQxQ/sxk1mpZwSNdrIf8h
	 Ilmd7ABOWB97Zsw47pKRCMnAxgusYp1ILL6vc3rlmcnUjlnVPa8Ao9NzxIUD7+8tiK
	 aKV/xh9bDf7+YSOtP/aASPVou+xZvVqaXVquMspPvcMs/cZTZRoNJU56Sd1s0CNatM
	 +kyV95HqQECxllcxyVNFLB+XgLQvdEUHqvwzht1zV4sIUcA1J8+0neJl4tT0ipe88M
	 KaXiU21mfCZwX08VKeHWE+LnRPnWvm04fImvyEThDCDStSEiRQWSqbzE2rmh0CIwhC
	 y96214Fs98rxQ==
Date: Thu, 26 Feb 2026 08:58:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Simo Sorce <simo@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Coiby Xu <coxu@redhat.com>,
	Johannes =?iso-8859-1?Q?Wiesb=F6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
	dhowells@redhat.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	roberto.sassu@huawei.com, zohar@linux.ibm.com,
	michael.weiss@aisec.fraunhofer.de
Subject: Re: IMA and PQC
Message-ID: <20260226165819.GA2251@sol>
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk>
 <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
 <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
 <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-8641-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keymaterial.net:url]
X-Rspamd-Queue-Id: 887EF1AD75B
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:27:43AM -0500, Simo Sorce wrote:
> On Thu, 2026-02-26 at 09:16 -0500, Stefan Berger wrote:
> > On 2/26/26 7:42 AM, Stefan Berger wrote:
> > > On 2/25/26 7:10 PM, Eric Biggers wrote:
> > > > On Wed, Feb 25, 2026 at 09:25:43AM -0500, Stefan Berger wrote:
> > > > > To avoid duplicate work: Is either one of you planning on writing 
> > > > > patches
> > > > > for IMA to use ML-DSA and convert the current ML-DSA to also support 
> > > > > HashML?
> > > > > I had done the work on this before and could dig out the patches 
> > > > > again...
> > > > 
> > > > IMA already had to add its own digest prefixing support, since it was
> > > > needed to disambiguate between full-file digests and fsverity digests.
> > > > See 'struct ima_file_id'.  Thus the message signed is at most 66 bytes.
> > > 
> > > The hash there is still only a hash over a file and that hash is signed, 
> > > isn't it?
> > > 
> > > > 
> > > > With that being the case, HashML-DSA isn't necessary.  It's not even
> > > > possible to use here, since there are no OIDs assigned for the fsverity
> > > > digests, so it cannot replace the ima_file_id.
> > > 
> > > For non-fsverify IMA signatures it is 'possible' to use HashML-DSA and 
> > > it's 'working' (recycled old patches yesterday):
> > > 
> > > Linux: https://github.com/stefanberger/linux/commits/ 
> > > dhmlsa%2Bima.202602025/
> > > 
> > > ima-evm-utils: https://github.com/linux-integrity/ima-evm-utils/pull/19/ 
> > > commits
> > > 
> > > > 
> > > > I'll also note that HashML-DSA is controversial (e.g. see
> > > > https://keymaterial.net/2024/11/05/hashml-dsa-considered-harmful/),
> > > 
> > > The problem with this is that NIST would have to react to these 
> > > controversies as we race to support PQC. If something is wrong with the 
> > > standard then it would be best for NIST to withdraw/modify HashML-DSA 
> > > asap. Otherwise it's the best to follow the standard IMO because if you 
> > > don't you get criticism otherwise.
> > 
> > What I am not clear about from FIPS-204 is whether availability of 
> > HashML-DSA is a "must-use" or  a "may-use". What speaks against it for 
> > our use case is performance. The lookup of a hash's ID (last digit of 
> > OID) and the creation of the 11 byte encoding to prepend before every 
> > digest for every signature takes cycles.
> 
> It is a recommendation, but there are plenty of protocols (TLS,
> OpenPGP, etc...) where the decision has been made to use "pure" ML-DSA
> only, even if what you are signing is not the full data, but something
> containing a hash.
> 
> Ideally you do not sign *just* a hash, but some structured data, like a
> context label that identifies the hash and some other related metadata
> for example. In order to make forgeries much harder should the hashing
> algorithm used to hash the data weaken over time. But it is not
> strictly necessary (NIST mentioned in some forum, sorry I do not have
> the message handy for quoting, that a structured packet is perfectly
> fine for use with pure ML-DSA, because it does enough to address the
> same issues that a separate internal context does with HashML-DSA).
> 
> If pure-ML-DSA works better for IMA, just use pure ML-DSA.
> 
> > Maybe it should explicitly state in FIPS-204 something along the lines 
> > of "with a given hash either ML-DSA or HashML-DSA can be used (for as 
> > long as you use it in the same way from then on)." At least this way 
> > nobody can point out that HashML-DSA should have been used when you didn't.
> 
> NIST will not change the standard documents any time soon, but for FIPS
> certification there are Implementation Guidelines.
> 
> In any case a FIPS module cannot distinguish between data that happens
> to be 32 bytes long and a hash of larger data, so the point is kind of
> moot. From the FIPS perspective HashML-DSA is just an available
> algorithm that protocol implementations can use, or not.
> 
> There are additional guidelines on what this may be useful for, but so
> far NIST has not objected to the use of pure ML-DSA even where
> theoretically HashML-DSA could be used.

I see that IMA indeed never upgraded full file hashes to use
'struct ima_file_id'.  Building a new feature that relies on this seems
like a bad idea though, given that it's a security bug that makes the
IMA protocol cryptographically ambiguous.  I.e., it means that in IMA,
when the contents of some file are signed, that signature is sometimes
also valid for some other file contents which the signer didn't intend.

Just fix that bug first, which has to be done anyway.  Then just use
pure ML-DSA to sign and verify the 'struct ima_file_id'.

As Simo mentioned, FIPS 204 doesn't require HashML-DSA when signing a
hash.  It's there as an *option* to solve a perceived problem, which is
actually solvable in better ways.

NIST doesn't plan to update FIPS 204 until 2029, and most likely the
updates will just be errata in the text (such as the ones I reported to
them), not changes or withdrawals in the algorithms themselves.  But
it's irrelevant: just because HashML-DSA is an option doesn't mean it
has to be used.  Pure ML-DSA supports arbitrary data, which includes
formatted hashes which allow for pre-hashing perfectly well.

- Eric

