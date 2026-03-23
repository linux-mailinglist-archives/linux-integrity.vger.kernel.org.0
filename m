Return-Path: <linux-integrity+bounces-9032-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HD1Mn3PwGm2LQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9032-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:28:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613B2ECA86
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B7E300C5B2
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE77296BBC;
	Mon, 23 Mar 2026 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeE/kdpY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A7219E8;
	Mon, 23 Mar 2026 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243706; cv=none; b=URMygqy/AcopCefSg+WrrHOncolbLo1AGeRf05f5WuoJ5Ldq5eI3BqWJRi/+fMNi7zeFvhfwJgpH39aVQqhZ3ySbBL8enSNAsYbfZY99EJo4/wMYOoablSaMCIP5XybE8iV/EoNiEPFZPv+S7s9w+OZdsH1z5h4o2hq7QF2xRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243706; c=relaxed/simple;
	bh=KWOkM2lz5metxKKkT/5crfIYZXl0HBH2YF8TkWlCRDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2rHf2cokjezBhxziZ4bmqAlNxp5FRfwF2muh91xS45TQyv2KUT5sY7PmZG44gZnVczmhm/N278ZrASr8xNfybstuhqRhF3sp1g/RjJ74ml121gvRVYw11Pmv+32XYttfdTaE12MMvzH8auBVg4Hh7mGjHNeN9FooyFdDl4+xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeE/kdpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989C2C4CEF7;
	Mon, 23 Mar 2026 05:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774243706;
	bh=KWOkM2lz5metxKKkT/5crfIYZXl0HBH2YF8TkWlCRDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeE/kdpYjJxoDBRK2nuq/bcvE3zG6VWzEhgBhjDTt+pBsXEHLmB6rLNpPRKNXbZwX
	 k5/aAPblJC6eB52vXoCE5xN0A9h8HsCDAphhaW2gMA2+xZOsTi9O2Vu+M+M4x6Rzbd
	 7udsqveW9YB8O6GXIFFOWnfRPoyL9xhJbSNIRgVWMXauRA2TnD+gP/BnpljAzdnlfO
	 JuQl69eB62S6UPok7zt1TgJvkUDXEzBFTZU3koD/3ldxyXWYUWpnYOyRzQLvV22s5J
	 phdbxik6zhMY62shapFrA3xrlXEP4G4RRylwaV628mLVlFzrmuVO1MtAGOCb1pt37U
	 IkVHIbxFVPIeA==
Date: Mon, 23 Mar 2026 07:28:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
Message-ID: <acDPdbRT0VuTzg4h@kernel.org>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
 <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
 <21cc6859-1750-4c22-91bb-116620764ca9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21cc6859-1750-4c22-91bb-116620764ca9@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-9032-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5613B2ECA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:44:03AM +0530, Srish Srinivasan wrote:
> 
> On 3/10/26 4:15 AM, Nayna Jain wrote:
> > 
> > On 2/20/26 1:34 PM, Srish Srinivasan wrote:
> > > The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
> > > for logging debug information.
> > > 
> > > Replace pr_info() with pr_debug(), and use KERN_DEBUG for
> > > print_hex_dump().
> > > Remove TPM_DEBUG.
> > > 
> > > No functional change intended.
> > There is functional change here.  This change allows secret and nonce in
> > the function dump_sess() to be logged to kernel logs when dynamic debug
> > is enabled. Previously, it was possible only in the debug builds and not
> > the production builds at runtime. With this change, it is always there
> > in production build. This can result in possible attack.
> 
> 
> Hi Jarkko,
> Could you please let us know your thoughts on this one?
> 
> And Nayna,
> thanks for bringing this up.

Nayna is absolutely right so I dropped it.

Solution is debatable.

> 
> thanks,
> Srish.

BR, Jarkko

