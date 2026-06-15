Return-Path: <linux-integrity+bounces-9794-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id byuYKuCvL2onEgUAu9opvQ
	(envelope-from <linux-integrity+bounces-9794-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 09:55:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB256845A6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 09:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9794-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9794-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB88230265BF
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B653090D4;
	Mon, 15 Jun 2026 07:43:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FC274FD1;
	Mon, 15 Jun 2026 07:43:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509422; cv=none; b=rFOYsXh5+ESArMXD/FT+PfAHPWBStwMTQt3C27S6HrZipK03r/zWiuM/aC2RV2n9uRU+nG/stxK+OBEOlpNRsI0gIMD+dhOCPYWRCWcjbcKNmTczMfh6Ukcx7xLlfvpcKdouLFnBjHanIzX6FDNeVfcZnPgGagEvecEgz3Sxbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509422; c=relaxed/simple;
	bh=28K2j26aCqXtjw5gXz4mCkYmJ6UK5OnO/rXxJMgdvLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrGla1c+DeFyUYt2vWfJ4qwWDqiWcVG71abKO1yJmHYAtyzjfxRBwtMq9dn5WWvMTwfVbZrM7Os//NouCy35do8jayJYUGIbfCSh+2VXSAU0snB/yxv7A7nz6u/YFFHhgvLDwNcPOM6twbt/k+eReMD0qtPCzKDkeJGFZuiL4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gf1jc2WPTzsWPl;
	Mon, 15 Jun 2026 15:20:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BCE2140572;
	Mon, 15 Jun 2026 15:25:30 +0800 (CST)
Received: from [10.81.207.22] (unknown [10.81.207.22])
	by APP1 (Coremail) with SMTP id LxC2BwBn087WqC9qE+P7AA--.50004S2;
	Mon, 15 Jun 2026 08:25:30 +0100 (CET)
Message-ID: <d86a9834-5f0e-4e6c-a181-0b6bd81caec5@huaweicloud.com>
Date: Mon, 15 Jun 2026 09:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
To: Mimi Zohar <zohar@linux.ibm.com>, Daniel Hodges <git@danielhodges.dev>
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aYNprpzxppKE0Gf2@fb.com>
 <20260206024240.19059-1-git@danielhodges.dev>
 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
 <c1d570271884159e6c14617fa7dcd39bc2103e45.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <c1d570271884159e6c14617fa7dcd39bc2103e45.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBn087WqC9qE+P7AA--.50004S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4UGFyxCw1xGr18Kw1ftFb_yoW8AFWxpF
	WrWayDtrWDKFyUCFnxt3Z5ZrykC3ySkw15Jry8GryYva9FvFsYqr4xC3WFga4kGr18Gw1Y
	qr4ay39xZ3WqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGovakYaugABsI
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9794-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:git@danielhodges.dev,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:mid,huaweicloud.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CB256845A6

On 3/9/2026 4:03 PM, Mimi Zohar wrote:
> On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
>> On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
>>> The crypto_shash_update() and crypto_shash_final() functions can fail
>>> and return error codes, but their return values were not being checked
>>> in several places in security/integrity/evm/evm_crypto.c:
>>>
>>> - hmac_add_misc() ignored returns from crypto_shash_update() and
>>>    crypto_shash_final()
>>> - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
>>> - evm_init_hmac() ignored returns from crypto_shash_update()
>>>
>>> If these hash operations fail silently, the resulting HMAC could be
>>> invalid or incomplete, which could weaken the integrity verification
>>> security that EVM provides.
>>>
>>> This patch converts hmac_add_misc() from void to int return type and
>>> adds proper error checking and propagation for all crypto_shash_*
>>> function calls. All callers are updated to handle the new return values.
>>> Additionally, error messages are logged when cryptographic operations
>>> fail to provide visibility into the failure rather than silently
>>> returning error codes.
>>>
>>> Fixes: 66dbc325afce ("evm: re-release")
>>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>>
>> After fixing the minor issue below:
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thanks Daniel, Roberto.  Daniel there are a couple of places where the line
> length is greater than 80.  To see them, add "--max-line-length=80" to
> scripts/checkpatch.pl.  I'd appreciate your fixing them.  Otherwise, the patch
> looks good.

Daniel, do you have time to fix the style issues, so that we upstream 
your patch?

Thanks

Roberto


