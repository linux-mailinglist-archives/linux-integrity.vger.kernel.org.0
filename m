Return-Path: <linux-integrity+bounces-9924-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AJ9VMl+SUmqHRAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9924-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 20:58:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23108742AA5
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 20:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=google header.b=gitZ0YU+;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9924-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9924-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F61300F5EE
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CB30E82C;
	Sat, 11 Jul 2026 18:58:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB030E85D
	for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 18:58:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783796317; cv=none; b=fn3z7ndO7UV8ehEy1m+aiJz6VMI49Ou1W4wMYK1HwYCctVA9hI1znym8sGe8W+3t/OQ3T/cfHVW4aNJAwBBq1BlqZmT2FOZyhtnqpIo49hrMOS2VWYFmlT6EbxGCmz1UqzUFbuqIiBE4Co/oXqCwnbQRn5AFzgFb3km+S7lJrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783796317; c=relaxed/simple;
	bh=YltYkcmBVzVzQVo898ceTao0dylmILngB+h59YPw35o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npHfmY/RCq9Ex3AW+m1A+IhYt+fqaa0EnPdN2zGvBHgbpZm2JqQ4nDS+JQqCyHnW+KxmanNZDHzWw2xq1/sLX/o2k32OSJTEkSvGExUN2p56cANgsGtFyV+e46sFTp5cZm5wSBe3ym/53Z4X7eC07NbwnKV46auR7jx4zRQs0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gitZ0YU+; arc=none smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso3953197a12.2
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783796313; x=1784401113; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLZbP2hIHDCrdLVnrBWA8g4pvo8bitPlPLjk8ksuKeU=;
        b=gitZ0YU+UO7yfNPwHdXl+wnob2YmXRCsRD2VVZbXKSBhFuLS/aZQ48NdkPnIYUOgZM
         iov9lTsrzKU0bfTt1anJ4gbdt2cWdM5I7s9C7VpopGqisWpEpIyE1+X+7dlG8u2O4hIR
         x0+jQXUsLAndv3PVa5o2Ocsed8fnqhMYuAZQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783796313; x=1784401113;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tLZbP2hIHDCrdLVnrBWA8g4pvo8bitPlPLjk8ksuKeU=;
        b=OAc2b+KTiV1NtN9q96nrH/F8SvOMFuJyhygTByxEJUAH93vsv993GZk7hXW4zQyckk
         wDbM5qPryFsNHBHU9Q9FeVzpG6n7JLLI+BIWuX0t3qNueTGtar6lSaeQ6E+0r5Tibodg
         lds0ZlYVclJg6zToGeqL1gti1NQs9hc5Ven2Mbh/awh2JZs/R1/7SbTsGvi//FZ9yrCr
         +gYd9YhCErL+V9MJPPigQ9gIpbuEhr1QKGMFD2HLfggSXEepVK0gurDXOLI/R4ANfoL0
         SuK+Krxr12hVj4c16V7+x5a6PZn9XMPi6wjFb2Xslsnx70Sz2MwTShy80fX1xnQ9qDV0
         G/FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpc/8zDpLFabI7QejFK0VqgMAAgNloeWVo4PKTH+SfDiVy3AOtkpR0F30D4aA1i1haLk1SEQcwFln9bJTkzsnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESg6ZiyTY2dVA6jEgcgQrXgFwbrW5N51oD34B5onhsFnzREXH
	kXAb84vkumAx4LCVSGXoGWWx5NIsZyZ7tmAXhisFyVmIhwRzDqV5NzJVo9/YN6zeY2N9VE0jAhm
	TvtsbvK8=
