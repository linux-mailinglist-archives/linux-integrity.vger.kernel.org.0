Return-Path: <linux-integrity+bounces-9849-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lydXK31kQmq66AkAu9opvQ
	(envelope-from <linux-integrity+bounces-9849-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 14:26:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA636DA25F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 14:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9849-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9849-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC563049287
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6713FE66F;
	Mon, 29 Jun 2026 12:22:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47C368D7A
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 12:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735744; cv=none; b=T6zh1ngFvi01hhHr+OdR1dzdbJEq3cZkXDOks2XTN+zMns8d/nynWQFVbd98XwOVWmZSuHuj6jdBAWcjo7+cbkTxdwNGtjN9hvqXUMXYE74YeyN+zn51W/zE9IR0Opi1wRvJ5L+ZrGAs2qwwyZvucT+jv6LIkjbgN4nOM+YgVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735744; c=relaxed/simple;
	bh=uUgPkES27b1+d4ovcXcDPpH+y4G4zrsQGziXRTCZO9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6TZtwRyyz7k5x6yGrcHW0wCHAdGe1ghfgyAKDdsfElB88u0s+mv22xAtJdlxrL+PON7rMtE9x5qVWn8VP3SxERzigoIm2YnjcDZ22+81gGvAqP4kHq/0yUCA/tYDF7ecvwE5glZdz7GPpwLCIR6twZPFHb6/hjp9+3Ip0qgplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gplcq4WZfzpTjM
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 20:16:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DA1934056C
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 20:22:12 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwBnaiduY0JqzioiAA--.38596S2;
	Mon, 29 Jun 2026 13:22:12 +0100 (CET)
Message-ID: <c4fcb3e90bea2ec98be110e29b17874b1d874b6d.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: correctly recover number of violations after kexec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, "roberto.sassu@huawei.com"
 <roberto.sassu@huawei.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>,  "dmitry.kasatkin@gmail.com"
 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Date: Mon, 29 Jun 2026 14:22:03 +0200
In-Reply-To: <28db33177bcd021da5c907a7941ae93f87e91633.camel@polito.it>
References: <20260619191452.7179-1-enrico.bravi@polito.it>
	 <8f9626a5cc4c03e57d63d290ce151caeda9293e6.camel@huaweicloud.com>
	 <28db33177bcd021da5c907a7941ae93f87e91633.camel@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnaiduY0JqzioiAA--.38596S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5Cr45Jw43Xr13trWfuFg_yoWrCr45pa
	9YgFy3KFykXr92krn7Za4UtF1Fv3yrGF1UGwn5Ja48Ar9xtr1Ykr48GF1S9ryxWrs5AFyI
	qF1Utws3Crs0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGpB30hKJQAAsF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[polito.it,huawei.com,vger.kernel.org,linux.ibm.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9849-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,huaweicloud.com:mid,huaweicloud.com:from_mime,polito.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEA636DA25F

On Mon, 2026-06-29 at 12:11 +0000, Enrico  Bravi wrote:
> Hi Roberto,
>=20
> On Thu, 2026-06-25 at 15:10 +0200, Roberto Sassu wrote:
> > On Fri, 2026-06-19 at 21:14 +0200, Enrico Bravi wrote:
> > > When recovering the measurement list after kexec(), the number of
> > > violations is not recovered as well, causing a mismatch between the
> > > number reported by the <securityfs>/ima/violations user interface and
> > > the actual value. In addition, currently it is assumed that when
> > > recovering an entry, this is a violation if the template data hash
> > > read from the kexec buffer is an all-zero hash, which can actually be=
 a
> > > valid hash.
> >=20
> > This sentence is a bit convoluted. Please rework it.
> >=20
> > > Verify that an all-zero hash corresponds to a violation and consequen=
tly
> > > correctly recover the number of violations.
> >=20
> > We need to clarify that this patch only fixes false positives (a record
> > is declared as a violation even if it isn't, and we fix it by cross-
> > checking the SHA1 of the template data).
> >=20
> > However, we are not fixing the false negatives (if the SHA1 of the
> > template data is zeros, we don't declare it as a violation, but it can
> > potentially be).
>=20
> thank you very much for your feedback. I'll rework the patch description =
to make
> it more clear and describe what you highlighted.
>=20
> > > Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Closes: https://github.com/linux-integrity/linux/issues/13
> > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > >=20
> > > ---
> > > =C2=A0security/integrity/ima/ima_template.c | 28 ++++++++++++++++++++=
-------
> > > =C2=A01 file changed, 21 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_template.c
> > > b/security/integrity/ima/ima_template.c
> > > index 7034573fb41e..147f228ed246 100644
> > > --- a/security/integrity/ima/ima_template.c
> > > +++ b/security/integrity/ima/ima_template.c
> > > @@ -430,6 +430,7 @@ int ima_restore_measurement_list(loff_t size, voi=
d *buf)
> > > =C2=A0	DECLARE_BITMAP(hdr_mask, HDR__LAST);
> > > =C2=A0	unsigned long count =3D 0;
> > > =C2=A0	int ret =3D 0;
> > > +	int i;
> > > =C2=A0
> > > =C2=A0	if (!buf || size < sizeof(*khdr))
> > > =C2=A0		return 0;
> > > @@ -515,15 +516,28 @@ int ima_restore_measurement_list(loff_t size, v=
oid
> > > *buf)
> > > =C2=A0		if (ret < 0)
> > > =C2=A0			break;
> > > =C2=A0
> > > -		if (memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero))) {
> > > -			ret =3D ima_calc_field_array_hash(
> > > -						&entry->template_data[0],
> > > +		ret =3D ima_calc_field_array_hash(&entry->template_data[0],
> > > =C2=A0						entry);
> > > -			if (ret < 0) {
> > > -				pr_err("cannot calculate template
> > > digest\n");
> > > -				ret =3D -EINVAL;
> > > -				break;
> > > +		if (ret < 0) {
> > > +			pr_err("cannot calculate template digest\n");
> > > +			ret =3D -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		if (!memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero)) &&
> > > +		=C2=A0=C2=A0=C2=A0 memcmp(entry->digests[ima_sha1_idx].digest, zer=
o,
> > > sizeof(zero))) {
> >=20
> > Here it would be helpful to have a comment saying that we are reverting
> > the effect of ima_calc_field_array_hash(): we tried to verify if the
> > entry is a violation, it is, but then we have to set the template
> > digest back to zero after the calculation.
>=20
> Sure, will add it in the next version.
>=20
> > > +			for (i =3D 0; i < NR_BANKS(ima_tpm_chip) +
> > > ima_extra_slots; i++) {
> > > +				/* Unmapped TPM algorithms */
> > > +				if (!ima_algo_array[i].tfm) {
> > > +					memset(entry->digests[i].digest, 0,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_DIGEST_SIZE);
> > > +					continue;
> > > +				}
> > > +
> > > +				memset(entry->digests[i].digest, 0,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima_algo_array[i].digest_si=
ze);
> >=20
> > Maybe we can just use the instruction above instead of differentiating
> > for unmapped algorithms? digest_size is taken from the TPM in that
> > case.
>=20
> Yes you're right. It should not be necessary to treat unmapped algorithms
> differently. I was thinking that it could be directly used TPM2_MAX_DIGES=
T_SIZE
> instead. What do you think?

Or sizeof(), looks more robust.

Thanks

Roberto

> Enrico
>=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > =C2=A0			}
> > > +			atomic_long_inc(&ima_htable.violations);
> > > =C2=A0		}
> > > =C2=A0
> > > =C2=A0		entry->pcr =3D !ima_canonical_fmt ? *(u32
> > > *)(hdr[HDR_PCR].data) :
> > >=20
> > > base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6


