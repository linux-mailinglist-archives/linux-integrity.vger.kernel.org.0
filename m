Return-Path: <linux-integrity+bounces-3557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59D977DE2
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E335C1F25A5A
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE21D7E5F;
	Fri, 13 Sep 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCesijiR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C01D7E39;
	Fri, 13 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224383; cv=none; b=hS65T82EXrSjawsMwRzD3VNRHo2Y2q+uOWzNT7uUbEUX64a/8e1RIfbr33MrFm6j24iRIqDCZEwN9AN6rerHF/ESijvPhehMCk8hfA9yi+Jjxc+qiL0umtepd8GYtCz+QyZRdkyz153fXG5/YMxxZnwQWLxinO4j9AE4Jf9KaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224383; c=relaxed/simple;
	bh=S3OfFPhvngzIXVIBvvu2VJ7Ne9DtASb05dIPumrAuGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVQV6Ubx3ptMeyUN0tT8O7ZmO/xgIQnn/I8Ee74AP3BNM35UQBI8QiL9nuzghXKge+d5n6kfBsbtVrtLIjmiboqw30UtYl0/rV+KUtQ4N2cbjLuTB+mucGHVNWgEb5Lv4wCF0T/+ob5daD6PabwP3AvyHcfMyYTYbvQD1FI9Ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCesijiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A22C4CED0;
	Fri, 13 Sep 2024 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726224382;
	bh=S3OfFPhvngzIXVIBvvu2VJ7Ne9DtASb05dIPumrAuGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PCesijiRN0EG3csPIokYtW3nnlsM02Sn8/crXyeded6Dwiab1FXZ1fvHFnj32e9UD
	 cUpXq9+9gb60uH+AhkYtovgYOFsLDU2WvffuKLjvouAEUdvtELf8wLcUFpeHcbx7UE
	 PQRmFs+U5Oaa0v1kQ6ALW5DOePB1fBbdgCS1l4awJ9RecUVQQidV/f/6/CVaZvssFR
	 9pLsHQ0AA8fyZh64QFPAmLTZOMJ5OnOGzfpFynP8FAX1vINw2F1j0K34I4XiMXX5Y8
	 AnOGx3kl3u0eqy8V5gzcrzME/JZ336CG29Z3URffZrBjoA79xZam0o+VvZqNjuhuY4
	 BRMp/RZi+BS3Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so24190331fa.3;
        Fri, 13 Sep 2024 03:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtjXwnFTNIuWnSbnkUwh3mG3eK9s80i598NqBybOM9WFflbthvaSQWT/sI23aDneB8mZCIDM+YDQLKVkBX@vger.kernel.org, AJvYcCUxlrTIMOpFB/UGvEnX4EaxQWiD2lHaNEILJooPdrIhFCtINDH8U2/jPJQxg2G0rbD6Q7BTyPkEccIO55kD@vger.kernel.org, AJvYcCXIHqZUR184CNDIy8QLX2hEkhyAs0T+fhGvgyWME+slirwUQprRnxfVIDWez3vAlwJ97UkQ4l3Cyw==@vger.kernel.org, AJvYcCXsvIfTLerldLa2wE4EUT769Y8N8i/BevX+aQ6HjWbIAv1j/whDkaAwxlbAv6SCG7OoDGHTGzzL2myKIknLJEce@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUcLhFUar0QGK9HSPfpf6X9uw0wPDOW8TOnshNJYQhbv19RF1
	5luUdTsRwJFNZ7u7ywM40DmK0ftvRKVaTxydIjWxdrTSABfosIyW6ovFn80ms3T0TA+hf5ZmaDd
	AK13nl3cc9om3s4u8tZnjX+Q76js=
X-Google-Smtp-Source: AGHT+IHgfCxPiT5vZMtaQepta9uqXpG4/5TNPzFxOmRXvEQwfvgwsKyWmN8/Fya2mEuSKQsg4t5AMIdDxMekLTQEEkM=
X-Received: by 2002:a2e:1311:0:b0:2f3:ed34:41c9 with SMTP id
 38308e7fff4ca-2f787f32dc2mr26801081fa.37.1726224380930; Fri, 13 Sep 2024
 03:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <1266435.1726219950@warthog.procyon.org.uk>
In-Reply-To: <1266435.1726219950@warthog.procyon.org.uk>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 12:46:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8nWtAzX+9xc2tLyy5d0w==JNQCMJBAbL=LdcF+XrYkw@mail.gmail.com>
Message-ID: <CAMj1kXH8nWtAzX+9xc2tLyy5d0w==JNQCMJBAbL=LdcF+XrYkw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, dwmw2@infradead.org, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, torvalds@linux-foundation.org, 
	roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 11:32, David Howells <dhowells@redhat.com> wrote:
>
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> > Personally I don't think the argument above holds water.  With
> > IPsec we had a similar issue of authenticating untrusted peers
> > using public key cryptography.  In that case we successfully
> > delegated the task to user-space and it is still how it works
> > to this day.

This is slightly disingenuous. The kernel itself has no need to trust
the peer - it only manages the network pipe and authenticates/decrypts
the packets on behalf of user space.

The situation would be radically different if the kernel itself would
communicate over IPsec (or HTTPS) directly.

Likewise for module loading: there is no way the authentication can be
delegated to user space, unless that user space component is
authenticated by the kernel (and runs in a special, hardened context).
>
> It transpires that we do actually need at least a PGP parser in the kernel -
> and it needs to be used prior to loading any modules: some Lenovo Thinkpads,
> at least, may have EFI variables holding a list of keys in PGP form, not X.509
> form.
>
> For example, in dmesg, you might see:
>
> May 16 04:01:01 localhost kernel: integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
> May 16 04:01:01 localhost kernel: integrity: Problem loading X.509 certificate -126
>

MokListRT is a shim construct, which is a component in the downstream
distro boot chain. It is not part of EFI, and in your case, this is
unlikely to be specific to Lenovo systems.

> On my laptop, if I dump this variable:
>
>         efivar -e /tmp/q --name=605dab50-e046-4300-abb6-3dd810dd8b23-MokListRT
>
> And then looking at the data exported:
>
>         file /tmp/q
>
> I see:
>
>         /tmp/q: PGP Secret Sub-key -
>
> The kernel doesn't currently have a PGP parser.  I've checked and the value
> doesn't parse as ASN.1:
>
>         openssl asn1parse -in /tmp/q -inform DER
>             0:d=0  hl=2 l=  21 prim: cont [ 23 ]
>         Error in encoding
>         001EBA93B67F0000:error:0680007B:asn1 encoding routines:ASN1_get_object:header too long:crypto/asn1/asn1_lib.c:105:
>
> which would suggest that it isn't X.509.
>

This should be fixed in shim not the kernel.

