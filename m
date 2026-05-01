Return-Path: <linux-integrity+bounces-9403-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAn2KLQL9WmEHwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9403-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 22:23:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D534AF75E
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 22:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E627B30107F5
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E64406261;
	Fri,  1 May 2026 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UTpkVPRn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6253603E8
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666987; cv=pass; b=JGeCfL9Mnth91c0Dy0avMD98DYQJqs2KMm2kKnr2m+rZLD2i3PvaBqW0VBSzfCKcccNwddrzaoLCU78X5hki/VsKxKh1ks72lUk6OC7hygC9nPICKOtEOVSmFbSePhAltz64jLUo9vJW8Yt2QHu4vq+/KssybyvTvxUvkOTon48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666987; c=relaxed/simple;
	bh=/ujJHrBN8PmIB1tZda+GO/6Bof5SAiLdmAOY8AD751Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsK25X8LUO9e/x3Ub24xqIdavdQBK+APSaVrr8KTaEF0l5bpxfMpDnVBbnF/zyGLOChDoyxAYfLfCMllgjoUzWz1LQPYzQIE4uQ5ytnqjdV65VIN5LZwruCXr6MpjgjCUEhagvr0lvdPoRS78zbxiF74BtYh8zH16zdHjwmj58w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UTpkVPRn; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d7c12e48eso19186241cf.1
        for <linux-integrity@vger.kernel.org>; Fri, 01 May 2026 13:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777666985; cv=none;
        d=google.com; s=arc-20240605;
        b=U0tGhsX4mguSDVyYRQj3m3pkK6E6wWFiPKjExb9xtQCfOxPQfeiZ076du+WMPbK+f7
         emI4/aMctbNcV9AutLh+NsAf5ljvCwdiCor8HsgS7M/oMNHqvtgHFIGj0eA2lZ68zotz
         XA2TU925ojTX01DiIxMpCp+aq01YxdlTQoyuN2T7LnJgEvbXD1zhmEcCo6OS3QtlEGcv
         bFXXb9nTy/j8wHpoovTcfMSWCApTNTjSlFD1jfcYjzhDPg4pVJ58j1avj/Pj4B/hcVEn
         jKfE1j9i1p39ERH46r9iU0oj1Z0Hnizey70rJGylakttfENu27UfyANkH42RMu1cLtz3
         Lo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D9nJHveM504JHQokSgxSmle5UvBUvshBQ90+TqYpXg8=;
        fh=Uw/oXTJPpnNHztp++G/UiD0zsm8KjgTK18M/QZ6QgOM=;
        b=Cro2p5X9zBDY1dwe4ZlmmnSbQFkuS3D7BqBnFTsECKy0VaBi0Q7OLuUwWHy66kuySa
         t3QGYhO6FptqDMOSgEcBwzDld7enN3R0jfbVu3oR9R3jFjvIFsikOA5RXXfUVPEuQURd
         lMFlZdl1FIGvKkQGCFJa4XN3fGD3/4VaRiDjc+o0Oj9pmpffGzPSxrjVlj0iRFB6LSOr
         Qui2gEjIKIbLyHiR5GTFGfH+y2R+Qq54pU5vi880bO0wiZU39E/0f8Xl1NexlgCyW6Fj
         3IedbGHdJg1xYX3dUDGa6zJgIm9VHhE25sMdVaLG1/u2V8Fl1u7u3ZZPlEBPFzCM+YQK
         z7fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777666985; x=1778271785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9nJHveM504JHQokSgxSmle5UvBUvshBQ90+TqYpXg8=;
        b=UTpkVPRnIsvM0XuVksdDrrcmhOdNDINqj3WsFzybXL8LhdfkQ2U6YiDKFCUBe1zSU8
         v5Q8HHInHJXslp9hnCUOoK5SzMr0CIcq4LW88WrlD4de4cU63aFCAlcbGHb2r/HYw3DM
         iq9Wug0/rh/PJcZkjc5l9lNqJtQ9GvxlJmwbUvwFbQoQfTdT7RSt9mF0FXxRz/DOEWGe
         z/uC9LFK6jINDsU1jK7yv5K84hMTSUQXY6iW2C+SKG8Q5NFNQPsloVtvDjP5rHFzSjaz
         BhekYJzyxiN+iC93vXcMU3jujbgrJACd9Pxe+zsBhL0X/ea7C9fFNKUUzzeLbIXFZ7hp
         /d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666985; x=1778271785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9nJHveM504JHQokSgxSmle5UvBUvshBQ90+TqYpXg8=;
        b=cFaZzgEiWcd/uXfUxPJklyDzLG9TZRrEfR7ZjAiSLmND9wseA4uToQkV5mFtlqYQCu
         U1K+GHg2jZrl/a7c7srT3kLRv9X6YODmpoTkyiUBKafxVfMNpZnuy0oM9NvfIDxL6geX
         z1+gJXZKLlaX9bObrJAn6Sxuc3kgBm55loOpLvvp3JXndTnC8YAu9p1D4U2+0tzWTp1M
         dkRJMJiDTPqnTEs8HIfUI/RHXWGLp+LVvreOr03Sn/N8k8Z49XhuUkBsNV8qW2dLxq+P
         o7P+2py7yZfsXTablaYukjCJjBjmzUtgHUxLDAT9woFI0EpyfUIVk1pXC3ho2p8f0QXw
         5e+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KrmQ4UjwbKUnAMDAvLN5zVbPTx+yRWbQjTa9M81096DjwRPTzXF0spqqGfTLsLokoxEDD4ORUCdctL6Uihq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYzmymbbuQI5oXWcCV8apkCyzt80D4yZPGj8yltn3It5f40qU
	XGo0qHnj5clFXKJhv/iPpsfdS819ikZJDrwRMj44yUWRpbZPxcrDZKkHK/dgMK48Iy7wQYCZTof
	S8byBE4XzdLGoLB8Xxrxkgif9lxwQvSTJADMg7Jtp
