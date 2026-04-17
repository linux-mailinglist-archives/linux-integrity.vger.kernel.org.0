Return-Path: <linux-integrity+bounces-9217-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBwrJLj04Wmv0AAAu9opvQ
	(envelope-from <linux-integrity+bounces-9217-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 10:52:08 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D85418F84
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E713093014
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A13AEF3A;
	Fri, 17 Apr 2026 08:50:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA9389E09;
	Fri, 17 Apr 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415802; cv=none; b=iWTG526zVGve7Wqr8Hg/hQViAQtFeqN1qCiPnxzBGsfdYk5AyyssUtU9bssexYWPX1qx7dvj2EbagWa8TtRAfLC+dQS2t+EzR/suFIxGiiNHJy32QNGpMn60qV54RFA091zYFvGcN3hTppYUdqbAAF5PlZKTAzZjEhL6nBaTDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415802; c=relaxed/simple;
	bh=azlK2AIJx/EJ1A+6D8LEEyLd4U7VcVCD5tRCpDB7cdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbrGyuxCJ4ganV8pMVJVTf611zoKlQjTmI3Vl+q41QHdF4AjxqEitvN8/maVSW7JRgLnvcX+or/gJoLt95wrX4EZ1sCtGuyo9R3gMyOFpUjBg0t6CHicFojIFL5yLQ/1czUPVT4A0qTnd+ujovtlSHq8e6WO18W/N0R6S6WTzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fxnz7661GzpVB2;
	Fri, 17 Apr 2026 16:26:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E9C534056D;
	Fri, 17 Apr 2026 16:30:42 +0800 (CST)
Received: from [10.221.98.196] (unknown [10.221.98.196])
	by APP2 (Coremail) with SMTP id GxC2BwBnHfqq7+FpUHpeAA--.33559S2;
	Fri, 17 Apr 2026 09:30:42 +0100 (CET)
Message-ID: <b28a714c-aabe-49f3-a8ab-274feff34d85@huaweicloud.com>
Date: Fri, 17 Apr 2026 10:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] evm: terminate and bound the evm_xattrs read buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
 <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBnHfqq7+FpUHpeAA--.33559S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFykWFWrAryrKry8AF4kXrb_yoW5Jr4xpF
	Zxta4Dtrn5XryDKFW3J3W7uas3G395GFyUGr4fG3W2ya9Iqr92gFykKa45uFyfJrW0yr45
	t3s0vFnI93W5X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGnh2QYCbQAAs4
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9217-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28D85418F84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/2026 2:44 PM, Pengpeng Hou wrote:
> evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
> enabled xattrs, and then passes strlen(temp) to
> simple_read_from_buffer(). When no configured xattrs are enabled, the
> fill loop stores nothing and temp[0] remains uninitialized, so strlen()
> reads beyond initialized memory.
> 
> Explicitly terminate the buffer after allocation, use snprintf() for
> each formatted line, and pass the accumulated length to

pass the accumulate length (without risk of truncation) to ...

> simple_read_from_buffer().
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - add the Fixes tag
> - replace sprintf() with snprintf()
> - explicitly terminate the buffer instead of switching to kzalloc()
> 
>   security/integrity/evm/evm_secfs.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index acd840461902..b7882a4ce9d0 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -127,8 +127,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
>   			       size_t count, loff_t *ppos)
>   {
>   	char *temp;
> -	int offset = 0;
> -	ssize_t rc, size = 0;
> +	size_t offset = 0, size = 0;
> +	ssize_t rc;
>   	struct xattr_list *xattr;
>   
>   	if (*ppos != 0)
> @@ -150,17 +150,18 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
>   		mutex_unlock(&xattr_list_mutex);
>   		return -ENOMEM;
>   	}

Please add a newline here.

> +	temp[size] = '\0';
>   
>   	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
>   		if (!xattr->enabled)
>   			continue;
>   
> -		sprintf(temp + offset, "%s\n", xattr->name);
> -		offset += strlen(xattr->name) + 1;

Also a comment like:

/*
  * No truncation possible: size is computed over the same
  * enabled xattrs under xattr_list_mutex, so offset never exceeds size.
  */

to motivate why it is fine to increment offset without checking.

Thanks

Roberto

> +		offset += snprintf(temp + offset, size + 1 - offset, "%s\n",
> +				   xattr->name);
>   	}
>   
>   	mutex_unlock(&xattr_list_mutex);
> -	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> +	rc = simple_read_from_buffer(buf, count, ppos, temp, offset);
>   
>   	kfree(temp);
>   


