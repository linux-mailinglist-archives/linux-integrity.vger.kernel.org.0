Return-Path: <linux-integrity+bounces-3487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C796096F58F
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417BBB20C0D
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699021CE70D;
	Fri,  6 Sep 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtRUpSdV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D691E49B;
	Fri,  6 Sep 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630011; cv=none; b=TGLMirorWh2MbrXuw9qZ3vGaxuXS4VOv5JgINk7atQsI43GnKHVv45x1e3GXXGlc8M5SWMNZR6zfe8c4vYw0cBd3mJ9Y+e84WywKzkuC5C3rIxMQTYupIIKJ9m8uKIqhMA7A501IT6sOE0R0lXFmhIOXJqThQUNqnpRqcV5KJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630011; c=relaxed/simple;
	bh=3X47wiK7Z53owlSZ6EkvqXjKfYY8m0qVta1OE1ylsh4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rh2+lP+jBlAVfmszO1kC0j8+P/4C3MinHTLREtAph+HAV6r8vJVI5ixcdMhT7nBollIwkOoaA/InQfh4c0EdO+2AFI1/IsYTKU1jM1rM1owMLuRwVYoSR93je8UaQ69s3Egu9AZtPV6O0z5vV4G2K85gwcE3/iVqacbD4P7upss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtRUpSdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492EDC4CEC5;
	Fri,  6 Sep 2024 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725630010;
	bh=3X47wiK7Z53owlSZ6EkvqXjKfYY8m0qVta1OE1ylsh4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QtRUpSdVRoGcXwVENYf8lux421Hr7+xhFIlobZYRJouGo25hZ7hdqr7xAa1vGV+/4
	 Q886fRhUxmBvmZ+ZNUJK7LbrTjNeidc/pD022y0BS2q9ztrvZ68nDpTehepSgsLTOM
	 1GtBGQiWbCb/+1nTSIiDKTqwD3QTofSpk8UAWU4402X2k1qwyZ7/ULPEQ6XJrpn55t
	 T18yqHQsfbOi/N1iflsKaQwmT4BtQs8iBOGUHMd1yffEtRAFov9d9lbAGHDKx9jy8b
	 TjxvCWNAOxteukoKwcSEDUV/1lzjhB134nfunlRNotn1oUMWfeDD/Fom3OeSVQGjH2
	 I2CnDYMfz++MA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 16:40:06 +0300
Message-Id: <D3Z8S9922SIU.QD22EOW9RGT0@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <wufan@linux.microsoft.com>, <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>,
 <hch@lst.de>, <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>,
 <jannh@google.com>, <dhowells@redhat.com>, <jikos@kernel.org>,
 <mkoutny@suse.com>, <ppavlu@suse.com>, <petr.vorel@gmail.com>,
 <mzerqung@0pointer.de>, <kgold@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v3 01/10] ima: Introduce hook DIGEST_LIST_CHECK
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
 <serge@hallyn.com>
X-Mailer: aerc 0.18.2
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
 <20240905152512.3781098-2-roberto.sassu@huaweicloud.com>
 <D3Z3PDARWOV4.1CBB4U4NW846J@kernel.org>
 <81fd98ce8a43c209e909144a13dcdbf3239e15ff.camel@huaweicloud.com>
In-Reply-To: <81fd98ce8a43c209e909144a13dcdbf3239e15ff.camel@huaweicloud.com>

On Fri Sep 6, 2024 at 2:22 PM EEST, Roberto Sassu wrote:
> On Fri, 2024-09-06 at 12:41 +0300, Jarkko Sakkinen wrote:
> > On Thu Sep 5, 2024 at 6:25 PM EEST, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Introduce a new hook to check the integrity of digest lists.
> >=20
> > "Introduce DIGEST_LIST_CHECK, a new hook..."
> >=20
> > >=20
> > > The new hook is invoked during a kernel read with file type
> >=20
> > "with the file type"
> >=20
> >=20
> > > READING_DIGEST LIST, which is done by the Integrity Digest Cache when=
 it is
> > > populating a digest cache with a digest list.
> >=20
> > The patch creates a new struct imap_rule_entry instance when it parses
> > the corresponding rule, which means that there are couple slices of
> > information missing here:
> >=20
> > 1. The commit message does not tell what the code change effectively
> >    is. I scavenged this information from [1].
>
> Sorry, to me it seems a bit redundant to state what a IMA hook is. The
> new hook will be handled by IMA like the other existing hooks.

I think with documentation (scoping also to commit messages) it is in
general a good strategy to put it less rather than more. No
documentation is better than polluted documentation ;-)

Just remarking what might not be obvious with someone who might not
be obvious, unless being a pro-active contributor.

BR, Jarkko

