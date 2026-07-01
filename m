Return-Path: <linux-integrity+bounces-9863-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /i0uALytRGqeywoAu9opvQ
	(envelope-from <linux-integrity+bounces-9863-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 08:03:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468366EA149
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 08:03:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=DjQyLh6k;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9863-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9863-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C19E303B6C3
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8A392C29;
	Wed,  1 Jul 2026 06:01:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D893955D8;
	Wed,  1 Jul 2026 06:01:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885681; cv=none; b=u1IBuETNdMfI25sVtS2PO7DxsZnP0YXNLqJ3VIS3kUvOs9VIO5uGlQDuMY37PJbe3vVah+kwehc7Ikgto0VAjMGUooguhmDHrggtSY463XhzEC7Muw2wJXmoMlKEwKMwvgtY2yuRLgKmNN8I6R9eMAWgMxBIgN3uXdiEmDT4wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885681; c=relaxed/simple;
	bh=DelOyr4Q/HBfTH6BSlNNi6sMOCMNSiKdZn93WzA09GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkXmJpEzw7rD5UZVxEwiA43vfFfMbRb64OGqQJ8jrqnxYXZKG/jQCkM/4eiTeimLSHN2gcYK8wZoF44177wsDZsdIHTGvuHiWHSiVSqxDrX/Oc8EfA/EMo1Ai2sMCwcvErWPsEC3rrr2HJVzvxUwwwCeK2bug5XTRb3sKY9tKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DjQyLh6k; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782885645; x=1783490445; i=markus.elfring@web.de;
	bh=Xy6Q8nTosbzVtz/e2WE19ikj/aI/XnvgQ7NJOmIDfOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DjQyLh6kqzlQsS+ixe9+/5RSUrrgV+7vVIGEECTEVsC/J5fFowHOyjMr4xNcN5vE
	 6bfyLnthv/Tmh4cNIzr6v+XxXkPxbzQEPNrKcvp2lJSdCp+/IoaemGlmqUpl+DjLI
	 mgQuCquGhgI9ScSvJ5sp3CHaLlU6jBN7XL269EWDGA3r8Ive1CtALNRgG7Plni2vt
	 ga1+X2HityIMwOWa9Ded7JnctnMZIyRrgT1ezGbb8syobqZZtFHUUH4OMWY5PFrgC
	 P7A2B9z33UsNDBfEdocnGuFQlD1z4RReFWlgSQ5dOUSkIYp8+hO/i6QxXxDMCvbhG
	 AHEW0oH0zfteuSaAzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLmo-1wb0fv0Yza-00T5WP; Wed, 01
 Jul 2026 08:00:45 +0200
Message-ID: <4b21e0d5-07d1-438b-a6ea-a2be596a3044@web.de>
Date: Wed, 1 Jul 2026 08:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
To: Tao Liu <ltao@redhat.com>, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Baoquan He <bhe@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Pratyush Yadav <pratyush@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20260701025732.66330-2-ltao@redhat.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260701025732.66330-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xbA5c1UHwIqj5RgD3GZl8yVj/SkfKs060P78SZpqof6yn2HulB2
 dWSH1UF2uNBy8wolOto6JKlPpEZMtSdz86DEbz4hIP57B8rXcYQlMJDStg5CFMFZzFtWbfB
 71qFmCm7q/eo2XAQgp+9ZAKkoqequpiOIKUhBnnGw552Y8z92UCPaaNUHfhz44DYAVxOl5p
 GMNdArGbpEI8vXO4j/LoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GKIGm79yHUg=;LgABditdxeGX6Bc+BUoCZ6BdNCp
 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
 QgxYJBCH40W7p9ITUk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9863-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:linux-riscv@lists.infradead.org,m:kexec@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:palmer@dabbelt.com,m:pjw@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhe@redhat.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:nutty.liu@hotmail.com,m:pratyush@kernel.org,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,oracle.com,kernel.org,linux.ibm.com,hotmail.com,huawei.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 468366EA149

=E2=80=A6
> Fix this by simply adding a check before copy.

                                           a data copy attempt?



> Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc1#n34


Would a summary phrase like =E2=80=9CPrevent null pointer dereference in m=
achine_kexec_prepare()=E2=80=9D
be nicer?

Regards,
Markus

