Return-Path: <linux-integrity+bounces-9790-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FPmqJG2+KmpIwAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9790-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 15:55:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA06727E1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 15:55:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9790-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9790-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF4331CDAA1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F4E403B16;
	Thu, 11 Jun 2026 13:42:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CEB407CFF
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jun 2026 13:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185340; cv=none; b=aePejpUbF9ZbK5DCoLlHR4bHv2aAATa0j+uxz/k7jVxIs8luc+hAuL6OJDTdIraaR8biSz/dHG3gyMsyv6mGin22kES5Z0OVlp/HrxzpWdSWsQqI1rQpV7DzXzu3nhg3HVbC0vIZFqTqb4ADezCpaTcqMxaJ+9cixfrZDR6LZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185340; c=relaxed/simple;
	bh=O3/L3AsA/gicjQVzh9UNHuz7oGnQ2OcSyoYvie9cO0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwcdjgmYp/mmhXkoHoTgJkMNCNPgwUxa/rL0z0MG8DQsQqNjVq3fozCunWXtNqYfvXSF25be0964BKx+IBjOZgHyeqjA05YgL1gpLn/5HkKNel0EgPQofD7mJCSbwdBuUDJKqImZ7XfT7L20UFgRJ5MCPlwg3K5c5E79wMEV2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gbkFk32dCz1HCqn
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jun 2026 21:36:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DC1C64056F
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jun 2026 21:42:08 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXUc0puypq7eXAAA--.2142S2;
	Thu, 11 Jun 2026 14:42:08 +0100 (CET)
Message-ID: <84fd6676148d01505fb56e9253211707e57150f0.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v3 2/2] ima: measure buffer sent to securityfs
 policy file
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Enrico Bravi <enrico.bravi@polito.it>,
  linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com, 
 roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
Date: Thu, 11 Jun 2026 15:41:58 +0200
In-Reply-To: <2658c55c9d6a97ee8edca682d27369138aab67f5.camel@linux.ibm.com>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
	 <20260526135118.289633-3-enrico.bravi@polito.it>
	 <2658c55c9d6a97ee8edca682d27369138aab67f5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXUc0puypq7eXAAA--.2142S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UKr1kKr1xWrW7ZFWkJFb_yoWrZr1Dpa
	90gay7Cr1DXry7Cr1xG3W7uw4Fg3yUKa1UW398GF1jy3Z8Zr1q9w15Ar1j9rySyryYyry0
	yrs0vrZ8C3Z0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGoqJEUPpQAAsP
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9790-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,polito.it,vger.kernel.org,gmail.com,huawei.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,polito.it:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:mid,huaweicloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AA06727E1

On Wed, 2026-06-10 at 14:59 -0400, Mimi Zohar wrote:
> On Tue, 2026-05-26 at 15:51 +0200, Enrico Bravi wrote:
> > When a signed policy is not mandatory, it is possible to write the IMA
> > policy directly on the corresponding securityfs file:
> >=20
> > echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> >         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> >      > /sys/kernel/security/ima/policy
>=20
> Or by cat'ing the entire IMA custom policy file.
>=20
> >=20
> > Add input buffer measurement, regardless of whether the new policy
> > will be accepted or not, that can be caught when
> > 'measure func=3DPOLICY_CHECK' is enabled (e.g., ima_policy=3Dtcb).
>=20
> Enrco, Roberto, a reason for measuring invalid or malformed IMA policy ru=
les
> needs to be provided here.

One reason would be to be able to detect attempts to corrupt IMA by
loading malformed data, since the measurement is performed before the
policy is parsed.

> In addition to the "ima_policy" critical data, why is this mechanism need=
ed?

POLICY_CHECK already measures partial policy load by file. This patch
would just complete the POLICY_CHECK hook by measuring policy load
by=C2=A0buffer.

I believe they can both cohexist, both would allow to know which policy
is loaded at any time. With the critical data, the existing policy is
included in every entry, but it is easier to derive the current policy
loaded. It would be up to the remote attestation solution to determine
which solution is more suitable.

Roberto

> > The
> > measurement template is forced to ima-buf.
>=20
> Please include directions for verifying the measurement record here in th=
e patch
> description.
>=20
> >=20
> > Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > ---
> >  security/integrity/ima/ima.h        |  1 +
> >  security/integrity/ima/ima_fs.c     |  1 +
> >  security/integrity/ima/ima_main.c   | 19 +++++++++++++++++++
> >  security/integrity/ima/ima_policy.c |  3 +++
> >  4 files changed, 24 insertions(+)
> >=20
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index a223d3f30d88..320c80a1a847 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -426,6 +426,7 @@ void *ima_policy_next(struct seq_file *m, void *v, =
loff_t *pos);
> >  void ima_policy_stop(struct seq_file *m, void *v);
> >  int ima_policy_show(struct seq_file *m, void *v);
> >  void ima_measure_loaded_policy(void);
> > +int ima_measure_policy_buf(const char *buf, size_t buf_len);
> > =20
> >  /* Appraise integrity measurements */
> >  #define IMA_APPRAISE_ENFORCE	0x01
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 75cb308cf01f..601718e02429 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -362,6 +362,7 @@ static ssize_t ima_write_policy(struct file *file, =
const char __user *buf,
> >  				    1, 0);
> >  		result =3D -EACCES;
> >  	} else {
> > +		ima_measure_policy_buf(data, datalen);
> >  		result =3D ima_parse_add_rule(data);
> >  	}
> >  	mutex_unlock(&ima_write_mutex);
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 1d6229b156fb..174110da0030 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -1204,6 +1204,25 @@ int ima_measure_critical_data(const char *event_=
label,
> >  }
> >  EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> > =20
> > +/**
> > + * ima_measure_policy_buf - Measure the policy write buffer
> > + * @buf: pointer to the buffer containing the policy write data
> > + * @buf_len: size of the buffer
> > + *
> > + * Measure the buffer sent to the IMA policy securityfs file.
> > + *
> > + * Return 0 on success, a negative value otherwise.
> > + */
> > +int ima_measure_policy_buf(const char *buf, size_t buf_len)
> > +{
> > +	if (!buf || !buf_len)
> > +		return -ENOPARAM;
>=20
> Please return -EINVAL.
>=20
>=20
> > +
> > +	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
> > +					 "ima_write_policy_buf", POLICY_CHECK,
> > +					 0, NULL, false, NULL, 0);
>=20
> Parallel to "ima_policy_loaded" consider naming the record as
> "ima_policy_written".
>=20
> The indentation is off by a character.
>=20
> > +}
> > +
> >  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> > =20
> >  /**
>=20
> [...]
>=20
> thanks,
>=20
> Mimi
>=20


