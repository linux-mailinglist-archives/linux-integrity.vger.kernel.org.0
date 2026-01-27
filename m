Return-Path: <linux-integrity+bounces-8328-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDXHLViOeGmqqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8328-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 11:07:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0993A926ED
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 11:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22088305C8F8
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F612E285C;
	Tue, 27 Jan 2026 10:02:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4F1F63CD;
	Tue, 27 Jan 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508144; cv=none; b=gz0eQkdOFhD/qfWL81XvSA2+sDzRm8GcsV1jxrI+8d+BCVXALNl/eqdec+5RVMWeyXX7JmaEdIgno5Ex/oZFriHtUg0s2imNtEbrKgd0ZsbVBbKpgGulG3dMlCW9XMkHToLWZNf5qWGzUjmUUKioTiZGJbKLlVlD54BO+QJbpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508144; c=relaxed/simple;
	bh=GCOyAEjXKyoP8HmZFb60M6uzhqkmSZLBq4cCgu3qTZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfHL3oPcrxLkcbjB5h12jQFov8LexUtx2e7yhDuYhem9fkpqHzdSWCErRBgoqTIf81z3YAIy5HlfaR7+FRyuCFZ+r5leJGRg4f4xkmFYH9/rosSRUAsBBbAb8WGhl9LSS06Kklh66yWippLwZZoWlMWo0k5/6uNujykazjgYZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f0gqh1CPgz1HDTl;
	Tue, 27 Jan 2026 17:59:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7882E40565;
	Tue, 27 Jan 2026 18:02:18 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCn4wUgjXhpZBm5Ag--.22155S2;
	Tue, 27 Jan 2026 11:02:17 +0100 (CET)
Message-ID: <caebe20b5f30cb76ba8021443ba50ad06a2ef570.camel@huaweicloud.com>
Subject: Re: [PATCH] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Silvia Sisinni <silvia.sisinni@polito.it>, Enrico Bravi
 <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry
 Safonov <0x7f454c46@gmail.com>
Date: Tue, 27 Jan 2026 11:02:05 +0100
In-Reply-To: <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com>
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
	 <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
	 <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCn4wUgjXhpZBm5Ag--.22155S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13Zw4xAF15XFW8ZrW8WFg_yoW8uryrpF
	sIq3WjkryktFyxKF929r1xGr1Sy3yxtr17Ww15Wr1UAwnxWr95Wr4fuFWruFWrWF1rCF1Y
	vrW2qa4fJF4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGl4LxwMFwAAs5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8328-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,huaweicloud.com:email,arista.com:email]
X-Rspamd-Queue-Id: 0993A926ED
X-Rspamd-Action: no action

On Tue, 2026-01-27 at 09:55 +0000, Dmitry Safonov wrote:
> On Tue, Jan 27, 2026 at 9:15=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > On Tue, 2026-01-27 at 03:05 +0000, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <dima@arista.com>
> > >=20
> > > ima_init_crypto() skips initializing ima_algo_array[i] if the alogori=
thm
> >=20
> > Algorithm.
>=20
> Thanks.
>=20
> [..]
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -404,6 +404,9 @@ static int __init create_securityfs_measurement_l=
ists(void)
> > >               char file_name[NAME_MAX + 1];
> > >               struct dentry *dentry;
> > >=20
> > > +             if (algo =3D=3D HASH_ALGO__LAST)
> > > +                     continue;
> > > +
> > >               sprintf(file_name, "ascii_runtime_measurements_%s",
> > >                       hash_algo_name[algo]);
> >=20
> > Thanks, but I think we can also print the unsupported digests, since
> > they are there. Since we don't have the algorithm name, we can make
> > ours like tpm_<algo hex>.
>=20
> I'm not quite sure what you mean. `algo` here is HASH_ALGO__LAST as
> you see by the check added. As it's initialized by
> ima_tpm_chip->allocated_banks[i].crypto_id, I presume it's
> HASH_ALGO__LAST there as well (didn't check this assumption though).
> Do you mean to print hex value of HASH_ALGO__LAST?

Even if you don't have the crypto ID because the TPM ID is not mapped,
you can still use the TPM ID (ima_tpm_chip->allocated_banks[i].alg_id).

I wanted to have a file name that includes the TPM ID.

Roberto

> > Once this is fixed, you can try to make SHA3_256 supported. Add the
> > TPM_ALG_SHA3_256 definition in tpm.h and the mapping in tpm2-cmd.c
> > (array tpm2_hash_map).
>=20
> Yeah, I thought of doing this, asked the related folks and they said
> it might be worth if it's a simple/trivial patch. Will try if time
> permits, somewhat busy with bug fixes at this moment. This one is just
> a fix for read out-of-bounds for -stable (and I managed to forget to
> Cc them! hehe).
>=20
> Going to send v2 with the typo fix and -stable Cc'ed if that sounds good =
to you.
>=20
> >=20
> > Thanks
> >=20
> > Roberto
> [..]
>=20
> Thanks,
>             Dmitry


