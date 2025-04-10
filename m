Return-Path: <linux-integrity+bounces-5759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE11A83F3D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729217B6D05
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D42676FE;
	Thu, 10 Apr 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT6SR8K5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DC26A0D4;
	Thu, 10 Apr 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278370; cv=none; b=s9hcc5rDHAo6ig8X1hYWLup6b18z9+h0ful/8s7ph0Jihi8YxkQ9OEIQSXxlvRjIYOQNcY0JD/dzjrzahpC4JibyuIoJHnKKHOYE/alnxEftW+WcnzLHc3LdPYLBUcTIcJv5owILUJAoVdbEQE5roaua6lFc2gB3DM5Emrb5i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278370; c=relaxed/simple;
	bh=4s3ZacDmF0acLH/4llQMYAZNHTv/D6yaEavN2T8m6+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwZL2D8oNozCQUL03n0b1nhKGgnURl1WFZUL4v0EH0qS5UwjSyR1H3YUj2d/rWUF7nPH4WtsR4gkea+o/AuVKlzH6AggkvOavhgRqTaKsrOo5rI8sHv2wnyIvYtDTfS3kb3DR60BYUjoXKru4a8/RuJ71gZVcWqVjN0QqShIFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT6SR8K5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7376dd56f60so369154b3a.3;
        Thu, 10 Apr 2025 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278368; x=1744883168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/OI6E9F737xY7P25JwnmZaPm/Y8Wf+gvRZpSuTpy6E=;
        b=OT6SR8K5twmenZmiGPtc5rp2i3q1k8aoQYIWf5Y9dHPXp3txA3BWCqOCLssQ3/br7Q
         s8Jn7ZqN8/7kAd05XGpH/hUF4c1m3hl/GDtMlXb8c6Dejm47rGr5nDne1F5Bc7k3GeTW
         K054+A6/fZ9c5V0+L3EmiXWIlkUUi7MjkRccKJMB+FbX2nauiWpqb1HhLOLGyafU3nl4
         CTJ1lb+6oTBwTtZemZdkgjz+2dTRre0SwqudTs4UNArAMxc9e9hPztEPwDhQMdXmJgz6
         thGFTGomyJG8HGd15dVgNydquU6LSEyME6A2GqzpHBHzVozFcLIdm8VcJYTrtBatUvzC
         J/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278368; x=1744883168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/OI6E9F737xY7P25JwnmZaPm/Y8Wf+gvRZpSuTpy6E=;
        b=fVZmtHvy3SWgf9N/ogq5A8t1UBrLQPzAg6EYs5U7KQ4a9pPu2JZO0lmy1HCI8BvWsQ
         aT/KR8DoMBMYpdKYN9anSX/+NWLgzZAu2bP/aztzNk2OgwCYheqR8bVkscdQu3GGB7/K
         HLBKdhzSmgnafMF2Y0vH8HF+CpxJz89PBgwZFSWX0EuLdy5t9z5msEH6UBjdHTYliMMC
         RKTAZF20irjrB+IVoGTUOhr80ApohKlHHG65z+ZVblcqmIkmI9VGEJCU5hqQxFCWXrZK
         wVDmWh3wXGOw3ctO94AshIplxF0omhWviWfSTXo9pEQqNLw+IOMFSzsEguvc13xnt+re
         qQeA==
X-Forwarded-Encrypted: i=1; AJvYcCUCzsqaO+wXlZ5btUXgo+FdrnT88VlEbfibW8w8NxqIaObnUAvfCOeg+bAr83yq3u6I/mr1T5pN18D0NhCY@vger.kernel.org, AJvYcCW53aNvCgNKYxxCj+riRABWw1h2HXqJe4IfRyurHB/cMXKP6SIlc9Y6sn1xQnD6fGgJuP+hhXQeaJw3pWu+t78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPYGNpIzcR38MFfBeWPClKwfCSGhF44dp3xlgTjEUv13xGGUP
	cWN+WXJkdNyeDxx5ZuEKdLRn3jjPMZPOcdgZOzC0Fb/i1hEU+mlw
