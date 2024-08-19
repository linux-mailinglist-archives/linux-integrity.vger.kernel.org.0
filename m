Return-Path: <linux-integrity+bounces-3358-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E559956E4B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31E4B259A2
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEF176233;
	Mon, 19 Aug 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="IljbFUz0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF6173355;
	Mon, 19 Aug 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080115; cv=none; b=rz2lWkrbqX0TuPUIFBT8MCFQvOBFQIZlZSd2Nw9v3W39uHtp7uyH6YyhKuxAOkiqAiFeFw2bNVINBkG0oQTkxaRLZT/0PazSHjYFt6cOJeRCSjspFcCJWEpH4UQ1gd/H6QIZWPIs/HIzI1fwWAhUruna91f8UoKFjjmZXT4hL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080115; c=relaxed/simple;
	bh=Qs/PzgbBLKl9GKa7HqJ3zp5F0p6hsq+CPvYp1Ln9pQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmoXuBU0+J0Vv2Bj/Iec77ZzrWC5rlG0CjKmFAtC8DdgHCb2CMdVtzl34OTzwey/ncJE5ylY3HWtt9Ao4vIX7H+dAljAOuMwc1OuBQH3PLzabB6w9nYN7HfEOteEHnZ4ySekkxAnEWey26d03nmIIomrhBqFMi8v72CSVrUywN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=IljbFUz0; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZQC4WINccEO2UXpIPJEtJ+/+AN4HEc5+AcWFTyZ8nIc=; b=IljbFUz0sEd/7RJK5hFlLdpQZj
	o1WZNRbIZV+gMIT/hLLuW9sl1P+/q0yIoZ42perXsWjS1Beq1/b30iZTMNvrh0zBSNZa8vl+5Ivd7
	m3rSfhJB8Z59cSDtz5p3V6gNhH0uP2ed+0mh8Sp+m0N0+yKZjecT0BWXRSUqYECFieOyK2pEkhz2X
	JJntJa7iZakI+pyL36mfigQ/FNx5mHKPpF/4P3D7C1RcoDD6GMLqJv03hD2qVfEnwEwxIRKOExBS3
	JDeGuAwOCeotfNXuq2/r3Hvpb+s9Fo/KAPsVljHs2Uvyo9JhUawEA1sYQQo5zsxJlCl0g8OKl6xq4
	vqw9rVnQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sg3zJ-000NIB-1a;
	Mon, 19 Aug 2024 16:08:05 +0100
Date: Mon, 19 Aug 2024 16:08:05 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZsNf1VdfkHqD8R4Q@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>

On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Support for PGP keys and signatures was proposed by David long time ago,
> before the decision of using PKCS#7 for kernel modules signatures
> verification was made. After that, there has been not enough interest to
> support PGP too.

You might want to update the RFC/bis references to RFC9580, which was
published last month and updates things.

Also, I see support for v2 + v3 keys, and this doesn't seem like a good
idea. There are cryptographic issues with fingerprints etc there and I
can't think of a good reason you'd want the kernel to support them. The
same could probably be said of DSA key support too.

> Lately, when discussing a proposal of introducing fsverity signatures in
> Fedora [1], developers expressed their preference on not having a separate
> key for signing, which would complicate the management of the distribution.
> They would be more in favor of using the same PGP key, currently used for
> signing RPM headers, also for file-based signatures (not only fsverity, but
> also IMA ones).
> 
> Another envisioned use case would be to add the ability to appraise RPM
> headers with their existing PGP signature, so that they can be used as an
> authenticated source of reference values for appraising remaining
> files [2].
> 
> To make these use cases possible, introduce support for PGP keys and
> signatures in the kernel, and load provided PGP keys in the built-in
> keyring, so that PGP signatures of RPM headers, fsverity digests, and IMA
> digests can be verified from this trust anchor.
> 
> In addition to the original version of the patch set, also introduce
> support for signature verification of PGP keys, so that those keys can be
> added to keyrings with a signature-based restriction (e.g. .ima). PGP keys
> are searched with partial IDs, provided with signature subtype 16 (Issuer).
> Search with full IDs could be supported with
> draft-ietf-openpgp-rfc4880bis-10, by retrieving the information from
> signature subtype 33 (Issuer Fingerprint). Due to the possibility of ID
> collisions, the key_or_keyring restriction is not supported.


J.

-- 
If I throw a stick, will you leave?

