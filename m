Return-Path: <linux-integrity+bounces-2583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA78CD5B0
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50BC1F22288
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439214BF89;
	Thu, 23 May 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z670RNwT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0F14B963;
	Thu, 23 May 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474386; cv=none; b=VD5LdrOsm6MD582WCawTvcnli4eNEvzzpttdTWY2UY9EM3Cg9WmWQsghfBv2SjCZ9q9kK8kSbHGGIT1PR6Dk+XJrqUN4L2nWone5il4JwnU7Z3EdpQJ7/jUwWpe/gKubgq4co2WScW1kh+CGmzMgA35MQjnJm47MeGsqEt3AzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474386; c=relaxed/simple;
	bh=BRelUIXHRNbgKGr9uiec6fA7kfy2IAO96U7wtTdHOvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DM3ljbnksQmvV3K5aBW7qkdNfBOAqVMu1HqpJF4mr9NjQ87udct5CKllkdM7kSeJ+O8fTZZPfzxHgO9IVgl1sqj6f6YxMdPq2SL/fyonKn/VwSpzBSvb6mlByLlIFQ51GrZb/ZrsqC3QqaHYw36jblx+m8YTZDgHlLIc1UTrm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z670RNwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003FDC2BD10;
	Thu, 23 May 2024 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716474385;
	bh=BRelUIXHRNbgKGr9uiec6fA7kfy2IAO96U7wtTdHOvA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Z670RNwTpMiq5Ropebg1SSzUGgmihspQHBUatXA6Zxb38ecj8kvHRNiVQ/rOPyXSK
	 pexclw0Ro64CFUkzd/xtmc9Yctiukv3Ru2Od/yExS6oKWk7lA4Iu3VW1bjmjB10aqG
	 HG+nU6EWLzJxbVScmQG1Ch7AcSduL4lvcYA5Z+SYvBQu/9dIksubwIOQhls82gRqLr
	 fmnih4zlqEArYM/cZE+2zhnRKzX8lDlge1PbvL+tIwsNc9j2k/YgrOzgQmVUxXgFeJ
	 QAtiBUqAeYrqFuwGah49rEAwUTuv5xzb6O7fEHf/lpC4tFRN8JStK5YJ0jRUq3I+cg
	 CRe9ywQ1MSqTw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 17:26:19 +0300
Message-Id: <D1H3DW5XHHBS.3V527WMDQ829U@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Ben Boeckel" <me@benboeckel.net>,
 "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240523142056.17159-1-jarkko@kernel.org>
In-Reply-To: <20240523142056.17159-1-jarkko@kernel.org>

On Thu May 23, 2024 at 5:20 PM EEST, Jarkko Sakkinen wrote:
> There's no reason to encode OID_TPMSealedData at run-time, as it never
> changes.
>
> Replace it with an encoded u8-array, which has the same number of
> elements:
>
> 	67 81 05 0A 01 05
>
> Include OBJECT IDENTIFIER (0x06) tag and length as the prologue so that
> the OID can be simply copied to the blob leading to:
>
> 	06 06 67 81 05 0A 01 05
>
> Since this in stationary place in the buffer it is guaranteed to always
> fit and not further checks are required.
>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Does not really substitute distribution kernel testing, which is
IMHO essential for something like TPM2 boot in systemd but for
simple patches like this, the following does a trivial smoke
test:

export LINUX_OVERRIDE_SRCDIR=3D<path to a kernel tree with a trusted keys p=
atch>
git clone https://gitlab.com/jarkkojs/linux-tpmdd-test.git
cd linux-tpmdd-test
cmake -Bbuild && make -Cbuild buildroot-prepare
make -Cbuild/buildroot/build
build/buildroot/build/images/run-tests.sh

I'm planning to migrate at some point to systemd and make it
appear more like distribution tho..

For recompiling just kernel only thing needed is:

rm -rf build/buildroot/build/build/linux-custom
make -Cbuild/buildroot/build

I've put this also to the MAINTAINERS entry of TPM driver although
I use it also for keyrings etc. Also it is open for contributions
via Gitlab merge requests (not requesting them per se but I'm open
to such possibility).

BR, Jarkko

