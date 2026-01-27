Return-Path: <linux-integrity+bounces-8327-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP0mKa+LeGmqqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8327-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:55:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247AE922C6
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50EA3014510
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CA93382F9;
	Tue, 27 Jan 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H4Mck3i2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56234335547
	for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507723; cv=pass; b=I3mu9rYUAEwEDHXljZCWE7+oKekSvxDBrbMkeB2KeBaExz8WetX7cMpGR/a/d+aMCIqFG7nQYLkv1k0b5E2xyO1K3mY+fwzZQ1p+rqeA34lj2fstS1eIsWuhweyFRtZ0REAEzKFZ6t87hQ8ElExN4yOj8FhjJif/cqXOeJ4YJxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507723; c=relaxed/simple;
	bh=L5k9bsZhbwfNwvr7j5DDwdxvwj9ZYR0SCo9EvGBH7HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAPrjcmgzNNnm1Jwr2iV/xPSUb56I1k3gSPtyvb3KOLnje0kyr+DAcPFd4MgPNrDHguznXlpL5m+/Ta9Lm1aYZJZKDKfF9DewsaXlWUEId7n9FjFOw/C/pJk7ZJl4PIxFOkM0OurKlVNgS1yCpxldJa94uHORqIErXd796mET6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=H4Mck3i2; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3599888a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 27 Jan 2026 01:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769507718; cv=none;
        d=google.com; s=arc-20240605;
        b=U6eQwnYPIne9JVtU4tYYmLzu1V/TE2v+vlEapA2uhdU+11KBuZca76nyWys1uomKr1
         Ya8jgShmQej9ddQ+5Z3IekI6ohwtZARNT8rWDhhGc+h/26JMiJosK8HFAb5MGrInPVkX
         LXhJrIkipr+Nx+0+e/5abKrFpkhdZdu/23accNGmUPDjjgcKErGCVBSJ9xWYU7JxPxBC
         YTUL+Qj1KqcPzefv5mK/ZVkmykBiXQDx8keAAhNsHCNRVtQEp9EWp5/ZSWVawy+z4irH
         m/IvjUBpFkFGEJxlGp841IxG3lAvmCAiADUUKJStFHZxIDIiENnx2VghmFE47Jahgtii
         6CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        fh=M17kABP58cr7Vby074Dp3NQjg2lWkOpQtF0muXWEyWM=;
        b=lSwWefsh3eqQISDTDfBVRHSHhL/WBCBBLrQxgekyRZlRwHsItEU/hwkdfdNnJBBubU
         a89UWRABILq7PFNf+8Kr0KUyeyCsYCa4p8N5tsFaSyXKA9jlYKsU8CG2LmgvUOrWJxsX
         pWDlJC5Q4zeXJOg23wyW7/zejCa5Cmh/WkZBSUO2BlXIORdy3knwb/lD4gnbWMtr9rG9
         AgrUZ+JtCgjlo5qIk7m4It2VpuIMxYWISgc9oruDMVd3n7H6B6h1dIPeumLGDnvqskYi
         53w/QRiJH/ihpcuwDGFxTIgYXR8iMBjUs5aTA+JIkyA74CbqdLuqKTVE/Lt8sZUNr5Br
         k4pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769507718; x=1770112518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        b=H4Mck3i2pMLlv1r7qnIymC+enXwNN1XuYBaqWxDnj/sLEJjQLbkhgMGgtyTGlqmqct
         8dbPbNbSJ0SrRKmcQKjJkUxm5p2cnvIzAZLYB4J4w42UprN9CmbELdR2H8x/5p5J0MRw
         7VY6y8oWi7LPDpagiOftI3AuBhYRwprlmB9yAeI0b0j1mwmMQ3t0KVYHsb89SjIVRCjx
         EvxOeL9riTTANcEMNPCP/9ry2Wz4LUvgMaroO68Am+4iY4d8QZEAar06yV/GcluHkvpa
         xdUhkQEQ2WuRQRo/j0PA9RrEUPbSRU0N8G7vtzEm5ShauwAYFVRNdCFnoQFMWXZ/f28a
         LRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507718; x=1770112518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        b=X+yVUh6fRC/KwYavlH1isgfuH+xuR7eLHh5yVxpSZqDmhuRV86JWN5O+87TplaNJYi
         AQIIvtZpA8EpI/6MMQNNwy3+VsueW89GCvQF0h3QVj381zjhEq5w5iHu/ZzivmhM/Jlv
         AH+oe9ivbH3y6nVWbh1MnoBIMCBCq5GwC7oKhs4IQv8BN/HGtEK1uNTDGDPzK6QqXKB+
         S5ldHwMpjltiDKhfNDZKEDsygDr7K3KiQTSzelFjjqVlpq8MaGJE6Pe/S9d7aVSUVXtN
         eYywNsPy2WmNWYRvPoUz21Dt0NPohpOqruaMjz9K1/kdqeesoKH5nawfjgqcOh/caSc9
         RK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmvKeeP7GOgo/3OhNOp1UCc7E626XxRi3bTRk+wDHkntFkQZaBMCb///h08Lsnmnm05q/a0XchVJpQOwjR088=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNQ2lv0OC+BkK7FNgmD5moDTJKPjrFjTLk2JEyHAxaiecY3kM
	MWOyVhea+ZSXgm1izQOux6m/+H0EvTiI15P712d+B7V1aeCyl5/qTX2XJMxMFhSWFMIP3GrA31P
	y5tIlGoglN5my+KSo86xqL/4bLH4MdbX7LrTcQEH3
