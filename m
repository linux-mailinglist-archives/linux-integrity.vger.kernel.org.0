Return-Path: <linux-integrity+bounces-9503-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEIyL6VK/2mN4QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9503-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:54:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F53C5002F5
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC54130036D8
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350733F580;
	Sat,  9 May 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvcY3fbO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CF239567;
	Sat,  9 May 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338466; cv=none; b=h7IRYRJTm5wHVQcerjKy93BHrWtRUGIcjFGJNxGJH1zCcbw4Vnc4DGpdPFKjS3Ef7LruBRT/6Rk/4xIuSDSyywiBtJBass9A9euD5BjXbKU6RIMk4pebz5pVYlrUC5x+vmhMSM4YmDsarDCe9nEIQkTGvH6mlcxW7znbKG6XADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338466; c=relaxed/simple;
	bh=xB3V5KcXXzXwF1rLAu6jbsABlM/MbOk6xgrndruslyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch2fuUdFHhd4udeYyw6zd57OLyL69+7ON/xoq1+3wirYmK2lnBGZokHzURlZgzmQkv42KWGrsfvzXWjrMYbggSbU57fcX5qAdGtwrds0og6pGG61bpCKe/qv0nz4+HVbLrnludk4Si0OcTmXFpL5EYKt7xkCdaSsVsuZd3/Owf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvcY3fbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E15C2BCB2;
	Sat,  9 May 2026 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778338465;
	bh=xB3V5KcXXzXwF1rLAu6jbsABlM/MbOk6xgrndruslyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvcY3fbO4hXcd7AHRuDM2ga+bhTsX8hK5+oKqs0PAIgUAuhAY4Yfv9Y2qZHsjIfgo
	 Q8N6cN5SnpoDxHNevjx1kFZS1T+WjgYxIg+xn8uxxtMLPutfsjvM6yOEVYwzSSWi7i
	 ZI2sqyowC4rrOHqHo5uV4RePw4NSgx4GEb6Z5xVh39TmkIhp6j3tNfdJT8zmuyj7W+
	 S1Az9ORULTOyebS37yCFwbDz10OL3QR4Ih9Tke7zfLiMHOspubZPf2Q12u/B4pDLEg
	 ljllJGACcGNgRKDiZ+5MCrHHmjVqK3HgGPARdxgGF+3gzDErmB4RJbl2Im2McpUpmR
	 Az0Sah5AStSpw==
Date: Sat, 9 May 2026 17:54:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <af9KnU90yMf8MxnQ@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324181244.17741-5-armenon@redhat.com>
X-Rspamd-Queue-Id: 3F53C5002F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9503-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> The size of the command is checked against TPM_BUFSIZE early on before
> even sending it to the backend. We therefore need to increase the
> TPM_BUFSIZE to allow support for larger commands.
> 
> For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> also order-1 safe.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 87d68ddf270a7..26c3765fbd732 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -33,7 +33,7 @@
>  #endif
>  
>  #define TPM_MINOR		224	/* officially assigned */
> -#define TPM_BUFSIZE		4096
> +#define TPM_BUFSIZE		8192
>  #define TPM_NUM_DEVICES		65536
>  #define TPM_RETRY		50
>  
> -- 
> 2.53.0
> 

Shouldn't this prepend previous patch?

BR, Jarkko

