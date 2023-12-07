Return-Path: <linux-integrity+bounces-374-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69641807FD1
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Dec 2023 05:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2474C281792
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Dec 2023 04:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B73566E;
	Thu,  7 Dec 2023 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5jVgvbV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F271C38;
	Thu,  7 Dec 2023 04:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263B4C433C7;
	Thu,  7 Dec 2023 04:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701924748;
	bh=Vc87ZS5RAgfRHDT98yn81VOmmSQCufCBY4OSxqpN+8I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I5jVgvbVEb6aiBxOP5poLVsUDlylK+EKZExZiWBdxQPjYouxGC7IfPbjFhfrx6RuR
	 0qoDwAbBuMILOPrgbpxBWQIf5jEp8/Oy9mN5rhCyGnFUHiESz0OYV+fijIpsvPBTAc
	 B5N8jaWctWsB9wgeM9CHzJJZwEomMYRFDLBIklEmVSkBvYw4GPoqctDMtHbdXo0TlB
	 DcK49dCWLrUARJRl9AddGkmNHEYqNjgp4lyjgX2f7wT02wTYestS8kJ754869oxhFy
	 t3Itw16fjr8mjrrHQgE0OQzDYsdyn14rZJJ+wg7LQyGXYCoB6U535pxyVlq0U6XXPD
	 HEZIWjkVeHttg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Dec 2023 06:52:23 +0200
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v5 12/17] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Message-Id: <CXHTVYW17UB6.MR6RH0TMDIX3@suppilovahvero>
X-Mailer: aerc 0.15.2
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
 <20231127190854.13310-13-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20231127190854.13310-13-James.Bottomley@HansenPartnership.com>

On Mon Nov 27, 2023 at 9:08 PM EET, James Bottomley wrote:
> Add session based HMAC authentication plus parameter decryption and
> response encryption using AES. The basic design is to segregate all
> the nasty crypto, hash and hmac code into tpm2-sessions.c and export a
> usable API.  The API first of all starts off by gaining a session with
>
> tpm2_start_auth_session()
>
> which initiates a session with the TPM and allocates an opaque
> tpm2_auth structure to handle the session parameters.  The design is
> that session use will be single threaded from start to finish under
> the ops lock, so the tpm2_auth structure is stored in struct
> tpm2_chip. Then the use is simply:
>
> * tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
>   handles
>
> * tpm_buf_append_hmac_session() where tpm2_append_auth() would go
>
> * tpm_buf_fill_hmac_session() called after the entire command buffer
>   is finished but before tpm_transmit_cmd() is called which computes
>   the correct HMAC and places it in the command at the correct
>   location.

Split each exported function into a separate patches. This too big
chunk of diff to be reviawable, i.e. it is impossible to give=20
reviewed-by in this form. I think I've commented this also throughout
the series, and it has not been changed.

There needs to be a patch per each exported API function so that they
can be looked into detail. This patch does not align with submission
guidelines in the form it is either.

I can give only one half review right now, which "yes wee need this"
but cannot give any rational feedback whether it is in the form we
would like it to be.

BR, Jarkko