X-Gm-Gg: AfdE7cnqWZBRohg+86C5nXIDCdQlQMDaAU15x6I//lDR+s48fGuqx5Pjo9SbRyZa/od
	26nViTXXUEqHrjq6D2py0hPm2R6/12ctAwwcSJFvlEVLCmtZTVmAaIXuyHN+gOYhbHTpZk/kX1v
	AM27sHhhIieWXmRCHAcr+127+QxEsjwDCgBAwMD6GeZ+ijEIU5BJzPEvvxiy8vkp4+53veIWyaN
	wq06umc4we82amflm4y1t93HfcI2V4MdIqUfz6E25NykZt+0I0XAyezOzR+XV+V2DpVwC53oAyg
	S0YeDELm9gbgIOBMM1ghSMAjWHL4V+RT3kL5iJJZexyucuLUubH8q/nDeIwQ9OJoD5uutDg3K5c
	HL3MJp9hxurvEiP5KcJVF2bym23GWOSjItwT+/pxQ2NvH9/JkH5Yg6aS0ieX/9Cz0tvoYgbRO2o
	KmImAc9EirLD4i+B3fFlU3wlQRH77YKksbDQCt3CumJFlJzOAqnBK4MLGCBj7o
X-Received: by 2002:a05:6402:d0d:b0:698:d6e:bea7 with SMTP id 4fb4d7f45d1cf-69c5f0df845mr1633640a12.14.1783796312995;
        Sat, 11 Jul 2026 11:58:32 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c14972fc7sm3197906a12.22.2026.07.11.11.58.31
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 11:58:31 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15b509c323so268165166b.0
        for <linux-integrity@vger.kernel.org>; Sat, 11 Jul 2026 11:58:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqKKMUYxUydnffJ7jgD2pJuY1XbCPMG/B/bgIOFzTzxZVlhqYboRNIerEjk4eaZ5n6a38g04pAuBac5I6nsK6g=@vger.kernel.org
X-Received: by 2002:a17:907:25ce:b0:c14:816a:156a with SMTP id
 a640c23a62f3a-c161ed8a567mr157693766b.43.1783796311041; Sat, 11 Jul 2026
 11:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710090217.191289-1-yong010301@gmail.com> <alJ4cg_lWo1mdLl8@kernel.org>
