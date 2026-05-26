Return-Path: <linux-integrity+bounces-9664-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K/3MYNRFWrcUQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9664-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 09:53:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC465D20F5
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2743022907
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C23CBE74;
	Tue, 26 May 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8hUD8I5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F503C3C0E;
	Tue, 26 May 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782015; cv=none; b=hwfxKiU5kcA8hnGB99ELGJWC42OEnAMoEmAEDX+RQXanDdrOsASeYnNhOp2ZGudTIfCc4QKHSU4Yt910owzwFtaIUNdTaXKJy7r/LHAtQ6hmoq3DlSs3EoH/F9mmo2pRTTDwTzGhZwxhsaZXTe3dLN0nKoRwVINB0224jxrjAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782015; c=relaxed/simple;
	bh=PcThI1BoyjVUtfmWqtNgKsUMru2GLviK0ovOx+c7bNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1Og1NbpJlLXBTpyC+lqKBt25+3zumQzwtqxLV6JyFZI5N3X1rzKVc1+K5Hocuq/f+I0K0EXwFJnfRej7zwEneMUM8MJiTWgh+QjkKT1uQvXobq1GBCRs5HDO/dLG0qjhiBCygv4Iaz8N6MLehvjhPqw/mmFsHbVcpi1lzCGzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8hUD8I5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D7031F00A3A;
	Tue, 26 May 2026 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779782014;
	bh=nYxpBaGqUSxWUWyckAnbLtrN2g0awmSJ1qiK/g5z2Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8hUD8I5r5viE+3paIJo8PzERmcmQvNknhFsONOpsvQ3KdHgHZ3qfBIVhO0F4WFO5
	 SAINdg67zmIiO47kRkgbzqDio2cV3uOeBJiQtZRFRKz/BhN5v3khYnqdZS1H3nCRju
	 KMo1OvtO8N8l6Av/zokiTbCCcPtyG06vvuf7mB5mEK6JsVIjM6+O7maAaG34hkcRlM
	 Gp9EFQjDCGVnKb1WN0J6Z9bUuPsmfM1U8Qf4728t+AuiQoiU9oo0CQLUudnaPTkQEI
	 96dbk+/nPTVHipCbIM94oaGc7RfJpE+FjS0veSqKtkI6wGZiXXuVW7FiBPMRK92ewh
	 rSMligZ4wLmog==
Date: Tue, 26 May 2026 10:53:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Arun Menon <armenon@redhat.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm-buf: memory-safe allocations
Message-ID: <ahVRefyT4BTKOu0m@kernel.org>
References: <20260522013555.1063716-1-jarkko@kernel.org>
 <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9664-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,opinsys.com,redhat.com,apertussolutions.com,oracle.com,gmail.com,linux.ibm.com,gmx.de,ziepe.ca,paul-moore.com,namei.org,hallyn.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8FC465D20F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:50:51PM -0400, James Bottomley wrote:
> On Fri, 2026-05-22 at 04:35 +0300, Jarkko Sakkinen wrote:
> > Decouple kzalloc from buffer creation, so that a managed allocation
> > can be
> > used:
> > 
> > 	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
> > 						GFP_KERNEL);
> > 	if (!buf)
> > 		return -ENOMEM;
> > 
> > 	tpm_buf_init(buf, TPM_BUFSIZE);
> > 
> > Alternatively, stack allocations are also possible:
> > 
> > 	u8 buf_data[512];
> > 	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
> > 	tpm_buf_init(buf, sizeof(buf_data));
> 
> This isn't really a good idea from a security point of view.  Remember
> the buffer has to be big enough for both the sent and the received
> data.  Today we simply set TPM_BUFSIZE to the maximum amount a TPM
> requires and all the send and receives just work.  If we let callers
> set this size, we're asking for them to get it wrong (or at least
> forget about the receive part) and for us to get a DMA overrun from the
> TPM ... which might be potentially exploitable depending on how it
> occurs (think of an unseal of user chosen data overrunning).

It's one patch so you're free to remark the call sites where this
happens. This is not a majorn concern at all.

> 
> I get the desire to support some of the newer chunked commands, but
> since none of them is yet present in the kernel, why not introduce an
> API that works only for them to avoid the risk of a security cockup in
> existing code?

Multiplying amount of maintenance work with a redundant implemntation
is not something I support.

> 
> Regards,
> 
> James


BR, Jarkko

