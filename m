Return-Path: <linux-integrity+bounces-8368-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAl1BDDoe2laJQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8368-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 00:07:28 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A94B5966
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 00:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC463301AD28
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A00374195;
	Thu, 29 Jan 2026 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NN3bmjiX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADDD374172
	for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728009; cv=pass; b=YhNHSIpxUyi/x6zmTAtZvfEcDN9zJqg/Y8elspaUqZRd8j6f5fmuZn4itm1qvVwkuMIRBPqJ4gkBQ9RRpWpd4/9f8XML6+IqVVhW6doc55wbmJkB4hxG/DvrcVlyMbtKoiq7UnkdEnD0xhPi3ev5sJZamRCb8E3FCmIGxhk1hcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728009; c=relaxed/simple;
	bh=rjhov0GaazkCkB4BJQ8rdsawUcuL8ouqck5WKEqQ570=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEkbqsq6reCZwnnT0ZljabwNyf2Mul4D/oLouSYxgHasJn7j9Yh/gWS1mYvMHhutTTMogTX/bivmmUVLrC05HsxiPESJ/E3nlEpqNYxNTvRyj/9JPHEQvQ7EGnMlvPG5I0ORVAMcmKoCz/ubxPS/A6eGO40ZAj979DRW7is6j/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NN3bmjiX; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c613161b489so611218a12.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 15:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769728007; cv=none;
        d=google.com; s=arc-20240605;
        b=AYWEJBFLHSr5AIUC5qEoeCDjkDGlyq0EwN08gmtCoP6JaIa3/iaM2+pOyU9tkdB5cV
         fM1jv2AhSFPYCcgdDFhoQsVvF23aR2o6IYiWzs9JmRngWRnD45UAFK0w+W6cJ66MaLgp
         Xpeiz7Kq5c8pWgf3qzH/6X6mWXAEMWEkeoGTe6WDkDj+dyJNL3EJmEdfaUmMOPlREs4V
         nE6ILOXsHZ9gjUcLgJjhX/JsUoDBYmsldAuKbTcbktJ8dj5/wdAaLTzWtuSf9FEXexXb
         go5V93PsTmj3wGoPZMtZ//Kh1ZMsX9Oe7ATjZSvnpwf6/E52z67yNAAkqtxAqeuCS1mv
         /9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        fh=xAuSuXBeDcR1FH7rNdYBsdEiSb06wLzOzefMhRlTw8A=;
        b=XnmB+93Hoo/1VwoH2leXJbW6SvpI5dyuGMtnmTx0yPoYYBiLs79jCuPZq1w3T9p9O6
         jK0gJLvXPIltaaWnZXJALI644niE1npSjovR8izHr+XG0p7r7BFWDYfqprbIuILbSoZP
         99g2eN5j/lwwqKDBD3pAcf+0DsoIkDL6Qu7PSuVaFiSRtEYJTqGcr9PkdKWrj/rEiLRp
         wk3z6kBUmO5kmxESu3EQGEiDkan0uJ7fyZn/l3e9yHkQ1/b4jeLexsxtY2v4+WdBGtRI
         D+1zE7d4IDUFiQywhQGpG5zqWjehTc8bw0NY7h2RmJXRDwnc7hqzhKw2W3gy5cnJ05Ek
         Lu5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769728007; x=1770332807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=NN3bmjiXJ/1Rv0kUuYchAl9y4jCWJzaiPufbucyLnNUW5M9flMkq1Y1DGpUydxcAiI
         qb6HH2WBAe5GVSiGL5+rUimTErvV1CP3qxe+Go3H23xqJJICSalnAqvHBc7JjTr+u//O
         1RpmkBBfFBTyrAwGUFe3aSE5419JmQk7rD7CXkF9CaSsDciWjPMzSQSj+S8K/c/XJt/p
         /WYk7AhwbQTQnjeRgtZ6Ikfewos9c47YuuuSV/cJ1MY7lt58nccSyPGHxdSy7lr9cEUz
         szXTR1CA7xO+xvPYHUB6kIaVxcgDr3ixzFjfnEU+CYEpCILP8NcPI3MpmO7GnEJQDSgD
         jkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728007; x=1770332807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FgRhUI4ULyQ5DXrJKYAevPbTbBkxgDEbQDJd5wdBQ4=;
        b=QdNoMAQjJe295nLfJK1eRFOgHrj0HxVVAVhdwAXT+XeLHKrXeaJc41kBCHZUhZlojb
         paNbWhiv4jrGoih4lXchHoUHksmZWx3yy/7ZyD62MKLLdQBHkXlJmBqIjX+djUbmeKRV
         4bbsLQIv/gUKXaPMwqF52sLuw6fUnaIAQvafcZZ7FUGeMbjJGE4Tq3JIv+W69S/Xc7+D
         J9lVCkj5rayvZ44gjTm6DpG/7v4PIhtuDEZBKtpPcGSiINIfxAs/pREurEbnrz24bMO0
         gfNSYABmKr3kmDDRfiGt5bC1EK+VeJuQXv7qsADKdAXuqbSop+OZOoNOQqH3TAWDOh2r
         Y6sg==
