Return-Path: <linux-integrity+bounces-9399-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKihFfbR9GkYFQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9399-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 18:16:54 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877654AE083
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E235A301CFF8
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE503DDDA3;
	Fri,  1 May 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jNqR/Qpr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF023FADF6
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652196; cv=pass; b=gYEN7QGEniyZmRMmu2i1slic6CUIwQf77Pqt8pCLc2I16RRvzvvpgR7fIo3EkoejyFxv8yB1upiV+yUNwlobBPVJjSzY2M1KGshYLZp30R2JYN/D7ulHCCw5Og3W8f0Xfq7rIIx36kQccezWrqZDevt1fNrK/Z2ZOZyKaQyALIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652196; c=relaxed/simple;
	bh=pwga7VdIBErnIYUdnTOFkDQP85+mp56HPlNPUK6p5Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8Pt5Uq/mAPgpO/4XgzR1HeS6YMyFLSeZHhmR/+wBw92GJOHYfm8B/TANlwZPp5SAP5UloaXDdog/5XkRXkRIETuCfC/J7ineJtN3MQyALZuFUW0oE3VznSlPShKcHSBC/DTQhV+VtjstG1ebL5jIBWZAbsuXJnREzfu2EzbgOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=jNqR/Qpr; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d4c383f2fcso1905598a34.0
        for <linux-integrity@vger.kernel.org>; Fri, 01 May 2026 09:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777652185; cv=none;
        d=google.com; s=arc-20240605;
        b=BKo7un+4qgwmwmSiX32PgslVtVDZhx2+hYhV7gf9zrGRhOuClcFOjrMAyE+Jm6j0DA
         ylyDGGtAe1yWUCMd9bX2ILXBsfnQ0oZ6mEa+0fzZuPRmUcjorJNVpcpyTnKo1+BURJ9a
         FwPbd6Ln6AqF5mYF1Tfh84q7EWyjS+Kblt/sOEN1f6hVy5SkE3xP+Q2a20lfUxEVeiBa
         R45M4C+TATlEU3GjLwJJM2OszBMJ8eRhfHZYFjAKyIyGhtQy/ZSL/01CxrKacxpHbNo0
         iLO+zr4vBIdkhcLJaXHPAEaged4Ap21c0jTR6zed0n5KgXPSVufpXq/J63JODdQMArwx
         cI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1FeZHGyJmif/tIXl0vI5887q4wWknazi7fMw4ZUhN4=;
        fh=kl7jtRvHKlgvqrdhII0sKNip4BvTsOreaNFj3co8li0=;
        b=WSXXm/IY6gZAPnJ5GgoMgz1DsJb/oHnwXHx6mmcnbJPaGt1FhY5Av1Cd3feiET2yu7
         vxIL5gMg3lem0H3GlNUnOngijp4KvGLGz2YJO4MLBloztMpQqm1SVQ5yDI6+BRTjh5C8
         VUQe3nfzpNTmTxxUCEiJ3liIZWqzA9Z32Aa4ygwjmBmyT7RoJRb+SXZdoO9KpybePUxz
         Lm5ROyP7cYdTlqK7zpXfMxicUrzvdaF43vtF9ZD4D/qpBztrmtbWoprAF8PnaVaZMxj8
         TQZ1okvmWDYJafaarc/n9wYKo4pP58Lv2gdZGmBPGXXkgU9/Hsqb6NluFDtpHpZCPktX
         Wi2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777652185; x=1778256985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1FeZHGyJmif/tIXl0vI5887q4wWknazi7fMw4ZUhN4=;
        b=jNqR/Qprx6i+wH2Ni4+pTUOgh3IqvgIY8Isc0CbYrkXSrrEQMhVSX0JiHQq7giczO4
         Ym30ihOjAMmRCXzMZqQD/410wa+ucFyr3hdK3BwXtdfj0rsiBI0EnoLXtLrB9OvNz9Se
         +oON01qRpwj7jRgVNZS3ukC3orYKUYO0C8tQmvV3kIY9KV3CYWmMEudxbqX+Dn26g0CI
         GPXP7AIK4IaEEDAu7HwHwstMnRMPcXlGDV2GLBkph2Fy53oQyxtcVLyuWxiVgxHmzys/
         XAnXGO55NkWaSyLykG0MO0QVU+CKVjSH3N8obIGg01ccrYlbsM1/IbhS+e909y+lH9xW
         oOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652185; x=1778256985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1FeZHGyJmif/tIXl0vI5887q4wWknazi7fMw4ZUhN4=;
        b=q30F9NvPYz0y9LbW+uV9j9n2uagoz6grhfC4Cg8HP/DwzIw9xmMc7+1XOT1ReYsYYF
         H7kxRW5L444NIxocNwEz55jc49sc3UKpxwVRpIGJdO0hUGvcyZyG//kYZK/RKV4SkAx/
         ij5h+GC1r6Q7ANrIozdlTGS/bNPzM+Uu0aFdKHJxe6N5H/dFVOniLE7vLpKAFXkMaE6U
         3jfgfkUEwDOB8wGN/C3dDmeD/LjdHRMPrsHPVAoqCzL8YCG/39NdnIVCxBHrxkaBO+6O
         AMMAdMD21hRR1Ga2/F8m9hmF9P+Nojov2MqiiwfVK3E9SUh0rFsySBwTOldJQG3RTLI5
         tbiw==
