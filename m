Return-Path: <linux-integrity+bounces-6968-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30CB406B3
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AC51A83910
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D88303C8E;
	Tue,  2 Sep 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ7FR6WT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AD305046
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823290; cv=none; b=VqYlJnsMFRwgXgs8YBWhe4hUxdMBgdlQPXfgCp06WBBqJnWyh5+2iP0IVx6Dk8eSBIZrUov9f47zxDEOeTQkyMQnCD/HodaZNjip2E0qUYh5zzoY6qY3ZbYFSmC57Y15gBM0JBK+Gf1wHGdnlgwflYe7sfj5qGKSAnvLsqfopuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823290; c=relaxed/simple;
	bh=pGNW8BtPz7INi8FIla/DDJsQV9EcsI9e30G/EtUw+14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ety3pUCn4VpEQt/vVMPkVMzEBG4vJmETa8ZTiJp158fFKXJzzmoWVelTx6+8j/t9I4uIeb1RZ46xFfcozhfe5V+LEYlCGErdRHofi4Vos49EagIWG3xLq9WL95hHRulQ1Qn1ehDk+QBpwYLwvoABef7s0YiMRRunIm2onXDCJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJ7FR6WT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756823287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGNW8BtPz7INi8FIla/DDJsQV9EcsI9e30G/EtUw+14=;
	b=aJ7FR6WTghUbEnEuJwIJI+STtq4jeyPKBZM6ccsw/jAHZIGKdCX57fYmS3oPSjbaTQCko+
	F7ef5sK0UIBr6vtJJ0giHu5ngZoIa1m9jW4Px89v9R0/gn90ZxsL/bFntHqkYs2UhHVeBZ
	CXc548bONvSipmItOd/VEnXCyc9Bid8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-KShl_D6qP4qRdO2U_fZyNw-1; Tue, 02 Sep 2025 10:28:06 -0400
X-MC-Unique: KShl_D6qP4qRdO2U_fZyNw-1
X-Mimecast-MFC-AGG-ID: KShl_D6qP4qRdO2U_fZyNw_1756823286
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7239ba7830fso17706077b3.2
        for <linux-integrity@vger.kernel.org>; Tue, 02 Sep 2025 07:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823285; x=1757428085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGNW8BtPz7INi8FIla/DDJsQV9EcsI9e30G/EtUw+14=;
        b=m+TJ6dQKMoGCOpXoZ1OMRx5qB1kkMQIV1StHfG8vBWh8AiR37Fy0Re4fY5nei7DI0+
         VQB8gqIm2iU6z2lRSf6w3uX8aKooDJKUYqaQL1wEnGSAOON9Glq8kxnWLzmkdvb0XEAY
         R5fae887mKLIFFZoGwV0C3z1k8egV2MOSzN9rR/ujBXpHMqGx9r1wGyzk6u3bNNKuDOm
         AkwleZjEc5Sz3R4Kejfzlx5ZQs8sKOjgJcu7smL6YJw71C7yBOzcELu+fnbOtTAsKBrS
         g3m4p+/rokivqgEouzbaJmWgGNvKYoqL3LJahFkmvQVo90GvtvIE37CGpXwDjBZsSU4Q
         ft8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc3v4GhDFWBbB4wBTXcoGMjsDrS3ldmFFr97AJKmzUki0n2gK1nv2R4MRkZryOjamNyCdqAfBcNKoGLj0YP+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KeboizgiARTQANTRRC5bcoDb3JT77jcBfP06FqpI04Fahr1k
	7CDeEp2V/OVylcvUnodhSeeSSHlDXXRgJs1lPaHWl5/ku2lmCpT+xb2Qse3P5ZY9nxrtSXZnplz
	m1HUToE8DwUpyThRA/0NbfrE3vP65PiewFVLgQt+NMtzkYJHqmBFQg0+kJqeq42ChhqhiRNfbDQ
	iGoaY5dHAyifr6JVnenXLt6SYqwBJxDeGF4qT2uCKodnl5KiXrLTBZYYg=
X-Gm-Gg: ASbGncv6UFNURHpn/HA/DZ8udDpUWCrEfd/a5DH82TXIvN+vnaQAvkvf4D/1DkhP9fd
	7R2/pR7p2FaBWQ8aaENY2OCVcP/myG+6EYpqCoQhSy2k2AIFgL8PUhYW7y0kaQaeDg10xt6IH+P
	+J80QdeAOmXtYT6WJ4URiautMw6SV0eXR5iX/dhXmxf9PrgB9sp9Eb5Q==
X-Received: by 2002:a05:690c:60c3:b0:721:5b31:54cc with SMTP id 00721157ae682-722764f8b0amr129554477b3.31.1756823285241;
        Tue, 02 Sep 2025 07:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuIXfOEO9H88D5KUVHWKykLlu1ftRVEkK94eFzphkSJsdf6VJGivVIZgzSANbEDIHlURc8stokt+0XErucAg4=
X-Received: by 2002:a05:690c:60c3:b0:721:5b31:54cc with SMTP id
 00721157ae682-722764f8b0amr129554197b3.31.1756823284848; Tue, 02 Sep 2025
 07:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829175152.9704-2-daleksan@redhat.com> <aLMGm9tf2mEdI_YX@kernel.org>
 <aLMHoVFj_jvsom_Q@kernel.org>
In-Reply-To: <aLMHoVFj_jvsom_Q@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Tue, 2 Sep 2025 10:27:54 -0400
X-Gm-Features: Ac12FXywFTEbjhWLvu9vCoJvXnK_x-MO-7dinZjZZcYQPR7ZuHmmOyqYEgW8l7c
Message-ID: <CAG+gbFdEdEfUxfAUsNwsaWyHz-WzOx9bnBF+mqkuUnR7T_tBsA@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko,

Sorry for the delayed response, it was a long weekend here in the states.

Thank you for the continued feedback!
Just sent over a v4.

Cheers,
Denis