X-Gm-Gg: AeBDieuNh3uIsxQmSQ73rQSXYxElFGHESgmTT4TvI4hSnmdwI+Si4JTCw1qAHRDPUiv
	HaMllZjYfuNdI6gqrloFVB5UtqlQ2ymtdMGAF7xlurKq2FJkZX89WTIw/3GXBS796p5FGfRRyzh
	DOiYOO7TUccfZtr+/6bjW6GnVM/mTwTp8aj4CsTwfzA5XtHmMZSJFw6EMYb+p+T8zsGtCEreLIr
	eZLM/aAFtSv4LE9xIttwlSulSRgmDBFYvkqJhr8uxFtbcoWGWAYZ160QtVnDDQGA/6MZYeKNCOb
	tNYwsJ946hcpQfXxU7tfRAJkf5wiMU76AYysqy1p5iYM8SqhOLb+VgckLyhtbgxZwUQ6Rl8KR1h
	rM01BTsQ=
X-Received: by 2002:ac8:5a51:0:b0:50f:b7b3:2ebb with SMTP id
 d75a77b69052e-5102d2181f1mr107428371cf.33.1777666984940; Fri, 01 May 2026
 13:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
 <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
 <CAFn2k5BciHURkQS9p-vZ70GP==1S_4GmoE=sMhA+WQXOA8nfoA@mail.gmail.com> <027d076e3ef0b22b648d024aaa7d8dd27746a624.camel@linux.ibm.com>
In-Reply-To: <027d076e3ef0b22b648d024aaa7d8dd27746a624.camel@linux.ibm.com>
From: Danny Hu <dannyhu@arista.com>
Date: Fri, 1 May 2026 13:22:53 -0700
X-Gm-Features: AVHnY4LU5WrglRXclfXJZlcAnBYmwHB-rYWfTnVBo1fRot0Lx9uyNCOG_5FmHHw
Message-ID: <CAFn2k5CVOL8S5jeFAi=7TM6pm4r4G6r51aRNOH4qpnYGWLwPYA@mail.gmail.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Sahil Gupta <s.gupta@arista.com>, linux-integrity@vger.kernel.org, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B3D534AF75E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dannyhu@arista.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9403-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arista.com:+]

On Fri, May 1, 2026 at 12:48=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:

> Thank you for the explanation. Just be aware that IS_IMMUTABLE  is alread=
y
> defined.  Otherwise your suggestion is plausible.

Thanks for your input! We will likely pursue this approach internally
and send some patches upstream once more testing is complete.

