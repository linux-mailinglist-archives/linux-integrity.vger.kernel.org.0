Return-Path: <linux-integrity+bounces-8959-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NESGucgsGmCgAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8959-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 14:47:19 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9A250C69
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ECE1325C15C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8238B142;
	Tue, 10 Mar 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsB+25vM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1139934E
	for <linux-integrity@vger.kernel.org>; Tue, 10 Mar 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147713; cv=pass; b=u+pRGaV/fW4lqt9AaIh8mqVh9MPmglm2pla9mKsSPusRpWT5OA/LzFTjm+/4R6wZ70vX2+WfX/2eE5BxRHRL6msdOEXLfUz46wdcKB1AeUw1piHkcLZ7FfXfiDsgocLGgHjTNCaIx6DJ+ejMdNzSOTk6j1SJQMdFGjdx1pMLsec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147713; c=relaxed/simple;
	bh=80A4i9KCVIM2d8s6pDs7ug1BHJ5YHRI8JuOyIT6WgPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR7HnxkCTNmJsRwUNt9S99qivPDiKO95hK1mgAWZbECIIX8r1Zl75xAq9PxxarQ+p4zbKSpJLDuwAfsh0BqhCT0JbTkGjONmH3MSqQQaPlgkcJYcsw+GauUumyE2EcNEOaDx/ZSp4dNGuKqZKtk0WUyR2v6v1SQh1btyB3V03W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsB+25vM; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a1443780c4so3134574e87.0
        for <linux-integrity@vger.kernel.org>; Tue, 10 Mar 2026 06:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147710; cv=none;
        d=google.com; s=arc-20240605;
        b=QK/UP8dpExNpLfxfFkzd6hwu8xGE5PIyZjQucnEBAu8Hn3NQsfDJIRml7G1bKRyTn/
         4A3ydlO1jPv8MfsagBtRABERGUVbLoN6mNp7fQyn6d/PB4QCjLvDPx1eOGkHAP2+rpMa
         xg7wx1y3Y/ZL+ce+K4wri+6s8c1/FunVTICU1/iGAFtiRJ39mTZ+zBikSwbJ1cQOkJX4
         v0vVIPBqbAPHSV+4WbVTzG8NFfSqanbWknI+NO04NTRlCXXRr+IS/ra9u2Wig99XghCG
         ipOEe5a+Um+hnbum0gTFhAejkxtfz1c7WEtd6a+yC35OnT79acKSpN90a6akI6dykJvG
         rYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        fh=JkrB9kdFMLCRUIPPegJBJIya1Ooa+74D2XXQvyOO6Ig=;
        b=QjZ9qSddDwQEPNOE1QQ3KQmWPgvc6FiXjp1Pn2+jVpg+8F0p1Wv/ZBhldyLkkShEad
         vc7i+enT5AWteJaVcQ/X1f/jxBqJw+tdZvDC5lgQt+m+v2eM7F15DBtRVBUPuBFAUPRw
         QgbBKWZoRpPfQ/uv/rvPgLymcPEIimdotucCHG83Dj7FRGAseQsYBE5y64j7X3x1061l
         ziXRgWC20nAWiuxFal5zyPT0YjBs9thAxO6sq7iUD/KgWNU3MqCIqxw+YfdKpU0w7ylJ
         6XjoFuLzybMTM0wMYVVTrx+jTSljqEf0DaJX8F+Mn0zP2As1sgqU6vw4JyT1JWeKFlBO
         +yPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773147710; x=1773752510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        b=JsB+25vMbEuHjklEfrkhYeJI+Jj36/q1XG+wdh958FhWGtyxMFPPbajXy2F2tQEhWE
         LLtCG5auEInB/I2wqsSSfcSfoXsHAsc/THg400rlBXcfrlfqj6WLANZWK9NGZZiwX0Qf
         YIz94CMUJiC+8zcu8Jk4SWS+sOF6WO014qGsgMvVl5gLDMGpIRfHr4NDrXxX9HX4LLZo
         huJRZXXU+Hl2sx5+evqsvXVGYFxULXozKUerR0gmTLKuP8NqaRfHIMPLwn4jAyhdKN2I
         /gqK1f6wW3ZoCOE4q1parxyPTDynJqVKNQAVgYpStf0E1iZriPO+DbrVLv4OPVODHIzn
         yYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147710; x=1773752510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HmXy9GuoY1W34b++DDgqfMop+biZa4H7WtjxNpBzCHc=;
        b=MU+tOI6a6nOoigx/mfebsIVW811rwwmq12HSmuI4PGMTUC6eeM8BKibN8qHT1V2tUg
         nI0ILbpooc2VzSKjN0wUc+5OJ7Bo2mMsefhw/qlZGTsPLbVKZcfcylvgfQUlB67mWfVc
         KXKZQlE7/3GSnd/3/jgZO7rBcOG/s6pXk15yJzl9geObrTIMHh0RhN+tu+g45AGsfZHS
         rev1sxe99RZgBcdBJWRiSK2LPhIVT1/sA62zrEXPPDKS06Q41itwTl83JvLzLd3s/8Ea
         8xy35E7g27YKeTSDkUD6lPenqpv7ca0nMWhxNbh3tUHrHuMOwjGPjSPDqtUrXULzlMlf
         sfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFc6JdrJJgFOEI095WaR4Bs/UpixXiqHXorraVU4onhMoYHgfpT2nrpXs3MYxDkXp/mMke07MqppRZtYmGCFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6rCYir6BtVmNkkZDU6SB2HcNXopO/OutQmfyxHiHSZQoh+rb
	oxWfvufIAbdQgR023hBf1otVFD28XUaDsOu3bJFgH4K5Osdw11uZS/2ONauuEgOJODdC0X990AV
	cAMEZ5lWytv1UMm5SNdjdo7jGr3q+ZNw=
