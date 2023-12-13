Return-Path: <linux-integrity+bounces-431-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49C8119C2
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E5E1C20EE3
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099D39FD9;
	Wed, 13 Dec 2023 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxm9QoTn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2542364AD;
	Wed, 13 Dec 2023 16:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA05BC433CB;
	Wed, 13 Dec 2023 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485739;
	bh=UnQkY4haweGH+Ng7uOudSim3h1wco1uOsY7euBPXDXw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uxm9QoTnsRor5k7RnTNNqga+H3tP3lOBgH+5EmDk4TKAN3CKnCApR881IWubPYg4u
	 rl9qAnlc3DoSBAHfL5vQmA2IPyICprUooody75Po2Pu49xYiUX1Gh9nWGG774llhii
	 nviXwdoAKYR9nB+DVx/2zaojsbWfzvtJuNEO2MpaXuySlE53iipErSFEszd65jXlHs
	 pQou0qA2kyVTZ8RDJruPPQ8WNj152GX4Cpl13pPnO9WOsLfwDxTeKdvd3Ho8lISAUA
	 Ug9k8LVzyB+tZMnJIPVFNZKdeLpicHAA9RA20V6BrJwsLnAdfIY+sphaDIUuvs3pFi
	 jTujRH7MweLtg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Dec 2023 18:42:16 +0200
Message-Id: <CXNCTQ9WNKDH.2AH4O16RD3W0X@suppilovahvero>
Subject: Re: [PATCH v5 12/17] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
 <20231127190854.13310-13-James.Bottomley@HansenPartnership.com>
 <CXHTVYW17UB6.MR6RH0TMDIX3@suppilovahvero>
 <f63ce1f09f7fe2b4ca421ff72d6553c5f7d354fc.camel@HansenPartnership.com>
In-Reply-To: <f63ce1f09f7fe2b4ca421ff72d6553c5f7d354fc.camel@HansenPartnership.com>

On Fri Dec 8, 2023 at 1:09 AM EET, James Bottomley wrote:
> On Thu, 2023-12-07 at 06:52 +0200, Jarkko Sakkinen wrote:
> > On Mon Nov 27, 2023 at 9:08 PM EET, James Bottomley wrote:
> > > Add session based HMAC authentication plus parameter decryption and
> > > response encryption using AES. The basic design is to segregate all
> > > the nasty crypto, hash and hmac code into tpm2-sessions.c and
> > > export a usable API.=C2=A0 The API first of all starts off by gaining=
 a
> > > session with
> > >=20
> > > tpm2_start_auth_session()
> > >=20
> > > which initiates a session with the TPM and allocates an opaque
> > > tpm2_auth structure to handle the session parameters.=C2=A0 The desig=
n
> > > is that session use will be single threaded from start to finish
> > > under the ops lock, so the tpm2_auth structure is stored in struct
> > > tpm2_chip. Then the use is simply:
> > >=20
> > > * tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
> > > =C2=A0 handles
> > >=20
> > > * tpm_buf_append_hmac_session() where tpm2_append_auth() would go
> > >=20
> > > * tpm_buf_fill_hmac_session() called after the entire command
> > > buffer
> > > =C2=A0 is finished but before tpm_transmit_cmd() is called which
> > > computes
> > > =C2=A0 the correct HMAC and places it in the command at the correct
> > > =C2=A0 location.
> >=20
> > Split each exported function into a separate patches. This too big
> > chunk of diff to be reviawable, i.e. it is impossible to give=20
> > reviewed-by in this form. I think I've commented this also throughout
> > the series, and it has not been changed.
>
> Um, you mean you mentioned it once and I explained that the API is
> unitary so logically it does belong in one patch and you didn't mention
> it again?
>
> > There needs to be a patch per each exported API function so that they
> > can be looked into detail. This patch does not align with submission
> > guidelines in the form it is either.
>
> There's no length limit on patch sizes, just the recommendation to keep
> the changes logical.  One patch per API is actually illogical and
> contrary to the guide because the APIs come in sets, so you'd miss the
> logical reviewability with that split.  I suppose what I could do is
> split it into three logically complete API sets: 1) primary creation;
> 2) session start/end 3) rest of the session HMAC helpers.  That would
> give three patches of 400-600 lines each.

That would be good enough.

I've now also verified that call chains look to go through with
bpftrace. I have full green flag for including from blackbox
testing perspective, the feature has (in my opinion) correct
design and also since distributions are gaining TPN sealed
encryption this sorts that orthogonally. So in that sense
as long as the code changes will become clean enough this is
definitely something that we want to Linux (just saying this
that polishing work does not go down the drain).

I mean with this, it closes how things are sealed e.g. in modern
Mac's, at least to the level that the computer is still open for
the owner :-)

>
> James

BR, Jarkko

