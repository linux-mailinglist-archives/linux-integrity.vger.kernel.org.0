Return-Path: <linux-integrity+bounces-9500-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ew5cE59H/2kH4QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9500-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:41:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C735001BA
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF62300BDAE
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A43890F7;
	Sat,  9 May 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9O6D0DI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17E36606E;
	Sat,  9 May 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337691; cv=none; b=tB+V651PbNCe/inbBeM82YGSKSN5uPgBQpYGIBe46t6n3h5sksPjMLSM8K4pMJaMX8QO0r9x2S4oSfUBmAu1Aoq1MkLEMhePtn7vSd4xPkq8hviiQW55L+iLadTD4RW4pNSKult/V7viIXskHG+Dyj374SkovMQe3OSudtmWKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337691; c=relaxed/simple;
	bh=rJasm3hemj3M41AjwyGWOSt5AGTGs83V1eqdgMuK3E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECrGIPvRv3+0PAABQ/Gr7WF/TjmC7isWBos5H4kwIPqo/41BfcUL7ZGjh55/r9XQpn8xruFiW6k201dUQK3muDgikmFI7eWEzhKkMOOKuDbTXqAtrE+k89ZMSfB9PITZw+/sVn6Nuoe8jxq7A49T8B+kS4svl7Z9grB2Vp/qNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9O6D0DI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A110DC2BCB2;
	Sat,  9 May 2026 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337691;
	bh=rJasm3hemj3M41AjwyGWOSt5AGTGs83V1eqdgMuK3E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9O6D0DIGjjmsRL/4mpnAYyGB2IFrTE0LK8QbYcGYot/PWoLIjdx6QdT/3uvAbvgj
	 Xm9YlUGcE6L6RISA9efMIu/M0qRreewmux9Q6N7uY2HFUAbLutBH+SZahrgEhzoPBm
	 AZIpHCKI7xzcWMsVxNFAwJoZnN1wcWnbcmnxiUCyN8KcsWr1TglKtQTZTAsta04qhh
	 ldkxLdiNdkDbNewvjfR/o35G18a+BWWF/JSLOb0tCx9Og/ohi72wyhFc/630u0O48q
	 BD23fH4+jm8w/GU+8WuNdWnsYEh2uVB3QFNElgBcdozSAln12cFd5wrvkl3dqYWHiG
	 vEUAq5VqZVpzw==
Date: Sat, 9 May 2026 17:41:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 1/5] tpm_crb: Add register definitions of TPM CRB
 chunking fields
Message-ID: <af9Hl3P91Z82j8ij@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-2-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324181244.17741-2-armenon@redhat.com>
X-Rspamd-Queue-Id: 90C735001BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9500-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, Mar 24, 2026 at 11:42:40PM +0530, Arun Menon wrote:
> Post-quantum cryptographic (PQC) algorithms can require buffer sizes that
> exceed the physical capacity of the TPM's Command/Response Buffer (CRB).
> To support these larger payloads, the TPM 2.0 CRB specification [1]
> allows for data chunking when the physical MMIO window is smaller than
> the required buffer size.
> 
> To support this protocol, the TPM driver must be able to detect the
> chunking capability, and signal the backend using specific start
> method flags, also known as the control area start register bits.
> 
> As per sections 6.4.2.2 and 6.5.3.9 of the specification document [1]
> Add 2 new bit flags to the existing enum crb_start and add the
> capability bit.
> - CRB_INTF_CAP_CRB_CHUNK: A capability bit used to detect if the backend
>   supports chunking.
> - CRB_START_NEXT_CHUNK: A control bit to signal the TPM to consume the
>   current command buffer, or to get the next chunk from the response
>   buffer.
> - CRB_START_RESP_RETRY: A control bit to signal retransmission of a
>   response buffer.
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 6c25305c256ef..67c0061d4cab7 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -56,12 +56,18 @@ enum crb_ctrl_sts {
>  
>  enum crb_start {
>  	CRB_START_INVOKE	= BIT(0),
> +	CRB_START_RESP_RETRY = BIT(1),
> +	CRB_START_NEXT_CHUNK = BIT(2),
>  };
>  
>  enum crb_cancel {
>  	CRB_CANCEL_INVOKE	= BIT(0),
>  };
>  
> +enum crb_intf {
> +	CRB_INTF_CAP_CRB_CHUNK = BIT(10),
> +};
> +
>  struct crb_regs_head {
>  	u32 loc_state;
>  	u32 reserved1;
> -- 
> 2.53.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

