Return-Path: <linux-integrity+bounces-8366-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENu+BXqne2lWHgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8366-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 19:31:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E1B3965
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D00A30037F8
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD262F361A;
	Thu, 29 Jan 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X1qGmbCk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4272882A9
	for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711478; cv=pass; b=BSUunz3WM+8iha6Perx/xfyBWddtIsUr+nxiVni1ejHNxNjjwZCh0crLanv5HqjZbgnvrl3sTqNw18Dh3vlwGU6DEG7hQg8TT8k0YIh+uPShj/ajqjvcHpFE6ZPv1gQEuJsCL0hg7txI+6MO4Fdi1QYULfQLsbh7ovlHGIdYSDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711478; c=relaxed/simple;
	bh=Ncr8iPFpMGCLqXwGz8eGHHDAxANhA4AXkI9FgNfxy+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoeVMxGOxW7iiUOcXnEm/69C1LdS72Q3uTmKmC7eKhceSPaG6UUP/PJpsKjpeZ5eyj+bEn/+DSIF/22YAZk4RkzRS0njHOnelPltAhbY+q+8e+sMb+j7V+j+SVPVQ8L+cdSO/xEFD3oXLGNo2PZh8JclxgJ2t+/BlH6Nk/QJaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X1qGmbCk; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso8430735ad.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 10:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769711477; cv=none;
        d=google.com; s=arc-20240605;
        b=gJKlU4j7P7lO4yB95s6C88Rht34+cix2qXnx07vG/uVRnxdn3aMY+cjR9bc+a00jYg
         WHgk1WwLItBg4IlmHNDHYXjcZnSaqCgLmvF2BJ7KeZj1Kln/chyCCl17r2QJMFxUa2lY
         6yjDGSbY9k+RanalpAI/dUHnese4yCXhsjOG1Cn+eIQHNl54YHsvMkC3L+nmvz3Igi9A
         knoQCZQHPZlXRF27O9m8TNxwtofDvntakbxJMaJTmm3DTJv4jyzo7bX6s9DthcRS7i02
         F8iOV/pPgIOHny1b2xSWsQFtzvjVtaTgQFtehe1tkg+46uHVm8vQkeE3FmbdIqfkjK4e
         Xp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        fh=AnPgiV6t5TL7g9nUdQ5z7JLjaTNH0f+nQrOHEp/b4Rg=;
        b=G2AkFd2ATJ1I7+z5LA+BeoiSIqgi1fOL8pBJ4ASp1KB9+xYz4gpZbIFrApHQ4paFqb
         gy9X7CvoBGQ7svNoH1IGokXmzh3Oil1NSV6x+46ru3ErbRHvyXSEE6llpimq/OWSDVyy
         PK9SAmZGMkV74qfH2uJULZ70XPE4ZZfxxeN5lDDHL+W4OgPBPXnCZeM8y8HjztMy9zuy
         0UwRSRSklG1UntK9b6/E+3qi4w3F0jrF909XtyNYiohqocK8jM0tRAhGZj9gtv/APGOo
         hdPOyECMmPLT7SD9l0Dm7GJ4Gl9UOFke9NlsYDFkLJsjHcVbGJMyV6NzGW8/Rvjst5U4
         0IlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769711477; x=1770316277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=X1qGmbCk8McqlrmPvQOfTsgOcXqXyjcTTbQ2lfy/7HcHA+dRHM1Lx5fLQGK6MRE0LU
         /RKiY4+i/O6I6nmzCxzc21Ssln5oBRcFpKRXYe5ouOzoIs0fxP5uCaaF+/HAKs2M5knK
         LrUX77EFYutKMd8FZfXre9ZZMlnnJw+HmI4t019wcsfivnZN4mXok5iQN4h32cwnJkMI
         EZxvZdEuo+5alm8VHOr4RpQZCvBWwj2eEUrXUyplGY0QS/Yo39NBK/w/Ci9p9r/Bh29q
         d7UJ/yQNOF/BKEMYmxmm1k0/Z7UDxkcW2iLM1NmPguPt7wDGXPt6pSO7FlyDvWs0Vcct
         6ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711477; x=1770316277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gaMEmesNW/2aeijf2CTvDdAzAco5YKTscfYAQiEGCu4=;
        b=FbhL1NgapOQ/mofENKuYFnQTtpp0hQ/6XsEtPwKoh6ZveXv1Z3ZaeL1IgP16sBc9VY
         roQAkueXRfP8IiQ8ZvWdo9DzLFpToFz9DMNtukTGZi+BTtrMhNfx1lth4htiYijG2fB7
         QAkbVKrKOj1SIWcKhKyc+4fJzLbaSEVDUeuEO726e+aOtjCmVXwK3MrgJyZcSuU6VmbJ
         ikLlPT5Yzbp/5sb9h3NUr5QLGogEOm2W7cdQDTrdZX0OIGmj5XVbF+MQrBuV/I7U4Eak
         RA3AzTHwy7nbB/pqQ+OdBOcqTZukd2pIzo7dB0+TNrrc/81wdeCyafK1DX8UI8BDaXPC
         TqdA==
