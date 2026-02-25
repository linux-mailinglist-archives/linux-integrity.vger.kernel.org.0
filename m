Return-Path: <linux-integrity+bounces-8556-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK5gDXc5n2m5ZQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8556-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 19:03:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BA19BF7B
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00F2B31474E8
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F518872A;
	Wed, 25 Feb 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NFDbDlxS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47522DECA1
	for <linux-integrity@vger.kernel.org>; Wed, 25 Feb 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042448; cv=pass; b=JgKg2vDlEFfe4y2T+e0FKd5wZa1pS4fRui4pkRX+jp2N8D5YHIqrRfeJazqQGAU7BKdy0D1n6jfP5Lxs5y8ss+mITdMIYz3domIcygbkM/ZrhGgG/k8LBQzicwbJy0LB/Md1BrWNupD7RosK2s4bT8rkve3xM+HDfuVDNUapMZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042448; c=relaxed/simple;
	bh=ezrs28hh800Wrad6rqosq13WMeXBTafZNVMfGZxxrPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7WkoyUOS0ao+N5lqZiJf19n2CScJ7Wr5HY+ESB1Qd5jHliik1EnrQ1GSN8KVLRzP4q6ipt5PYZLpri26UrlCoL047A9fP1cAGST0Uu02nQ3lbF8z17JVKyOaHZuFx+cuZEOq8Ias+UqbbWZuX48wom0bURmSCfat2EtqqMlY84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=NFDbDlxS; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adc1d9ec56so10594375ad.0
        for <linux-integrity@vger.kernel.org>; Wed, 25 Feb 2026 10:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042445; cv=none;
        d=google.com; s=arc-20240605;
        b=bs2eR1dbhNIpPws3X/zHAqvMjoyk+VRb2SB74eJNdymo0Jqn1I4Tk9zarHe1dzMQOT
         QCZGKQKnFQll5j+OC7LQhUoskNzxa2msbXtHVROQ0rQmS+32eSlCMea4cBLyqzXYHQ2w
         9OqK/Mj1bFW6EYtC63jTk7agxSpMqdSB061XCZ9HsUivcWq95CyFB8LRkvby+7N0Ewef
         j4NmkslHErLrD9hWAfiMijwjkHacaYTmaXnGYdw9w8L2WBWdcCjdkibvKFtzgJ6RQJnK
         7u0gyNuZUVgM69WOUJEZYWYRm8TdebSPasLwIU+SK3is+5L/SkZDouStHPBt8T+V6fPI
         RV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        fh=44lpLzwW5wFovSht4dWKm86z344R+S5YQNvpVjdoY6w=;
        b=iP4g/KHTaZeXGFXz/NRMbutGosRwtg+RDwaxRqdGz36P/+WKVGGvDu9OXNauatk5Z/
         EfTA/iF79OAiCMXx5VVAIVg/qxCExpkNWP6Wzt8p48lRHNjc15YQicydikHLdDvg9FR3
         VQn3d3wWQ61o+IgzNj+AMmT52fbBjsUDxzxhjUdVn7jTTc3L/kmOxdzt3zSgew+YrDu3
         U/5euCiFC1ntFEyEhdEbW9zaFUwq+znH/hLAAqe96QcZhAtYZEuUMW6mue6/DnOr5lcV
         v7M1D3L0BpCICmauNZpAB8LVkG0qa8r5Tzmqul/2OPRJasAcYGaLAxdtVbGO0yvVIUJD
         3+yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1772042445; x=1772647245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=NFDbDlxSchreCFA4REu5sfMZ42uB0CaSJZwym2B2f50pfwhGNXTkGUb4PqUXjK23km
         55rxRAMwMD/NQ9xEmOADEXNr+1otfMj353teENNrKaC9NxPJuJbh9mGCZRRJX7tx/uYU
         IcfrP4gI+j10pyNC2u6KuhjzLjXpU8jtcZofjpsemTJkJF45bwWyHeIq+rX4HJp/VgMJ
         Khnzz2oDTHvYevWSNGZh5krarObAwnMIp5FhNBlnAe+D5WuFU4J2j+btYH76tvy/RNtm
         KqEhrCM63QjjRt+guPxF3m4fSWvlCat1gG/AjDmspcNfBuR5m8u+krLmPvVbeGn1WpET
         ZC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042445; x=1772647245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMRnj3JHAXVYN9zdN33x2FI+URGfW6audXAgRVy6efg=;
        b=RzKdj4j72rngZHQw7ydsYYqv/enNTPxU1zBFKceeRo1AtodyNWPNwYTu+XgIbNE/Dv
         Bsen9HkZdiejmRO1hLfRVLX/waa5h3and3ga5hoPt5iVdrXMVwauf6FB9NfIFvM5hdwH
         9doOiLDB9jHm84TZ6nMcz0qbeU/FaTq9TYmbkXNS8mRiYWZAUfoOxsELkTmxge8UKkFo
         8oC+rKDjS4WujfTysErTRcvAd9vWSrRJ5EDxKlt2dfxOI7U9bZMz60mjddhBSdMyjmDJ
         OWAgywl4kjjdRYib/NYFKGND7nY/kAhNmF+GjZzzRlbOm6rBKW5QYpSfeiSN0Krn0EnS
         sXIg==
