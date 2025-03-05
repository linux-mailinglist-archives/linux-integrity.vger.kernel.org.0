Return-Path: <linux-integrity+bounces-5127-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E175FA50AD2
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 20:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA377AA120
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4451A5BB7;
	Wed,  5 Mar 2025 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVRO0vNM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F892517AF
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201353; cv=none; b=rL248Y6OIobFLOz5V8TuIGXiDQ+U3fva8eoP0EBxVj7juakqoIEfsc2300bB/XTbe179akUk4c+jJ9LnAYtG6l1rAAyCF67kqHgYOMji72lMbSTwLYQRQa6AQL5gbZ/9fSnQleIzZLmtNHpXPue6WOi0KIXQvQMMeAyb0WlkKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201353; c=relaxed/simple;
	bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzu+FI0b0s49qZNw+39qlFgLZSNilB89dHS9PZzhwy6lY7IH7zD+ag18YDt/TESHuaLfoIK5K3PEHg33iQDptVAATzNOasUPXKct0lPQVepgdXEsEx9Mkmx0Q18bRTK1eG3hhGNO4UsqF9/XO+AaftwrsxyGot4Edo4lV4AX1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVRO0vNM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8efefec89so5556966d6.3
        for <linux-integrity@vger.kernel.org>; Wed, 05 Mar 2025 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741201351; x=1741806151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
        b=NVRO0vNMMP1xb5l7yHeeZHtiu30SNJmMnG5TGDpZzC2ZPgqkxt9C1VlqqHdoYF6F3b
         DXmaIBjL/zBVH9EvOBV7G4+KhXZoaryYs4+h66JHvkQFCx2Dh0TW1xHDhqP68mgosR+H
         Ov7+ccF/9aXpTP26/fHZlJqXJS6u6zS/NToVqd60eZ0Bnx4I+3Lf/zGYiIgcZzIesIKv
         moUJEyAWUa46Ak5Ww+ksWe/M9kc/dWNFU2rkeuaEZysHnKsje4l/Ylyi7KsE7T7X8a9A
         3kT6BmnnKtxT9Scl3i403/D7KuYC3XRTJB4/DIDwNaGl6D7vxQb6encGf+V9KOboRA5Y
         19nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201351; x=1741806151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PImNvEb9R7mU674MFRkVo7MQticSDFJlq5WrSF4+QLo=;
        b=jtRGz6hLJ9yt8gk13gK7SmByFWdFUwQMWo8D4E4M9rXfsmoi3Z7JJyR98npuMcDj5L
         VIfWyhY0iQxrQCKNMXFZSyYjPl1UXINmDit7m3Pvl9QLvvxS49WVw90OmtjDPidRUesj
         6Zb5rVN/xxB+R7XSEOU4+b7rMpHXBdm1APsiqrnuQ8AlZe0EYWJHnGILq2Y3aTWxciPW
         9iXg7aVtc2O0ZcnpBPoYO1kz0ySV4KcwH5u39noNljGtc97I9Y2y2ahjR7hL/wOcXLtp
         VC4kM1HQq8VKrWUs2ByGFkbOaDfGEweNyVa+a09bwia8+PCCSNB9pcnsmmCgJ91+HTUH
         afoA==
X-Forwarded-Encrypted: i=1; AJvYcCUetbpFTTubH9J599/a5ZNGGIhYeKDynvrbtDeb/1M21D5LgUeQ7W7QedvIiLrTbx2VC1qxqZprdBdSMsZS13Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM05dVj43V4xWzsNmnolH0QR+Xc/LlnB7zyQ6jraTHdXimSBLN
	g19DGfdRSqnUR25U5RMlW548Fddn50C7AUhJEHV5ZHq0+DEfKZApucq1jJT1EhGBkpYcz9d1qgI
	k
X-Gm-Gg: ASbGncsfWWnGsslXzdOkkneLnGJtjcV+qXvgkXE3bw0CpjngjKEb+K6aLiaEZbUAnKD
	aV82441CplnnKUsCBBZn/anrnlPzDVXjHaF+S6NVy5ofsq51HHjwtizn7oJK94phnRbsDs2i9C2
	atD/zjtd4x9QJ0wbHlAqgz5ehgloUoj5/vt+ePInCrmpPiQ+2YefAMiiFbDvwgmcPt6W8Lf63kF
	RGGViflVl4f8BP3dAp+4sPCOSPfBLXfuui1ieugdehUTnSP5u255M0opf8V5yjJwNIKCrSn9XEZ
	0VlMT5ilKvQ8QNOUC6TYodqam2Ynf/eCvJdOtZFb6aZuav1uWa08+Hs5p2qN4M1Jm935s6BS5xQ
	ofr+dVxCTtpKBX1HGjA==
X-Google-Smtp-Source: AGHT+IFj/qwQTwKG8SNNtgVxRj9GZyBrMpWQIs1ECNvXkzZ0QEhM4dpXu10vspXzdcAPMQORADqmUA==
X-Received: by 2002:a05:6214:c48:b0:6e8:952a:240 with SMTP id 6a1803df08f44-6e8e6d1366emr58222716d6.32.1741201351058;
        Wed, 05 Mar 2025 11:02:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e885f85csm11121396d6.100.2025.03.05.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:02:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpu0j-00000001Ucp-3R2H;
	Wed, 05 Mar 2025 15:02:29 -0400
Date: Wed, 5 Mar 2025 15:02:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <20250305190229.GC354403@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>

On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
> Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
> avoid that, I can restore what we did in v1 and replace the
> TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
> think it is fine).

I think it is a pretty notable simplification for the driver as it
does not need to implement send, status, req_canceled and more ops.

Given the small LOC on the core side I'd call that simplification a
win..

Jason

