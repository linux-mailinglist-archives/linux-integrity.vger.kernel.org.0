Return-Path: <linux-integrity+bounces-6872-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B767DB2AF9B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A555F2A0AD6
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Aug 2025 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD842472B9;
	Mon, 18 Aug 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOwDuITn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F12773ED
	for <linux-integrity@vger.kernel.org>; Mon, 18 Aug 2025 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538806; cv=none; b=a1LU5UVcQfkjdetJvI+6LWtx6rFCM/wqgxhe/jlwFgmHiLD30U7F9jaVdX34GwGmKKHs7hxG3/J/+QMrKwgoRl8wrys+XzarVgaAzbevfXFAp3KBbKewD+2UhYGH+B3EOSKeckAX5asBpjpaomB0KnwhWPCxhkuwF3cLUBB2F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538806; c=relaxed/simple;
	bh=tHS7wqv6PDbHZD6D0zslBdZsTurmCV/xCMPsuVRZ8KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7V3/Q8pAXyyst9sumfZnIduLd/TbLa+1fUngZ0Ocybeazw34Pop//siuQ1zZBAgpvyZQNu8OuwBuhtWeBhXf8hJgTEmXZxnsMY7L0NIwO06N/p+B0Avjkv6t7ZLkWQ12stTXUfGSMh6oF07iDq80irFIgLORxvRUSipTm0v8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOwDuITn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E821C4CEEB;
	Mon, 18 Aug 2025 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538805;
	bh=tHS7wqv6PDbHZD6D0zslBdZsTurmCV/xCMPsuVRZ8KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOwDuITn6I4NUK8O/yIdu/xrsgH1BAD+t0bIpeujxSyPEbfwJi1uFZ/YJbzGxpUqF
	 E4xnCPhRvF+ErGb2j8+MRn1zD/VkBENjNvkwaIRt7uiSun6uFgUv/4xBl+mOpN86oe
	 Snyqy+TvZLGFpOq2TJXO+WIvSc43yDpAFj0P4xs5o4taqtzI8xzOGGyEQM0YhgZsVS
	 BHgz9temqGA6dApDBsgFHBnmf0T/MA7RLJEP6w6yeOVaY9CnvtwDx1qbN2w/hMKTm9
	 UIbZHR1oWTlaJf0WrmJqtvNFly5a5QfX4LRTVg2o3BwiKWlrMc1bP8Oc2i/Qmyx+56
	 hln0HRuJfbvuw==
Date: Mon, 18 Aug 2025 20:40:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aKNlck45-FF_p40t@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>

On Fri, Aug 08, 2025 at 02:32:02PM -0400, Denis Aleksandrov wrote:
> Ping.
> 
> Just checking in on this patch.
> It has received a "Reviewed-by" tag, and I was wondering if there is
> anything else needed from my side for it to be picked up.

"This bug is not seen on most machines. Reads on tpm/tpm0/ppi/*operations
can become very long on misconfigured systems. Reading the TPM is a
blocking operation, thus a user could effectively trigger a DOS.

Resolve this by restricting unprivileged user from reading the
above-mentioned device files."

OK I took some time to revisit this. I think the symptom is correct but
it should not be fixed the way it is done here. I.e. the fix works as
a bug report but not as a right type of fix because it will also
change uapi behavior w/o strong enough reasons to do so.

What you should do instead would be to cache the result.

I.e. first declare this as static global:

static const char *tpm_ppi_info[] = {
	"Not implemented",
	"BIOS only",
	"Blocked for OS by BIOS",
	"User required",
	"User not required",
};


Then declare a spinlock:

static DEFINE_SPINLOCK(tpm_ppi_lock);

And finally static arrays that contain indexes to tpm_ppi_info e.g.,
tpm_ppi_tcg_operations and tpm_ppi_vs_operations.

Then on first request populate them and after that the results are
cached.


> Thanks,
> Denis

BR, Jarkko

