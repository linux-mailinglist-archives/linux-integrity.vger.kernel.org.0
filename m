Return-Path: <linux-integrity+bounces-4058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8DD9C0723
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33272824E4
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF720EA54;
	Thu,  7 Nov 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IREtZLrW";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IREtZLrW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F120CCE5;
	Thu,  7 Nov 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985659; cv=none; b=N+fmoOZiHYIPydVYP72b/yrnOnJGcTrrgrkl4JrLs0ExAk2qHiWoS90Xzw82z8jXxJ3pHiJ2gvppqYBeMySXSUJ2ZmEhb6e4/gOpKyUPaUcpRyQSixDzEY1WsiwRGqNrlUXfxwrzJf6LeOxNoyIsrXiBrOCvc9ghpYWZb4dJr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985659; c=relaxed/simple;
	bh=/hIKkyMLrJn4I2+JsuYojwtEsAVODgj3nEdGixCrPkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6Xv8L/456XJcpLlrTB5/MmzCXPuKkAdf6g/lahQnM12+wIsTOw4keHKSsUXR7hKY93qduvTEpE7jiZ79D7zSjNU0TYCbJ40xPWUcRf8gavGIKCHr52JG3zbWYW/dnc/wFO0//jywKHGMY1j+jiH0a2XQnti2QdgqsWlZizdJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IREtZLrW; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IREtZLrW; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730985656;
	bh=/hIKkyMLrJn4I2+JsuYojwtEsAVODgj3nEdGixCrPkg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IREtZLrWGdLMbP8gYjwk6LbsOguaKFhfoP5bXlTMRlXB0Qp9l+kX4NkMR6S3Q5keu
	 Zo4odXhZ294W/2hzIUsw4hy1ExdFQpfl5P1yZV2zK6C89bxH0x0/JuMsc9m9gNHm3N
	 0Ygd5WD+fsZRxej/IjGR/CV8F5TTBLAVjvaAWza0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7CEF11286BF7;
	Thu, 07 Nov 2024 08:20:56 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id kEfJ871_3_8j; Thu,  7 Nov 2024 08:20:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730985656;
	bh=/hIKkyMLrJn4I2+JsuYojwtEsAVODgj3nEdGixCrPkg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IREtZLrWGdLMbP8gYjwk6LbsOguaKFhfoP5bXlTMRlXB0Qp9l+kX4NkMR6S3Q5keu
	 Zo4odXhZ294W/2hzIUsw4hy1ExdFQpfl5P1yZV2zK6C89bxH0x0/JuMsc9m9gNHm3N
	 0Ygd5WD+fsZRxej/IjGR/CV8F5TTBLAVjvaAWza0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5A1591286A68;
	Thu, 07 Nov 2024 08:20:55 -0500 (EST)
Message-ID: <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 08:20:53 -0500
In-Reply-To: <20241107095138.78209-1-jarkko@kernel.org>
References: <20241107095138.78209-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
[...]
> +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> +                        u8 attributes, u8 *passphrase, int
> passphrase_len)
> +{
> +       /* offset tells us where the sessions area begins */
> +       int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> +       u32 len = 9 + passphrase_len;
> +
> +       if (tpm_buf_length(buf) != offset) {
> +               /* not the first session so update the existing
> length */
> +               len += get_unaligned_be32(&buf->data[offset]);
> +               put_unaligned_be32(len, &buf->data[offset]);
> +       } else {
> +               tpm_buf_append_u32(buf, len);
> +       }
> +       /* auth handle */
> +       tpm_buf_append_u32(buf, TPM2_RS_PW);
> +       /* nonce */
> +       tpm_buf_append_u16(buf, 0);
> +       /* attributes */
> +       tpm_buf_append_u8(buf, 0);
> +       /* passphrase */
> +       tpm_buf_append_u16(buf, passphrase_len);
> +       tpm_buf_append(buf, passphrase, passphrase_len);
> +}
> +

The rest of the code looks fine, but if you're going to extract this as
a separate function instead of doing the open coded struct
tpm2_null_auth that was there originally, you should probably extract
and use the tpm2_buf_append_auth() function in trusted_tpm2.c

James


