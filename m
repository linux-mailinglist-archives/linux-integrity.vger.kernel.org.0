Return-Path: <linux-integrity+bounces-8886-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI2HC27lp2mrlAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8886-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Mar 2026 08:55:26 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6661FC08C
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Mar 2026 08:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF4CA304DE43
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Mar 2026 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EF037F00E;
	Wed,  4 Mar 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNnTPrmD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68683386438
	for <linux-integrity@vger.kernel.org>; Wed,  4 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610756; cv=none; b=TgPv4AKYL3yrzSsBj+WsNLQNjqx/x835yP8M1ZjjfkSFswwgUoRRuk9Td+TJmPjQKuWiR5U8VHmUk4gY+bpUcn1t5/zrilIOJ/MpdfCzaTc5cKxFsFv3/WIY826KDk+M7irswYccrOQHrJRsp2HCDA1/Ltl2vwdr9YbNmSAyzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610756; c=relaxed/simple;
	bh=EcLDMvBjjbTD/cKF5y1BkO7ob6e6OBIu3jcREkFicZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvtfjdZMyE2cD0uQ8moErFk5Rhm3kgHLjAeZ1LtkeTAWwIIuTJJt00moX7d3/Anaxaq4d/8ErBO6Ak9S8KQ2qiSNYZBLbW/T+yEQcwEKHdLtriViGWHNPbzIgjbAaT7Kigcc+KxTYc+JfVF+OLyH0C+KVHuUz4gb5QLULH/H7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNnTPrmD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3147996f8f.0
        for <linux-integrity@vger.kernel.org>; Tue, 03 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772610748; x=1773215548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=FNnTPrmDvPeJsl7KgOkZBHjigGbAfeWKOyNkXPj/ux+4SYrQn4MTPSHMrouYmSgqIa
         YuFUNmIKbBGjpl8HC4GdNNkeY3ChhyRlnRpH4V0ri52oDep3hlSTOoliQedMT0Q80eJ/
         u74NOjzU2/l3poPflXJgxfZbtt5Jd1H9iW1nzjA/GbFpj7Don+kWtej1SpQqfk5AYi09
         Eb9dLae/TK4h5q3fJZKI1g95C/udZxLAoLe0Upb2/LygfKo5T5+smDUdi37tfQZDsldY
         1va/Z7NSVaRop+Elt1Nxco58Kr4VF80cTnrvUk2M/x5YabCEcP0q7FV2F+ubPjbxO5dH
         6ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610748; x=1773215548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=WxPaOSNRwucz2yNWfsuPXkvmWRK0IFs42qsbYjRodz9M7VHvRSjDZw1Yi+Hq3Z+ZSV
         hBwITuvt2BJOrg3raNSZYDfIus6vGfmLvHelo9NEyOzXexMYP7HLj914V/L7Vop5lYEK
         YO0ykx0+MriZXkflFGhQg24RSo55WJajTbN/y50QUXE6orwEaV7pQSMTdUmrw72KlU/x
         ULKuIhQhpWN2shzyrsUvXp4Hr5Jfzm1Y/Eew7r/3BXdlwRz5EP4CffwaHhGKCOVWhyey
         ksjEe3XaKUmj5A5npMm/GEoGZmPUE1sFRLT4xtYi3TXO8Tsj1axW8BaCxB1R1096qMC3
         VpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFClPiG8Ri58Zn2PG26nVmZBwdS+9GmNxiY+s81xMMSEuEZJPZ3Mm9OVw8l7esy58gDQbsjzFTmSO4p30mUqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJv+0w2TBJWlkT0rGsjTt7MMeKazfr4S7rUca/5pmifRG3nep
	i6Lk4O3lN/iGaEI9RlxArojyxoLGQjZ8K/0xpZCS5KHvABX6E88BSz6ryUVhKwjwmsw=
X-Gm-Gg: ATEYQzzDkpMP+D5ETTbH9x6h0DSTx1FHk6tTqSQ6iuyUVCkaMbGIl99nnEFQfeUqY6l
	eC7PIZtjK3NALmRimcklZpPFZr4/9yoOP6oftNUm4YNzLsiqCwBPc3hmVXakePmApW84q/DPly9
	HcLF4XZ2ZzBNqMwsvSk+qrGjpg8VLZiQmV4etUa2AUNEzj9UNdye6BseRi+ZsgZQWE2f3vjuNzb
	FNVFrTD3ylcrwfCw7ePo+CZwJRK6j4xzF8XvmCQsTcTFv3/ZOVDK5mYPv2fh3BnWq6ycFhL0d8i
	zfxrCs9iLvMLSjFuDpUQAONYieGsY1VZqPojrJS2kvUL+PmltHEN6rnrhiXx1pZkiIcmF/1b1IK
	8QUk+xQ2+EYNuBtapeilGIG80Sznby6eHWDQme+uHqRqa/SiXAcC16bTtMJtbdIK1RIK3ymF6RE
	QexQQhkzaVTPqV8F3kf1jnKMpgRT4v8rym8LC+4M6TPtFSneyN0z4udbk6ycRvT+1ETjxEN+2G7
	gLhubxQhuHcuY5TkLVVEOp4gX/7g1GMqIli+dcAKOSJMaoSvIrDHwCBFdK9EE8rQK96lj0ji/FC
	RHcW
X-Received: by 2002:a05:6000:4301:b0:439:b886:20d3 with SMTP id ffacd0b85a97d-439c7f7e5b7mr2101563f8f.15.1772610748337;
        Tue, 03 Mar 2026 23:52:28 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm42229774f8f.3.2026.03.03.23.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:52:27 -0800 (PST)
Message-ID: <97a56169-b71c-4ad0-8992-c6e2d381ff02@suse.com>
Date: Wed, 4 Mar 2026 08:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] modules: Move 'struct module_signature' to UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC6661FC08C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,kernel.org,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8886-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:email,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

On 3/2/26 1:42 PM, Thomas Weißschuh wrote:
> This structure definition is used outside the kernel proper.
> For example in kmod and the kernel build environment.
> 
> To allow reuse, move it to a new UAPI header.
> 
> While it is not a true UAPI, it is a common practice to have
> non-UAPI interface definitions in the kernel's UAPI headers.
> 
> This came up as part of my CONFIG_MODULE_HASHES series [0].
> But it is useful on its own and so we get it out of the way.
> 
> [0] https://lore.kernel.org/lkml/aZ3OfJJSJgfOb0rJ@levanger/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

This looks reasonable from my side and reduces code duplication. With
the removal of MODULE_SIGNATURE_TYPE_MERKLE in patch 6, as reported by
the AI, the changes seem ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

