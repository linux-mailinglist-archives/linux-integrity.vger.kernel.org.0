Return-Path: <linux-integrity+bounces-4837-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA38A37C9D
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 08:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A716C3AA9AD
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D5199921;
	Mon, 17 Feb 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwevGcCz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6C19995E
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779103; cv=none; b=A4f43zb4pUB03gEtYSF8IJcTfHX8yTpX1uVpvzEDgz2Ok31VFS7188h5YFFKboEx9A88sTXBJ0GVPiAvNdiE1bI6jxdJRgyP7ntjFLqmZLddx+aW1r6EtnuA9boajISDGleSB16g6/poWjij3WGoy83R1OAJkfHDM6s2rTvShUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779103; c=relaxed/simple;
	bh=/M3ezt3Z/lLmjNEp9YYFZLIfonOW+E/UIMscXYZ0U6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+r4qpcgQ1/gbhZUr8Pjfm0bBqSDq7pyX248g/9GLRLddYgqoFiCLWdUYvr83hx7mgzyolFpDYzmizSQhk1888UsDcnfhiCxt0FZ5iU8iDUPmTpfvChzWau2X2qRNbQWJSlc5+k/ksBRyQ9HHA4MBtE1GW6ngcMsoQW8YR3jI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwevGcCz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb97e15bcbso130512666b.0
        for <linux-integrity@vger.kernel.org>; Sun, 16 Feb 2025 23:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739779100; x=1740383900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApD7BwCDLH9Cer9mwkanCNIi/wQ8i9+UwiMAZTm2yAI=;
        b=PwevGcCzFJ4IG2e29mNl4goTmejxuovFScJIngKUG7FFcmJGkzFlUU3yfHDyCNHZHQ
         DCoiXOoRVADxX1pHzw32/yCEr0djnVI8xbzwhamnHoyxE2ltqmxTBa2k1SARlwo/RYQ7
         oqD8YN9abrA5Ew0iScRIOr3lcNTUbtMh+z0/LAEx+ee5yxqKKvDukMSecoVeHC2mZM0+
         P0AhOvhVQPeTXNTF5TZOpfxrIxKDywHRONX7zjSY72dWZaNcxT2eEhg/M6aei+/OZucH
         ex16zGV6bfNnggzu1WU+Xd/fW3XqMuknUFCU906g1gtFjq+pOzUVe44rM6IWcgST+SC8
         3iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779100; x=1740383900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApD7BwCDLH9Cer9mwkanCNIi/wQ8i9+UwiMAZTm2yAI=;
        b=iSk4pLBbRfXvIrmohMnoarGVp0gXJQuLU74Zeo0s/3M4pQ3g0LwRre3Gsa0Vczo5x2
         kp7Vc/uJwLjfRHmeHevYnHaTug8oJDTCu0S7098DV0INf2kLyryz4lVQfWEqHkQGTKSj
         dBOMBsVZ9sCeqt68NkqPMRCx2hNpGJxJly9Fnu8Rznqw65W/3QRsU/dozg9gvAVkipjw
         zPmQe3sZzcMOPj0qiouagk9M67ML+RW7cOez4Z96T1lJmzWb+c6JQ/BamtcH1ypZiCO3
         /pdaEBE0LnFIQzvKrAznceVAq3jigNsPTfNcNv8WrWXYp/a///21RAxLcZAQAEVwl/Gi
         03MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXggqHgKbgycJFSX7N/gFAl3EURDuVwgN/rkCxopoDxgMZw0f1t+QGneQERV4YtWJZQOtw91ObY6ruwWUCHhYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Dg0hem0xX1FVhR1Pu4Z4m6rC5BfqlqdpScnLxrl8CdVoej+n
	C12h2NeRDchXfwvVkN3mG1T/dJ/OardQSyhaTdZNGA73LDkH+FEr
