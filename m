Return-Path: <linux-integrity+bounces-4116-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AF9C7F1B
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 01:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151351F211F9
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC47370;
	Thu, 14 Nov 2024 00:02:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58246BF
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542577; cv=pass; b=tq2IDxugLenyRNHsFvNy1I23u3KkLZ5/aklnsF42UKTRx9/fX9Zl/NoFjr5k5vJj2YSLX34B3RwBo6WUEi9nhRW9ozTZDcIVZYoDH+rZzIJNgnhpEdR/yS+UaUH+LUArdExe8DiKONdlFx2VDgviJp/Eg3H/GNXsp8VbTXOaF0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542577; c=relaxed/simple;
	bh=P0oVs6Aa+K/5w6sJDQJuJKIHcD5IxSfXZCsXJeHttbk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wnp8Fys0ZFdT1icY7NMXNMR3F9CGclWudLoVaiYB3XEQq/n0t6fn8NII1l4VFt4/q06DPx7V8+pocCTuXl5shVeHZwX8GMTTwneRHaEcZxEY0960d8/rTGo40UK2wY9eSfEru1R6zGQSwjYXDYDcApn1Gyl3G2AyCSU2vTHmrSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 35A671A41ED;
	Wed, 13 Nov 2024 23:56:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-14.trex.outbound.svc.cluster.local [100.107.243.58])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id F2A8B1A4BF3;
	Wed, 13 Nov 2024 23:56:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731542193; a=rsa-sha256;
	cv=none;
	b=atWGBBPUB5gYma5DSC1hiS8Q6zvs1P4okltlqrwUnDZVzIzORk522kw4SQLHZvUnkiwg59
	36/1YJ4H80vdQMhLhWNex6ueejHCGjZITyf9f6aFww/1sUNL6KH7IIIHQmjyXITzxawzpY
	oteTKOoXd/v0eUUHq0S62jeGWo8RX+vu9IqHt7x3e5F9eaPoB3Anb9BRbtVWQZDkcvAu/6
	bQ9I93vdPeLst+Do7sGqcppWZnRuehSbGb+mGXK5/0TaCqMSE4FRpab7XfM6uCSyOeuaIm
	Ax/UB0/jL+uRPIHADgmNvUExG+u5Nno/U39+MdeRtPOiZK4Cv668slp8dVO6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731542193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0oVs6Aa+K/5w6sJDQJuJKIHcD5IxSfXZCsXJeHttbk=;
	b=kN0ayfYk9p5z3C0d6+QjDs2xWCZT7CHBj2hcLj6LzE4ZxJ6sBsk/CeVdQKHlUM082qMpgF
	yQDkRDMlrleM4PEQbPe2w5nJ7XBr6r/kzObpi4ZGtotVLrGMeSeVI4kwtbGNunC4CGbj4x
	b6uOCM8KEBR8OaomxnDKYw4xKVIrWzpqPSOV5MXUkKNpeRJ0/N+voWBxO/SXNMYWIk6GAy
	GysAWd72tC40gxi1iMkL9VV1U945Kw15X/zzzZxuNED0Eu0UbgFqxbaSSgfgYsrsB2d5IH
	GYK09SyRXRHu52g3HjgvO4zpTr3yzEIl69jUjyya66GMZcKDgGtDFz/Fh381VA==
ARC-Authentication-Results: i=1;
	rspamd-645676964-62f6w;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stupid-Left: 71c0a112033fb00a_1731542193640_3510987435
X-MC-Loop-Signature: 1731542193640:2550054170
X-MC-Ingress-Time: 1731542193640
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.243.58 (trex/7.0.2);
	Wed, 13 Nov 2024 23:56:33 +0000
Received: from p5b071105.dip0.t-ipconnect.de ([91.7.17.5]:59749 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tBNDt-0000000AfCD-0xnI;
	Wed, 13 Nov 2024 23:56:31 +0000
Message-ID: <c1b56e93bd7e92d5313fde89dc0ee09fdd4c8577.camel@scientia.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Date: Thu, 14 Nov 2024 00:56:29 +0100
In-Reply-To: <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
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

On Wed, 2024-11-13 at 07:47 -0800, James Bottomley wrote:
> That could be more significant, especially with this in the log:
>=20
> > Nov 13 12:33:06 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
> > Nov 13 12:33:16 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
> > Nov 13 12:33:26 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
>=20
> I think we might have to expect the NULL name to change on actual
> hibernation because unlike suspend to ram it does power off the TPM.
>=20
> However, the code that causes the above message was also in 6.10 ...
> are you sure kernels 6.10 and beyond hibernate without producing this
> message?

Quite sure. At least the "flooding" wasn't the case, and `grep`ing some
older kernel logs (these should all be 6.11.5) I get:
$ zgrep tpm /var/log/kern.log.2.xz
2024-10-29T21:03:39.499295+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-10-30T14:23:34.460371+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-10-30T17:50:53.559651+01:00 heisenberg kernel: tpm_tis NTC0702:00: 2.0=
 TPM (device-id 0xFC, rev-id 1)
2024-10-31T14:28:10.449727+01:00 heisenberg kernel: tpm tpm0: NULL key inte=
grity failure!
2024-10-31T14:28:10.529662+01:00 heisenberg kernel: tpm tpm0: NULL Seed nam=
e comparison failed
2024-10-31T14:28:10.529673+01:00 heisenberg kernel: tpm tpm0: NULL name has=
 changed, disabling TPM due to interference
2024-10-31T19:52:23.385845+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-11-01T06:55:20.138812+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-11-01T15:41:22.428940+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-11-01T18:33:47.141633+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-11-01T22:28:13.469085+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending
2024-11-02T06:12:26.424367+01:00 heisenberg kernel: tpm_tis NTC0702:00: Ign=
oring error -5 while suspending

But this is probably anyway obsolete as Jarkko seems to have found the issu=
e :-)


Cheers,
Chris.

