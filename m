Return-Path: <linux-integrity+bounces-8548-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NHsFpa5nWnERQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8548-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 15:45:42 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96381889DE
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 15:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9A2311DED5
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6A3A0B07;
	Tue, 24 Feb 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOcavK0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4373A0B1A
	for <linux-integrity@vger.kernel.org>; Tue, 24 Feb 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944298; cv=pass; b=TMfQxk8Ouksf6JeiKDg5SPQVQX96gX2XNcMAsHNADfBr1toPaxU9yrrgH673fXAh7ZN5+RxH8pondOlFJjQbYp9VHwMtMoaTOAzQehfdPQjXWzTR/UNEXzDd0C/EHeoFU0QRd04wd4yR15OKVTZuc6CpQuIMge9MudnlhL5lIJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944298; c=relaxed/simple;
	bh=NpXDBXAqbPlLtzWPxOL/h0QZP9LJz3X72C7AQTPy0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZmXiDz66dEoZrvSGdukOF1N79Cbo1vVF+AltpkcSV9nNlKF5pfeLS6KJb2eaBnhyVvGWfLZ7gRVgD1pN5jLzoZ3hMIfJ6woGDMxxrUUekfTvtZCoCxrMru5XdqKCmPscrlXhjC7e9Ctov0wogbOwosLxYONdDKfIXGmlOWogS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOcavK0; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70b4a69bc7so1117108a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Feb 2026 06:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944296; cv=none;
        d=google.com; s=arc-20240605;
        b=SQUta3L07RsMuUbuOxc+ISMa45lKX1gjzfhYJk/OzdCLk1DTb67RcpuQChBVit1MTo
         gFL6no8B90rryOmI7AseWu1WSa2xWtdLnn/bxo58MJLKBPNpJtPtI0ltKCuVKSe6Rgpb
         cbi6ykKBpHghWd3SP6BRvS6qoIJqsDgb6rMH656beIo/YqvV+/XFJXP+cEGeAE77pIEs
         alJKAPYD6hBX1Zu0S03TvOc1ePz+H9P7tzyZbBkoz87WqMcE4yQyhbVx5s1pfrrsBs4C
         PYfk9uUtEsn18wyE2Oki4xMzg/9ZptRlb/5veMGaJgK1UBFH3QNzZZFy3BM7bAXIblbL
         clzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        fh=1lRWDbUH1jqBEGYk73bUiG1Q7hO8OLkMD5gstiZudZU=;
        b=MS1t6Iqhdl+4G977fRvemsPIvqXWaG/O0UEWT9sPtuDUFoJOLuutzPH6DDuo0RMoVB
         iL15DsacUogwh5jtyhfl7A6NyjMYGkg1wCJsDm6pgSVkJcXAqLQq0+0sYaXAcejUWbZ0
         ZXmrUes6qK64GzfoOvKTfsf435mJ7Qx4O7t3yj/fSpSP7i/6HocScdQ5hqpsYyihD2dy
         1H40LI49Ci72qxOY51U/c0j50eymlLbUn9aVcWhGX6x4naqsPTgea+WVi1ScPOOaGTbc
         gfO+tTh4DWByRMRsMA6MyOnYimCC9IQqtaYMygKpQWXo+x7LCZ10xCzy3DXC8VVH+Sd8
         EQlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944296; x=1772549096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=LBOcavK0uZWARHpfwTPAPRL5N89Z1QVZ43J6IN1qDaESM80vqGti73ZLcQ2HqG8aLQ
         FP4xrvcPMnUTPHoo+zyhHmBSI6Q0wLvzsoh5iVk3aifVv0xFKbCeuAkeQYp5Vc9FrYni
         5LSl679JJ0OP7GlIqLGhgA57/k+40Mu6UHwz3k4Fx94frpv4tQItF5rFAA7XVGoH2q8n
         OhP8N71bZ4OtpTypA9Z8inSlfz/QYYT04pnSWEX9LMRe3/gP7IsrDOd6Mj19H2NAO2zK
         7xv0bp3GMOxqTSyG+sx0m0Tg+n24tMxDiiGlsi4qzxfLC1/81hu+Pp6I55JIwNNbLALT
         /byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944296; x=1772549096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=DzGfl6jI3dLj6DKlDNmvkQq1lQiVNx4/xbJzKjHbAUCfSnppoRo9KwomM9bHNb97Bx
         JFRKOQp8W5+Oddz/s8IMplge+NWSAlIYRpGDRuLiIyJB53rMUeIxxP6JcxDUUel95mry
         Eu97HrQ3N7/P6XXtlppYF/Mv7s/+lq7kZMitzr7mPL0ZsTHe5NjJA3fPXC1ZkarCcvde
         8LRR8heOVS7LM5zMNkjLtue4CvtYOhP4owE0ZW7B+V+leiJQ4Yliiw7hJehEu9u5bORv
         tipHjtoXcc1CrjVYVHK7T35ZMhYctIW6JcOfWR7a7OOgMhMiftWuPD8DxgAeCy2NzwVr
         6Uig==
