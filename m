Return-Path: <linux-integrity+bounces-5839-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D213A85B23
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0789C15EE
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA93238C3C;
	Fri, 11 Apr 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geR8o2fx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C2278E7D
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369486; cv=none; b=HCGSF8DxYy7YB82NYYCnbqECyNdq7sADls6W7UAR1Rn0xNtW7F8i8JLy7nQ4hTV2FymHGF6gTDCXXRu0e77sAS26HxABmepNDmwDiAONuqQPiO7Bt29ZyGlpIKXixijJ13Yuku5FDD/pRSDqQ/NikBE2xtghzuVT5DJSJIn2vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369486; c=relaxed/simple;
	bh=uajPRHBnqZI1GLJPzOvGXLNfqLZjpi3CYEOATO+vZLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvf8uB+IaJprggvdVarc4fF9z7ReW8Wwy/q5+YvsCMWpis7KGb0zwYpMoAQW2OGdzqn9cuWxpMDeNcHT1nzeeks0exeavwg7HunTuP0JK7A55Bk6W7PKAXtfUbbSc50SWEFWval4SuB9mElSZiwZwsCVDABOyvB5pJFi1AA3Iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geR8o2fx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744369483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kGVLAUeqeImzVMPUUHLx3PpuM44ltlLh5qZ2mrd1cZM=;
	b=geR8o2fxNIR2xkmAznrUePcB12LgJgSwxyaUysWAtsoEMUWEunReiGyUSRvbXaX640mLTU
	0LEpH/jsi9D/AxKfmHGknbP2DfyGkuVBj8IXMYLTurIZun/QCi6bI99/A3eHneb4h8j2Ma
	xx8cFjOwt+oeUKc7Yoztj+YEnH3LARE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-er8LYg_5PVqTYXxyrkFxUA-1; Fri, 11 Apr 2025 07:04:40 -0400
X-MC-Unique: er8LYg_5PVqTYXxyrkFxUA-1
X-Mimecast-MFC-AGG-ID: er8LYg_5PVqTYXxyrkFxUA_1744369479
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e6eb748b17so1686548a12.3
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 04:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369479; x=1744974279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGVLAUeqeImzVMPUUHLx3PpuM44ltlLh5qZ2mrd1cZM=;
        b=LY4XLSymTPiarb6Gn1Z3dnHx72ST1w7fF1ftk2qVuIgL4WOW5SPZoT+YRn8dqkWDVp
         +uL/0nzD2UXN7asuXan5txQId8OJ5dDUVSWsxIrNG+hcOv5Gj6TpnJjYWAuHZasV7xQS
         NbfOZLVFOnfpB6Qc7PgAYgJC4cINxBYTGht8qeRyvoPSZfZrmXz5tYbNIVxTjwcRutvp
         TD3cS9+hqCavbBahO91qoQ3Taybv9VE/evLUBSmGy6fq/90lx2sjn13gk5n8XQnthGtI
         xYkrr1DH4M9tISLwFyFJSAElmMZguaRiPVX96N1VyC0sSdlCbSqmod1eSEKNs0CNhM5S
         mo0A==
X-Forwarded-Encrypted: i=1; AJvYcCUFPaWQ8SKg4X/vjQPSHGvG7oy6cVq81iR5/w04lGkXhlN+GwbGdYuo/f/pyxRGtPOjRzro7Iazm4nz+uQQKcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PRI4NM77tRXcXBicuPuLTXtKDmcBzdtPWTUU6qyQHUtXJvSN
	sms5TN6jogvXmRwcgJpyzPCHHFFihJfQgLeapZtFUCD35xVcc2kA0XrMzfNoO7S4UuDuE4BZU+G
	sonu/VNWJeojSYOf7QGQj8DnZb5JAE6MOKFKjRumJx3XZyWsC7cIBhkkrg/o6puC9nw==
X-Gm-Gg: ASbGnctrv7S5obApFgtGbsVH4GS+EFz4q6nzatgF6FRjCybxL26ageYJV4Fpe+Si3kx
	1cJ/zUcZo7Jf2N0xSxVPqc+1bst4185eojS3RNvjRH87bsWMqfDEEsRX/hqwBlVwwqC9G5s7uy/
	31xLWRL6cmwhONEyrxg5L/Zu/dnhs6Yu0SCqsmo6mxhZK4PbbZAH6Nxhc6s5fIVTKhECWKNcl6r
	2DFjwEQm8AQx32Aji0fpXxQA8I8nsHCKuupNmvtlQQC7Q5llPdlM9ay1e54QGJj6WXFadFruPW+
	VRDfUQktVNb3d7rsgIhWNaLBXps7SR5Lntx4HPz8uB5W28AiY8NyPHTLaxGZ
X-Received: by 2002:a05:6402:1cc1:b0:5eb:ca9b:523a with SMTP id 4fb4d7f45d1cf-5f36f875f21mr1560996a12.20.1744369478843;
        Fri, 11 Apr 2025 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5wveEInHxoECPogDCN2NO4egDXj/9R9QDpAb6OOjFUgGUjCqN/ETz/GFkKwlRbfEfCyqyrA==
X-Received: by 2002:a05:6402:1cc1:b0:5eb:ca9b:523a with SMTP id 4fb4d7f45d1cf-5f36f875f21mr1560937a12.20.1744369478233;
        Fri, 11 Apr 2025 04:04:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f507687sm797137a12.56.2025.04.11.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:04:37 -0700 (PDT)
Date: Fri, 11 Apr 2025 13:04:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	peterhuewe@gmx.de, jgg@ziepe.ca, stuart.yoder@arm.com, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <xixqxrt6anogjj25jq3774bmjoeb3jzxgtez7affpewq2cuqib@qnq6cv4g72kp>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <Z_jw6z_2k0vzqyK_@kernel.org>
 <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>

On Fri, Apr 11, 2025 at 11:43:24AM +0100, Sudeep Holla wrote:
>On Fri, Apr 11, 2025 at 01:37:31PM +0300, Jarkko Sakkinen wrote:
>> On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
>> > For secure partition with multi service, tpm_ffa_crb can access tpm
>> > service with direct message request v2 interface according to chapter 3.3,
>> > TPM Service Command Response Buffer Interface Over FF-A specification [0].
>> >
>> > This patch reflects this spec to access tpm service over
>> > FF-A direct message request v2 ABI.
>> >
>> > Link: https://developer.arm.com/documentation/den0138/latest/ [0]
>>
>> Sorry, did not notice in the first round:
>>
>> 1. Does not have "[0]" postfix.
>> 2. Only for lore links:
>>    https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org
>>
>
>I was about to comment on the presence of link itself but left it to
>the maintainer. It was part of the first commit log from Stuart. If it
>is so important that it requires mention in each commit, it better me
>made part of the file itself to avoid having to mention again and again.
>Just my opinion, I leave it to the maintainers.

I agree on this.
Also, are these links assured to be stable? Could we just mention the 
title and version?

e.g. "TPM Service Command Response Buffer Interface Over FF-A"
      Document version: v1.0 BET

Thanks,
Stefano


