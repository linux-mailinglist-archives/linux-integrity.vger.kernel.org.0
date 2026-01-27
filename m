Return-Path: <linux-integrity+bounces-8329-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE7CILePeGmqqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8329-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 11:13:11 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3F92891
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEAEB3004F07
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FC033ADB2;
	Tue, 27 Jan 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="R+Y+q3a/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D633A02B
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508788; cv=pass; b=OvGT664Gmbzd0VJaPr4VsQaNOGw8yDIPQPyOrG9pRRfjMF/ZlrrNZzRwZ/FQKPYn1OmMuP9bjd0JBO0eCBFrHEH2uPZpKzvNuwo/gFMFjMEYv4ltamBgoGFzHsiOnPhgWsjP9N8YHWcYRVEuF5dMqehGQpIWyKRyztypYF68DwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508788; c=relaxed/simple;
	bh=BNkNDaRw7wJvmpZ0xqHoUNkLvSMjGh8Igx22lzCei78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzWTOuMNc3SwvdK/AvIjJyknG1Z0GsclZMImnS2KsjuQ4z2wvr3JZRgl14n4rng46dZmriAI0tpBl4a5cvty9ucG6XHgvFY+XKdgqfXeIznBkCw86GGWkrszRyLF1PH2hJdbKm2BSK2Z1r/ms/4l7b6zsJqmy1C9Is7/yT+7OLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=R+Y+q3a/; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c56188aef06so2245581a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 02:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769508785; cv=none;
        d=google.com; s=arc-20240605;
        b=EN6FcxggAXxUIlQjf525aNWyviCbxSWAwR67Ary9sJLXTXQx3BLA0+poFWQnuP5H8D
         iOxfFK/la/zax81RJCJGgU4qaiUXsbrvgH50AwKqRudCcIDV8m2Tk/6f36ZkxrC6DBC9
         FQEo/gc9NehasIPKe5ueZdcOYBGEswUWRGLX9+SZpYXR9mMbHcIFe3iCkSlfpLPrGNs/
         VRMjooVlS/JJJLzzvPQKXdAcS1VLPwHm4+Mc6BM6a/0kADdBwX2PhJScGTEBrniiElT/
         FMxKOUteFpncNoSWyxR/Z5XHSIG2fpDnKqH2J2zd5T4NT0YQBNQ7q3prsoTjjMravTjL
         6TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        fh=7NvRcxaok9NZwsoispJrF/TQp5ABArof5D7lFo29GGc=;
        b=gl2pQ45gBTILxK7mb+OJnahFcvz/GnJTzCzJU+T4laacSy8QCB3i83FHkP75IjXZR3
         +I3R/aJXrJciY4D6zkgIxM8hCh14J4ITL8gUV6QiVOdTRurPxmmcbObMzV1cz1PQLfux
         8872fa4dajHM7vsWUxyjA5hgcsHOXSMdTW9eyafVSyDEQNXI3C58sFyDM5hJurdRs9TS
         niYmiJsKz7yzoSMYp7HVllYBAb/OsimnKP9XnDIyhgSnCb5jw4UpNfkywYmTu8ahVPl8
         6kIHR9TyZSZLKjfEsuzqZ9vr+EC6fQapboEyUtjoZus8tV3EgxBUwTJ0AmqMTyHNhJov
         A1Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769508785; x=1770113585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        b=R+Y+q3a/aYEchjOzn5HXLDiF0RVAXsftb6tuQUYXc0zlnJz6l5E4JC6dIfV/JsMBg6
         MDugf75hH4Iid1xZPUIFgV7hBSWCHA1S5gPl0vKoKW/cn35Omn27O2hSRHDFLBh27bQs
         kYTj2kMdVeWRY32MZrP8RixIH0GHFF1V9xiOqMvuBwz7tRhOAFOHc8q3R3uXW6Lr8GP4
         ZWpm+Ylth1TggyrMiRy2p/9uZZtFzmrC0qJIdKBdwXei/vF2vtSGvabuhZbCi5x6C6Sd
         i2nPJ/VkosfwtUKabOnEIWjSFtSCmO8PSB+NZTO26PDY5ZhrkDgYtZhzDguylFzBbMN4
         VSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508785; x=1770113585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbeSfjy2R8c8CkBxZ7PyS7O/VnqwWM72yxw330pD0Pk=;
        b=maxt3Cq+OL3R5gz8E/4jQ2p41tCG++2Z/iesR+9si38pg95bWqqIzFyjUwtcovmfZb
         vy/56WMVTIwrLb1gfLG54f4ZN60BfEa90w6kvmhB/5BeHZV8hhT8gP5MxVKzvyVmudUj
         Y1aJlAjdig9hnCxbEhSU0IwyqxWFLqsgMWhKmj5R32M10vpQVWdWYg/4GuEK9XfA6l5K
         RnL8ZF2nccz/1bllEV2/ijKA+dVt+4w1qi36qfXf7DD+BG8ktifyo82JUiq9nUu9zkv3
         5jPAhXMaxRvDSIc7u9hXsZGDWwYqmbUmmzEmpPgsd/zFAxWmUcnPENYik1GkexCc6cPY
         MXuw==
