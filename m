Return-Path: <linux-integrity+bounces-7550-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9BC23A53
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A48F4F10AC
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91510303C81;
	Fri, 31 Oct 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqbdENRx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C52F8BD1
	for <linux-integrity@vger.kernel.org>; Fri, 31 Oct 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897620; cv=none; b=TWfcBtr95q8gzTFt6Pl1piPmrJ3hetXqAiIdGYPA8DX5tAF0kdGuzYIB25Xgu/RbZ+7/uFsp6IVdvdxGOQNIzTjC0VVwwVb23upVE7hoyxPFtmowMYCFTa4kwZLcETxfFLcwxWuXg8RLieX8H7fVtXJqsRMH3Pbqo3+YxGO0wFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897620; c=relaxed/simple;
	bh=lB66Wru9u8c0qnRy/70ZKohUPZs+4FPyI3uKveKSmO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5C0+CVSr2L7uty0jZAy8THGK77eg5Pr8YVbYIYRpN7qKYOtgg3v7jP6r9H1kW3TTrZ2WaJVHaBJgTdgGgbS2pBTKSFdn5mj534j1xopUoQF/BQQnkZK6WiOy5i34XJ1fYMmOUfxjITBu1fzTem4ToRCeiq1jKOvB7Aayf4AoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqbdENRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761897618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
	b=AqbdENRxm5bKwc9rz0eBk2zPpC5Pu9z4BHjRpm4bBDsrr2XIRMHP3tZT9AIpQ/d7quIjPG
	3so4x2p0OGIICPVDos+e8TPZhe0S3o9G2iOKjzmrdbgmaqx/hA1WJ5P/a3bi4yZjN7/NrX
	Fk+jHsAC1maViB/aqryjXDEkRvlyBrA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-4-92wBTjNzGe7jOxPdq53Q-1; Fri, 31 Oct 2025 04:00:16 -0400
X-MC-Unique: 4-92wBTjNzGe7jOxPdq53Q-1
X-Mimecast-MFC-AGG-ID: 4-92wBTjNzGe7jOxPdq53Q_1761897615
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso1961810b3a.1
        for <linux-integrity@vger.kernel.org>; Fri, 31 Oct 2025 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897615; x=1762502415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
        b=jZuMeeY+llJBFLLcDw9044H/BBL/xIxG5c9G7gV9ZrBaFp8nelhijJndxsIFnRR+ct
         qPDGuGCgY/cVDTv3piHuuy71CCsC3dYjS+Pj625KSVBTkakRBzubCtqFQfb2kUWOrgo6
         JKDWEjQWUGRBsvadylZl1cac17+r9V6f7OxDe7cNscAaeA8NDe8Fu+IyyZpccuB+J/BQ
         X6FBW4ZyA9WypemaZoTyze+1qA5gd0FtBIXHIcXk7zvyVCxNZN74GNqrNNzgWMJLDIqZ
         u7UhJrFWDDNUCkz+qDGqQIv2xBnt6mxV2bMKQhh3MY1ibDXAtST6ty6bgLDpgPOgiViH
         Oj/g==
X-Gm-Message-State: AOJu0YwTkDCcZjDz3RcSpxmvXE/ef411hQIoFbHCYAY6lWskYsM+M3Gy
	QuuY2/lIH54xk43CYbBE44B065/1WZiKe+U73VjigjTVt5S8+33My6h28U3EkSSpvGON9gQBBdi
	eFeyjdOJ4EN6TO1GyG3il2kmmSF8HczdpsvQrgbaDNqKtWmwGaw1qUGGZWfgjfipXqK++hA==
X-Gm-Gg: ASbGncva9Q2y+sgoxJjRa6wteykV4hIL6sJwxCisVExIvLyJGPk2XqhjrC6c3Q7mFhi
	8cKPaybz+PB3FsimwQMWoiSzDmNpLiAE7yCq2K6mlpCKvw682CgeDPEuE2NuHrY1iLT6nA1Xwbt
	ACtgNL9L/hT8VOlEOQ5doUc7FCZPbAnLnu/FzM86fNJbS0+pnnBu76+1SWJAGJWYzuOvo4PXeao
	V3okbCXIEyBJnbsUgb3Nhn2tZu6uX3B/e5q7mp95iGjN7VB5XbFSIYrVMPDsbRHmm9B9SBF4gWL
	F/f/h1TujSgC3v/RzsIRwl6rwQgMMxvua5c3OqFMSjKVKFaMRtsnzocGrxHrWigubA==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521392b3a.15.1761897614742;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDLa7KGTb5wSf4W252Q0VnFRq/HtpgYqzeaYMwjIvkHvSdOsEAOc6ZNfr8cT8FHHmEHw3VRg==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521347b3a.15.1761897614194;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1250591b3a.15.2025.10.31.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:58:11 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <wlc2cylowxiuvfvj2yizes364yr27i3um5xen7ilyd4t2i3xzx@uucsqesigr2l>
References: <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
 <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
 <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
 <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>

On Thu, Oct 30, 2025 at 12:50:48PM -0400, Mimi Zohar wrote:
>On Thu, 2025-10-30 at 21:42 +0800, Coiby Xu wrote:
>> > >
>> > > Another question is whether we should allow loading a kernel module with
>> > > appended signature but misses IMA signature. Both IMA arch specific policy
>> > > and init_module syscall only require appended signature verification. On
>> > > the other hand, we only allow "appraise_type=imasig|modsig" but not
>> > > appraise_type=modsig. How about we allow loading a kernel module with
>> > > valid appended signature regardless of its IMA signature? We won't call
>> > > set_module_sig_enforced but as long as we know is_module_sig_enforced()
>> > > is true, we allow the module in IMA.
>> >
>> > Based on the policy, IMA enforces signature verification. Only if
>> > CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not define an
>> > IMA kernel module appraise rule. However, custom policies could still require
>> > both types of signatures, not necessarily signed by the same entity.
>> >
>> > The option "appraise_type=imasig|modsig" allows either an IMA signature OR an
>> > appended signature.
>>
>> Thanks for the clarification! If I understand you correctly, some users
>> may want to enforce IMA signature verification and we should provide
>> such flexibility. Then do you think it's a good idea to change the kernel
>> module rule in ima_policy=secure_boot to
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig" so
>> ima_policy=secure_boot can also work for in-kernel decompressing
>> modules?
>
>Yes, that's fine.  Unlike the arch specific policy rules and the Kconfig
>appraise rules, which persist after loading a custom policy, the builtin secure
>boot rules do not persist.

Thanks for the confirmation! v2 has been posted.

>
>Mimi
>
>

-- 
Best regards,
Coiby


