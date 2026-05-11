Return-Path: <linux-integrity+bounces-9520-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zJ7eCopNAWq5UQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9520-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 05:31:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298B507A19
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 05:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6782300330B
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 03:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969F36CE14;
	Mon, 11 May 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gisH6UGe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24736403C;
	Mon, 11 May 2026 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470278; cv=none; b=uEA9N+Ym5Wlu9y74Pp2t7486bnvq6M9FfnqP9MQxWx0vyQMTk74z5OCTXchLy4RNn8IMM4Ne2aooUV6KLZY+uPEVJ0mhzQRO4pOaoTG7LddxmfBm8VehNjtnxnCO/aYS8CDMSJeJT7fbCxEYVG8Ho6J+mYuRRINI2Obpw8hb96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470278; c=relaxed/simple;
	bh=yuyU8K15m+nQP/3ieR0cIHqcaM5UYmzo2Z9dnFBGYgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnVDSC0k+iyaxZn5Ld1AVl3je6q500qCn66mVpwKLvQo9+nBVyj+sCK6XPr16b5SsJNxij2E1i2Qd6U4fXKd+r6cj+UGxa84g4JJiypO693IYkMJgGBSngLjr33tHF0mrFnYTGF4dXWTHKdbRdQvFAASQM7R2dnLqrBT2YQYF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gisH6UGe; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1778470273;
	bh=yuyU8K15m+nQP/3ieR0cIHqcaM5UYmzo2Z9dnFBGYgA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gisH6UGeyqpmPLOzc7IpaOaOgVFm3EO9A+YCeJ2maJyzXCnm+FJgUfykYA1tT0za5
	 kExoMXxTFf87BBJGtRm3EErZ8I5iAI3/AuxBelkKKA4dKZdCx4GYTYr4WFeCGdq3iz
	 zPchGnB/N9nd2qu/BKQl6fHqzeJxlNa8Qm4dWXns=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 664681C02A3;
	Sun, 10 May 2026 23:31:13 -0400 (EDT)
Message-ID: <ea79fd5021c0bf069746b3b450e5b2c20ba90805.camel@HansenPartnership.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Jarkko Sakkinen
 <jarkko@kernel.org>,  "Niedermayr, BENEDIKT"
 <benedikt.niedermayr@siemens.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, 
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Bauer,
 Sven" <svenbauer@siemens.com>,  "Zeschg, Thomas"
 <thomas.zeschg@siemens.com>, "Gylstorff, Quirin"
 <quirin.gylstorff@siemens.com>
Date: Sun, 10 May 2026 23:31:12 -0400
In-Reply-To: <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
	 <aP_NN3HwO4Hp0-9T@kernel.org>
	 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
	 <af9QQah4QN5VD-4P@kernel.org>
	 <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7298B507A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hansenpartnership.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hansenpartnership.com:s=20151216];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9520-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org,siemens.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[hansenpartnership.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[James.Bottomley@HansenPartnership.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_WP_URI(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hansenpartnership.com:dkim,HansenPartnership.com:mid]
X-Rspamd-Action: no action

On Sun, 2026-05-10 at 22:42 +0200, Jan Kiszka wrote:
> On 09.05.26 17:18, Jarkko Sakkinen wrote:
> > On Wed, Apr 29, 2026 at 02:33:20PM +0000, Niedermayr, BENEDIKT
> > wrote:
> > > On 10/27/25 20:51, Jarkko Sakkinen wrote:
> > > > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >=20
> > > > > As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM
> > > > > may write the current time epoch to its NV storage every 4
> > > > > seconds if there are commands sent to it. The 60 seconds
> > > > > periodic update of the entropy pool that the hwrng kthread
> > > > > does triggers this, causing about 4 writes per requests.
> > > > > Makes 2 millions per year for a 24/7 device, and that is a
> > > > > lot for its backing NV storage.
> > > > >=20
> > > > > It is therefore better to make the user intentionally enable
> > > > > this, providing a chance to read the warning.
> > > > >=20
> > > > > [1] https://github.com/Microsoft/ms-tpm-20-ref
> > > > >=20
> > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > >=20
> > > > Looking at DRBG_* from [1] I don't see anything you describe.
> > > > If OPTEE writes NVRAM,=C2=A0 then the implementation is broken.
> > > >=20
> > > > Also AFAIK, it is pre-seeded per power cycle. There's nothing
> > > > that even distantly relates on using NVRAM.
> > > >=20
> > > > [1]
> > > > https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-P=
art-4-Supporting-Routines-Code.pdf
> > >=20
> > > Hi all,
> > >=20
> > > we recently also stumbled over this issue which led me here to
> > > this thread and maybe adding our observations helps to clarify
> > > things here a bit (hopefully) or at least augments the
> > > information related to firmware TPM based implementation based on
> > > ms-tpm-20-ref.
> > >=20
> > > Based on the optee_ftpm repo, as Jan already described, which
> > > currently references commit 98b60a44aba7 of [1] suffers this
> > > exact issue because of the NV_CLOCK_UPDATE_INTERVAL [2] which is
> > > set to "12" and issues a write for each command after ~4 seconds
> > > have passed.

You keep quoting this to us, and other parts of the spec.  However, you
forgot to quote from the Section 7 compliance statement in the same
spec which says:

   the NV subsystem of the reference implementation is not
   representative of the actual implementation of most physical NV
   implementations but is a crude analog.

I get that the the optee people failed to realize this and only just
corrected the mistake, but the fact is that all other TPM
implementations, both physical and firmware don't have this wear
problem you've given yourselves because they noticed.

> > > This config has been changed to "22" (on current master branch
> > > [3]) which is the allowed maximum when following the TPM spec
> > > (chapter 36.3.2 in [4]) which leads to round about 70 minutes,
> > > but optee_ftpm didn't move ahead to this commit, yet.
> > > This config exists for being able to adapt the write cycles to
> > > the specific wear conditions of the hardware.
> > >=20
> > > Moreover the ms-tpm-20-ref repo seems to not be maintained
> > > anymore and one should rather switch to [6].
> > >=20
> > > So there are currently firmware TPM implementations out there
> > > that lead to these frequent writes.

Yours is the only one I've ever come across.

> > Really this would need a product and official bug bulletin for it
> > to even consider a workaround. Speculation does not count.
> >=20
>=20
> The key point Benedikt tries to make here is that the TPM 2 spec
> forces any vendor to do something about persisting the last seen time
> at  least every 70 min. If they didn't do that, then they would
> violate the space=C2=A0

That's correct, but a red herring: if the optee TPM had done this 70
minute flush ab initio you wouldn't have the wear problem because the
seed writes would be much less frequent.

> - arguably a bug.

Well, not following the spec is a bug, yes, but it's not a bug in the
kernel ...

Regards,

James