X-Forwarded-Encrypted: i=1; AJvYcCWBnvmHYRwgOpCovavWCMER5qkoG/YiKTNOmHgGdH4PSW3RWUNftA9MB07F9KCUPyLg2NqYvsmXJ8Pr26kOu8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKN5H/21TpciGFWgmlBsrXuJYJidZr9DrsEGmV/oGyvMaM7Er
	uITat3P9RwAIimE5cB7FX9VKtWTgTvMp+TErRz3D1WRg3MY2I0h4PCru3XJTCdRYL81U0dfRMb7
	Xc5cREfouOJ38dKrFi56N8CfE21zyovMZX3bzQKCT
X-Gm-Gg: AZuq6aLCy2QQnnyOJnKSE2LcYxWyMZ8eDrn9eohp2rX3PdgtvCxsH0sKHckhpilztUq
	/Itx2tWqy9uPXTeTABjbzkuc0Y4K/jHG9RbSWF3iQoQmj+Ys1968NkSY9Gd0icQ044ML9hkt1np
	cDB8zHxf1CcYF4Do85WE0v1nKdFhZG0gsIUER5eHQRPJYg/b0pxu/MKKSZWhPB0et88xGzdTO9A
	Ade7ii7AM27wnLD1+5ZXecUSBImUGVL7lBAGH/qrE7/7IyaqWybciVcvOOLTcgfB0UXjwZts5X4
	cvQy8Xosb9RXL2LXmbeijz4XD9oeI4a05U/Z2Gbe7LOjYAvvTtrrDsa4ucYAXo7trWs2Ark5nHv
	RnYiVLAcL0A==
X-Received: by 2002:a17:90b:1b49:b0:353:5c16:aa7 with SMTP id
 98e67ed59e1d1-353fed876demr1248805a91.25.1769508784958; Tue, 27 Jan 2026
 02:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
 <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
 <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com> <caebe20b5f30cb76ba8021443ba50ad06a2ef570.camel@huaweicloud.com>
In-Reply-To: <caebe20b5f30cb76ba8021443ba50ad06a2ef570.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 10:12:53 +0000
X-Gm-Features: AZwV_QiSBPPfw3H7Mo24J3F156JO1ZCc1yz7--IZjmP_FgJPL6awTCJb_xgRqFc
Message-ID: <CAGrbwDTTPNkogW1WM0goz-JTgV+CQgO4fGng8brox5+wWKGFtA@mail.gmail.com>
Subject: Re: [PATCH] ima_fs: Avoid creating measurement lists for unsupported
 hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8329-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arista.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A4A3F92891
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:02=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
[..]
> > I'm not quite sure what you mean. `algo` here is HASH_ALGO__LAST as
> > you see by the check added. As it's initialized by
> > ima_tpm_chip->allocated_banks[i].crypto_id, I presume it's
> > HASH_ALGO__LAST there as well (didn't check this assumption though).
> > Do you mean to print hex value of HASH_ALGO__LAST?
>
> Even if you don't have the crypto ID because the TPM ID is not mapped,
> you can still use the TPM ID (ima_tpm_chip->allocated_banks[i].alg_id).
>
> I wanted to have a file name that includes the TPM ID.

I see, thanks, I'll try this.

Thanks,
           Dmitry

