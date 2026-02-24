Return-Path: <linux-integrity+bounces-8551-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKWdIzb4nWlzSwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8551-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 20:12:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562018BB7B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 20:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EB06304025E
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0E2FF17A;
	Tue, 24 Feb 2026 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KhhbuuKj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53122FF14D
	for <linux-integrity@vger.kernel.org>; Tue, 24 Feb 2026 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960372; cv=pass; b=EZW29HLppkYBPNxcZgi6o5J4jLrGwzAb3duGKrAXZ6WfgMxVTS+WcDjCppxFyULSvsskxL1Ry89XYkIL3DsvTcJu4g1hdDxkZlGuK0S8abj1VUkpBOCwN63qw3A05kEZaurtdyYCF3ztVVW32dniqTZVNZ065uphDAmmpy40N8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960372; c=relaxed/simple;
	bh=Mx7EWvPLyqSJRzwqUTOqp6F3rZbh1xURjor89wXlRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AA5c5VTR8e571lVvrTE+CFNVP1QqD9EC7oitZGgbY2y3VKaNRMlPZa7XRFGCHtUIyI3ikGXWIJi9xUyEgLl0paABX4uyZw9GfSxdOVbSHyxzdBu3HSKWKZZIAcQe/+4jQ46gvn3B/HWf2xz8aDoOTLfY+YBtVli9Aq+F/qiuRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KhhbuuKj; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so5685875ad.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Feb 2026 11:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960370; cv=none;
        d=google.com; s=arc-20240605;
        b=HVOdd2IEt+TMebtC8LFE/UTV8PvGOq9cDA/8D3bONtQJ261mlU63h686GgGksbbMPx
         A0p9qH5rTni1O/T5SZ6+sy5l/64iaX0JyVRsI9XerAC0EIiEEFJFL8oscoYVQfSs4bsO
         O2i3kr0u8iVz5mitdFl5vXN++UPFHKmqp33GKIUDvZdb6yZv0vZDSzPrFQ520n1gqjam
         Ij9tu54AugDvkBjqTg7lbwfo5Xq3cQP7tfBTLqWUnll0p/lx0omPW105OUcqzcegt8sI
         HOscdeSU363F55XNHXmbV3zE1HprQdNSnAqoPyoIZfDCjN2cdcIeTlJ/N+zeSZ/RrmIL
         J8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        fh=4wrCWU36oVBLToI3QtoYbkRf/uhDnV7FQNlW9zB10IQ=;
        b=bE+JX8hV/tP2eIhoOcbZvxKCmpik43o6BZp0fhgCDVC6iet0tc8rgpRePA2iZL0Fjj
         Q4RaV66VO4a6J29rtrHdjKRycuqDP8kgt6xA9v5l5ya1PHwTJxxWfKSZf90iP6YfrWFD
         mUzZYA8JHHT78Ym9X6h6TLb4fIFfmmtb8fhIY+yNJMpwGTp+rwdAF+rOivmMTZOkZlcK
         Ubb/j/WsRlYSjheB8+8KA4yuZocQftr6D6i9D+bXtMEknWuDQYFINu78Obc7xkG3w/St
         JEhxYCMp7pAluDwPc3WnU6cMISHnKfh3wHQ9sOMKwhjSVnt/IqffLQNXRNpR4NQlaGIA
         VK9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771960370; x=1772565170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=KhhbuuKjR2JZaDvUwlguZ7AuuMNvsmzE4zIPHLqtgm2iz89AuXVcj8Hm/uzUNYTJpc
         4kDewaiBV/FCaeIN++4HzE1v45Gx3PptJ2DCUFJtfGrFGipyl9O9u/msqwZsFDmSbRh+
         Yyi+W8+d/Qgzh1UKgo6+hLF1RrGHLQ8HGiPvsc66YIGxomqKrxgLCXTY9BwWzeH9GlKS
         Oeqh5fBzOB99TnDnZf1EowhWVBj6VUmkQmmprTAbcZHN+gZRle9uH1aKwY+pZBPkssTQ
         V4LgTNhI3mYkzL3NWPU9S5pvZBSE/9gMjl1wL3BM5r6x3Aon9H3s1fl3dZxbCO2ioL/c
         vpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960370; x=1772565170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=Y9P562JFYzFbyY5RysDWG8N8SC4SAz77AHspv6alK2K7jCnnvuOC4WjBO1j1C4p79K
         7ttXqQf9WK1RP3+wZoETRBBl4nqdOiEWszYsDKz4xflxROuk2c24Hh707mN5PBWcVuyr
         MkJW94meMedcy7awL1ruk8uF7ylOQMD2JMCmf8KE3Xa6CSXaahLWv2PKuamvXlfoth9U
         tWjOIpiSgfmSzqkM6j1vx/wZUVI0fWS68uBTTRzd71RqHjLnG8peLSzWO+b1PRTBZj5f
         K+0lcWVt6zGBK1N7o89bj2LqgMMSCDMu84XAiqnZ6gIlXyHy4riA014hRIhoFH2jZ7EP
         dwGA==
