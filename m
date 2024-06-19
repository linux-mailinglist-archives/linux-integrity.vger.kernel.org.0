Return-Path: <linux-integrity+bounces-2875-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795E90F63B
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC518284E5C
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9E1586CF;
	Wed, 19 Jun 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pioi5qnt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05541876
	for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822652; cv=none; b=mrAcdI9vQitpkoIZ1W4ylYwbt8uVla6DZ1cozLBFhAB8wjZnOfCldLshO0YnCwFDjWnFFUFEfcQ4tRAQBvzu/Czwm/QoENiqKyyBD7wE6om+PgbuITnPOPX9HuKHyK0HsCDph7/UF8Zva+awkGAFLxoHm865arZjSw3toYFUurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822652; c=relaxed/simple;
	bh=POFve0DmEktYU/Q9LBEZgVsromDP4CbL8eVyLHPQrk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tab+gdjVY5cvpZWXA9PDDPaOfObEGA+Tqc9ugWGq56tfOs5fSyjdR5Vy69cgO9z0/dG/hKLjCbdj8rC/pq2RH3TlR0hvGU0B6ujm2c/bwrWLTx8pJ5uwYEpNv/Xsxqfs9OX2QlQGDfjZd1GdhL+vPu+SwZnCdXtxHx1B2HXMW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pioi5qnt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so68951276.1
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2024 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718822649; x=1719427449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POFve0DmEktYU/Q9LBEZgVsromDP4CbL8eVyLHPQrk4=;
        b=Pioi5qntPCxOIm3z53nIpGWi2uPbDOic+mRo2/Qq3fNPCJpVILcMRMyLss3bPQKTCJ
         230Svjct3MoM6oeE1JRjUs1a8I5c/jndCl3S5TX4fX1J3luteLUdfFYK7LN3OVg3T1f8
         cF72+1VzBKZDywOQuDgQLH0dOYewrgMUIXyS95rb4u6p01zlKocbFbGHBwl+v0plA/ra
         dnQktVN3J3bKVNUQTNa65frKaeiR6ai4/uDYnyK/mn/avVG4baIwGGBS219TUYWePZc2
         wypJWegTMYYxyJf0EBllFQF6g4MZtdmEJmdD882szy8cP2NpspENfiK+zHqA4PncUkVX
         P/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822649; x=1719427449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POFve0DmEktYU/Q9LBEZgVsromDP4CbL8eVyLHPQrk4=;
        b=n4W6YNCVPIhvQFF9ve4lhukIUgMb/kW3RN+1OOLSWPXKq795JSfw4J92uUHv03sbpz
         vd3gDO9zL6MwG5PbAVwNVlGnGIEHVZsum0LjUIyTCA4A0hVPxigR8YAZN7uip+nqld3O
         C9GLzT9ve/sHD1xeX0Dp4CoZrqC1ktJZ2Wb0bNGZTJJpZNHllEKhGFEBV9g4A2T49gPH
         sAj3ptr6u3BYK6qd8yxvwMIfPsD6NsbKl3nSaLd5ezSG0wC7j+RLuIew1NGxhNa+mhxh
         EAo7NiZvRfNHr9G+peax3/gs+t6bB45LTjYiiIYQLvLIc3ZVdI7+f6QHMMu+AxKfcLEL
         H6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6InoahzS0gv0AdRCSNe6k60W+MSvRDuwIbVhwKJ0ZraYvQPcXH3HJJeF5jLPVLCm9G8jdUZ61FlRbjyafeLJmudNkFXsrdyoxsY/OjnZC
X-Gm-Message-State: AOJu0YzqcRYt45WxT+htq8pgcrqozDXQsesx6bYwLZgFeY5Eu4vviXIw
	feFrhnz6FHClUErKaIveu04aL0YoWcG8y0qZh6sFpH4fQ6aRGrvlNGchapTDHgiRGl3qzo/kCzC
	+nDdRVT7y3b3hTOrjw08rnadAKmbhgENX4vYE
X-Google-Smtp-Source: AGHT+IHqUYv4vQPGwGcr2ob928yU34u20roGy4+cdrTQUMxtndJziPMKog+pA/vBVDGo8roMs908SVyt/zescjJ93yg=
X-Received: by 2002:a25:fc20:0:b0:e02:8b7a:2b07 with SMTP id
 3f1490d57ef6-e02be141ff3mr3782911276.20.1718822649520; Wed, 19 Jun 2024
 11:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com> <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
In-Reply-To: <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jun 2024 14:43:58 -0400
Message-ID: <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Making it a kernel subsystem would likely mean replicating what the LSM
> infrastructure is doing, inode (security) blob and being notified about
> file/directory changes.

Just because the LSM framework can be used for something, perhaps it
even makes the implementation easier, it doesn't mean the framework
should be used for everything.

--=20
paul-moore.com

