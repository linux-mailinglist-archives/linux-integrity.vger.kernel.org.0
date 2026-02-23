Return-Path: <linux-integrity+bounces-8538-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACRxAaRsnGmcGAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8538-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:05:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F21786EC
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62184305A436
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580D3446AF;
	Mon, 23 Feb 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PfnHG04+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98A28853E
	for <linux-integrity@vger.kernel.org>; Mon, 23 Feb 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858781; cv=pass; b=sSidn7Rx0xgYT9GPGt5YlJxP4FILF/5Hn7SdCL9Au6V0KKorygVaXTkfHL9CvEdQgKBKVl63AAyczeqoTSLEgLd/60hUlN1rKZLf9zYZ7oPPCQXx28MXe5tSlgqqtXOjOzNGWLKQZxZ0+9ygH/wQxW+K27Q9NX+WQI+OI3ekiuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858781; c=relaxed/simple;
	bh=Ua5ebazVPkVAaROdqBahoTBmr7z+xfRmyIun4rznWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AztcWdna6pporowfelj3Dzp0jGW+imWRQq26mrw898L3WqR+VBrwUEf5t1N3nXaEXTxjRoUFafw5JvMfJNgkjDkseCeuH5pJ55yTameYt8hFR83rfqxBCKy3eblnmrx7OoLj8ogZVIfBmdrbGsoMiDsMUq4j5mpJRT+lxZ5FBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PfnHG04+; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad617d5b80so26810145ad.1
        for <linux-integrity@vger.kernel.org>; Mon, 23 Feb 2026 06:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858780; cv=none;
        d=google.com; s=arc-20240605;
        b=A/Hw9kzmXgIAWFSEutdLkarNgjyAZfJDCGhfF+ziHOApDrGTntGEMsNp8Uugc8ACk8
         vuE/Pnd6iu/Y/uU2BBzA8/Pv41XOR5naD4Urt4ZZXPdJXSR8Rp9NxHmq0gOEYvVSk2Xl
         9/Gdh1lMs4gCj1dT675JccAJw1ec5RGG14OUgLB7glV99oDv5XiR4Kp0Tn0+BvU8cdlM
         8r1NLXTY/1mUjZEqXhiusZhHGY/Esxg6zf2fMFpSNcy/QT4eG/imGFKaUXuoE6kAfVGu
         AaJWn1RBiFD0T3DelXVCMqDUInrXrVSZBl59S9ph7A+B2gS0/hBiw1XrThp9NhgVFLQh
         EPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        fh=ndoRmReL54+fuxtQql7kurBt43tbjnYHfh0ap6lo1TU=;
        b=kKavx7UUSH7t6fTMV+KcYnXbEJ8vxp3j5pazz6LmYMltE+sVvFml0OE8DI8V5PcZKE
         m083HS6yATIgKRlN9AlxY4FWFnTzDnsZN7wBR8qLu/jCzb7yeLMEWtdgU16eYIqcMR7R
         PE7cV7yuBzcGZ4NgUhFPgmVV8ih75xU9/YnAWJfL1d3V2C2QjKgiLQTJtNFVhP/szGDY
         Ex8mYCjVxraA75CUzziOGnbQwDXIOS895WYO7lbQVoYz03tn4/35Ef1+cXwASvJI9p+4
         ZpXnT5/oRA4o6Oks6GGKgiyC3blbc7A4ufdSok5zy2sv94otWvvB2r9E2JB4kQLHWM5y
         553A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1771858780; x=1772463580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=PfnHG04+XUnWCp92qHHPIornNbkLV8rre0fZd5MujhQEJl2ndftjWe0RUiLXXNBZz7
         9zI55kcPuY/gnrNSm+aHDJsRy3nua32X01EgZJXd24oY+wYhOanPizHIQCR5R5GVJorn
         wrZ3Z3UX9F34LGKkHKGBAtZHdTOFuIQUkDqDjoHCqf5jJnrR9qo2gjW+A5xIGeLfxQhP
         bndT7JOOmrNad4HrmPyCEuniA/M93g6LtxNDP88uZ3RKqdi+ATI5ayzoX5djeawA4tv2
         xTG9lYg3Rdk7hmGUyvT0ZEZnJbHFBMtVDRxVyUejDH4smQCR+/0bv9BEYs73pnJsbjZO
         UXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858780; x=1772463580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmVR5VYIWGRxvZwKsHYm9ca+X+2FqDD0nNMP2ivYeTo=;
        b=oPUB8GG4/+xDYyOhsv2iNxj597p39eQCU7aZ7Emkm1Tm+K/Pa2ojTY+odGbZjLbWW3
         NNE1y/zNKKw5LUBLPltCKna82bvIMm9tLz1L0HeoZ4beXlQ136LK6mowGvsp52319xSS
         rmS6kk6DtwwVvwHd07fMjcxIDnkLDiYtq9jMcuaWKG6QSQuYVyjRhE1TeNHqHZZQLRdR
         HbLyxtUd115xAdjEPibYP2ctW2FV/Dju7CMupIaT0u7lC4L5hP5xGZrDSqXgAUAb9Bfo
         1eLSm9jVS/1uBtUwTeM4YVSe0dgzK3vjOyMNDSQp6n48AL42DS4V1npQILF+qeO27FC6
         9mxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTW3NpfdA02k/rpcLs+K+nXX2N/SEtQcTAO4fiWClfiaVlXV5i5i+FvbxEvvR5NWUAjxidfShPby0chRpDIpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRy+FnFcm5qqW31xwOfXJJTJlh5bJL1LtwOF5Seq938mFgj6J
	/GFkB/a6ZPQRzBPS50HiGipvB1tK42ny2ye0v+DkM1cOIwP+ob93+Lf4RxW5qXcbwVODlwXZtDy
	UPzmC3Xg/dTBi7WZ3MpheNx9ME1Zo7m0oSteNL8dK