X-Gm-Gg: ATEYQzwslYBkdbGW8ZN6WdPf5pRh4xNHS1ydwrTmQHUIB3crXYUc9nhj0W6mYGowomT
	F8AUI72OkPki81cOEfJRnPLgLT2bZxhGI0y/xZlkvMAWeXn8Rk+binGkg7FoWkHJ2QrnRCJ35Hb
	Lk0K+ig4c9vnVATq7NOv9QOuarhm3J15lppVXUTAiKkgooR0FYqTGaFlSQgJXu1Nr5Du82MSYaz
	xN07PIZamPe0N85LmYwvvVLaNtnxSeKhD84znaXseLHqWGsOSGuroVhWMuSgcIJm2ngDdWmzxB5
	aVzvwErRSNrd/c+GVOc=
X-Received: by 2002:a05:6512:67db:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a14e48a613mr874536e87.18.1773147708096; Tue, 10 Mar 2026
 06:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-iino-u64-v1-0-18422a053b04@kernel.org> <20260310-iino-u64-v1-1-18422a053b04@kernel.org>
In-Reply-To: <20260310-iino-u64-v1-1-18422a053b04@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 10 Mar 2026 22:01:31 +0900
X-Gm-Features: AaiRm53VuLCINpkeyLwgGa3qyn5MXOBgR8oSJIecEGpm5hN3ZsL6dTvldvEDd5w
Message-ID: <CAKFNMokA0NrTT-iXzhoN0XVJtWQF4+SytZNefseEsGi++LxseA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 29B9A250C69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8959-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,dubeyko.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konishiryusuke@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 8:44=E2=80=AFPM Jeff Layton wrote:
>
> With the change to make inode->i_ino a u64, the build started failing on
> 32-bit ARM with:
>
>     ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!
>
> Fix this by using the 64-bit division interfaces in
> nilfs_bmap_find_target_in_group().
>
> Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier convers=
ions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@i=
ntel.com/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thank you.  The conversion seems reasonable.

Ryusuke Konishi

> ---
>  fs/nilfs2/bmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..4ce9a93149a5af13bc215cc18=
77a757e2c6cf49b 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct =
nilfs_bmap *bmap)
>  {
>         struct inode *dat =3D nilfs_bmap_get_dat(bmap);
>         unsigned long entries_per_group =3D nilfs_palloc_entries_per_grou=
p(dat);
> -       unsigned long group =3D bmap->b_inode->i_ino / entries_per_group;
> +       unsigned long group;
> +       u32 rem;
> +
> +       group =3D div_u64(bmap->b_inode->i_ino, entries_per_group);
> +       div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &rem);
>
>         return group * entries_per_group +
> -               (bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
> -               (entries_per_group / NILFS_BMAP_GROUP_DIV);
> +              rem * (entries_per_group / NILFS_BMAP_GROUP_DIV);
>  }
>
>  static struct lock_class_key nilfs_bmap_dat_lock_key;
>
> --
> 2.53.0
>

