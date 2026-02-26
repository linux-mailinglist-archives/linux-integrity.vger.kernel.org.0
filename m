Return-Path: <linux-integrity+bounces-8566-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNdIBhgNoGnbfQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8566-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 10:06:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 834501A31EE
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 10:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33276301486E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05638945E;
	Thu, 26 Feb 2026 09:01:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342443081D7;
	Thu, 26 Feb 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096468; cv=none; b=nrnfvLgTcgBVtUumt18fI6XZgTRL4Nv+MG4VeZBougkiFxp/FacHe572oarbrCdsRazszGlP2pAQ+uUOgrOXabc0zp8mOegmEVgsSixUAYaKqQcMqhVYPaZ/uDidr/qEdyx0pzhs1TMGnDTpBYOA7+UCzsPQ9ZgD6zeZHLlH55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096468; c=relaxed/simple;
	bh=iTWeqEAEZ0QP67jxSEfBBq/rELVHvd9z80WYyil6sjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGk+zPZEwjTC2D7jd5xk7l9SC8GHAj9H9WOYjyisN2e6XrBGhD6b4tcgMhSKzCNpyCCft5dmLcNdjkFf5ZpDyHtX1bt7OBqz6P2ne50sIqcZfX5rRdmX0XZLpA4wpfmXktGRJpvnKP+h7p56x1DcKDzWYT/nYYKii0NWcFquYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fM52K2mGzz1HCSp;
	Thu, 26 Feb 2026 16:57:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BB16440569;
	Thu, 26 Feb 2026 17:00:56 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3z2q+C6BpgliCBA--.50931S2;
	Thu, 26 Feb 2026 10:00:56 +0100 (CET)
Message-ID: <dec58b13c7c2f5d46aad3640719c123920dfa388.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Add digest_size field to ima_algo_desc structure
 and use to show meas.
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devnull+dima.arista.com@kernel.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Thu, 26 Feb 2026 10:00:43 +0100
In-Reply-To: <55905382b88f00de0d7a82aff0605b6d0d9a1e8c.camel@linux.ibm.com>
References: <20260225125301.87996-1-roberto.sassu@huaweicloud.com>
	 <55905382b88f00de0d7a82aff0605b6d0d9a1e8c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC3z2q+C6BpgliCBA--.50931S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr43tryfuw1DWF18AFyrJFb_yoWkXFcEkw
	40vr9rGw4UuF4xWa92kryjgFZ2ganrtrn5Jw15W342yay8J3Z7tayfu3yFvw4xJr4kAF97
	Wr90qFy3J3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGmfvCAF6gABsS
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8566-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dima.arista.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 834501A31EE
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 13:37 -0500, Mimi Zohar wrote:
> On Wed, 2026-02-25 at 13:53 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add the digest_size field to the ima_algo_desc structure to determine t=
he
> > digest size from the correct source.
> >=20
> > If the hash algorithm is among allocated PCR banks, take the value from=
 the
> > TPM bank info; if the hash algorithm is SHA1, use the predefined value;=
 if
> > the hash algorithm is the default one but not among the PCR banks, take=
 the
> > digest size from the crypto subsystem (the default hash algorithm is
> > checked when parsing the ima_hash=3D command line option).
> >=20
> > Finally, use the new information to correctly show the template digest =
in
> > ima_measurements_show() and ima_ascii_measurements_show().
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Thanks, Roberto.  The patch looks fine, other than the patch title.  Coul=
d it be
> renamed as "ima: define and use a digest_size field in the ima_algo_desc
> structure"?

Sure, will do this and add a comment about the TPM digest size.

Thanks

Roberto


