Return-Path: <linux-integrity+bounces-5827-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259CDA85555
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 09:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD841B82D11
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446B27E1B0;
	Fri, 11 Apr 2025 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl5wWprz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AF27CCE7
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356066; cv=none; b=ZETMnlt31AgG5SUY/u0yEjuPPsAVHPPaZVuWBIZzRy12rGzdBJ7YVxITiy5gERP3e1hbtw62vBewgmrQgvEhjRo35L9XCn2qBPzMdwQph6AZhRELaamgAmw0UFsId6z6PEHghJBfvAebX64CctKWqMTcp41jPKKtSsq9+N8KIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356066; c=relaxed/simple;
	bh=tfY0+aiphqwjINKWSldhfBgZGc6Bs+gu2iidj5ZXeew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcJn1+qe5n3MeSWd53n/6XGW3/K8b1VqNGY8j/EWCpc8hRONdAD6HSAMVfaNgFymZ1pRBzpg4a/0yn2uh2/HPR0ypxnV6iXnFbQbJuth3GT33SzvCFg0+1y9WWHHfEDAE9vHZDWZ57YCc4cgcLgbPi5vCH/0GwSkcXIO4KxCl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl5wWprz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744356063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU+hARZZfkB6r2YbUGlr1S1PdLPrDG1XB/07xKaVaWg=;
	b=Kl5wWprzx4GotgHjVuqX3FRjqgSCgSN2+mV0gdEjO5uwwGwwg1OaB76Oq76Beq1fZnIPQC
	c8SZbbTFrbF2/M1GVZQ/ozd16x2c7q6a3gOLMNhu9Ylgniy3q+QVjuWQNOBe00znbGSDaX
	p4mUuQj0UQyRwJ+AHi+YJwT3nYYOQIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-yJ2h4kjGMb-_Y9lTPLvm_w-1; Fri, 11 Apr 2025 03:21:02 -0400
X-MC-Unique: yJ2h4kjGMb-_Y9lTPLvm_w-1
X-Mimecast-MFC-AGG-ID: yJ2h4kjGMb-_Y9lTPLvm_w_1744356061
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32a30so699358f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 00:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744356061; x=1744960861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU+hARZZfkB6r2YbUGlr1S1PdLPrDG1XB/07xKaVaWg=;
        b=l22Y6QvPOGBCbeptOq8koucqqzmq3o9nz8ERa9NFanjVHUAw9QIFMyaC0VT0427NxG
         hN19j/jevqduUzOZL2wBurrrSAGqoZeEJa9H09fhtQj2aC4nTiO42zF+2KnkDr87bAN4
         QYEZ7j0cVrj8BOiJQN9YbxJW8PAZzduSOfbKRKpJVBEUTSbP1hD4QlDeZhbnsdBxY/X4
         jLUxw06xRLTvHfdvSXKYbGQ+8YDNFaCbmKTQe8/sdhHmbcZ1aRBqYs0dwMuzOBK4yWtH
         FBYDkQOucu3AJnQlD3UWKtHf814UIZXZq7lUuPBh1cD6yvNZs24XLaCuuJclCCr0xiF0
         QnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQbxR5bFOlWxd3LCAmKDe2z9MJgKOqHJQ+C9Sq/LOWtDaN+sjWjIDQzed5mVFXbFrzVr8wzlc3IaRdGUFeaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDMVshvFMP4rioqfQnlA5I9dOal5ML3vs328rlQ90ADgy+HBA
	ihSyYpdNOOuM5rNs5oGSrRJjwoqSZfVVbfEpT+8BdrEvrJNwXDLjJVcfz4c3/9CGYnSVlO0jK/6
	xRH9n2uuCFAVX8be0DLGwmv/35hTZWawbtzzbPcygqejawvOoDq6Qlmufi5+senQ+Eg==
X-Gm-Gg: ASbGncsHFbOGB9tmH71cpZQyNBQNTVtzLaoYFek91F9Md6gu/XjiH2/AuPTtU849RU7
	a1UVNT/PlFldmYy4iL3T0rxSV2w8qwvvKKT2CAdoQ/TcckcP1X1w/BK8E9oIHxiuc/FUfqf9BI/
	KuadjPldJsjRukoIlK2l5WdtP4VgOrMsFMvQ/0jkYPAMO6DirBqayCZKc8D6165wXBdKeoc7gHO
	y5XAyieLkVlt2cWwQvNc0TTEInFD0EB/xPevZYlRmrnq1yuywO9Al+1Y2vaNO9y50MrC7yC6dgR
	RQXhZM8egwPty1nunAfxUI+lBuKFttU1FNg/ZYarBDb3njLhNCgZELgYGMvU
X-Received: by 2002:a5d:6da5:0:b0:397:3900:ef8c with SMTP id ffacd0b85a97d-39eaaeaa1aemr1401789f8f.35.1744356061097;
        Fri, 11 Apr 2025 00:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2jtPdv16xG1nJWEPcEfUEGfKBbRody2tYk5FP7adbLH4loS3sGojYe46GWuT4PaxDCOT5bQ==
X-Received: by 2002:a5d:6da5:0:b0:397:3900:ef8c with SMTP id ffacd0b85a97d-39eaaeaa1aemr1401756f8f.35.1744356060639;
        Fri, 11 Apr 2025 00:21:00 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cf42sm1146799f8f.64.2025.04.11.00.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 00:20:59 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:20:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: tpm: tpm-buf: Add sanity check fallback in read
 helpers
Message-ID: <6w3lsskngim3x6lx7akwfly3hrrzxyi4pq4itwyye3rywlqum7@oiwkjmvtawl7>
References: <20250410103442.17746-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250410103442.17746-1-purvayeshi550@gmail.com>

On Thu, Apr 10, 2025 at 04:04:42PM +0530, Purva Yeshi wrote:
>Fix Smatch-detected issue:
>
>drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>uninitialized symbol 'value'.
>drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>uninitialized symbol 'value'.
>drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>uninitialized symbol 'value'.
>
>Zero-initialize the return values in tpm_buf_read_u8(),
>tpm_buf_read_u16(), and tpm_buf_read_u32() to guard against
>uninitialized data in case of a boundary overflow.
>
>Add defensive initialization ensures the return values are
>always defined, preventing undefined behavior if the unexpected
>happens.
>
>Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>---
>V1 - https://lore.kernel.org/all/20250409205536.210202-1-purvayeshi550@gmail.com/
>V2 - Update commit message to clarify patch adds a sanity check

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> drivers/char/tpm/tpm-buf.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>index e49a19fea3bd..dc882fc9fa9e 100644
>--- a/drivers/char/tpm/tpm-buf.c
>+++ b/drivers/char/tpm/tpm-buf.c
>@@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
>  */
> u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
> {
>-	u8 value;
>+	u8 value = 0;
>
> 	tpm_buf_read(buf, offset, sizeof(value), &value);
>
>@@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
>  */
> u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
> {
>-	u16 value;
>+	u16 value = 0;
>
> 	tpm_buf_read(buf, offset, sizeof(value), &value);
>
>@@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
>  */
> u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
> {
>-	u32 value;
>+	u32 value = 0;
>
> 	tpm_buf_read(buf, offset, sizeof(value), &value);
>
>-- 
>2.34.1
>
>


