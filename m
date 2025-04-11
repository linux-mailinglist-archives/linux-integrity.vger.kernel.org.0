Return-Path: <linux-integrity+bounces-5848-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B969AA86857
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 23:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B5016EE58
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B129C340;
	Fri, 11 Apr 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMOt1crC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1D290BC8
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407173; cv=none; b=ZpoN8VouH04kPRu5n8ao7Afnvq+Pf/bmpLGQ1pCGkbJtqD0gCJzdSIU9vD9XEE2JlakPWqUCIi/5rb0r6iT0thgDEp0hghU8jYGxFzqfU4F2Qwo5BRzRsFLdCuVIxhN2UEv00xNsiLYRbAqhUt3B0D2dvPE6gWntwC5Hzf/Uj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407173; c=relaxed/simple;
	bh=/3tH8CvukO+vlevVOFlntDYEjBrYdIAzSgCsbqTQLxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVjlPfbX/GNc+CiyQ6sXXkSRpyDqTuFxFoDO8KuaV27tILKn/7mRZN+eTzNBH8BU+2y3x8hMNE6/bO5qRyd0KK/p0TlLdDGsPMJzS07h0llEOTZwnafWuhFwI+Bmit06o54nZxNwj6uWQdPuwuFvcx3exh/3jQYIikjt2hIwMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMOt1crC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so18449085ad.0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744407171; x=1745011971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=LMOt1crCRQs73eNK2HbRb9PqL0BMPWtRzEolG5uHstDhtEf6oySC8qL8wXuxEcGGlw
         BR1D+F2lQNPzP75CsCeXYG5c3kJHdmXo9a1kW2pVoMZyPwemqYA+zajtzMDCi8/cnXuS
         r3mpjyyx7LfG4900x6md4uTxy3EpqOwiWLTkJEHB/dpAKW45qM6t3YTEkuzEljFWydw/
         fdntwATFSZZReekXEs9GYif0OFS62ygEV+Ge1s4ojEP+ErT/eySDKOXeC/pdO3K8CM1n
         5s+NqTpF56oW6pv3e5a394w48ZUaP7dmaDgUvWz9irepb7efgmgQxnQcK5ejyeUWeP/f
         1chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407171; x=1745011971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=UnFUQHxZEofkXQLF5elX8tICOasw8dakyZVR4cgZAymZ6UJYp6M/ru5Z6oq3a4h2bq
         V/Bbt5KF1/JYhUSVVC2w4z1MZeu0BwSdAgm1U9czRUFXhEbEswroYTZTDT1CeJwvVqxx
         4Pzjzkawrw/IbqmLBNoWV00cgh1uOduh21uECt3jQs7vEj0rOLRktT+FE4XFv3e18/hs
         AIsMmQEiqdDJhGCGqJOZE0J1WyesJyLeB80kT8AaC+rROae9Q5QT+KxDBN2xloE5ex4I
         J9yHQXQu4H7xNB2Iiw72fWwp6ECfT4xtDlWEAwBEW5VLbVmEH7IKM9fk4uPfoHXSaMCF
         znsw==
X-Forwarded-Encrypted: i=1; AJvYcCVOHD02Y9V3kSxAXMNrCzL1H40s7R+/O+nXtGoYRCMm6SYXFRx7RAy1Bq+up6AUBSa8OKeJOg8oDqyiPsdOAvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOqRPlpjfjWAB0JClCupYv9U/WQwC5P1Mpaqf0tMFlHkJEKrF
	gQTuM5CRgBOa9T38J9zR+qzRxNRmdFaefrmQuI6AwT04y3Mh+Us2VybO24K/vQRiLMpJe3e9inU
	QNg==
X-Google-Smtp-Source: AGHT+IGWRveftZO1wji7CvlkOdr/kE0uz4l6esz3nDwfvBuY+d4Ew0jp3EjBMobySbyO9+duVZkiSgztRF8=
X-Received: from pfvf19.prod.google.com ([2002:a05:6a00:1ad3:b0:732:51fc:618f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:224:910:23f6
 with SMTP id d9443c01a7336-22bea4fcc8dmr67226125ad.45.1744407171250; Fri, 11
 Apr 2025 14:32:51 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:32:49 -0700
In-Reply-To: <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com> <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
 <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Message-ID: <Z_mKgfZznBZgS-Pb@google.com>
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel documentation
From: Sean Christopherson <seanjc@google.com>
To: ross.philipson@oracle.com
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, ross.philipson@oracle.com wrote:
> On 4/10/25 10:50 PM, ALOK TIWARI wrote:
> > 
> > 
> > On 11-04-2025 02:11, Ross Philipson wrote:
> > > +
> > > + - Entry from the dynamic launch jumps to the SL stub.
> > > + - SL stub fixes up the world on the BSP.
> > > + - For TXT, SL stub wakes the APs, fixes up their worlds.
> > > + - For TXT, APs are left halted using MONITOR/MWAIT intructions.
> > 
> > typo intructions -> instruction
> 
> Thanks for the review. They are two separate instructions so is this really
> incorrect?

From the peanut gallery, I'd just drop the "instruction(s)" qualifier, i.e.

	- For TXT, APs are left halted using MONITOR/MWAIT.

Pedantically, it's the combination of MONTIOR+MWAIT that puts the CPU into a
sleep state, not the individual instructions.

And while I'm picking nits, the documentation is also a bit misleading as the CPU
isn't halted per se.  I'd go with something like:

	- For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.

