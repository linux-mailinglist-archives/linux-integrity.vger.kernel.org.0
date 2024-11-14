Return-Path: <linux-integrity+bounces-4119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66669C806C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 03:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E0B283CA8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322A1885B4;
	Thu, 14 Nov 2024 02:17:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from donkey.ash.relay.mailchannels.net (donkey.ash.relay.mailchannels.net [23.83.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBC5336E
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550638; cv=pass; b=Kp4nZNcqZ3InU/IgLvdqDIBoW+roblZ18OK8wPW+eTEaJ1lJhmGAe9q6UbKaNW0BkyokGDOLUPMwvqc2PGWMFSKwMCjTfIf1jBOAKIB10mE6wjNG3Ebfv5G4GkMX4zfYuxlynEtbIBMqA3XzFjjdRs0S8RqwA8/adcNzhdYPqxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550638; c=relaxed/simple;
	bh=Ju4+NANyu8LnKcnarb88PBKfMhzxRBD+bYnlLN59i8M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtIwL0SUgQEwEvKgtrb9OH4GRbfy/O2e+czxwKLLPd2DDEFhUe7F7z1OVQ5dP0pxf1zaUA/f+x9EiJO/5Ak2wsH0plrr8ok3Xv9NwBYrVNWyXpd7HMJO/VQ05TG1rBInvcDsAr9MA0fiCEDh4Qjos8ByOfavY1a5HAAlJnR+ObA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E4AD583EE6;
	Thu, 14 Nov 2024 02:17:08 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-112-138-111.trex-nlb.outbound.svc.cluster.local [100.112.138.111])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 32A1D83F24;
	Thu, 14 Nov 2024 02:17:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731550628; a=rsa-sha256;
	cv=none;
	b=K4xtv6FQZKYwENIhNxNh3ZuCA2+s+aty2I5BGZZ/tDZcKF64hbaFXR68AJKDBy1LQectBZ
	vO6BlKtTR4Ne4it4eoQ3MeE8CBqTpW5oP+SV/i7axblQuYtfypgfishoxCef7kE/jaCs39
	9/EflTsYWLqQnCYFiKCjjAT6oUCvPDkE8HSQ090X/g8GM2vijQ/KoKIKF3QFmrd6g3AC9g
	L5O5XvbW2DEv5oSlyzfhtALmTlSSvSdDV0geQH4eQMXoQ5I8b3vVC7pbGZxVeff1zpgGxw
	8I0uvO7IHdnWe4fufFJEuaXZQwwV+clWox7IQR55q9mi2jGewOX3n1iRAv+4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731550628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju4+NANyu8LnKcnarb88PBKfMhzxRBD+bYnlLN59i8M=;
	b=gz+08xVVBF9vVO+2sovAPbb8rJFrsBM3fDBHgcRucijoIYDYEQnYMGwfFI4X+2tUdYrdrz
	OPiHbbnisl9A8752ATL2PQbWaP7pCqbbZqCNi9hdKaOUnNGeHjNJHwj2Uwl9zr/QR6w4/d
	u66YVqrhZlUgs9z4wt+tXlcy2YN4VBrfiYER+szoY+aog2cweHjJ21vkc3V0Bp6WwmEato
	jUS5+nntgjT1Pu+5m1mISOFeomoiR0lVCqj8Q06/Vg3ur/ZmafjYdsytgppfjdOH+/YkwB
	wbS7x6AuHZx08TTL7YNtX0P+yA4YJGvotaVvCFKs0MfQs9UFO2OQlGg2AzvJqg==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-rppzn;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arch-White: 16d41f176d1576a3_1731550628812_1351477993
X-MC-Loop-Signature: 1731550628812:2697194632
X-MC-Ingress-Time: 1731550628812
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.138.111 (trex/7.0.2);
	Thu, 14 Nov 2024 02:17:08 +0000
Received: from p5b071105.dip0.t-ipconnect.de ([91.7.17.5]:63657 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tBPPw-0000000BAGB-3CIb;
	Thu, 14 Nov 2024 02:17:06 +0000
Message-ID: <6b66684616408e2f9576bd5eca5ab58254a69438.camel@scientia.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Date: Thu, 14 Nov 2024 03:17:05 +0100
In-Reply-To: <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
		 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
		 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
	 <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Wed, 2024-11-13 at 18:06 -0800, James Bottomley wrote:
>=20
> Getting the TPM messages to quiet by disabling the chip fixes the
> message spew, but it doesn't get you a working TPM chip back on
> resume.
> I'll take a look at the hibernation path and see if I can see a hook
> we
> can use to bring the TPM back.

Sure, but actually I don't use TPM anyway so for me the main point was
really just the nuisance of the repetitive log messages O:-)

Still, it would of course be nice if you get it properly running after
hibernation.

Thanks,
Chris

