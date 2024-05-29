Return-Path: <linux-integrity+bounces-2692-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F118D29F1
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C514CB2586E
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B415A862;
	Wed, 29 May 2024 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3yUUzZK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99003632;
	Wed, 29 May 2024 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945947; cv=none; b=ZVUA6SPt6xuNkNs/38SQ1bIhblRmGV0xS797yqXswQUjviLHnTBVJPN4tP/LphVko7upl3RF/nBps+ANplaY3NzwNVIp4Jk0A/5JX8mn7XUXj9JlVNx3jNJK/zhUHLelW67wBHigVCvUVtGoHK3VemOoQPhGTHwD/u1HUZ0Gk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945947; c=relaxed/simple;
	bh=kYSsGE77H18edFCZ/qJ7N+G3t+QZ2sKhNkQqZvYis4o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l0FVb6DAdtHbJqZRl4gNBxTyoQv89O/K+KsApD35pgTkFWSjWp9Utz58CEddmS1+0cnm2Uy2VJ5Wzk8btRQKDf/jsQk6exCw+Ah6X3gpZqW5vZvAxq9gQIfxhu6+pdAOU5bp6XZEMSablWs32JMOq6aAUtgh1w6P94FeqbC6sXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3yUUzZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B3EC3277B;
	Wed, 29 May 2024 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716945947;
	bh=kYSsGE77H18edFCZ/qJ7N+G3t+QZ2sKhNkQqZvYis4o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Q3yUUzZKciCLnR2eeEi7wxqu1gujXTavjGCPMQ/FYBe4d2Gx/wtX+KQ9Ex4F5GgIt
	 BPx7OYRYaGDTBl+nlfw1dM4joMzq7v6fNMBPkWueXVQ0UdSwlUMzU7jtv+31q/F5nW
	 mqIa4WdvV/tS7KNIh0PMBLUD82QcYqVQqeUI2SFmg32LMqzmVa/9+hncM5suqS+suo
	 wEo1+VBFGFlBUTeqPFEsy4LSepsXyIz1uhUhdKn0GD+PDv90I/lvl/9Afg+GZjpgsg
	 TAmONAcWhtXjI4YDtUeDfzqdwYf4HZmlMOWL25A5soEdIAFKOwrD/DfG/lCnqtmTJT
	 hV6MEuZOhiX2A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 04:25:42 +0300
Message-Id: <D1LQJH4GRM9K.DH9M2VYX46US@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Lennart Poettering" <lennart@poettering.net>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-2-jarkko@kernel.org>
 <12cc5fd9-6537-4a0b-b7d9-1221da3bf9f7@linux.ibm.com>
In-Reply-To: <12cc5fd9-6537-4a0b-b7d9-1221da3bf9f7@linux.ibm.com>

On Wed May 29, 2024 at 2:20 AM EEST, Stefan Berger wrote:
>
>
> On 5/28/24 17:08, Jarkko Sakkinen wrote:
> > ASN.1 template is required for TPM2 asymmetric keys, as it needs to be
> > piggy-packed with the input data before applying TPM2_RSA_Decrypt. This
>
> piggy-backed

Right! I consciously wrote it that way, i.e. have used wrong spelling
up to this day :-)

Thanks for the review! This is not likely to change that much. Would
not tag any other patches tho before up to p521 have been tested...

BR, Jarkko

