Return-Path: <linux-integrity+bounces-4193-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EE9D88E6
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB80CB28820
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACC1ACDE8;
	Mon, 25 Nov 2024 13:49:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D119258B
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542590; cv=pass; b=q1Ihhz0BMOVgt49lnvS0lylp3RDCnh+l94rol4chYgzahu+OpYRSo0z4YHUhKhrPmrIEW+VJrEuIVMSLxkVMq1biS7g9/qlyHQSdXJ/317VveaN4PO4Dbkhf8MJzGCuc3qXg75zaibk2qrhnvszuZJkZnkM19OwojqaUVQutBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542590; c=relaxed/simple;
	bh=VHQtaV/5qNjoYZArCaBfjykdFwaQ/h0uNReLC4UdOvI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=at5BoE/9mjwu2HaeZIml4H5wbENktVOXIy5c2RsVRiSVWUUZP1i1mkkEzNzAj5r883UgvUHq0OGkNgzFa1B2OV7zfCj5EPcLi+00Bf48k4Z6w4dK7FltNpCb0IsR6gP1ehzniXMlx1IzR4v7SqeFFmk85ba+JQUwD93ozVvcXWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BAA8E9412D3;
	Mon, 25 Nov 2024 13:49:42 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-125-209-122.trex-nlb.outbound.svc.cluster.local [100.125.209.122])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CAF079420BE;
	Mon, 25 Nov 2024 13:49:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732542582; a=rsa-sha256;
	cv=none;
	b=rsOrjfrPtZNPfWK9OeXsnXqM89IWZtqvI2gZlnMPIuNAf8lQT2EG8GoLUE7tnPwOqVHfRA
	P8iAOieZgPKtsuTVIXCuUSF11F+jL5PbV+4wds526JkhO4J/RAYmII0uUVTQJFdE7pz8D/
	raWckcy2i3o0kFvaI9UyGxP2wque0j6iZuqW6HTjk7tiYxf/81uyCukSIUrLqht9Jr2Vzo
	Qdkmbfjvo4zkJPKnrk38ip6D2YManjqOmdtvGqm+pfjoVtkRGsm5x5Pxq4D5UWjimJdcH1
	y+JcNbsaU1HlLZR7OFVNHEuyultOesS4FsVNeAtpZbeBVs0ArSq4BHRaQmfzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732542582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHQtaV/5qNjoYZArCaBfjykdFwaQ/h0uNReLC4UdOvI=;
	b=sjb2WAhZ0ySQjpJE9Lhjd05F5LPujtYI6G5PbPnUJuVLKaR4rQIxsKJb6J06v80O5DnLae
	6EiFT9awOd4DlbPbOIlucCs2L3304lmeueLlFFTYhSQ/Kk9m3xTVdiiygVwWL0PcgtlO4L
	OYSh3BF/oUd91g0MiLcRdn0Of39xY9t85l3lcl5XsmXynojAWRASxnW9jy0smYeOyOIuEr
	qLIObU3McU/JziIzt/mBWxWwKBvgSXRNg5TIqV9V5sWaVuXlPJnZzd3wBo0x4+hCNX0Zyc
	UWUT+jEO0qq78Nfta6jsHS7ui05n0VAF4ejXZlpeimG7UKUbdSVI1+IRFOBgsA==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-rdxx7;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Celery-Eyes: 7b5bc2e80200749e_1732542582413_3037724163
X-MC-Loop-Signature: 1732542582413:3479798707
X-MC-Ingress-Time: 1732542582412
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.209.122 (trex/7.0.2);
	Mon, 25 Nov 2024 13:49:42 +0000
Received: from p5090f5d8.dip0.t-ipconnect.de ([80.144.245.216]:60130 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tFZT9-0000000BbrJ-0qMP;
	Mon, 25 Nov 2024 13:49:40 +0000
Message-ID: <05f8e45aad9f3d975653d8e52bb8cc7c7389442e.camel@scientia.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Date: Mon, 25 Nov 2024 14:49:37 +0100
In-Reply-To: <D5LMVWUBX2FK.205ZHBLQKY7SB@kernel.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
	 <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
	 <05f511502a5918fe81d69201ec3df01b25803bcd.camel@HansenPartnership.com>
	 <6b66684616408e2f9576bd5eca5ab58254a69438.camel@scientia.org>
	 <D5LMVWUBX2FK.205ZHBLQKY7SB@kernel.org>
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

Hey.

Just for confirmation:

The patch indeed fixed the repeated log messages after a resume from
hibernate :-)


Thanks again,
Chris.

