Return-Path: <linux-integrity+bounces-8335-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHtEEqTMeGmNtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8335-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:33:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258F95C53
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CD68300382F
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3D347C6;
	Tue, 27 Jan 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UrI1Pd4I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CE1F130B
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524260; cv=pass; b=Ae+vLc/9/5+cjWQ/H1f2ua4Vkpm8mmJKXxLsL1RDgLK2cZObwuAZCyTHs6zNPzC7CiX1I1uUfNVo0LVAdQuN2br0SJWB62GX/3yUjMBcqzmcloLxzURT/CoAnulDGaHOJgB7OlTnIbKRYIKCtrA8uDZ6AG7sMPGKxCEHA75iwcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524260; c=relaxed/simple;
	bh=4L+1CduCICSFsgHUjcOkN7OHpLxEb9vbNkxHmmODV1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar0CV3Z0DHy/iWHYj0TdyvDwini8LBrU5j2CFCasDVqK408lgovXhz0of9zDx3fNDZzr49+Kwh4yEt2ve+Tcn0y135ThMeO7YKXrbcm8qSoqV2PyWIXd87MEeCWj0t+3ywWbjMD1u/XNC41+KGxCFOcdcbuvjOmtif2iDf6W/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UrI1Pd4I; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so2550983a91.2
        for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 06:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524258; cv=none;
        d=google.com; s=arc-20240605;
        b=Zo/E6Pif4l3LF6Vq0cZWLB4i6pL1pWIj5EkLAKvyxiGxgmlIhc1oNyIM0WpcEWg+VA
         QLBJ0JMIJ/iLCo3lpJK4aTzJuTkLo7Agbyc6aMG/J396Vp5UvQ551Bt7toqC2pNgtoth
         3wQMUpOl2nTq15o31Bck/ysjRIr4+Bs3VUzVE2OqIreb/0VE5a/b+rZlml3ML0B7Va09
         DwslWt/0FkCWSrMNmTIpc0aLh92PVhQ4kbA2j0C1LNdXUXAhKvdduWmrd7dr/Il+6G36
         fImLoD8wO565hImpilU45bg2LifwbEA/yTQcHKzE6lgwiqytR/g+xvaXQyFJwOZMKM5m
         cVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        fh=ZEDDe0HC3Jle9+jwKQw2UE86it/zo+VblySr7SwoZZA=;
        b=fHgmwXfK4HM2ZaWfCKhY4cctE/+zVUwl2vM+9ON3VFGj+yU0LrSVnjqHg/InGnwaok
         4m6oXyCEUPRieOSdzjtWSj1/s3xxFsLBLPu0DFmxkf89PocXkAiEqL9OqCmI5WjQSBn7
         N/VAjqmXxREiqxmYFYU021a+mSM/abiI0YUWkIRPPbd0njsBo620Xt6RAzCo6TJ4l6IK
         hmxrMZdoIgsEp5Jz/p7AXEY6LRJQgdbSL8cToewRhNV/ayKt3NGIwz2uY6jXp+vN+6at
         mhSIXPVslqgKPwYbTAeBGB4iRclX755RazBquWkLgrGFmHzoxwDDnwEXT2dZdQTaC+b6
         +cTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769524258; x=1770129058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=UrI1Pd4IPugpem4HPJfJXlQMlWX6aj69E1mR6VFoqA7ZFvC1MvYiVCvcg3yGgVmyaO
         awRjaG9fczBF5Y2VNkO/vyfFOqphG6Cv+3rNcD65WgHu7Gq9XvmAwIvCVhqs+KvXMpEO
         jhbeahL0iAc+mbKVsRfdeGrWkJKt0nj4R5D6yTo/GRFqNx2ScMMyyc5CEiwQ7tzOXIA1
         ZGQ9rCGMKAYWShY/jB/at3ImQpOGLWEtsMMMUj2/MFEHQ6kT3HR8LNresKlng4ShZIDZ
         3FvSgpZI6qQnTfU7xkV93bJst3nOrARuKdWfPdjbu5fStWNt+CMEu9RRSeiBT8xA52Zs
         FXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524258; x=1770129058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=wfV7KiDZ4dCH2HXTiwLIgmw1+0+JfEn4tn93nbzd9mwWQ9/+ocXdftjyhcQO/Kam2z
         4kkNQ0oQciLepfkOrvwGpTCZ6CR2cFigl96YIEXUYTjsCfnAGL3I7nTm9Hin7afbGoYK
         26an0M0DfUEqtqPenrxLmRpa4YvTBAfA4SVBd9cGkvP41+1zURcstm6Gt0egtE0nxNjb
         xbDNOvsatJpV5cyxkiMklM2Cjo0GLPlpEyBXWAKdbhk9qgXsVtpAlhnAFHXOSuV21b+R
         Sl8hzAae52vUeI7nNyCrWnkW4nT10Y7OKxgjpX863RF2TOXjp43asRCqHsLPJC9xWU1i
         lT9A==
X-Forwarded-Encrypted: i=1; AJvYcCVAvo6o09JBd/svtek6xJXQPc4i4Yl0HPQahdWp5I432N2GnLaN/XBQfpJVbG1SK+IS9AmNmOQoD0JeekWZpVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCuVqvO2vYzEHxTwyOV//WyQ5P2OkZ4iiOGnD07+/zNVRlYLe
	wTx6EAVOm0aQRG2RYJESPZjBvnB+pDjc23INo8Tzpp+Y0IEg2O5W/k5u80abu6xV6NYNfEeyARc
	mm8i2Cv4ptvLC0p8Ib+KA02wVEHR21kK+qwYdV5VW
X-Gm-Gg: AZuq6aKa8xbUG64skIzmzDs71gulLxGKLUXxEl/gWevlgQMDlG2DV/UKZETS+YThROf
	/IMsLTinSUxTf5G6RcfJKSXpx+Y6Yj2Bx21E0RyHiPcGKQnTpGq8Gvs43p64pKC01vSwRZnBAMv
	hMwrsru8ew3plTdDYv2JdhAx2puAanNWkrR4yEOG6nNyr8GTm/0EFmjdN4wl2o9nbX2OY6vJ1HS
	+miQaYD0o+RZp30IJp6B+IGPxCFaKeY/ZJcP7RwTs5V1Ol3CofOLCJOTPSzi+vHhp52QTnhFYOg
	VfUjBbqzgz2sYlwJsu2Y7AImGK1uIF+AuCGEYcfOnT47/vwrcyqT5UsE1uP9JztrQRtlgHQg2yg
	eQBWpONEVDW2mbHrBZZic
X-Received: by 2002:a17:90b:51cb:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-353feccf407mr1736081a91.2.1769524257987; Tue, 27 Jan 2026
 06:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com> <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
In-Reply-To: <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:30:46 +0000
X-Gm-Features: AZwV_QiPE-wr7bzvtCNR8Zj6-bvGnDiuzbDIAnCn8Y0x5J3sx1pzHd8HlA92AzM
Message-ID: <CAGrbwDQWo8Eebtu4FHsahtJTOkw4jXgncm4paFY6uyU_GkqVtQ@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8335-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:email,arista.com:dkim]
X-Rspamd-Queue-Id: 6258F95C53
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:28=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 14:18 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     if (algo =3D=3D HASH_ALGO__LAST)
> > +             ima_putc(m, "0", 1);
> > +     else
> > +             ima_print_digest(m, e->digests[algo_idx].digest, hash_dig=
est_size[algo]);
>
> No need, the last one is ok with ima_tpm_chip->allocated_banks[algo_idx].=
digest_size.

Cool, let me check it and I'll update it in v4.

Thanks,
           Dmitry

