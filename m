Return-Path: <linux-integrity+bounces-5378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54DA6C70A
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 03:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B37C46650E
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBF6F2F2;
	Sat, 22 Mar 2025 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OIiq/tKk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06427347C7
	for <linux-integrity@vger.kernel.org>; Sat, 22 Mar 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742608815; cv=none; b=DG6aAMs2bNcy74RG44myTWwYKZ/KpxCuxg50hdajvauSGRj885jF6GJOx/eAOsAD4hQDNx96Ji8u4n7++kBeQQ4NtV6icaTdVdhvHnVxwAWOaQ+4OrRw8zXRAZV47fuN0y8iPCJVwfgICkMIxVof0y/2tBKY6c0g9IHjlu9aj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742608815; c=relaxed/simple;
	bh=8IqTk4BKS73rbztsZ8s4OStuLs1QlK86pI5xopXqGqg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kkimaTzhTk3RA95O82fG5JaORqxTOz7SSF90F1IpPaMvMJR6u/mnOVj/VUZE16wxv1gp2oMnNY8BeWeyOFkHlPups4nD3Dgx+yX/5Ac32XBsSEF12M8ifN7VpanePn0IjKZ9ZJpjXzLpw+0nkaHVql9+eKnmFkPb5XXCBKjYRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OIiq/tKk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47686580529so24740421cf.2
        for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 19:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742608813; x=1743213613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeTkf0HU2gV+J9uhRCrFRQXj1avZrvZhAtEkCp/R+W0=;
        b=OIiq/tKk+8b6q6okI4e8/WsII58/A52u7Qe8FxIfDHAaZ4fZiDfbhj22ARZcmYOSon
         pP9WSCnsNKN5DdHTKVaOsaYio/CCy8bQPW5AWkxK9eDjuTkC7h+/xbHseFzAn9AbwX8t
         4a4cVByMj6FjBMFNSa+K2+I+ALLx225jELdDW9KmTik9xaeiTXY46GZPb5ocUat3KLdJ
         Ei+o7qj2lGCSwlh6htOw8Fx2U8BXCUzo4QMxHXkJMjqzXPawwlp0G/tWJytMD3bV1Bbe
         W2OsuR2van4AkPe319vkOBYSVNoV4dxotKRpHQ9Vr/AkYFE26G8wsQ6lRSeeCn3ZwMiN
         ojIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742608813; x=1743213613;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeTkf0HU2gV+J9uhRCrFRQXj1avZrvZhAtEkCp/R+W0=;
        b=GljFPvwZAxsvyS9ahWJXB0+jn0pe4c3szjRwDhr24gi74nXT1QGpUjNm1OY/Rq0jC3
         rRm9VOR8vrPIgbBiRuI+f+j7unJUssisO02bTBjjpUEC7n1OKbIThuUNQ3vfwy4dL6hL
         b5gQ9NvTzjq2Shme0PQxzOmIBZEeGf71qH3zrX+TyjkC7Tuj9eGk29PPnnwJEhmBishn
         oc9wiZ9aVlahwSmGCW6Xa7H3Jk1/bjQzW+I/5jnRzcPwFevpMgFQ3ZWuJ8eXgtUhLJv3
         5HCDwHQRpa6Pv8hrMOxtt0nEaAp/I2yxNROCPxeF44DYBOJZr1SjYhSJYfp4nsU/+DDg
         JSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUeeo5+GHs5icXzVePhDSWE+1ShBdC6ubcFRowMoO8JCkUXnEEemhpEcRyEu3O+z1oyl51EVyxCJv63LN575+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2wWA9bMlINgNszswVl5hdHqi7LHO5ADDooCi/G7lKKH7Q6YS
	PI8ICulHaqNDFgQiV4oNxS0Y9qaWHHf2NdLtcB6DOdaRicZp9Nw6q1NGKL3yKQ==
X-Gm-Gg: ASbGncvvYBJBsuO0eb+122iKZ03fyyyQeNBycFL9lcPms0KskoMKU01WV1WCO3UsYnD
	WTfEMz/xDwyeRGEOj3H5sHqPu5iG3WO3ClbZhUELbmNI8wxVGfAEin4lpG6kP/wXPmMKIN199wC
	n9D7XER5J9BooGMZV8O7bQB5jZvILQek8eW6Bt+SvvzIFfg9Gtut/KIwwt2YsYjjEV/hGmL2+dC
	4q/0QNRh5cLV25+zCnJ05FM1Kcs9cheAGQV7xpuxJ2Sb81f/enTSLDqkIfQXaI2yQ/nENZFpJmW
	ZJq6HEHt7mVQ9NZkhOi25YUG4mjGbtwSKpuvGFUFle4Zun1UaLyigbMPy+a2zcFp3Q2ABepeO6Z
	ET4Rlhtx7Qf/t3ofQIaqAH7REp0CCEA==
X-Google-Smtp-Source: AGHT+IHzlySTB1FiLSeLQACkKxr5JgVdqK7Me2MGxcPq3zmWtz2HlzgUUzb9hZF9TIbpp4ZVYFmCfQ==
X-Received: by 2002:ac8:4418:0:b0:477:1f2f:1717 with SMTP id d75a77b69052e-4771f2f4477mr66553491cf.20.1742608812678;
        Fri, 21 Mar 2025 19:00:12 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d17afbfsm18987491cf.26.2025.03.21.19.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 19:00:12 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
CC: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>, <linux-efi@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Date: Fri, 21 Mar 2025 22:00:07 -0400
Message-ID: <195bb943458.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <E8FD1D0D-4A71-45C3-B74C-5224ACD7CED1@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
 <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
 <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <B89ED288-1A01-41D2-8ECF-285669139553@oracle.com>
 <CAHC9VhQb55+SmwmrsVpyw5X2Ys0oo6gJ_dbDf64mS5c008230A@mail.gmail.com>
 <4F901DC6-51DC-47A1-8D2A-D84DCD9D0C2D@oracle.com>
 <CAHC9VhT0y5AO0Yjy649PbsYnN+Xf3_pTJCegW1kPW7=GM9RypQ@mail.gmail.com>
 <E8FD1D0D-4A71-45C3-B74C-5224ACD7CED1@oracle.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On March 21, 2025 6:56:53 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>> On Mar 21, 2025, at 4:13 PM, Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Fri, Mar 21, 2025 at 5:21 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>>>> On Mar 21, 2025, at 12:57 PM, Paul Moore <paul@paul-moore.com> wrote:
>>> ...
>>>> , but I will note that I don't recall you offering to step
>>>> up and maintain Lockdown anywhere in this thread.
>>>
>>> I didn't realize that trying to contribute a new LSM and being willing to
>>> be the maintainer of it also involved stepping up to maintain lockdown.
>>
>> It doesn't, but your criticism of how Lockdown is being handled
>> definitely falls a bit flat.
>
> I merely pointed out the inaccuracy of your assertion that people are 
> freeloading
> off it and not contributing anything substantial by providing an example.

In my opinion the example you provided did not demonstrate that at all for 
reasons already mentioned.  As for the issue of freeloading on Lockdown, I 
believe I've already made myself clear on that point.

--
paul-moore.com




