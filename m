Return-Path: <linux-integrity+bounces-8567-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFbcAA4NoGnbfQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8567-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 10:06:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C21A31CF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CDF33070B36
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99602395DA7;
	Thu, 26 Feb 2026 09:05:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB8396D36;
	Thu, 26 Feb 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096721; cv=none; b=XK2LoXcXGEdwqfUQC2jNGXbzikM7VJDC+bm8wmLPh3LUJNUE8LtubacAIUw8oG7ShH+u/CoUn/4Fr3FM+RdycJNecyOlqlAlJv9XyQkYNe/fLpvQc2+fhzlzlmPmnFbVwwvhUQoBfA2c/KGxGS4YWRMKakDMPSVmd46QZ0AwS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096721; c=relaxed/simple;
	bh=8GctGznDx1m8vlDMQUlw+5vjbSc1rOsvy2MQg45nMQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+MmjipeeZ2sJmXRw2VDC/p/+j0cyqiWS+d5nb8N8mU3rW+dtdve8OWMob+aEZdCH95WVUrIB+zzeTPdBn5yaanP/TT2pdHl+H+nTE43h2+JbPMNkZ+35UoQ5uA4Mzc5OTRur/mAuJkLisNv24ZCJx+X7rTAipHF+r9uNHcbPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fM57J2QYYz1HCHS;
	Thu, 26 Feb 2026 17:02:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AF78C40565;
	Thu, 26 Feb 2026 17:05:15 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHEWzBDKBpZGSCBA--.22824S2;
	Thu, 26 Feb 2026 10:05:15 +0100 (CET)
Message-ID: <0fde824faace320c6d3ef6137bf50cee0289c6c0.camel@huaweicloud.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dima@arista.com, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Silvia Sisinni <silvia.sisinni@polito.it>, Enrico Bravi
 <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 26 Feb 2026 10:05:03 +0100
In-Reply-To: <6808b1a8fcb014e6c7c18241d39155f5c12edc31.camel@linux.ibm.com>
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
	 <6808b1a8fcb014e6c7c18241d39155f5c12edc31.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHEWzBDKBpZGSCBA--.22824S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rtryrWFWUJw1ktrW5KFg_yoW8KrW8pF
	WfZryDuas3JFW7trs3KF18uF4Sk3yakw1UGrn5JFyUA3WkWrZ5KrsFkF1YkFWvkr1Fya40
	qr4aqF9xA3Z8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoY
	FADUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGmfvCAGBwAAs9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8567-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.ibm.com,arista.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 970C21A31CF
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 15:36 -0500, Mimi Zohar wrote:
> On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <dima@arista.com>
> >=20
> > ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> > HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> > are places relying on the algorithm to be valid because it is accessed
> > by hash_algo_name[].
>=20
> If the TPM algorithm is not supported by whom? the kernel?  HASH_ALGO__LA=
ST is
> defined in linux/hash_info.h.  If the crypto algorithm is not supported b=
y the
> kernel, then the kernel won't be able to calculate the hash to extend the=
 TPM.

Yes, by the kernel. True, that is why we do a padded SHA1.

> > @@ -404,16 +398,24 @@ static int __init create_securityfs_measurement_l=
ists(void)
> >  		char file_name[NAME_MAX + 1];
> >  		struct dentry *dentry;
> > =20
> > -		sprintf(file_name, "ascii_runtime_measurements_%s",
> > -			hash_algo_name[algo]);
> > +		if (algo =3D=3D HASH_ALGO__LAST)
> > +			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
> > +				ima_tpm_chip->allocated_banks[i].alg_id);
> > +		else
> > +			sprintf(file_name, "ascii_runtime_measurements_%s",
> > +				hash_algo_name[algo]);
> >  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> >  						ima_dir, (void *)(uintptr_t)i,
> >  						&ima_ascii_measurements_ops);
> >  		if (IS_ERR(dentry))
> >  			return PTR_ERR(dentry);
> > =20
> > -		sprintf(file_name, "binary_runtime_measurements_%s",
> > -			hash_algo_name[algo]);
> > +		if (algo =3D=3D HASH_ALGO__LAST)
> > +			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
> > +				ima_tpm_chip->allocated_banks[i].alg_id);
>=20
> There's no point in creating either of the securityfs files if the kernel
> doesn't support the hash algorithm.

It is not useful per se, but since it is an information that it is
produced and maintained by IMA, we can print it. And second, it will
expose the fact that there is an unsupported algorithm (in the case of
SHA3-256, the fix is add to the TPM - crypto subsystem mapping in tpm2-
cmd.c).

Roberto

> Mimi
>=20
>=20
> > +		else
> > +			sprintf(file_name, "binary_runtime_measurements_%s",
> > +				hash_algo_name[algo]);
> >  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> >  						ima_dir, (void *)(uintptr_t)i,
> >  						&ima_measurements_ops);
>=20
>=20


