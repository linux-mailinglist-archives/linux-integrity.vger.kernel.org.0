Return-Path: <linux-integrity+bounces-2645-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEA8CEF20
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751911C2096F
	for <lists+linux-integrity@lfdr.de>; Sat, 25 May 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594BC43AD6;
	Sat, 25 May 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VtwIkuKh";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VtwIkuKh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB1E480;
	Sat, 25 May 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716644528; cv=none; b=tgUBkMQuKEAWmnPIRYAyidvQI8ln6haQkZyqTSz8Tq/UblDMfFGZN4S9oCMQR5WpceWhbYrkRIHiTwyobCL25uBRW0qUd0I5FXZIw1sGo1U9BdUa0GjgdnSWb2tFP7qPsyvHsT1xbBPD1x/BROqEpynzs1P3n4EhKmEjU60DcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716644528; c=relaxed/simple;
	bh=amI1SPYRnBjM8Ew/R6TtCgxDdWD5U2OLyaFMWH/xHco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aa1MMQQLBgU5qJ0eBmBtTOBfknBd+HJDXf7QKzay6smJ/8R1wudXxA7AgcXP+fNY99wXZ5W+y2C1G7D/ZiaRJNLQIcFthWDhYMjToySBWgzMVdnZP8WfkY9doUvzZAZ5m2Z8oP/X4yXjN0HimND+Wc6prxWQj4GoqMAHBTVLRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VtwIkuKh; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VtwIkuKh; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716644525;
	bh=amI1SPYRnBjM8Ew/R6TtCgxDdWD5U2OLyaFMWH/xHco=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VtwIkuKhcA50/tF3DmtgWWcszs8/cLEA02WPuZLwtGVta7DLVEO8WmZkDFCORIqsk
	 M6F2y02YGWSrUrh4IyyC1rabzA8T7vAvMA5F4a6PBtoo6n2rbDP235Ww7vJVEqlYtz
	 WCiaJ6fKL3qM5CCSGUtQApDaVgwDKWg4VEmYbi5o=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7818B1287ABA;
	Sat, 25 May 2024 09:42:05 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 1QvmScxBCgUX; Sat, 25 May 2024 09:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716644525;
	bh=amI1SPYRnBjM8Ew/R6TtCgxDdWD5U2OLyaFMWH/xHco=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VtwIkuKhcA50/tF3DmtgWWcszs8/cLEA02WPuZLwtGVta7DLVEO8WmZkDFCORIqsk
	 M6F2y02YGWSrUrh4IyyC1rabzA8T7vAvMA5F4a6PBtoo6n2rbDP235Ww7vJVEqlYtz
	 WCiaJ6fKL3qM5CCSGUtQApDaVgwDKWg4VEmYbi5o=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5AFC01287AB8;
	Sat, 25 May 2024 09:42:04 -0400 (EDT)
Message-ID: <b1ac7ec116c871294d856185da44ae1e9fc02fe7.camel@HansenPartnership.com>
Subject: Re: [PATCH] KEYS: trusted_tpm2: Only check options->keyhandle for
 ASN.1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, stable@vger.kernel.org, Mimi Zohar
	 <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore
	 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	 <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 25 May 2024 09:42:02 -0400
In-Reply-To: <20240525123634.3396-1-jarkko@kernel.org>
References: <20240525123634.3396-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-05-25 at 15:36 +0300, Jarkko Sakkinen wrote:
> tpm2_load_cmd incorrectly checks options->keyhandle also for the
> legacy format, as also implied by the inline comment. Check
> options->keyhandle when ASN.1 is loaded.

No that's not right.  keyhandle must be specified for the old format,
because it's just the two private/public blobs and doesn't know it's
parent. Since tpm2_key_decode() always places the ASN.1 parent into
options->keyhandle, the proposed new code is fully redundant (options-
>keyhandle must be non zero if the ASN.1 parsed correctly) but it loses
the check that the loader must specify it for the old format.

What the comment above the code you removed means is that the keyhandle
must be non zero here, either extracted from the ASN.1 for the new
format or specified on the command line for the old.

James


