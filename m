Return-Path: <linux-integrity+bounces-9534-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADQ3JsSLB2oI8AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9534-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:10:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A08557A69
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA44D3002F52
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7083E835F;
	Fri, 15 May 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ57Bx9O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06128487BE;
	Fri, 15 May 2026 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879423; cv=none; b=TE1yVdRiLBMWmZaiQGLmkSpFwGqVw9kb8r0xRDaCJ9PUCsbvwpMiFaRrKwmZcll5uWSBpFbZHkU+W7IyheQTbolSN2R82U1KA9tjeWQ7qKbE0XZBFkPcfKZOIqxQBZNEQsBQd9f9aKrWb9n8JDv7wFKw0vjh53uYL8iLxoMc/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879423; c=relaxed/simple;
	bh=w+3teP2/HohrpI2HRWYBxqQiTtE1OuSjTSTdwM0Bhvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nonuNsm+e8x37FxxbMoyZTIkbEfK5MaVnT8ancs2yWOf0EdPdIBDieV4tH8U5FupQ739WVDvFsJMt6/OHx63E8yrzeUxnrIjJ1LuWkmTeOJOLLhj2aO8oh1vVo8fR1c6TsVGGMqHu5Asvpxw+9gUNEiEGfkK00ipGqZQIOYoYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ57Bx9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C263C2BCB0;
	Fri, 15 May 2026 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778879422;
	bh=w+3teP2/HohrpI2HRWYBxqQiTtE1OuSjTSTdwM0Bhvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ57Bx9OXcq0K1NpqVIadVtXZmw4Z94gZ20HxBtDSaArJY5aa7Xyz8dRK0JDHS6yr
	 0sw11RStpRlxk2ea0J5hyFXWxuB16eXk5PF2URw5qq2mqzBlJ+HCcPOUph+7/oT0qn
	 /fhi+VfNHCUt9HuQ/KFpmYfyiuk/qsbZ0eFaesarIyMiVgcte6d2xQSBjBkQ9PC4VI
	 ZC6WZ+4zf3sZ2ooZWMRwwfeNtKb+jUij3k8tXDVPo76vPx3NY/hKL6Jo5jRU678OGA
	 DK9Rq4p3mbdC7v6frQUTkPwXv2GzmGq2RcaO3qNZ5R0+znuEAr+Ag2oNsD4HcQnlmx
	 URZJrdTWA3wLw==
Date: Sat, 16 May 2026 00:10:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	"Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"Bauer, Sven" <svenbauer@siemens.com>,
	"Zeschg, Thomas" <thomas.zeschg@siemens.com>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <ageLuuuq0HkF3ARm@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
 <af9QQah4QN5VD-4P@kernel.org>
 <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
 <ea79fd5021c0bf069746b3b450e5b2c20ba90805.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea79fd5021c0bf069746b3b450e5b2c20ba90805.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: A0A08557A69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-9534-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_WP_URI(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,siemens.com:email]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 11:31:12PM -0400, James Bottomley wrote:
> On Sun, 2026-05-10 at 22:42 +0200, Jan Kiszka wrote:
> > On 09.05.26 17:18, Jarkko Sakkinen wrote:
> > > On Wed, Apr 29, 2026 at 02:33:20PM +0000, Niedermayr, BENEDIKT
> > > wrote:
> > > > On 10/27/25 20:51, Jarkko Sakkinen wrote:
> > > > > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > > 
> > > > > > As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM
> > > > > > may write the current time epoch to its NV storage every 4
> > > > > > seconds if there are commands sent to it. The 60 seconds
> > > > > > periodic update of the entropy pool that the hwrng kthread
> > > > > > does triggers this, causing about 4 writes per requests.
> > > > > > Makes 2 millions per year for a 24/7 device, and that is a
> > > > > > lot for its backing NV storage.
> > > > > > 
> > > > > > It is therefore better to make the user intentionally enable
> > > > > > this, providing a chance to read the warning.
> > > > > > 
> > > > > > [1] https://github.com/Microsoft/ms-tpm-20-ref
> > > > > > 
> > > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > 
> > > > > Looking at DRBG_* from [1] I don't see anything you describe.
> > > > > If OPTEE writes NVRAM,  then the implementation is broken.
> > > > > 
> > > > > Also AFAIK, it is pre-seeded per power cycle. There's nothing
> > > > > that even distantly relates on using NVRAM.
> > > > > 
> > > > > [1]
> > > > > https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
> > > > 
> > > > Hi all,
> > > > 
> > > > we recently also stumbled over this issue which led me here to
> > > > this thread and maybe adding our observations helps to clarify
> > > > things here a bit (hopefully) or at least augments the
> > > > information related to firmware TPM based implementation based on
> > > > ms-tpm-20-ref.
> > > > 
> > > > Based on the optee_ftpm repo, as Jan already described, which
> > > > currently references commit 98b60a44aba7 of [1] suffers this
> > > > exact issue because of the NV_CLOCK_UPDATE_INTERVAL [2] which is
> > > > set to "12" and issues a write for each command after ~4 seconds
> > > > have passed.
> 
> You keep quoting this to us, and other parts of the spec.  However, you
> forgot to quote from the Section 7 compliance statement in the same
> spec which says:
> 
>    the NV subsystem of the reference implementation is not
>    representative of the actual implementation of most physical NV
>    implementations but is a crude analog.
> 
> I get that the the optee people failed to realize this and only just
> corrected the mistake, but the fact is that all other TPM
> implementations, both physical and firmware don't have this wear
> problem you've given yourselves because they noticed.

I guess a quirk could be considered, if there was a specific commercial
chip product or firmware TPM using optee but of course that would not be
"optee fix". It would be applied on when that particular device would
be identified i.e., not across the board.

Just mentioning this for completeness, fully agree what you said :-)

> 
> > > > This config has been changed to "22" (on current master branch
> > > > [3]) which is the allowed maximum when following the TPM spec
> > > > (chapter 36.3.2 in [4]) which leads to round about 70 minutes,
> > > > but optee_ftpm didn't move ahead to this commit, yet.
> > > > This config exists for being able to adapt the write cycles to
> > > > the specific wear conditions of the hardware.
> > > > 
> > > > Moreover the ms-tpm-20-ref repo seems to not be maintained
> > > > anymore and one should rather switch to [6].
> > > > 
> > > > So there are currently firmware TPM implementations out there
> > > > that lead to these frequent writes.
> 
> Yours is the only one I've ever come across.
> 
> > > Really this would need a product and official bug bulletin for it
> > > to even consider a workaround. Speculation does not count.
> > > 
> > 
> > The key point Benedikt tries to make here is that the TPM 2 spec
> > forces any vendor to do something about persisting the last seen time
> > at  least every 70 min. If they didn't do that, then they would
> > violate the space 
> 
> That's correct, but a red herring: if the optee TPM had done this 70
> minute flush ab initio you wouldn't have the wear problem because the
> seed writes would be much less frequent.
> 
> > - arguably a bug.
> 
> Well, not following the spec is a bug, yes, but it's not a bug in the
> kernel ...
> 
> Regards,
> 
> James
> 

BR, Jarkko