X-Forwarded-Encrypted: i=1; AJvYcCVbMdQjvsXVuXdtfxRvPsbKwUvSLoNXWYWiQcVmUNPUTFdog318WsfagaZD01rSEWLErk9v8d33p9+3gdJb9ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nGZovoMCsFizuIOtHex2wAhLK2xGHItsL6ys2oKiAK9es/v0
	/r1IzZmlL5q+wvjGeJ/ujVayNbhSlWZYqPEq8EypbjNmjgOfoXXUQe0QW33Z4fCqTG7QvOcLk9a
	nx4yDK1m31bAvAOvsml06H1qDsfMiRzi/uHfMUhel
X-Gm-Gg: ATEYQzzngaqUAfNr47fGomV/4R9sbWJKe+mfmaJ5VIQ0xt2q5S8Iqi8lfb1T4NhUpo3
	ugeoy6JPr/NKkVdERddwnh4z1Hf+e4zHxV3WNUkFcKW8y9eE5YM87Q+hK+kuUf+X6/SVyrpP3RN
	HCZFY/BcYjRNpU/+QOXNj1O78F56Cx/DSpIgHg8sPOUgyLCtVIj+7/3qZ7+sdvZlyU7KcUZ43CZ
	83mKYYfJXHfS7AUy1xq4TNw0pAwsUv2+R2da5mTnxh6DAhMg1Zh7vJ5WhFuE8moDXuCSDN0ceoC
	j6Xu7IgMcmULcqaz4gMwzkL0mNj8k2peITqurCsowLFD6u2srnSSARnpBAq9+UlxSz26CYYb17d
	M9/e8VE+xIFjIhex697gl/61KOKO0ws6p
X-Received: by 2002:a17:903:1b6e:b0:2a9:6165:6e88 with SMTP id
 d9443c01a7336-2ad742b4ddemr145518575ad.0.1772042444923; Wed, 25 Feb 2026
 10:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com> <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
In-Reply-To: <5579780966d26d2fd0e3756d404d2156bd55a06b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 25 Feb 2026 18:00:33 +0000
X-Gm-Features: AaiRm50Ofcel8xIk3XALa1jfjwmSOSuMPTyZWqkq20mhBhxlK5tUNoc9kdl48mw
Message-ID: <CAGrbwDQC_jp0iYtpW5JUMqEkJPZ01O4iL6zhyMgWQxXcfrc-nA@mail.gmail.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, Jonathan McDowell <noodles@earth.li>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8556-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,earth.li,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marc.info:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huaweicloud.com:email]
X-Rspamd-Queue-Id: 828BA19BF7B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:20=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> > @@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_f=
ile *m, void *v)
> >       seq_printf(m, "%2d ", e->pcr);
> >
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     ima_print_digest(m, e->digests[algo_idx].digest,
> > +                      ima_tpm_chip->allocated_banks[algo_idx].digest_s=
ize);
>
> Sorry, I realized that this does not work if SHA1 or the default hash
> algorithm are not among allocated PCR banks.
>
> I just sent a patch to correctly determine the digest size:
>
> https://marc.info/?l=3Dlinux-integrity&m=3D177202677128752&w=3D2
>
> and applied yours on top of that (if it is fine for you):
>
> https://github.com/linux-integrity/linux/commit/6efbd2b38b102ecbadc350228=
cc30fd67666a089
>

Thanks!
            Dmitry