X-Forwarded-Encrypted: i=1; AJvYcCUOcwoT6vdWXWypv4PeU8+5f7TCZ3oO0HP4fYQP0Vd7C9ROvwFchv6nl+VVHp0jWWiuxKTK3Y/7Zd5O5n6D8g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGXbNqlA0ZY59NkZQf5Dosuof1jeoDWkdVldGWHovDurCngIm
	SysW8X3K5TjuEidkHRjJ0+Vm7xW6lb1wNzBARG8i/m7YEad2JMVgELSYj3WuIrmtcRzP+IebmQh
	cTBOAmXFkdWZKxbofrgneVbNXeX9l4S/pi0XbSpFi
X-Gm-Gg: ATEYQzz8hPoKS5yX1y7x2ecJqIa8Mmj5DPombvPhdvHohnplwySycA+KblkmEcj5iB9
	cvff9kOiHZU4CNlL08TM4iURm+Ap+cIU0oxPnKsjlAOC9VYebkePTE1JsvGHLZTiPx9E3vGPD/k
	qBgDyXYoaD56nm9eHavZRG4eZ0MCLCImpIGOrEEuj9zSDMeRzFcNvPNp9bzM5zo7hlWjZirYffO
	c051IvK/tqkTFrD9c+KHNREdNFysyQq0JUVro251fA9unFxeOuC2rzwuF/anLsk1R+6i+IHrwC5
	U6pDC9E=
X-Received: by 2002:a17:903:3850:b0:2ad:3e57:91b7 with SMTP id
 d9443c01a7336-2ad74447156mr109545555ad.16.1771960370108; Tue, 24 Feb 2026
 11:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
 <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Feb 2026 14:12:38 -0500
X-Gm-Features: AaiRm503rW9ZOS4V4zxiebdUBzdo3Pfwr2D3jQYLmSqJvm2WIFtI559N_YW2Cig
Message-ID: <CAHC9VhRmAH+mymmoEivKKNgGScUHyD-2t8t-ed+=r_mNzT5wzQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, danieldurning.work@gmail.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8551-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[schaufler-ca.com,gmail.com,vger.kernel.org,namei.org,hallyn.com,canonical.com,linux.ibm.com,huawei.com,digikod.net,nttdata.co.jp,i-love.sakura.ne.jp];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3562018BB7B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 9:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I'm not going to argue with that, and perhaps that is a good next
> > step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> > that drops setting the S_PRIVATE flag to see if they complain too
> > loudly.  Based on other threads, Christian is aware that we are
> > starting to look at better/proper handling of pidfds/pidfs so he may
> > be open to dropping S_PRIVATE since it doesn't really have much impact
> > outside of the LSM, but who knows; the VFS folks have been growing a
> > bit more anti-LSM as of late.
>
> Adding S_PRIVATE to pidfs inodes was originally motivated by this bug rep=
ort:
> https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.th=
elio-3990X/
> when pidfs was first introduced as its own distinct filesystem type.
> Otherwise, Fedora (and likely any other system enforcing SELinux)
> stopped working.
> So we can't unconditionally remove S_PRIVATE from pidfs inodes without br=
eaking
> existing userspace/policy. If we want to introduce controls over pidfs
> inodes and do so in a
> backward-compatible manner, we have to either move the S_PRIVATE
> handling into the
> individual LSMs ...

... just like was originally proposed.  Just do that and be done with
it; back-n-forth like this just wastes time and energy.

--=20
paul-moore.com

