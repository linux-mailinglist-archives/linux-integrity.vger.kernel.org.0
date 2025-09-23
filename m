Return-Path: <linux-integrity+bounces-7242-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE96B96804
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34871885737
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607421FF49;
	Tue, 23 Sep 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKb4qCSf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAA1DF994;
	Tue, 23 Sep 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640087; cv=none; b=bkC0ITWjiHrT1QTpaikGOUR0wGiFBFeJXfjnU5BaZsPRYN+s3zux68W+Shp5ELWl9y4VLWNSHtHAuJ5WvEtZR9FooTEpPxvwXlcy/I4SGan5x00pgDs0lU5Q4xp5DrOspqX33V1kB9Pk6ue77i1MB30C7s1LHxQ4qUa7lfpIWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640087; c=relaxed/simple;
	bh=S9GOsjmp40/4qQXOv2AcNQGiY/8K8Xg4xmBBsp0hplo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjqy8KIYP+Ht3CkkDcLr77eRBd8fwJrA1gXTwDb72q8EbqQSnNLIK3pJ0jvm/zGpmWe/HobWRVf2hOgHuOXFjnpWxwbeJKU3HC3600HOD/Ihd1jQGRH18upEIZNgwfr0YiAAs5mNa5dKlfsEktkrCEEjZBTTbFJmTUTbU/kJEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKb4qCSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C28C4CEF5;
	Tue, 23 Sep 2025 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758640087;
	bh=S9GOsjmp40/4qQXOv2AcNQGiY/8K8Xg4xmBBsp0hplo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKb4qCSfqdiYoghX1dzKfeaJxLlXumN2D7ZPtY1nFAUdlvS59WH+vjiPJM0NGPo+e
	 ZkYHFl5bAl7TcfW5EnWU1P6PlEIKVLzMkY3tKIJFfcnQSiroM1/AGJFrpI9YzC+8ig
	 w12qV5OTNW8wtz+ubD3Ee71wKvP2AlNtO6W28+aiFGdQoKbZZIGWjyKPRabOd3haqd
	 mGg0D3ZFh1gS2j6FOa0Mu3M+AEBMPN4/7SwUjWka7fvWjfYdOldRuFIdIKNon6eTSg
	 6Enkbcli2lfHULo4xQjuWsPW7/Go8a9vbr+KoGv8mqddAT9A0SwR2kUCxqb4lePhkK
	 ImQEiBu1CMTfA==
Date: Tue, 23 Sep 2025 18:08:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aNK30-5LLloQFXbD@kernel.org>
References: <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
 <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>
 <aMwptnyYedvdqdHc@kernel.org>
 <aMxC6hU-UhCP2m6v@kernel.org>
 <aNEPLsJlV6LjnAty@kernel.org>
 <76504837de4d85c385d32f36b8340af0ccad2a09.camel@HansenPartnership.com>
 <aNKt6kjNnFvhgRW1@kernel.org>
 <d84351697f65dc3ab58d7c1634d129dee431074d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d84351697f65dc3ab58d7c1634d129dee431074d.camel@HansenPartnership.com>

On Tue, Sep 23, 2025 at 10:37:06AM -0400, James Bottomley wrote:
> On Tue, 2025-09-23 at 17:25 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 22, 2025 at 05:31:24PM -0400, James Bottomley wrote:
> > > On Mon, 2025-09-22 at 11:56 +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Sep 18, 2025 at 08:35:38PM +0300, Jarkko Sakkinen wrote:
> [...]
> > > > > The way I see it, a "random project" would apply to any project
> > > > > that a format is locked in, and it is quite obvious that fixing
> > > > > handle as the anchor is exactly fit for exactly for this
> > > > > project, and within those exact limits it is probably a
> > > > > sustainable choice.
> > > > > 
> > > > > Being able to fix key into cryptographic  identity is somewhat
> > > > > sane addition because not only does it lock-in the creator but
> > > > > it also allows to use offline stored keys with the same scheme
> > > > > i.e., non-endorsement hierarchy derived keys created with
> > > > > TPM2_Create or TPM2_Import.
> > > > > 
> > > > > In the context of OpenSSL TPM2 engine, perhaps the current
> > > > > scheme is fine but in the context of supporting a "ecosystem"
> > > > > as a kernel feature it's not in its current form robust enough.
> > > > > 
> > > > > And how else I can describe it other than I don't care about
> > > > > the project, if the file format enforces me align with it?
> > > > 
> > > > The ASN.1 definition limits types of keys while there's no any
> > > > good reasons to disregard transient keys. 
> > > 
> > > As I explained in the bit you quote above, the spec covers volatile
> > > parents.
> > > 
> > > > It also enforces handle numbers, which is not very robust
> > > > approach.
> > > 
> > > I think if you read the spec, you'll find it only requires handle
> > > numbers for persistent keys ... specific handle numbers being a
> > > feature of those keys required by TPM spec.
> > > 
> > > > I've neither seen any cryptographic object in my life, which uses
> > > > ambiguous data as part of the identity no matter how hypothetical
> > > > the possible threat scenarios are. It's a bad security practice
> > > > plain and simple.
> > > 
> > > This contains no actionable technical content.  However, it is
> > > possible the spec doesn't cover your use case, it's just you
> > > haven't actually outlined what your use case is, so no-one who
> > > knows the spec can actually confirm or deny this.
> > 
> > I revisited the issue and this is how I see the situation.
> > 
> > I think the most feasible approch especially for volatile keys would
> > be to store all structures included in TPM2_Create response, instead
> > of only storing the first two response parameters. Rest of the blobs
> > can be e.g. optional. It's the most bottleneck free way to address
> > any issues.
> 
> I still don't understand what issues you're referring to.  However ...

OK so I can work on the topic more. In my case, I realized that the is
existential question that why having ASN.1 format is useful in the first
place. This is not to say there is not existential reason (i.e. not
claiming that but) if save just the whole response to the disk I can
load a key as:

1. Read the response blob.
2. Read parent identity from CREATION_DATA
3. With the information iterate through handles in the TPM and find the
   correct parent
4. Pass the parent handle to TPM2_Load

So if this works out I might not need to change tpm2key if I just use
the response blob itself as the file format. I need to experiment with
this and find the possible issues wit the approach, and if there are
fields in ASN.1 that don't exist in some form in the raw TPM data.

> 
> > Creation data contains indefinitive information about parent and this
> > also enable the use of tickets.
> 
> This is already being discussed on the list if you want to join:
> 
> https://groups.io/g/openssl-tpm2-engine/topic/patch_doc_update_draft_rfc/115384542
> 
> Regards,
> 
> James
> 

BR, Jarkko

