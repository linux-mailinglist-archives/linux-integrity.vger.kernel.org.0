Return-Path: <linux-integrity+bounces-9518-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EMwIInuAGptOgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9518-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 22:46:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A8A506523
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32A24300C5A1
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE2314A6F;
	Sun, 10 May 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="lLePA2ms"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270B2836A0;
	Sun, 10 May 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778445957; cv=none; b=nDi1mJh7Y5qh+q4mlX78zvapA7Ed6whScDw8bo8t92lSN9ugWI12x3lur5dvGxMVxm2LPerfUMmDo3qMPr4YdVhLjZX64WKGzKoqZCr2y5L6o+i3qIxW9nLLy7Ng+K05u0Z+EX++xXBHy1yBUxkIc4UsehBhrcuelFySAWQR6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778445957; c=relaxed/simple;
	bh=NmVs1pS/HxOIFX28NvsDmf5NQ9YSnkHMBC3QkZiYJLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfQm4ORcYL0zzjXEsSQpVLDTWuHqioqFozTLDFHGy0gQOt0z+DW4WH8VldFQxRKMxubfgI+rws92LQz1EIzXia+fhFZ04eeN4bQpEyMO06q0w0ueY4TPwD7qYl1Fw2RjuZmUYjgFwg+dpxyczS/nooiQePV/5Gvz2lHBLsfcq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=lLePA2ms; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778445953; x=1779050753; i=wahrenst@gmx.net;
	bh=a4r1WClzOddhY4ba+V89G/IejE6LjiifDjv0Dyou0w0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lLePA2msUzdV1jNG4GVrN9lsgiqJ9PKvyKytlWxxgfwy0CFnAgkoYWF0qgBgbq8a
	 htCaGKHO+GZHdOnmDhPG18sTuDjK1Nnu/wjbNaD+TzuT1TLzuM6o9w2A3Y0U9Y9TI
	 /w1QEMkfWV7Odpyr2wpNMkyP7ui4KglQihGHDY28jRCuI/X99NLPdAmRXtRhcJEB8
	 1idrSrGDjgb+3MGQS1mHjweLQl2B3cINfw7nzeZcUqAlZJiJNrsqVfuKMYrLWwzEE
	 9oslx/DSKuogl6eWoXJ9Gk2F0f1wfFujFPU56+CCglpVlBwAPZM+rPh/h+JBXs/eU
	 QMacLPS6l4qRE00hNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1xMczd0r4O-00rB2R; Sun, 10
 May 2026 22:45:53 +0200
Message-ID: <033c013e-8b32-4459-9dc9-255232d1d2d7@gmx.net>
Date: Sun, 10 May 2026 22:45:52 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org
References: <20260509185108.2681198-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260509185108.2681198-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W0tqTbrT/2O2OOSWQWDxVpIs287Z9lZKvNfCR/umvbO33EpaYbj
 7xlNa9NKzkhRrUnSCi3CnLBB+dFTAl4n2Hbtbm53fXRBN8uduZG37liFNxulw1hPU0hJhGW
 /AoYm0G/Nq2Cndkf9nhal0F6A/kXSx0ew864IqESAKdBcxoO7vUNSLoG9X/w7U8Qk1TBN+G
 Zp2UVSpV1eOpOp6OwrqQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PNDKVst7Yvo=;fuPUnI1x9hoDq0+IyVySrUcu/gM
 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
 0pg5re3VnAFfpzMMawaVWtWxsheIuifCO39g=
X-Rspamd-Queue-Id: D3A8A506523
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9518-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmx.de,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmx.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Am 09.05.26 um 20:51 schrieb Jarkko Sakkinen:
> wait_event_interruptible_timeout() evaluates its condition after setting
> the current task state to TASK_INTERRUPTIBLE.
>
> With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
> path is used:
>
>      tpm_tis_status()
>        tpm_tis_spi_read_bytes()
>          tpm_tis_spi_transfer_full()
>            spi_bus_lock()
>              mutex_lock()
>
> Address this with the following measures:
>
> 1. Call wait_tpm_stat_cond() only while tasking is running.
> 2. Use wait_woken() to wait for changes.
>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Linus Walleij <linusw@kernel.org>
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net/
> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
The issue isn't reproducible anymore. Thanks

Tested-by: Stefan Wahren <wahrenst@gmx.net>