X-Gm-Gg: ASbGncu4zER2uwxJNXMiogBwvxcQVxEPD/WyYE1R2Z9oanRzZRbnF2Tt5IL9/aoeXi/
	Gw3QOeyz300stqWhj6TQfDTGEtTU9np92OKpNTzzEy/FNyDt+gk8uytWEfHesKp64UPoIMd5qjA
	e3kCpOdd3eLtYN40o52b7RA0dEgcSGM7cyivxBQa2opTdI00N87k2laR/axR/+yHHHbFB3J2myC
	WpdZmbZwbR9EPQdMQ/ssuSd+NSnocfAPLVOL1iZt0kz6/ikrVabu3hI0o8bRd8PZw7Ophs3iuov
	DdZd1jTwWTggCqVw4JyDVtLiO9n5Eol58haZIl7Cpg3MdhuWyulqVVFf1nnpsv4Pw78VmDWkjsm
	7fgiViZNf9BXmNww=
X-Google-Smtp-Source: AGHT+IGxbykd1xi8RysmDEKp0xcBu26rSmEn29jOu9EKsE75TvAMZ2b+c2vZBXR06+5s39q7XPlTqg==
X-Received: by 2002:a05:6a00:170b:b0:736:4110:5579 with SMTP id d2e1a72fcca58-73bc0a074eamr2649067b3a.2.1744278368431;
        Thu, 10 Apr 2025 02:46:08 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:5da0:ac0c:6934:f07? ([2409:4080:204:a537:5da0:ac0c:6934:f07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b34dsm2816398b3a.4.2025.04.10.02.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:46:07 -0700 (PDT)
Message-ID: <70de56d3-1cdd-466b-b2b9-a4f69981d696@gmail.com>
Date: Thu, 10 Apr 2025 15:16:03 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
 <fab2bb2d-a78e-4130-a5fd-bf07430210c7@gmail.com>
 <Z_eHei1jT0YoPgki@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z_eHei1jT0YoPgki@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/25 14:25, Jarkko Sakkinen wrote:
> On Thu, Apr 10, 2025 at 02:12:07PM +0530, Purva Yeshi wrote:
>> On 10/04/25 13:21, Stefano Garzarella wrote:
>>> On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
>>>> On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
>>>>> Fix Smatch-detected error:
>>>>> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>>>>> uninitialized symbol 'value'.
>>>>> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>>>>> uninitialized symbol 'value'.
>>>>> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>>>>> uninitialized symbol 'value'.
>>>>>
>>>>> Call tpm_buf_read() to populate value but do not check its return
>>>>> status. If the read fails, value remains uninitialized, causing
>>>>> undefined behavior when returned or processed.
>>>>>
>>>>> Initialize value to zero to ensure a defined return even if
>>>>> tpm_buf_read() fails, avoiding undefined behavior from using
>>>>> an uninitialized variable.
>>>>
>>>> How does tpm_buf_read() fail?
>>>
>>> If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are
>>> effectively returning random stack bytes to the caller.
>>> Could this be a problem?
>>>
>>> If it is, maybe instead of this patch, we could set `*output` to zero in
>>> the error path of tpm_buf_read(). Or return an error from tpm_buf_read()
>>> so callers can return 0 or whatever they want.
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>> Hi Jarkko, Stefano,
>> Thank you for the review.
>>
>> I've revisited the issue and updated the implementation of tpm_buf_read() to
>> zero out the *output buffer in the error paths, instead of initializing the
>> return value in each caller.
>>
>> static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count,
>> void *output)
>> {
>> 	off_t next_offset;
>>
>> 	/* Return silently if overflow has already happened. */
>> 	if (buf->flags & TPM_BUF_BOUNDARY_ERROR) {
>> 		memset(output, 0, count);
>> 		return;
>> 	}
>>
>> 	next_offset = *offset + count;
>> 	if (next_offset > buf->length) {
>> 		WARN(1, "tpm_buf: read out of boundary\n");
>> 		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
>> 		memset(output, 0, count);
>> 		return;
>> 	}
>>
>> 	memcpy(output, &buf->data[*offset], count);
>> 	*offset = next_offset;
>> }
> 
> Please don't touch this.

Got it, thanks!

> 
>>
>> This approach ensures that output is always zeroed when the read fails,
>> which avoids returning uninitialized stack values from the helper functions
>> like tpm_buf_read_u8(), tpm_buf_read_u16(), and tpm_buf_read_u32().
>>
>> Does this solution look acceptable for the next version of the patch?
>>
>> Best regards,
>> Purva Yeshi
> 
> BR, Jarkko