In-Reply-To: <alJ4cg_lWo1mdLl8@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 11 Jul 2026 11:58:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
X-Gm-Features: AUfX_mwiSPnW-LaSSziyeDvApZGgTTA9h525pYrgJ7b_oNxXe3NJYxhxbnOjgRw
Message-ID: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
Subject: Re: [PATCH] tpm: Reject reads outside the response buffer
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jaewon Yang <yong010301@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="00000000000078f48c06565a719b"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9924-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de,ziepe.ca,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:yong010301@gmail.com,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[torvalds@linuxfoundation.org,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23108742AA5

--00000000000078f48c06565a719b
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 10:09, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Please don't delegate the work for me that  you should doing i.e.
> looking at your reproducer and describing the scenario/sequence
> that would lead to infeasible consequence.

I don't understand this reply.

The original email had all the relevant information: how to trigger
the condition, what the bug is, and what's going on.

The bug seems straightforward: the tpm code appears to blindly use a
user-supplied 'loff_t' that is simply not checked. The email you
responded to seems very clear on the issue:

  Sequential read() keeps *off in range, but the fops use the legacy .read
  callback and neither tpm_open() nor tpmrm_open() calls nonseekable_open(),
  so FMODE_PREAD stays set and pread(2) passes an arbitrary offset straight
  into *off.

So what's the problem here?

Now, honestly, I think this tpm code is badly written to begin with,
and the patch doesn't fix that fundamental issue.

The code simply shouldn't change response_length by how much have been
read, it should just use the fixed size of the buffer and compare it
to the offset.

And once the buffer has been fully used, we clean it up.

Something ENTIRELY UNTESTED like the attached patch. But I do want to
point out that this patch is

 (a) UNTESTED

 (b) bigger and more invasive than the simple "just check the offset"

That said, I really don't like how the original patch by Jaewon
depends on TPM_BUFSIZE when the real limit is that "response_length",
but that's a direct result of the tpm code being disgustign and
changing response_length as a response to partial reads.

So the attached patch tries to fix that fundamental mistake, and in
the process I think it makes the code more readable, but whatever. I
probably think that primarily because I wrote the patch.

Comments? But this "dismiss a patch based on bogus reasons" seems like
a huge mistake.

Again. The attached patch is UNTESTED.

                  Linus

--00000000000078f48c06565a719b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mrgq8ky30>
X-Attachment-Id: f_mrgq8ky30

IGRyaXZlcnMvY2hhci90cG0vdHBtLWRldi1jb21tb24uYyB8IDY3ICsrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyks
IDI5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWRldi1j
b21tb24uYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWRldi1jb21tb24uYwppbmRleCBmOTQyYzBj
OGU0MDIuLmYxYzE3ZmRlYTc0ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG0tZGV2
LWNvbW1vbi5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtLWRldi1jb21tb24uYwpAQCAtMTI3
LDQ0ICsxMjcsNTMgQEAgdm9pZCB0cG1fY29tbW9uX29wZW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0
cnVjdCB0cG1fY2hpcCAqY2hpcCwKIAlmaWxlLT5wcml2YXRlX2RhdGEgPSBwcml2OwogfQogCitz
dGF0aWMgaW5saW5lIHNzaXplX3QgdHBtX2NvbW1vbl9yZWFkX2NsZWFudXAoc3RydWN0IGZpbGVf
cHJpdiAqcHJpdiwgbG9mZl90ICpvZmYsIHNzaXplX3QgcmV0KQoreworCSpvZmYgPSAwOworCXRp
bWVyX2RlbGV0ZV9zeW5jKCZwcml2LT51c2VyX3JlYWRfdGltZXIpOworCWZsdXNoX3dvcmsoJnBy
aXYtPnRpbWVvdXRfd29yayk7CisJcmV0dXJuIHJldDsKK30KKwogc3NpemVfdCB0cG1fY29tbW9u
X3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCiAJCQlzaXplX3Qgc2l6
ZSwgbG9mZl90ICpvZmYpCiB7CiAJc3RydWN0IGZpbGVfcHJpdiAqcHJpdiA9IGZpbGUtPnByaXZh
dGVfZGF0YTsKLQlzc2l6ZV90IHJldF9zaXplID0gMDsKLQlpbnQgcmM7CisJc3NpemVfdCByZXNw
b25zZV9sZW5ndGg7CisJdTY0IG9mZnNldDsKIAotCW11dGV4X2xvY2soJnByaXYtPmJ1ZmZlcl9t
dXRleCk7CisJaWYgKCFzaXplKQorCQlyZXR1cm4gMDsKIAotCWlmIChwcml2LT5yZXNwb25zZV9s
ZW5ndGgpIHsKLQkJcHJpdi0+cmVzcG9uc2VfcmVhZCA9IHRydWU7CisJZ3VhcmQobXV0ZXgpKCZw
cml2LT5idWZmZXJfbXV0ZXgpOworCXJlc3BvbnNlX2xlbmd0aCA9IHByaXYtPnJlc3BvbnNlX2xl
bmd0aDsKIAotCQlyZXRfc2l6ZSA9IG1pbl90KHNzaXplX3QsIHNpemUsIHByaXYtPnJlc3BvbnNl
X2xlbmd0aCk7Ci0JCWlmIChyZXRfc2l6ZSA8PSAwKSB7Ci0JCQlwcml2LT5yZXNwb25zZV9sZW5n
dGggPSAwOwotCQkJZ290byBvdXQ7Ci0JCX0KKwkvLyBFcnJvciBvciBub3RoaW5nIHRvIHJlYWQ/
CisJaWYgKHJlc3BvbnNlX2xlbmd0aCA8PSAwKQorCQlyZXR1cm4gdHBtX2NvbW1vbl9yZWFkX2Ns
ZWFudXAocHJpdiwgb2ZmLCByZXNwb25zZV9sZW5ndGgpOwogCi0JCXJjID0gY29weV90b191c2Vy
KGJ1ZiwgcHJpdi0+ZGF0YV9idWZmZXIgKyAqb2ZmLCByZXRfc2l6ZSk7Ci0JCWlmIChyYykgewot
CQkJbWVtc2V0KHByaXYtPmRhdGFfYnVmZmVyLCAwLCBUUE1fQlVGU0laRSk7Ci0JCQlwcml2LT5y
ZXNwb25zZV9sZW5ndGggPSAwOwotCQkJcmV0X3NpemUgPSAtRUZBVUxUOwotCQl9IGVsc2Ugewot
CQkJbWVtc2V0KHByaXYtPmRhdGFfYnVmZmVyICsgKm9mZiwgMCwgcmV0X3NpemUpOwotCQkJcHJp
di0+cmVzcG9uc2VfbGVuZ3RoIC09IHJldF9zaXplOwotCQkJKm9mZiArPSByZXRfc2l6ZTsKLQkJ
fQotCX0KKwlvZmZzZXQgPSAqb2ZmOwogCi1vdXQ6Ci0JaWYgKCFwcml2LT5yZXNwb25zZV9sZW5n
dGgpIHsKLQkJKm9mZiA9IDA7Ci0JCXRpbWVyX2RlbGV0ZV9zeW5jKCZwcml2LT51c2VyX3JlYWRf
dGltZXIpOwotCQlmbHVzaF93b3JrKCZwcml2LT50aW1lb3V0X3dvcmspOwotCX0KLQltdXRleF91
bmxvY2soJnByaXYtPmJ1ZmZlcl9tdXRleCk7Ci0JcmV0dXJuIHJldF9zaXplOworCS8vIEhhdmUg
d2UgYWxyZWFkeSByZWFkIGV2ZXJ5dGhpbmc/IFJldHVybiBFT0YKKwlpZiAob2Zmc2V0ID49IHJl
c3BvbnNlX2xlbmd0aCkKKwkJcmV0dXJuIHRwbV9jb21tb25fcmVhZF9jbGVhbnVwKHByaXYsIG9m
ZiwgMCk7CisKKwkvLyBEbyB0aGUgcG90ZW50aWFsbHkgcGFydGlhbCByZWFkCisJc2l6ZSA9IG1p
bl90KHNpemVfdCwgc2l6ZSwgcmVzcG9uc2VfbGVuZ3RoIC0gb2Zmc2V0KTsKKwlzaXplIC09IGNv
cHlfdG9fdXNlcihidWYsIHByaXYtPmRhdGFfYnVmZmVyICsgb2Zmc2V0LCBzaXplKTsKKwlpZiAo
IXNpemUpCisJCXJldHVybiAtRUZBVUxUOworCW9mZnNldCArPSBzaXplOworCisJLy8gQXJlIHdl
IGFsbCBkb25lIHdpdGggdGhlIHJlc3BvbnNlPworCWlmIChvZmZzZXQgPj0gcmVzcG9uc2VfbGVu
Z3RoKQorCQlyZXR1cm4gdHBtX2NvbW1vbl9yZWFkX2NsZWFudXAocHJpdiwgb2ZmLCBzaXplKTsK
KworCS8vIFdlIHN0aWxsIGhhdmUgc29tZSBkYXRhIGxlZnQsIHVwZGF0ZSB0aGUgb2Zmc2V0CisJ
Ly8gYW5kIGJlIHJlYWR5IHRvIHJlYWQgdGhlIHJlc3QgbGF0ZXIgLSBkb24ndCBkbworCS8vIHRo
ZSBjbGVhbnVwLgorCSpvZmYgPSBvZmZzZXQ7CisJcmV0dXJuIHNpemU7CiB9CiAKIHNzaXplX3Qg
dHBtX2NvbW1vbl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1
ZiwK
--00000000000078f48c06565a719b--

