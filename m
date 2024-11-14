Return-Path: <linux-integrity+bounces-4117-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450389C7F20
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 01:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C44B2103A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2024 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D21FC3;
	Thu, 14 Nov 2024 00:05:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364081367
	for <linux-integrity@vger.kernel.org>; Thu, 14 Nov 2024 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542704; cv=fail; b=CrIQ6nE7Wtk427iE/fRtCFOD6ZehdkXNkn/d4uJcz+CRoCiMajBy7/fUjEbZQdTZqVUFukXAgB5Seg5Z+jAYSmIdQ+NRI6vO4gago8/GrDUBicxEQaSgerpJhbLBh07A10eiAnqRmunx7TtwUIwaPDiL90Boz1L35BXk5PQ3yqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542704; c=relaxed/simple;
	bh=pLxEuiaxgMJnwWXMzCW2c3r4qRbtiGrdrQUiMznr6sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUevwO7ikLmRbPbz/ABfPzgo1HozHeMgr3xe8ew4+my92dO0+4q/83pHwYfx0HptZfx/Y7C805l8IH+lUJKzpFv1BV6OLVvUyNaqFNbH9K2Kle2+YlpWEg5WbnDdYS36z3xhJVomRzf3npqbwpp+IKTUsJXkz37j1zG+TD0LGYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=fail smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9D66B181ACD;
	Thu, 14 Nov 2024 00:04:56 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-112-196-227.trex-nlb.outbound.svc.cluster.local [100.112.196.227])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8A1151826C0;
	Thu, 14 Nov 2024 00:04:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731542696; a=rsa-sha256;
	cv=none;
	b=ohjrnKeMB2kXfuh7DxAHQcDlpnOf83MP8qogKMmoBVRMb9Yux9B/IqxHUUHmic0UKU6jd0
	ZhisjlyIsnX/BLgIG7A5O8sxqtZlJc0nNPkWtpK9UsMxWD9JH2o97+RedYhYNi7ed4d32R
	HnNE3V4GmAHxtNaMRFau+n8a2awNavsdksn9uelG17OiYzUaPj9S+BlsTlJn/GfiTCkrER
	M+T0qysmNUoniyjR1L3fzU6F6Tvo35Q4GqapvT3K/qNiddv0rHkfZiIoHrCQUE23Qrrgqi
	UKjWiKEkrI4lHqj1ZtnRVX7zm9dV6k07oWa0QWhf66drLYbD/PoolKn+6ubQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731542696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OShJAfqmCKGuO6LWPrLICJ3FWA3fAbMZtXnWt2lNmu0=;
	b=acir5N9goy9EIjx391l+7VtyOeyCY29D8I0WZt36f+p3fJ3OFkDzfkEW8JVTweOb4deCXc
	VyDigEHkmral9DhyzhKbuCS++CSK4kkN7YDYbY1l32hqTtJTsDByeBFJ4Sv1cxs7H2voGr
	a5MhLWtFQnV20uElcBfmd8Aqd6OLY/534/DtIlnYbIr3CgwgnUoDOb6meKmsxbdLjpagCn
	dKQh4MhsIEpSiHyOP4+rVCLYOWovDXYUcmjDfgSMCa14X2yfR0040kyO+LO+fj3Xt2ctOs
	BID+qAFH5r7zbmcZNJlrg27YhNXgj7hr1SP8nER3qjGlAGz0CDg3Mz7VNe32SA==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-9hbnn;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chemical-Scare: 6ea9d40759e37899_1731542696387_3203533427
X-MC-Loop-Signature: 1731542696387:1022715188
X-MC-Ingress-Time: 1731542696387
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.196.227 (trex/7.0.2);
	Thu, 14 Nov 2024 00:04:56 +0000
Received: from p5b071105.dip0.t-ipconnect.de ([91.7.17.5]:61447 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tBNLz-0000000AhXq-2KDN;
	Thu, 14 Nov 2024 00:04:53 +0000
Message-ID: <10783d8ac0d407f85feb8e0de8eb7ccece8c8e57.camel@scientia.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 14 Nov 2024 01:04:52 +0100
In-Reply-To: <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
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

On Wed, 2024-11-13 at 20:49 +0200, Jarkko Sakkinen wrote:
> The problem still persists related to TPM bus encryption not working
> with hibernate in 6.11.5 but the message was shown only once in the
> log (and thus you did not notice it).

At least my grep from before wouldn't have shown it even once.



> Please test my fix and I can take it to PR.

I've seen your PR was anyway already applied, so testing still needed?
I'd need to compile the whole Debian kernel which takes quite a while
O:-)


But other than that... and especially as I'm seeing these:
  2024-11-01T15:41:22.428940+01:00 heisenberg kernel: tpm_tis NTC0702:00: I=
gnoring error -5 while suspending
errors...

... I wondered whether that rings any bells on your side with respect
to: https://bugzilla.kernel.org/show_bug.cgi?id=3D216998

I short, ever since I got my current laptop, suspend2ram was broken,
that is per default I get:
# cat /sys/power/mem_sleep=20
[s2idle] deep

and that "soft" suspend works (but there the CPU, keyboard, touchpad
and stuff is still on, drawing power and even the fan continues
running).

If I overwrite it to deep, I can go into suspend (or at least the
laptop actually does a real suspend2ram, but when I power on (here it
the really requires the power button, no longer only keyboard or
touchpad movement) the system immediately freezes and the screen
doesn't even light up.


Not a show stopper, but still quite annoying. Having looked around for
similar reports for quite a while I indeed found people indicating that
TPM might be the issue, but even with disabling TPM in the BIOS it
still fails.

So after all it might be just some broken Fujitsu firmware... but if
you'd have any idea what I could further try I'd be happy to hear about
it.


Thanks,
Chris.

PS: Thanks as well for the quick fix :-)