X-Forwarded-Encrypted: i=1; AFNElJ+e/j1s2jNod8hXXQcDVNpbu2X9shOxIQOn8KH4h6pWo33xUbJAoMiS13QFfESqvRDc6IqYiuGkmA3aUNAzjXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7Re3voaTBiP6EQszpomSnz9bm0aiOJkj8ky+SFVDfUiwf5YW
	xQ4r2WJ4b2AX//v8Orh8qAIMEicnyPqvo1xPwOG7Sdydba8xambleQVQGDAV6QsFBQ9A+1FjLqt
	JbEPkcztJcpwAJ6AwkW9Xj2gpMJVrrP2DqkIC9CoO
X-Gm-Gg: AeBDiesbOS9Lrp4JEexZ4Q37HUTh6M/4f6SJQx1E1td62FXKm9hkxKspwlWsbmxP0wP
	aN9BiAl6KeUuBlRqYII7wW/I6N41t4RiLZ3mWMM7FIKEX7SeQ+bnqNQ1brGRWarKAscHB0ATXiR
	MXUYunS7/2NNtA+Ta9QWxRM6c66E0bJB8wW7MnPOXidIDrOTMlWZsrZ4GLzUjKdFiU4FI4aeIi1
	qvT9AXxe3fbjqSXcI1y2/AlwkAxAG0q68fw/WRPS2LpbHpQAtsFCwy1ZPr1RiA3a/etxPG53Mz+
	61sVaIY9EUKIX6tEXm2K03VgGGE/deGf9bctvjmlXjaGixw3CBpMb03hiOaSmHEbd+kd2UO8VeV
	BhGkGG5c=
X-Received: by 2002:a05:6830:6604:b0:7dc:cba3:e8f2 with SMTP id
 46e09a7af769-7dee13fd085mr107809a34.19.1777652185362; Fri, 01 May 2026
 09:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com> <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
In-Reply-To: <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
From: Danny Hu <dannyhu@arista.com>
Date: Fri, 1 May 2026 09:16:14 -0700
X-Gm-Features: AVHnY4LxHMOXX41xK71xIT8mPQSOUOjFqUDkAszp7510GRLKOV-RpHXamGr_b1Y
Message-ID: <CAFn2k5BciHURkQS9p-vZ70GP==1S_4GmoE=sMhA+WQXOA8nfoA@mail.gmail.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sahil Gupta <s.gupta@arista.com>, linux-integrity@vger.kernel.org, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 877654AE083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9399-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dannyhu@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arista.com:dkim,mail.gmail.com:mid]

On Fri, May 1, 2026 at 4:42=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Thu, 2026-04-30 at 21:32 -0500, Sahil Gupta wrote:
> > > Have you considered using IS_RDONLY(real_inode)?
> >
> > OOC are ima caches invalidated on fs reconfigure? If that is the case,
> > then IS_RDONLY ought to do the trick.
>
> Per-inode IMA integrity status (iint) is now stored directly in the inode=
's LSM
> security blob rather than in a red-black tree cache.  By "fs reconfigurat=
ion",
> do you mean remounting the filesystem?  If so, the iint stored in the LSM
> security blob should be freed when the filesystem is unmounted.
>

We considered using IS_RDONLY(), but the concern involved the remount
path rather than an explicit unmount and subsequent mount. From my
understanding, userspace can toggle the read only flag using "mount -o
remount,rw" without freeing the inodes from memory. A malicious user
could then exploit this by caching the appraisal result, modifying the
file, remounting fs as read-only, and then IMA would trust the cached
appraisal result.