X-Gm-Gg: AZuq6aJxzf1/ihgt/Vj0ArXe8DCtgOI0desOrp3Z+Cfg05cWp2cewbvTKWenPTaSbyU
	Wm1YiR4ZiAuG4Zr/zWMR9Le15jqg5kymFr1wsxN8S6BVoX/viKTBrYYJzSQ1b+dXOL3SAPyCNv1
	GE0LdJ5rVwjdm5SkbWw2NpJ60ofQ5WAoiJ0tTcg85bHEFiCIj8j6t64XifyvGipNFD3lprf+4jd
	mv/kDq7qdqczSe9eBaaLOYBIsjGJtavlY9P092AcOOrswYm4Qi8IbqhvWYKZZ1MhKVYt+QUrN31
	EH4AN+F1tWPjt/FGhF2cc7Rs3zdTQYC5Ad7WejumWsvTPvn3iijU+BOyCac0dGcWWm01nbrt1nj
	JzRcmk+Yiww==
X-Received: by 2002:a17:90b:2ecd:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-353fed5c9d7mr1240343a91.18.1769507717868; Tue, 27 Jan 2026
 01:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com> <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
In-Reply-To: <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 09:55:06 +0000
X-Gm-Features: AZwV_Qg6oboibS8qbS6QxWmADKc2aUjC5oJj_WK2C3ladL1H3hO57bglwnxMO6Q
Message-ID: <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8327-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,arista.com:dkim,huaweicloud.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 247AE922C6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 9:15=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 03:05 +0000, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <dima@arista.com>
> >
> > ima_init_crypto() skips initializing ima_algo_array[i] if the alogorith=
m
>
> Algorithm.

Thanks.

[..]
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -404,6 +404,9 @@ static int __init create_securityfs_measurement_lis=
ts(void)
> >               char file_name[NAME_MAX + 1];
> >               struct dentry *dentry;
> >
> > +             if (algo =3D=3D HASH_ALGO__LAST)
> > +                     continue;
> > +
> >               sprintf(file_name, "ascii_runtime_measurements_%s",
> >                       hash_algo_name[algo]);
>
> Thanks, but I think we can also print the unsupported digests, since
> they are there. Since we don't have the algorithm name, we can make
> ours like tpm_<algo hex>.

I'm not quite sure what you mean. `algo` here is HASH_ALGO__LAST as
you see by the check added. As it's initialized by
ima_tpm_chip->allocated_banks[i].crypto_id, I presume it's
HASH_ALGO__LAST there as well (didn't check this assumption though).
Do you mean to print hex value of HASH_ALGO__LAST?

> Once this is fixed, you can try to make SHA3_256 supported. Add the
> TPM_ALG_SHA3_256 definition in tpm.h and the mapping in tpm2-cmd.c
> (array tpm2_hash_map).

Yeah, I thought of doing this, asked the related folks and they said
it might be worth if it's a simple/trivial patch. Will try if time
permits, somewhat busy with bug fixes at this moment. This one is just
a fix for read out-of-bounds for -stable (and I managed to forget to
Cc them! hehe).

Going to send v2 with the typo fix and -stable Cc'ed if that sounds good to=
 you.

>
> Thanks
>
> Roberto
[..]

Thanks,
            Dmitry

