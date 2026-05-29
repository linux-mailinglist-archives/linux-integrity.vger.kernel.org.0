Return-Path: <linux-integrity+bounces-9695-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dt9NiCtGWpEyQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9695-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 17:13:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C0604627
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB4DA31BBD2F
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAA3D16EF;
	Fri, 29 May 2026 15:00:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4232E8B67;
	Fri, 29 May 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066800; cv=none; b=TQfJ0QJr5gMToiRQYqee6FMdohzx2tIDI9QuwHbBOJiD/lMuBkLiLnuYUv6sS5TEtzhq3IJ089AdHC42rZh8QZ9lDJHhp67w1+05s1yFqychSnA+HV3yq5JrHrFozRWRySLdYT8X3fQGlS0t7JbomfPTtc0SpHbKF+TpXLnfrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066800; c=relaxed/simple;
	bh=Yb5xZh+ixyrbfIrO8NYmZ70+SmcD6/eyVzBO631EP9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyNrkMMPS8dtBFuhBXlymp9PxyxIJZPSMyK8l1O6lkeKL05w41H/TnqLR0QgFY9nmD23Dd1AEQv25IfvyWz7dqP7CyL7dUH18XOmEXieNrPnHvQQi96HjYVon2Kme9qQtrNswUX1nzDrU4AD+1X3Bv7cxfnvQ2inbwAcplg010c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gRmbf29SMz1HChr;
	Fri, 29 May 2026 22:54:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DB0C84056C;
	Fri, 29 May 2026 22:59:47 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXTmrYqRlq4kwMAg--.36081S2;
	Fri, 29 May 2026 15:59:47 +0100 (CET)
Message-ID: <8a0c965e1c2f3eee1006c4941206d70a71e7d0f0.camel@huaweicloud.com>
Subject: Re: [PATCH v5 12/13] ima: Return error on deleting measurements
 already copied during kexec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 skhan@linuxfoundation.org,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 29 May 2026 16:59:33 +0200
In-Reply-To: <ea886419ef3047ede1885504fad8f865cdcc5ce3.camel@linux.ibm.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-13-roberto.sassu@huaweicloud.com>
	 <ea886419ef3047ede1885504fad8f865cdcc5ce3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXTmrYqRlq4kwMAg--.36081S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4kJrW8Ar1UZw13ZFWkJFb_yoW8GF1fpa
	yfW3WFkr4kG34fCry0gw4DAr4Fv3yfta1DGa4kJw43A3Z5WFyvkr4Fkr1F9FWDKrZ3ta4Y
	yw4Utry5C3WqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBGoZdzUCKgAAsX
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9695-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: C95C0604627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-26 at 10:02 -0400, Mimi Zohar wrote:
> On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Refuse to delete staged or active list measurements, if a kexec racing =
with
> > the deletion already copied those measurements in the kexec buffer. In =
this
> > way, user space becomes aware that those measurements are going to appe=
ar
> > in the secondary kernel, and thus they don't have to be saved twice.
>=20
> There are two reboot notifiers: one to prevent additional measurements ex=
tending
> the TPM, while the other copies the measurements for kexec.  This patch p=
revents
> deleting the staged measurements after the latter notifier.
>=20
> Instead of introducing a specific method for detecting whether the measur=
ement
> list has been copied, rely on one of the two existing reboot notifiers. T=
he
> simplest method would test "ima_measurements_suspended", which would prev=
ent
> deleting the staged measurements a bit earlier.

Testing that the reboot notifier fired (with the
ima_measurements_suspended variable) is not enough to know whether the
measurements dump took place or not.

We need a flag (one is enough) protected by ima_extend_list_mutex, so
that we know reliably which event occurred first, or the dump or the
staging/delete (which are also protected by ima_extend_list_mutex).


Roberto


