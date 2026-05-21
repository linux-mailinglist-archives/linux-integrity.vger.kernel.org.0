Return-Path: <linux-integrity+bounces-9619-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBacKJjIDmoHCQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9619-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 10:55:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7F5A1954
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06787306B6FA
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA792364049;
	Thu, 21 May 2026 08:45:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9735674C;
	Thu, 21 May 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353149; cv=none; b=DfgtiGEnlD1jgHMX9xWbh9RLHPPiGpfDUODCNY8WKiDA8jd4airMK6fDQcOZV6egFiPG613vhvIz7ClKmj9iQ14IlZyuidqB0VDlB+VdCwe9k6h7a2Qqhvl5Wpae6X13LBVaaZfvVGcyhiFcFm99RQM5mXV7gaxVb3Dkhd57tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353149; c=relaxed/simple;
	bh=XVpa3gPs4WHuWXOXdevcBTIxStwkVCXV0ajpL5/HWc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGmpfl/lnrLk8MODmPnNh+7cfazliQ9c1bUoxg0wgScZ53DvisBzy14gbnUqBvVv+fIdZG62f9xlnPpfltDY4mEmP4V4Y/DSDHrESRZvVJf7RS3RCPGKNoxChBOpsOwSehlMJNaSQs4gIusyYr7JC6E+wPXJ1LJ5m81rFw+pBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gLhL55nbJz1HCnv;
	Thu, 21 May 2026 16:25:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A972D4056C;
	Thu, 21 May 2026 16:30:16 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXyaKOwg5q4q+OAQ--.43580S2;
	Thu, 21 May 2026 09:30:16 +0100 (CET)
Message-ID: <760aa1c86b2c8fa3f4ceab5c65c42f4f1e1f59c1.camel@huaweicloud.com>
Subject: Re: [PATCH v5 06/13] ima: Mediate open/release method of the
 measurements list
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 skhan@linuxfoundation.org,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 21 May 2026 10:30:04 +0200
In-Reply-To: <db872f810f22bf25ff0ae7fe15b44f316b078079.camel@linux.ibm.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-7-roberto.sassu@huaweicloud.com>
	 <db872f810f22bf25ff0ae7fe15b44f316b078079.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXyaKOwg5q4q+OAQ--.43580S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw43tF15Wry3CryfAry8AFb_yoW5tr4rpa
	yDGayrCr1kJrW7CFnrGa47ArWFv3yrGa15urn3JFy3AF1rZr9I9r4Yyry7Crnrtry8tr1f
	tr4jqrZ8uas0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGoNmbQK-wABs4
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9619-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.ibm.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: A0C7F5A1954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 22:07 -0400, Mimi Zohar wrote:
> On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the ima_measure_users counter, to implement a semaphore-like
> > locking scheme where the binary and ASCII measurements list interfaces =
can
> > be concurrently open by multiple readers, or alternatively by a single
> > writer.
> >=20
> > A semaphore cannot be used because the kernel cannot return to user spa=
ce
> > with a lock held.
> >=20
> > Introduce the ima_measure_lock() and ima_measure_unlock() primitives, t=
o
> > respectively lock/unlock the interfaces (safely with the ima_measure_us=
ers
> > counter, without holding a lock).
> >=20
> > Finally, introduce _ima_measurements_open() to lock the interface befor=
e
> > seq_open(), and call it from ima_measurements_open() and
> > ima_ascii_measurements_open(). And, introduce ima_measurements_release(=
),
> > to unlock the interface.
> >=20
> > Require CAP_SYS_ADMIN if the interface is opened for write (not possibl=
e
> > for the current measurements interfaces, since they only have read
> > permission).
> >=20
> > No functional changes: multiple readers are allowed as before.
> >=20
> > Link: https://github.com/linux-integrity/linux/issues/1
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima_fs.c | 71 +++++++++++++++++++++++++++++++--
> >  1 file changed, 67 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 9a8dba14d82a..68edea7139d5 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -25,6 +25,8 @@
> >  #include "ima.h"
> > =20
> >  static DEFINE_MUTEX(ima_write_mutex);
> > +static DEFINE_MUTEX(ima_measure_mutex);
> > +static long ima_measure_users;
>=20
> long?

The limit pre process can be up to INT_MAX. Two processes could
overflow the counter if it was int.

Since privileged users can bypass the system wide max-file check (see
alloc_empty_file()), I will add an overflow check to be sure.

> > =20
> >  bool ima_canonical_fmt;
> >  static int __init default_canonical_fmt_setup(char *str)
> > @@ -209,16 +211,76 @@ static const struct seq_operations ima_measurment=
s_seqops =3D {
> >  	.show =3D ima_measurements_show
> >  };
> > =20
> > +static int ima_measure_lock(bool write)
> > +{
> > +	mutex_lock(&ima_measure_mutex);
> > +	if ((write && ima_measure_users !=3D 0) ||
> > +	    (!write && ima_measure_users < 0)) {
> > +		mutex_unlock(&ima_measure_mutex);
> > +		return -EBUSY;
> > +	}
>=20
> Thanks, Roberto. The code is really clear and well written.  However, it =
could
> use a comment indicating the different ima_measure_users values as a remi=
nder.
>=20
> ima_measure_users:  > 0 open readers
> ima_meaasure_users: =3D=3D -1 open writer

Ok.

> > +
> > +	if (write)
> > +		ima_measure_users--;
> > +	else
> > +		ima_measure_users++;
> > +	mutex_unlock(&ima_measure_mutex);
> > +	return 0;
> > +}
> > +
> > +static void ima_measure_unlock(bool write)
> > +{
> > +	mutex_lock(&ima_measure_mutex);
> > +	if (write)
> > +		ima_measure_users++;
>=20
> There should only be one writer at a time. ima_measure_users could be set=
 to
> zero.

Sure, but I find the code more clear this way.

Roberto

> > +	else
> > +		ima_measure_users--;
> > +	mutex_unlock(&ima_measure_mutex);
> > +}
> > +
>=20
> thanks,
>=20
> Mimi