X-Forwarded-Encrypted: i=1; AJvYcCXmzxbEXgnVDqJnqpzShqUtsH5/KzMEACHx8FN+1bi23UvjcwvrByqihVNgjWvqXzDNzt1isHtcvK2fnRDLF3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nzDx3gxHyf/zJWUxboxSslFSduqxNcH6yWrliEDN73f461TI
	d4CyyyQT5rMTcuIpu53gyImavcca/LXuwXdylm0+BmMTWnm1I7HSYbHcqTOxlQ4T+XCJOWz/tuH
	/++w7xm+94r9o8rTNqTVp/ehNTTbAeb2HZcEetVlW
X-Gm-Gg: AZuq6aLLRjOnKoSvp/ki2y771fbkGuJTaVwCitsKM8XZ9mr7AIU7bcWKWddzlf11X51
	jtx1TDCS3MvTgYCwdf6ZLZUdFyvDU71GG56ucIYG+iKwMzPIWLfMJtigx4cwXvl6UWIJFib3N1a
	wqFP8ay/6O8JlVh82RyBDhdRUl3BArVJ++575LYgeYtWJnLF9G+uaVhxNjL5kTLOWJazQ8sa/YM
	HLxDjlQ3L4ac5x0z1K43AZB+e4wglGYhSAuXN2vxG3vJqL3vAGgJtpqBTOuwBAzRsmvrqE=
X-Received: by 2002:a17:903:f8d:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a8d9949210mr973325ad.53.1769711476784; Thu, 29 Jan 2026
 10:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
In-Reply-To: <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 13:31:05 -0500
X-Gm-Features: AZwV_Qj91bihFusy7ufZpFTlJZmfomzjnqMHFZc12ATcxs7ntbmfJHUq6C4Bs2Q
Message-ID: <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework initcalls
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	wufan@kernel.org, mic@digikod.net, gnoack@google.com, kees@kernel.org, 
	mortonm@chromium.org, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp, nicolas.bouchinet@oss.cyber.gouv.fr, 
	xiujianfeng@huawei.com, linux-mm <linux-mm@kvack.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8366-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 676E1B3965
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:
> > Agreed, the mmap_min_addr should stay visible and applied unconditional=
ly.
> > AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN=
_ADDR
> > is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_AD=
DR
> > and the sysctl-written value?
>
> Thanks, yeah we should probably actually move the non-LSM-relevant stuff
> out to mm to be honest.

Yes, definitely.  Send the LSM and VM lists some patches after the
upcoming merge window closes and I'll make sure they are merged once
fully ACK'd.

> But that's future work, for an -rc8 hotfix ...

Expect a patch later today.

--=20
paul-moore.com

