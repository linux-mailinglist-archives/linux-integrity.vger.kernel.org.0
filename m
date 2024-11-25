Return-Path: <linux-integrity+bounces-4194-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA04D9D8A32
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A140228235B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489D2AD25;
	Mon, 25 Nov 2024 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qig0sME+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6C1B415E
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551759; cv=none; b=OSRDrjGGY05XE9SgKyHgeSsr5/qvFQF4t4IqBJ3aKa4vWilGwPVWqY4wdese7bJ6UUBnKFvsm6VpIzsnK8r6T5JCI7TYujFbjUQIEzFu99skqpartoyeAiDmiZ+IW8p4IrumqXSks6rE2rNNgaDxZF0YetmTLeHlEvRIZ3vCeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551759; c=relaxed/simple;
	bh=SOtD3wRCEIiC5+ezgG0pVQMc32AJMnknrAMHMNt4Pa0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=r7fEK/fVTfK2BVJNW37YzHIxfUug6fNT/Wzg8lPiXs2IkBre/yS59ZFD1RNDMQA57AftbxBzEF8FPkr4SxGolr6dowacYg6a1/vYVe1ql7ABYsngpTE6lWfUYKDg3aZh0LTgydIkvYz1RJGNy9NFKKWUu9lLcluSvraoQcwLJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qig0sME+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa560a65fd6so68377766b.0
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732551756; x=1733156556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOtD3wRCEIiC5+ezgG0pVQMc32AJMnknrAMHMNt4Pa0=;
        b=Qig0sME+T50bu/058Mc2w4SYJ7qi+wuIZNcElyS0kuPsXuO+Bh3uoHRAspw5sia+7M
         x269KLsIo7AovBBXvGg81S+eVbj7KcOoRua14Ysm0qAoJzAJga7FoAxYbQFaF0gaH3n3
         vyXf4xdUtWjr2CivqwTtkn3hc1GF7ZzDc374yU8OHS055FXjA8KvF95MzCCH71wh11/e
         EIcJmz7xT7rl3FmL7Bw7RCzOio2yzTs+QprVjD26nerEY0rzL7xDTh9LE0rUOpfd3y6O
         dpXQ/K8RTY211OB8/gF/jlU3v4RwYUl2go2K3j4NRMfYosWQcF38kMZMleL85zb4Kw+m
         i8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551756; x=1733156556;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SOtD3wRCEIiC5+ezgG0pVQMc32AJMnknrAMHMNt4Pa0=;
        b=RQ2qdu9/G2+fM6EGwYakRTFUIIt33HYWP5YaKlHB4eBsH3d2xsOfojCezBtV8Wfqx6
         eMXMNN2Ml3xmWQCJ62EYuTAv8ER4qvplLSFyJjxxLG/dHN3X0S33xhHSp62Iere+LOml
         Flge+QhZZTT6KEAj08Qc+xVJz+/Z7R0CKb4D4ilsA298/vp/vfa5ZcjJWhkF1epm12MQ
         LZlRKBOsGUmU7EDFQqP098V728hIuwEgvhARg18h7jCA0Fkrz8cJlzs5B/1eKOt1WQEv
         Bvl1IOIxxd/gbxCX0IolkfxLqOAyA2Kz5CaYM22Pg01OXbgJ5xtJ6JGvrBmxgbhI/Wps
         FWww==
X-Gm-Message-State: AOJu0YxZYr4j2lFcAmAy3UbPw0nmOetc/wQbZr3DjpF4ArX07yZSeRFX
	EDSMlsC/cBDSQb29rTWJ1AemjvzD8BpQUodBd6GaaHcs1iMml9Ok
X-Gm-Gg: ASbGncvRqOSAtKfnUdPMRyTQkd7redSyIA8VNOl5+tfd0jW4uPElGo4KwLtMi54Ex5L
	HxRTa/mo/22PVH5Gxy+Ejm/2Y5w3tMWjMH+1BzKvgtdo9eR/bwKL5F+QfzfNiu8TE73QObhRs8P
	p6v/UJdV3d70KmIQv3HDQyxMPuaPUkHKC7IJkDImgEV6lzrpuwLZ9cLTHVX3NZH4auLBet9ZsVh
	UIRxe1ZGY7wGj2DBdkg3C7pxMTblUOEwjk2xH3gUUCM+IUWw6pRfngzLRf0iottDwfTTR8nMAl+
	Fp92D7QT4oRjbB8aiHH28Fu0/GmzlyuoaA==
X-Google-Smtp-Source: AGHT+IE8UMTywdm0jDOUXXuFrwcaAvAzVnuNlX5Rrf7X+wMJlfPboTf1C2RisoIFN2Sj5FPvzsBaGA==
X-Received: by 2002:a17:907:7751:b0:aa5:1cdf:7bfd with SMTP id a640c23a62f3a-aa56486a009mr137366b.7.1732551756070;
        Mon, 25 Nov 2024 08:22:36 -0800 (PST)
Received: from [127.0.0.1] (dynamic-095-116-179-226.95.116.pool.telefonica.de. [95.116.179.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b584131sm478519066b.168.2024.11.25.08.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:22:35 -0800 (PST)
Date: Mon, 25 Nov 2024 17:22:34 +0100 (GMT+01:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	"M: Roberto Sassu" <roberto.sassu@huawei.com>,
	"M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
	"R: Eric Snowberg" <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>
Message-ID: <3a3a1a22-636a-4ac5-ba12-4c59eabad664@googlemail.com>
In-Reply-To: <85139843-047b-44be-a1c1-4b0110206cf5@schaufler-ca.com>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com> <85139843-047b-44be-a1c1-4b0110206cf5@schaufler-ca.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3a3a1a22-636a-4ac5-ba12-4c59eabad664@googlemail.com>

Nov 25, 2024 17:17:19 Casey Schaufler <casey@schaufler-ca.com>:

> On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
>> Hi,
>>
>> I noticed that the `prop` parameter of `ima_match_rules()` is
>> currently unused (due to shadowing).
>> Is that by design or a mishap of the recent rework?
>
> Which tree are you looking at?

torvalds/linux:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/


>
>>
>> Related commits:
>>
>> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
>> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
>> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")


