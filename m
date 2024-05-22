Return-Path: <linux-integrity+bounces-2555-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ED78CC316
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E761C20848
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496813DBA4;
	Wed, 22 May 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r+rFsDCd";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r+rFsDCd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B61DA24;
	Wed, 22 May 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387655; cv=none; b=l0QGEett0b3xAW4K9s3WhxVjW8mW1l4OnewQXOPPZpiYa27C4ThiLgVBBBZYb/NmWIkgt8Y6d9BQ9LrxtkqKVBYEbXcClD8/bMfNB8BLLw78i7ghdMWfoxGz4HRdKOEr3/TgEPXqGqohVWU1rR30lMA4hwkfBylj2xAKDMNQ9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387655; c=relaxed/simple;
	bh=Qc2gAd8MhG2yEXYE7B6LNfnOPeSvf72pmI8Uv8VVHsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IP7uPK+JrBGIcA3qY4RU7YUCNKwQCWtm7g2oIkVeaHsm+MhNl9dhCF1UBXtRqyOU6rVWejyN3wuwfaJZPFzY9Aj4go9bH9VsbP/J0sCD0xFHl5lZJRuPIRGyFoOuFmn+Q53jBCcV+STbz4aGvBZIxv0Wvu4LRcI6cOtX4DAnpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=r+rFsDCd; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=r+rFsDCd; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716387652;
	bh=Qc2gAd8MhG2yEXYE7B6LNfnOPeSvf72pmI8Uv8VVHsc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=r+rFsDCdSs8ltgw4K0M1in9P1eGZgGIFHGqu7ywLUvUZs5+xMD7sZcWWRS7gk0JSa
	 FMJvyUuikxXvuVaN05PyWReX7Vvv2saOs8m/miwq4uKqPp6baal2ijUV03Xg6fmP9s
	 dSQu430/VC2/LVC7QbjEWBvMowpFmAQWlmnYyaVk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A37FE128136D;
	Wed, 22 May 2024 10:20:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Sds60rMqxxQH; Wed, 22 May 2024 10:20:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716387652;
	bh=Qc2gAd8MhG2yEXYE7B6LNfnOPeSvf72pmI8Uv8VVHsc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=r+rFsDCdSs8ltgw4K0M1in9P1eGZgGIFHGqu7ywLUvUZs5+xMD7sZcWWRS7gk0JSa
	 FMJvyUuikxXvuVaN05PyWReX7Vvv2saOs8m/miwq4uKqPp6baal2ijUV03Xg6fmP9s
	 dSQu430/VC2/LVC7QbjEWBvMowpFmAQWlmnYyaVk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6C4B21281294;
	Wed, 22 May 2024 10:20:51 -0400 (EDT)
Message-ID: <0d925d801d8988bb55afa476fb0564b052d54e62.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Vitor Soares <ivitro@gmail.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 10:20:50 -0400
In-Reply-To: <D1G8FRJFBBAO.X8CAFK3K34VJ@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
	 <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
	 <D1G8FRJFBBAO.X8CAFK3K34VJ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-22 at 17:11 +0300, Jarkko Sakkinen wrote:
> For tpm_crb we should actually disable HMAC at some point. It is
> essentially a performance regression for it.

You'd think that, because of the shared buffer and no bus, but you
never quite know.  For instance several confidential computing early
implementations used the crb interface set up by qemu (i.e. over shared
buffers which are readable by the host).  For them the only way to get
security is with sessions.  Even with the default Intel CRB, the TPM
transaction isn't handled directly by the main CPU, it's offloaded to
the ME (which we all know google loves because of its tight security
boundary).  It is entirely possible to imagine a software interposer
running in the ME snooping the CRB buffer.  A very different type of
attack from the LPB interposer, but plausible non the less.

James


