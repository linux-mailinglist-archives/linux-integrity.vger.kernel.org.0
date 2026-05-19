Return-Path: <linux-integrity+bounces-9602-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IKqMNAlDGoIXQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9602-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 10:56:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F957AA2C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6D093040BA6
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7EA3EFFBE;
	Tue, 19 May 2026 08:55:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E453EF0BC;
	Tue, 19 May 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180940; cv=none; b=dOMWnqYeAgMxQ984Xii1dS3GoYI7LSOTMVoYWPAmx2it/fHDr3OlPqgI/+a1ut95GXU+yEq6Egyf5U5m734yzvbFzh5mgixZe+nHlxyRHPKL1PpXkjeAITBVU74uKmlnzkjJkZODR0b8lMVd6pO86s7Y2dz3YNPrxEgOOrq00vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180940; c=relaxed/simple;
	bh=J05AeAqG71CwR6+dkANjT+VWQxCxqr/Vrlgz+AgBcz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqNwvQan/xoZsu1uwwre8BpREt1hh2YYTors2MVOTJZLfcQ7pNQwW3/PACNCbWN5Rftewn9AxA3IQFmXqDCSa7CSk162PO/DlNU+jOMOkjdMniA0vqN6XyzujkIwlg84KHkpC6JlyEvZY+pESjQQaKhiTLqqqyg4Ef67Z9jyl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gKScl52lzzpTS0;
	Tue, 19 May 2026 16:33:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2764E4056C;
	Tue, 19 May 2026 16:38:38 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHymaDIQxqPxhvAQ--.19007S2;
	Tue, 19 May 2026 09:38:37 +0100 (CET)
Message-ID: <3e2629f86015edb92951dfbdb9f6df4e82c6a456.camel@huaweicloud.com>
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, steven chen
	 <chenste@linux.microsoft.com>, corbet@lwn.net, skhan@linuxfoundation.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 19 May 2026 10:38:24 +0200
In-Reply-To: <8db443f1-d2f3-47ce-9116-18985ed0b290@linux.microsoft.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
	 <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
	 <2302296a13b847960dbdbab3cf5518b275938838.camel@huaweicloud.com>
	 <8db443f1-d2f3-47ce-9116-18985ed0b290@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHymaDIQxqPxhvAQ--.19007S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW5urWrGr17Zw4kWF4Durg_yoWfGwc_ur
	1jyryvkF4UZw15CFZ2vFn3WrWDJ34Fy3WfGw15Xrs8J3srJwsxGrs5KrZYyF1fJrn8ZF1v
	9rZrWFWFvrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Udku
	cUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGoK9roL3wAAsv
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9602-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huaweicloud.com:mid]
X-Rspamd-Queue-Id: A49F957AA2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-15 at 10:37 -0700, Lakshmi Ramasubramanian wrote:
> Thanks for the response Roberto.
>=20
> On 5/12/2026 1:17 AM, Roberto Sassu wrote:
>=20
> > > >=20
> > > > This submission proposes two ways for log trimming:
> > > >=20
> > > > *Flavor 1:* Staging With Prompt
> > > > *Flavor 2:* Stage and Delete N
> > > >=20
> >=20
> > I'm happy to support your trimming method. Just does not fit with my
> > use case. I would like to keep both.
> >=20
>=20
> If "Flavor 1: Staging With Prompt" would be beneficial to the Linux=20
> kernel customers, in general, we should continue to review the change=20
> and merge it eventually.
>=20
> My request, then, would be to split this patch set into 2 parts:
>=20
> 	Part 1: Implements "Staging With Prompt"
>=20
> 	Part 2: Implements "Stage and Delete N"
>=20
> I think that would make it easier for reviewing the code, test\validate,=
=20
> and merge.

No need in my opinion, it is simple enough.

Roberto


