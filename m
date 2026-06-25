Return-Path: <linux-integrity+bounces-9833-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKFiAgctPWrwyQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9833-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 15:28:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7206C6215
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 15:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9833-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9833-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726F830300C6
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2026 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6031AAAA;
	Thu, 25 Jun 2026 13:28:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888F326924
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 13:28:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394115; cv=none; b=bo967sU8C3uSMqRaYRvm+A/+6G4XX7DSotZf5yNbTCawTELMzc30B9eceszppvLEioKEgmd9tnJz7A6bTYLLRhIha402+2v4me0gEF9siQyQ0oCQ3foAsuUjBcTTpg331BuCgJStKeJocnq315lx4K1j44nsOCEv7jnPKJcFIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394115; c=relaxed/simple;
	bh=tFKTH8Lkpg28TDDn1Pf8z5xvoDPo8G+zFxqrmzB/oIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNVNV4kGS7Z0vTIFF5ZbqusZJECh9UUslO+cf+smObHhQ7gw7xkf57uVYqA2I7wM+TtFAgkUIZaBm1S8Uch6cS35gwfg9WGwkNHVUa6EXHJQGBigoSEUisZ6XKuGFgiMcFj82tenW7Dr6rGYKBxCpGwOpmwA1b/2hjYqLE3b8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gmJt83RJczpTtQ
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 21:04:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C885840565
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2026 21:10:12 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnFdGtKD1q4OmcAQ--.30184S2;
	Thu, 25 Jun 2026 14:10:12 +0100 (CET)
Message-ID: <8f9626a5cc4c03e57d63d290ce151caeda9293e6.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: correctly recover number of violations after kexec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
Date: Thu, 25 Jun 2026 15:10:03 +0200
In-Reply-To: <20260619191452.7179-1-enrico.bravi@polito.it>
References: <20260619191452.7179-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnFdGtKD1q4OmcAQ--.30184S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5Cr45Gr1rKFW8Cr47twb_yoW5uw4Upa
	9agr13GFykJFyIkrn3AayUAF4ru395GFWUG3Z8Ar1jyrnIqF1Fkr48CF1SvrW8Wr95AFyI
	qFyqyrs5Gw4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGo8mTpSbwAAsB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9833-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huaweicloud.com:mid,huaweicloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C7206C6215

On Fri, 2026-06-19 at 21:14 +0200, Enrico Bravi wrote:
> When recovering the measurement list after kexec(), the number of
> violations is not recovered as well, causing a mismatch between the
> number reported by the <securityfs>/ima/violations user interface and
> the actual value. In addition, currently it is assumed that when
> recovering an entry, this is a violation if the template data hash
> read from the kexec buffer is an all-zero hash, which can actually be a
> valid hash.

This sentence is a bit convoluted. Please rework it.

> Verify that an all-zero hash corresponds to a violation and consequently
> correctly recover the number of violations.

We need to clarify that this patch only fixes false positives (a record
is declared as a violation even if it isn't, and we fix it by cross-
checking the SHA1 of the template data).

However, we are not fixing the false negatives (if the SHA1 of the
template data is zeros, we don't declare it as a violation, but it can
potentially be).

> Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> Closes: https://github.com/linux-integrity/linux/issues/13
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
>=20
> ---
>  security/integrity/ima/ima_template.c | 28 ++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/i=
ma/ima_template.c
> index 7034573fb41e..147f228ed246 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -430,6 +430,7 @@ int ima_restore_measurement_list(loff_t size, void *b=
uf)
>  	DECLARE_BITMAP(hdr_mask, HDR__LAST);
>  	unsigned long count =3D 0;
>  	int ret =3D 0;
> +	int i;
> =20
>  	if (!buf || size < sizeof(*khdr))
>  		return 0;
> @@ -515,15 +516,28 @@ int ima_restore_measurement_list(loff_t size, void =
*buf)
>  		if (ret < 0)
>  			break;
> =20
> -		if (memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero))) {
> -			ret =3D ima_calc_field_array_hash(
> -						&entry->template_data[0],
> +		ret =3D ima_calc_field_array_hash(&entry->template_data[0],
>  						entry);
> -			if (ret < 0) {
> -				pr_err("cannot calculate template digest\n");
> -				ret =3D -EINVAL;
> -				break;
> +		if (ret < 0) {
> +			pr_err("cannot calculate template digest\n");
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (!memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero)) &&
> +		    memcmp(entry->digests[ima_sha1_idx].digest, zero, sizeof(zero))) {

Here it would be helpful to have a comment saying that we are reverting
the effect of ima_calc_field_array_hash(): we tried to verify if the
entry is a violation, it is, but then we have to set the template
digest back to zero after the calculation.

> +			for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
> +				/* Unmapped TPM algorithms */
> +				if (!ima_algo_array[i].tfm) {
> +					memset(entry->digests[i].digest, 0,
> +					       TPM_DIGEST_SIZE);
> +					continue;
> +				}
> +
> +				memset(entry->digests[i].digest, 0,
> +				       ima_algo_array[i].digest_size);

Maybe we can just use the instruction above instead of differentiating
for unmapped algorithms? digest_size is taken from the TPM in that
case.

Thanks

Roberto

>  			}
> +			atomic_long_inc(&ima_htable.violations);
>  		}
> =20
>  		entry->pcr =3D !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
>=20
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6