X-Forwarded-Encrypted: i=1; AJvYcCXQODTnSZzB7pyRgHNggstE1o7kKBPTXevXjajsNJxZJWp6Zp0P1bba0TU/yfDOrhd5pzvadgNk+f70CpPIx8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbA0bj7FFPnPaT/Ma9CTEjz8pPn77/pUImCvj54svPCK0AjY/
	itNLHNDAuC/A/a4X9vEBkzyPm0WBYs95DSDOBr0guNRrqhl2QJOAlgzVwKDd4x4+Bl6D53nVwQo
	2YFDXEQov4Ckx76pNSxK9izbMd2DC7KdDodTXMPwt
X-Gm-Gg: AZuq6aKHT8k1o1sLUnoAIDvHV6nRsDX+AMJ8l1hVCmSMRq+IE4J08Ck0/qSlS1zrz44
	XR9sg6XiMLMRpmQ3QgbdAWZIgyV7wDwfOjUadtKV+yM7Qg7C3lVsnFfSL3kn5BwZU/yUiwfPlJ2
	bxVqYjlQDWACdclamEGEEFrSd7ZIywnkVTeCz7zSwISGpXjjpXm4Xv1usSR7Pi2sk0tQnx53mhh
	Vw+vSzklukpNdXrj4LaAVy8nxJV5RqjRcdlg8Uy2Y4G5+X0tHIZDm6oFfZbjG47seWk3wE=
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3543b2ebe3fmr942700a91.6.1769728007348; Thu, 29 Jan 2026
 15:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com> <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com> <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local> <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local> <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
 <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
In-Reply-To: <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 29 Jan 2026 18:06:35 -0500
X-Gm-Features: AZwV_QhVDVaLZs8JJVAmxYQR-vhXYvsk_Nd5ubbkE2VXzkBWSDq2lgRuz96U7i4
Message-ID: <CAHC9VhSqpqVT4oFzvFpReJbh247mJnAz6U9ax-DS3oapHRnf=g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8368-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:url,paul-moore.com:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 63A94B5966
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 1:59=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jan 29, 2026 at 01:31:05PM -0500, Paul Moore wrote:
> > On Thu, Jan 29, 2026 at 12:11=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:

...

> > > But that's future work, for an -rc8 hotfix ...
> >
> > Expect a patch later today.
>
> Perfect thank you very much!

A link to the patch is below.  Assuming I don't hear any negative
comments, I'll plan to merge this into lsm/stable-6.19 tomorrow and
send it up to Linus early next week; this should give us a day or two
in linux-next and then most of the week in Linus' tree before the
v6.19 release.

https://lore.kernel.org/linux-security-module/20260129225132.420484-2-paul@=
paul-moore.com

--=20
paul-moore.com