X-Forwarded-Encrypted: i=1; AJvYcCXuGRXu7lQg7tE7TgN/cBxRnVMWqzcj4/8Lp8o26RJ+8V9ygBLVkmufL0bGiZHA2+WytgcRwB4zJQH2hr0hhKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0/o2kg1wrC0nRLuh9tTHf30VxJrWtmF89fBoPV61YF/FSJ+/
	oj0CGSQLew96A/Le5QzIxGyevnlPasLpzrbRxsaBFbxA4xXdDSawTOBGhjRHoxyuhkb267YChQT
	hVrt/4X8Og6BAAttAp8AG46KUVOKBovE=
X-Gm-Gg: ATEYQzzkEEZXHVcr8rqgCbpNT/PG2U7Ixbb+1ksOjmRd0Alch70J+8TYkznuzZIf+GA
	EIsIJyr73/MXUUmg99f1jyOvMjhQHkJ0EgDueQ4PTQimeVX43vzIz+IW1mnE1OTrjJGmLi5Azt8
	H5dO4BQ3PysnlqkkE/IC6x8aqvDsMmnweWpTwsBdSaIM982hCXkbEa+u1n9hjDwyQ8qvLFAedEO
	kh/II8b6Zvl2+XxoDLJANgCn8iLZEXBpCMGk9pT/yZGkceMjPjozeuer+k+B4o1ZTZxsNUC7vUm
	BwfVPLQ=
X-Received: by 2002:a17:90a:e7d1:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-35903849c76mr121288a91.12.1771944296292; Tue, 24 Feb 2026
 06:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 24 Feb 2026 09:44:45 -0500
X-Gm-Features: AaiRm50Bs0-On7LLkESDz1iNdkf3h1DBjn6hYvjZSdJVINzCMBHE_JQir6F04Vo
Message-ID: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Paul Moore <paul@paul-moore.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8548-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[schaufler-ca.com,gmail.com,vger.kernel.org,namei.org,hallyn.com,canonical.com,linux.ibm.com,huawei.com,digikod.net,nttdata.co.jp,i-love.sakura.ne.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B96381889DE
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I'm not going to argue with that, and perhaps that is a good next
> step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> that drops setting the S_PRIVATE flag to see if they complain too
> loudly.  Based on other threads, Christian is aware that we are
> starting to look at better/proper handling of pidfds/pidfs so he may
> be open to dropping S_PRIVATE since it doesn't really have much impact
> outside of the LSM, but who knows; the VFS folks have been growing a
> bit more anti-LSM as of late.

Adding S_PRIVATE to pidfs inodes was originally motivated by this bug repor=
t:
https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.thel=
io-3990X/
when pidfs was first introduced as its own distinct filesystem type.
Otherwise, Fedora (and likely any other system enforcing SELinux)
stopped working.
So we can't unconditionally remove S_PRIVATE from pidfs inodes without brea=
king
existing userspace/policy. If we want to introduce controls over pidfs
inodes and do so in a
backward-compatible manner, we have to either move the S_PRIVATE
handling into the
individual LSMs or introduce a new hook in pidfs_init_inode() to
determine whether or not to
set S_PRIVATE. Such a hook might also handle labeling the pidfs inode
although we'd have to
see if we have enough information there to do so fully. Note that such
an approach will still likely
end up leaving pidfs inodes created before initial policy load with
the S_PRIVATE flag and hence
uncontrolled; not sure if that is a problem in practice.

>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 318253344b5c..4cec73b4cbcf 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void=
 *data)
>        const struct pid *pid =3D data;
>
>        inode->i_private =3D data;
> -       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
> +       inode->i_flags |=3D S_ANON_INODE;
>        /* We allow to set xattrs. */
>        inode->i_flags &=3D ~S_IMMUTABLE;
>        inode->i_mode |=3D S_IRWXU;
>
> --
> paul-moore.com