X-Gm-Gg: ATEYQzyE62seDNhnYzfbLJgFyXXlcSAj64lG0taEuTCSje/ozlm82YyCFlzXkVGcvlI
	BYoU8BLJZd/Rb/Q3AYg1dxHjO0sQ3hm4JRDORQ2xvpxLyj1Fq45SuSiRCtwQxyWL9GxsdFHuk7E
	i3okLAbbz5dO1Qt9OWTyesj4DH0ggI/eMjpBA3NuLj/x7WTcNvjLqBOxlmEJ/1qlp2/J09bb+lA
	K0wRRUpoBe3zKT3DTb3QdKHsZP1VmKSkdtq1IJqGsFbDnunAYZRcRP/je6p27mEPAYXY+sev9Eh
	VoOZN4dfA7EbXct3qmXoEgTgybdM/vpj4AGKhoZGINgw30HVI/ebBB+JtjI2ItYmn3nWL8A9xBs
	LEK6nCcnBfU/QWwtTOGKKjJU37nDRSro=
X-Received: by 2002:a17:903:1210:b0:2aa:e6fa:2f67 with SMTP id
 d9443c01a7336-2ad74511a69mr96850605ad.29.1771858779863; Mon, 23 Feb 2026
 06:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com>
 <701de3f87f0f6bde97872dd0c5bf150bfc1f2713.camel@huaweicloud.com> <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
In-Reply-To: <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 23 Feb 2026 14:59:28 +0000
X-Gm-Features: AaiRm51Ex5szTVumxkie8rxUGv5c2Mexa2CnyFm86CE9yaxb63DUCIaTBGDvtsE
Message-ID: <CAGrbwDQgySNjK8K68PpWmKdhe0h7AuMeX78joqsC3bjiY=gyNA@mail.gmail.com>
Subject: Re: [PATCH v4] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8538-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arista.com:email,arista.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: 6E1F21786EC
X-Rspamd-Action: no action

Hi Roberto,

On Thu, Feb 19, 2026 at 8:55=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 16:20 +0100, Roberto Sassu wrote:
> > On Tue, 2026-01-27 at 15:03 +0000, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <dima@arista.com>
> > >
> > > ima_init_crypto() skips initializing ima_algo_array[i] if the algorit=
hm
> > > from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> > > It seems avoid adding the unsupported algorithm to ima_algo_array wil=
l
> > > break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip)=
.
> >
> > The patch looks good, although I didn't try yet myself.
> >
> > I would make the commit message slightly better, with a more fluid
> > explanation.
> >
> > ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> > HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> > are places relying on the algorithm to be valid because it is accessed
> > by hash_algo_name[].
> >
> > Thus solve the problem by creating a file name that does not depend on
> > the crypto algorithm to be initialized, ...
> >
> > Also print the template entry digest as populated by IMA.
> >
> > Something along these lines.
> >
> > Also, I have a preference for lower case instead of capital case for
> > the file name, given the other names.
>
> Hi Dmitry
>
> do you have time to make these small changes, so that we queue the
> patch for the next kernel?

I've just sent v5. Sorry for the delay =E2=80=94 I got busy with the local =
release bugs.

Thanks,
           Dmitry