X-Gm-Gg: ASbGncub81yGcJoQY0JcyjHWlgNo6TU5+qQd8eh+V/hShjnehGdmogBJ6WJgnHjlb2x
	6uivq8YK3Lr1K2ktCuVk6D1Yn0ltWpDHq/1hf9QGAyQCvDqH1UW2DIEt4bkJbrSR6RyN86ClYiT
	IBEmB/ur5MB0pECwfZXkcrpv/czjHjLU+AS8qRExOiec4wPyEHmbB9ZO1ttG1/W1rtUNI6gOVgQ
	d7L+RE/5uJMOP8pi29j3rmhTv9UW/164Ifkds+sC9fefJ2YTSv1PvOR87ML7ZLBAmlOXWWcXCMo
	9xYIV0gHFaBriKLujGOVKfJK+AkjmyE=
X-Google-Smtp-Source: AGHT+IGX390FOPHXgV0NpdCEyO/q1N+yhgq8PJVniRaE6lQIwr6rUFGG4d+Wp3xEMZQx2Qa6HcYR7Q==
X-Received: by 2002:a17:907:3d8e:b0:ab7:5b58:f467 with SMTP id a640c23a62f3a-abb710dcd60mr887440566b.40.1739779099850;
        Sun, 16 Feb 2025 23:58:19 -0800 (PST)
Received: from f (cst-prg-82-124.cust.vodafone.cz. [46.135.82.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53397f47sm836991766b.127.2025.02.16.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:58:18 -0800 (PST)
Date: Mon, 17 Feb 2025 08:58:08 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-integrity@vger.kernel.org
Subject: Re: [robertosassu:evm-iint-ptr-v1-devel-v3] [evm]  e38e699a42:
 will-it-scale.per_process_ops 160.4% improvement
Message-ID: <33ac5nnu2mte56mrrm62fqsyqozdifll63wdohjp2ywcnizwrd@2besd5mxagjg>
References: <202502171412.ec2e5b88-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202502171412.ec2e5b88-lkp@intel.com>

On Mon, Feb 17, 2025 at 02:45:23PM +0800, kernel test robot wrote:
> kernel test robot noticed a 160.4% improvement of will-it-scale.per_process_ops on:
> 
> 
> commit: e38e699a42b4db5daf7dac453759fdc8ba0dab31 ("evm: Move metadata in the inode security blob to a pointer")
> https://github.com/robertosassu/linux evm-iint-ptr-v1-devel-v3
> 
>      24.57           +72.2       96.76        perf-profile.children.cycles-pp.__fput
>      24.63           +72.4       97.02        perf-profile.children.cycles-pp.__x64_sys_close
>      24.67           +72.5       97.17        perf-profile.children.cycles-pp.__close
>       0.00           +95.2       95.17        perf-profile.children.cycles-pp.osq_lock
>       0.00           +95.5       95.53        perf-profile.children.cycles-pp.__mutex_lock
>       0.00           +95.7       95.71        perf-profile.children.cycles-pp.evm_file_release
>       0.00           +95.9       95.87        perf-profile.children.cycles-pp.security_file_release
>      98.69           -98.7        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath

Contrary to what's indicated in the report, this change is in fact a
significant slowdown (or rather, will be when other problems get fixed).

The open3 microbenchmark issues open + close in a loop on the same file.

On the stock kernel the some of the problem is false-sharing within
struct inode.

The biggest bottleneck is lockref manipulation:
- there is lockref acquire and release happening *twice* instead of just
  once
- the lockref facility is prone to degrading to operation under a
  spinlock and staying there when microbenchmarked. you can see on the
  profile this does happen here

evm also used to pop up, which I patched away in 699ae6241920b0fa ("evm:
stop avoidably reading i_writecount in evm_file_release")

Your patch adds a mutex which adds 2 atomics to the fast path (so slows
down single-threaded operation) and more importantly adds a
serialization point for multithreaded operation.

In this case the resulting contention helps decrease the loss of
performance in lockref and that's how there is an apparent win.

I have a WIP patch to move dentries away from using lockref, which will
in turn avoid the degradation. Should it land, the mutex added here will
be the new bottleneck.

It needs to be avoided by default. Do you *need* to test the condition
in evm_file_release() with the lock held? Perhaps initial test can be
done without and redone after acquiring it?

