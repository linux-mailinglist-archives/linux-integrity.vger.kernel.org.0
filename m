Return-Path: <linux-integrity+bounces-7687-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B38C8D9E9
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B263A8EE7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFE2D948A;
	Thu, 27 Nov 2025 09:45:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF253161BC;
	Thu, 27 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236738; cv=none; b=fCLUglum1fpeRlJe9apG1jun2g4XgmV2YjS9D1zQ/whP8lK5sT2fgF7p9FoeG2x+XZr2Jw/2RJcHEGaNuj3iF/mjEdCVqHw1q7bcZuy6Odk3gj12KsZFl7tyaa74nJkX528sMvVvMfEspcJY1s8UdNLPe5loqwZIivaxk65oGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236738; c=relaxed/simple;
	bh=3d42s9z7GkRr/vqBKA99DThFXorNi/IoyPuPaGLcxYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwVeEfobLXTqkuRYURpRzo21hFXWSpeigyiOCVdePj2LPLGmDtFqSf4R2Ia66iGTOiqaPZcZyoXuwkW4otsLelNilBi4PlaOtvDhlSwcVAE438vRQcYgMkdDlWrseOxXs2tZuNCmrj2c1xffNJIQyqCENHtnmxSFGFtBMFXO6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dHBMl4wkczpTkF;
	Thu, 27 Nov 2025 17:44:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 91AB414022F;
	Thu, 27 Nov 2025 17:45:26 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHfSGsHShpgdAoAQ--.4984S2;
	Thu, 27 Nov 2025 10:45:26 +0100 (CET)
Message-ID: <3f85e98e2e4ef6a0de4fe4f6c2093791def1e30b.camel@huaweicloud.com>
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>, 
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,  Eric Snowberg <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge
 E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org,
 Steven Chen <chenste@linux.microsoft.com>, Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>, Sush Shringarputale
 <sushring@linux.microsoft.com>
Date: Thu, 27 Nov 2025 10:45:13 +0100
In-Reply-To: <bbafa611-3a6c-5cf8-631c-20f72f651d9@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
	  <7722dff4e68ef5fb7f39bd732a8a77422bad5549.camel@huaweicloud.com>
	  <a77e9609-f6bd-4e6d-88be-5422f780b496@linux.microsoft.com>
	 <1e5a3b427fe2783e57e88ca14630f5e38e01fac5.camel@huaweicloud.com>
	 <bbafa611-3a6c-5cf8-631c-20f72f651d9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHfSGsHShpgdAoAQ--.4984S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kWry8WF4DKryxGryUJrb_yoWrKw48pF
	WSgw4fKF4DJa43Gr1kCa1xZryF9395J34Utrn5K34rZ3y5GFykKw15K3yYqFyfCrWkZryj
	vr4avr9xuayDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBGkntCQE6gAAsz

On Wed, 2025-11-26 at 15:40 -0800, Gregory Lumen wrote:
> Greetings Roberto,
>=20
> If I may chime in a bit:
>=20
> > The only way to make the verification of measurements list snapshots
> > work is that the verification state is stored outside the system to
> > evaluate (which can be assumed to be trusted), so that you are sure
> > that the system is not advancing the PCR starting value by itself.
>=20
> You are correct; to make the described approach work, an external source=
=20
> of trust is required in order to detect unexpected or unauthorized=20
> trimming of the event log (for example, by signing the trim-to PCR values=
=20
> from the previous verification/attestation cycle). This should be true=
=20
> regardless of the mechanism of trimming. More generally, I will go so far=
=20
> as to suggest that any attempt to attest the integrity of a system using=
=20
> IMA will likely fall into one of two general approaches: either the entir=
e=20
> IMA event log is retained (either in kernel or user space) from boot and=
=20
> claims of system integrity are built by validating and examining the=20
> entire log for signs of tampering, or an external source of trust is=20
> introduced to allow incremental validation and examination of the log.=
=20
> Other more innovative approaches may exist, but we make no such claims.
>=20
> I will also say that it should be possible to implement either approach t=
o=20
> attestation (retaining the entire log, or relying on an external source o=
f=20
> trust) with any sane implementation for IMA log trimming.
>=20
> As for our proposed implementation, storing the starting PCR values in th=
e=20
> kernel preserving the ability for any arbitrary user space entity to=20
> validate the retained portion of the IMA event log against the TPM PCRs a=
t=20
> any time, without requiring awareness of other user space mechanisms=20
> implemented by other entities that may be initiating IMA trimming=20
> operations. My personal sense is that this capability is worth preserving=
,=20
> but it is entirely possible the general consensus is that the value=20
> offered does not balance against the additional technical complexity when=
=20
> compared to simpler alternatives (discussed in a moment). To stress the=
=20
> point, this capability would only enable validation of the integrity of=
=20
> the retained portion of the event log and its continuity with the PCRs,=
=20
> and could not be used to make any claims as to the overall integrity of=
=20
> the system since, as you observed, an attacker who has successfully=20
> compromised the system could simply trim the event log in order to discar=
d=20
> evidence of the compromise.

Hi Gregory

all you said can be implemented by maintaining the PCR starting value
outside the system, in a trusted entity. This would allow the
functionality you are hoping for to validate the retained portion of
the measurement list.

Keeping the PCR starting value in the kernel has the potential of
misleading users that this is an information they can rely on. I would
rather prefer to not run in such risk.

> If the ability to validate the retained portion of the IMA event log is=
=20
> not worth designing for, we could instead go with a simpler "Trim-to-N"=
=20
> approach, where the user space interface allows for the specification of=
=20
> an absolute index into the IMA log to be used as the trim position (as=
=20
> opposed to using calculated PCR values to indicate trim position in our=
=20
> current proposal). To protect against unexpected behavior in the event of=
=20

From implementation point of view, it looks much simpler to me to
specify N relative to the current measurement list.

> concurrent trims, index counting would need to be fixed (hence absolute)=
=20
> such that index 0 would always refer to the very first entry written=20
> during boot, even if that entry has already been trimmed, with the number=
=20
> of trimmed entries (and thus starting index of the retained log) exposed=
=20
> to use space via a pseudo-file.

In my draft patch [1] (still need to support trimming N entries instead
of the full measurement list), the risk of concurrent trims does not
exist because opening of the snapshot interface is exclusive (no one
else can request trimming concurrently).

If a more elaborated contention of remote attestation agent is
required, that could be done at user space level. I'm hoping to keep in
the kernel only the minimum code necessary for the remote attestation
to work.

Roberto

[1] https://github.com/robertosassu/linux/commit/b0bd002b6caa9d5d4f4d0db2a0=
41b1fd91f33f8a

> With such a trim approach, it should be possible to implement either=20
> general attestation approach: retaining the entire log (copy the log to=
=20
> user space, then trim the copied entries), or relying on an external=20
> source of trust (quote, determine the log index corresponding to the quot=
e=20
> plus PCRs, trim, then securely store the trim position/starting PCRs for=
=20
> future cycles).
>=20
> -Gregory Lumen


