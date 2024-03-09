Return-Path: <linux-integrity+bounces-1686-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389E876E70
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Mar 2024 02:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E11C20933
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Mar 2024 01:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671216423;
	Sat,  9 Mar 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y1ZITEOE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1E11187
	for <linux-integrity@vger.kernel.org>; Sat,  9 Mar 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946871; cv=none; b=qszR5AXemm4Q9plCub7gZs4KWkU2zcPWkf9ANXJT7FWPV7fJeZASpCYzsVHK2+qugLLRA16BUhCKDB/4107RQvz2GcdrUW3Os4CgO/wR93OX3OE2OMsDsjp2L3ZI4Tg9ZIL14NjOoypXqA4+7K6hnGL2Ee21AEMWkD2msI+zkoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946871; c=relaxed/simple;
	bh=PVSSW/TRZScbGAXptUtzNMhjOI0JAjP3o2LHf4YtFlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufZyJZWL/E8Tu+Y7TOfR3POfg4Z1BJh5pv5KpjavKrUSVf1zpgrfueCRsQhj7gboE1uXJEe071keJWfjo8BKsxyXIazCxWhtUFQuNi8Q3c1nYHIKPi9MuptStJezqSLmhJMOy0fcwYo4iAr22NnKANlIsb+M4ouifCYb4ZvvY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y1ZITEOE; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso2689281276.1
        for <linux-integrity@vger.kernel.org>; Fri, 08 Mar 2024 17:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709946868; x=1710551668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPz2z6DvnJxq/mvZY2AzEM7nepXgQps0sd3FnWYy8AY=;
        b=Y1ZITEOEQMcPGo0IG+gwiGch8CnQXfEH4HEZKP2VNMxLUEtC0/XKnlmtFb01oTOAoM
         bUlhF//VTz39WdyQJ4aNxBCGDXS2HHz8fRKSaeXfnzQg/WmzaJdmlHo4tS+0cUaCQBMS
         pUqke+3r86nVSAScKNFYk/sFgex4OoZh72SHtjI0gIV2MIR72aHwQcSQLpNqlG92Vp3L
         cdKjHiDqA44uJNzOECaQdtY14Z5kBvXFj6Q7wfZWgwbuYjW9o3QX6cQSt3btbzM7Tak3
         mE7eNvUokKYai8U35gAQ+n09p7inXwVrvXZLcL7JCci6k5+Q2SDk1+MZ8k25c8zXXXre
         CZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946868; x=1710551668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPz2z6DvnJxq/mvZY2AzEM7nepXgQps0sd3FnWYy8AY=;
        b=IvouW92zLc70FONG6Jm2bO3RIhF3uWp5bpUIINgkadgOH59nDnn35H5U7sqH2y/WiL
         qxGU3mKCh2SGpTvbluHxWUg6zcxem0wwUEt89vzUXnMaNG3wzUwGaAVn5UsYaHf93dMy
         bo+irK4epvGthbeDIi4Qj5QQNMimUWbZYCphrFbDdeAgBfAZcqOMfWrmArkY4sDP6aS0
         4Hgpelt+F4lkErf0heCntAoHhMxeoUHOKxvU0Sfh1ohAZCaPiB3n3OvBWiA5Fikf9qTJ
         bPhqWWcLzzBN8E28lkaaIToV0wuPz006qENP054JeaO+njXkEmrGbnbICH7L0t2fdhY2
         jh3w==
X-Forwarded-Encrypted: i=1; AJvYcCXPtjmvhrqOQsZJqHHOIJcFFhYxo5ysG06/k2tCbwUq24hbQz/C3Sci22dr39xqjoKlIYPRrYu/uuwm/5i5ohWls2yMsuu6/6nkJtpuBnLo
X-Gm-Message-State: AOJu0YyXtoPc6ztgJP9NTpMPNbpfwU7fdCjz0wqX8Nco8gEkNy6wkm2l
	XrF6B/paF/sSWRvZBxaHcALgaNNO0v8ntIlwzY53VJQxO4J4qZgljOgYTz8EZF39rzOPnsI6QT+
	ODueeRbWrcwURlFZHL4r1NoxCHZ7qhmgm/1Ai
X-Google-Smtp-Source: AGHT+IG/iVw0xp4cUGbrbuHW4JP6YIUG2WhfFnWUrnT+aZkEjbYKTgvQfRu4/7uLG7cpfDOqG4dr9VoK5RFcwZhesog=
X-Received: by 2002:a25:b227:0:b0:dcd:1043:23c with SMTP id
 i39-20020a25b227000000b00dcd1043023cmr780907ybj.1.1709946868255; Fri, 08 Mar
 2024 17:14:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Mar 2024 20:14:17 -0500
Message-ID: <CAHC9VhQ90Z9HbSJWxNoH20_b92m6_5QWJAJ9ZkSR_1PWUAvCsw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 00/19] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:34=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> Overview:
> ---------
>
> IPE is a Linux Security Module which takes a complimentary approach to
> access control. Whereas existing mandatory access control mechanisms
> base their decisions on labels and paths, IPE instead determines
> whether or not an operation should be allowed based on immutable
> security properties of the system component the operation is being
> performed on.
>
> IPE itself does not mandate how the security property should be
> evaluated, but relies on an extensible set of external property providers
> to evaluate the component. IPE makes its decision based on reference
> values for the selected properties, specified in the IPE policy.
>
> The reference values represent the value that the policy writer and the
> local system administrator (based on the policy signature) trust for the
> system to accomplish the desired tasks.
>
> One such provider is for example dm-verity, which is able to represent
> the integrity property of a partition (its immutable state) with a digest=
.
>
> IPE is compiled under CONFIG_SECURITY_IPE.

All of this looks reasonable to me, I see there have been some minor
spelling/grammar corrections made, but nothing too serious.  If we can
get ACKs from the fsverity and device-mapper folks I can merge this
once the upcoming merge window closes in a few weeks.

--=20
paul-moore.com

